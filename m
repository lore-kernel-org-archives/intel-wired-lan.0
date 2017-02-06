From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon,  6 Feb 2017 14:38:51 -0800
Subject: [Intel-wired-lan] [PART2 PATCH 8/9] i40e: add support for SCTPv4
	FDir filters
In-Reply-To: <20170206223852.31177-1-jacob.e.keller@intel.com>
References: <20170206223852.31177-1-jacob.e.keller@intel.com>
Message-ID: <20170206223852.31177-9-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Enable FDir filters for SCTPv4 packets using the ethtool ntuple
interface to enable filters. The ethtool API does not allow masking on
the verification tag.

Testing-hints:
  Ethtool commands to enable sctp4 filters should not produce errors,
  and should properly direct traffic to the desired queue.

  ethtool -N <device> flow-type sctp4 <input set> action 1

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Change-Id: I093e88a8143994c7e6f4b7b17a0bd5cf861d18e4
---
 drivers/net/ethernet/intel/i40e/i40e.h         |  1 +
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 10 ++++
 drivers/net/ethernet/intel/i40e/i40e_main.c    |  2 +
 drivers/net/ethernet/intel/i40e/i40e_txrx.c    | 80 ++++++++++++++++++++++++++
 4 files changed, 93 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index f218a5bb7a16..33d1730878b7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -381,6 +381,7 @@ struct i40e_pf {
 	 */
 	u16 fd_tcp4_filter_cnt;
 	u16 fd_udp4_filter_cnt;
+	u16 fd_sctp4_filter_cnt;
 	u16 fd_ip4_filter_cnt;
 
 	/* Flexible filter table values that need to be programmed into
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 2dce5f5a486e..d9b379ef203b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2469,6 +2469,9 @@ static int i40e_get_ethtool_fdir_entry(struct i40e_pf *pf,
 	fsp->h_u.tcp_ip4_spec.ip4dst = rule->src_ip;
 
 	switch (rule->flow_type) {
+	case SCTP_V4_FLOW:
+		index = I40E_FILTER_PCTYPE_NONF_IPV4_SCTP;
+		break;
 	case TCP_V4_FLOW:
 		index = I40E_FILTER_PCTYPE_NONF_IPV4_TCP;
 		break;
@@ -3291,6 +3294,10 @@ static int i40e_check_fdir_input_set(struct i40e_vsi *vsi,
 	int err;
 
 	switch (fsp->flow_type & ~FLOW_EXT) {
+	case SCTP_V4_FLOW:
+		index = I40E_FILTER_PCTYPE_NONF_IPV4_SCTP;
+		fdir_filter_count = &pf->fd_sctp4_filter_cnt;
+		break;
 	case TCP_V4_FLOW:
 		index = I40E_FILTER_PCTYPE_NONF_IPV4_TCP;
 		fdir_filter_count = &pf->fd_tcp4_filter_cnt;
@@ -3322,6 +3329,9 @@ static int i40e_check_fdir_input_set(struct i40e_vsi *vsi,
 	 * ip4dst fields.
 	 */
 	switch (fsp->flow_type & ~FLOW_EXT) {
+	case SCTP_V4_FLOW:
+		new_mask &= ~I40E_VERIFY_TAG_MASK;
+		/* Fall through */
 	case TCP_V4_FLOW:
 	case UDP_V4_FLOW:
 		tcp_ip4_spec = &fsp->m_u.tcp_ip4_spec;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index a2cd3979b81a..6223db6ac728 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3323,6 +3323,7 @@ static void i40e_fdir_filter_restore(struct i40e_vsi *vsi)
 	/* Reset FDir counters as we're replaying all existing filters */
 	pf->fd_tcp4_filter_cnt = 0;
 	pf->fd_udp4_filter_cnt = 0;
+	pf->fd_sctp4_filter_cnt = 0;
 	pf->fd_ip4_filter_cnt = 0;
 
 	hlist_for_each_entry_safe(filter, node,
@@ -5912,6 +5913,7 @@ static void i40e_fdir_filter_exit(struct i40e_pf *pf)
 	pf->fdir_pf_active_filters = 0;
 	pf->fd_tcp4_filter_cnt = 0;
 	pf->fd_udp4_filter_cnt = 0;
+	pf->fd_sctp4_filter_cnt = 0;
 	pf->fd_ip4_filter_cnt = 0;
 
 	/* Reprogram the default input set for TCP/IPv4 */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index cb38a248c38f..1dabe5c57a88 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -347,6 +347,80 @@ static int i40e_add_del_fdir_tcpv4(struct i40e_vsi *vsi,
 	return 0;
 }
 
+#define I40E_SCTPIP_DUMMY_PACKET_LEN 46
+/**
+ * i40e_add_del_fdir_sctpv4 - Add/Remove SCTPv4 Flow Director filters for
+ * a specific flow spec
+ * @vsi: pointer to the targeted VSI
+ * @fd_data: the flow director data required for the FDir descriptor
+ * @add: true adds a filter, false removes it
+ *
+ * Returns 0 if the filters were successfully added or removed
+ **/
+static int i40e_add_del_fdir_sctpv4(struct i40e_vsi *vsi,
+				    struct i40e_fdir_filter *fd_data,
+				    bool add)
+{
+	struct i40e_pf *pf = vsi->back;
+	struct sctphdr *sctp;
+	struct iphdr *ip;
+	u8 *raw_packet;
+	int ret;
+	/* Dummy packet */
+	static char packet[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x08, 0,
+		0x45, 0, 0, 0x20, 0, 0, 0x40, 0, 0x40, 0x84, 0, 0, 0, 0, 0, 0,
+		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
+
+	raw_packet = kzalloc(I40E_FDIR_MAX_RAW_PACKET_SIZE, GFP_KERNEL);
+	if (!raw_packet)
+		return -ENOMEM;
+	memcpy(raw_packet, packet, I40E_SCTPIP_DUMMY_PACKET_LEN);
+
+	ip = (struct iphdr *)(raw_packet + IP_HEADER_OFFSET);
+	sctp = (struct sctphdr *)(raw_packet + IP_HEADER_OFFSET
+	      + sizeof(struct iphdr));
+
+	ip->daddr = fd_data->dst_ip;
+	sctp->dest = fd_data->dst_port;
+	ip->saddr = fd_data->src_ip;
+	sctp->source = fd_data->src_port;
+
+	if (fd_data->flex_filter) {
+		u8 *payload = raw_packet + I40E_SCTPIP_DUMMY_PACKET_LEN;
+		__be16 pattern = fd_data->flex_word;
+		u16 off = fd_data->flex_offset;
+
+		*((__force __be16 *)(payload + off)) = pattern;
+	}
+
+	fd_data->pctype = I40E_FILTER_PCTYPE_NONF_IPV4_SCTP;
+	ret = i40e_program_fdir_filter(fd_data, raw_packet, pf, add);
+	if (ret) {
+		dev_info(&pf->pdev->dev,
+			 "PCTYPE:%d, Filter command send failed for fd_id:%d (ret = %d)\n",
+			 fd_data->pctype, fd_data->fd_id, ret);
+		/* Free the packet buffer since it wasn't added to the ring */
+		kfree(raw_packet);
+		return -EOPNOTSUPP;
+	} else if (I40E_DEBUG_FD & pf->hw.debug_mask) {
+		if (add)
+			dev_info(&pf->pdev->dev,
+				 "Filter OK for PCTYPE %d loc = %d\n",
+				 fd_data->pctype, fd_data->fd_id);
+		else
+			dev_info(&pf->pdev->dev,
+				 "Filter deleted for PCTYPE %d loc = %d\n",
+				 fd_data->pctype, fd_data->fd_id);
+	}
+
+	if (add)
+		pf->fd_sctp4_filter_cnt++;
+	else
+		pf->fd_sctp4_filter_cnt--;
+
+	return 0;
+}
+
 #define I40E_IP_DUMMY_PACKET_LEN 34
 /**
  * i40e_add_del_fdir_ipv4 - Add/Remove IPv4 Flow Director filters for
@@ -441,6 +515,9 @@ int i40e_add_del_fdir(struct i40e_vsi *vsi,
 	case UDP_V4_FLOW:
 		ret = i40e_add_del_fdir_udpv4(vsi, input, add);
 		break;
+	case SCTP_V4_FLOW:
+		ret = i40e_add_del_fdir_sctpv4(vsi, input, add);
+		break;
 	case IP_USER_FLOW:
 		switch (input->ip4_proto) {
 		case IPPROTO_TCP:
@@ -449,6 +526,9 @@ int i40e_add_del_fdir(struct i40e_vsi *vsi,
 		case IPPROTO_UDP:
 			ret = i40e_add_del_fdir_udpv4(vsi, input, add);
 			break;
+		case IPPROTO_SCTP:
+			ret = i40e_add_del_fdir_sctpv4(vsi, input, add);
+			break;
 		case IPPROTO_IP:
 			ret = i40e_add_del_fdir_ipv4(vsi, input, add);
 			break;
-- 
2.12.0.rc0.151.g8a5726c42288

