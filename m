From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
Date: Tue, 12 Apr 2016 08:30:45 -0700
Subject: [Intel-wired-lan] [next PATCH S33 06/13] i40e: Allow user to change
	input set mask for flow director
In-Reply-To: <1460475052-6348-1-git-send-email-harshitha.ramamurthy@intel.com>
References: <1460475052-6348-1-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <1460475052-6348-7-git-send-email-harshitha.ramamurthy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Kiran Patil <kiran.patil@intel.com>

This patch implements feature, which allows user to change
input set mask for flow director using side-band channel.
This patch adds definition of FLOW_TYPE_MASK into the header file.
With this patch, user can now specify less than 4 tuple(src ip, dsp ip,
src port, dst port) for flow type tcp4/udp4.

Signed-off-by: Kiran Patil <kiran.patil@intel.com>
Change-Id: I90052508f8c172c0da5a4b78b949704b4a59ea78
---
Testing Hints :
e.g. Using ethtoool, side-band filters are programmed such as:
	ethtool -N p5p2 flow-type tcp4 src-ip 192.168.0.2 \
				dst-ip 192.168.0.1 action 40
	ethtool -N p5p2 flow-type tcp4 src-ip 192.168.0.2 action 41
	ethtool -N p5p2 flow-type tcp4 dst-ip 192.168.0.1 action 42
	ethtool -N p5p2 flow-type tcp4 dst-port 5001 action 43
    What to look for to see if side-band filter is matched or not:
	Look into port stats (using ethtool -S <ethx> | grep fdir) and
        specifically look for 'fdir_sb_match'. This counter should be
        incremented whenever filter is matched.

 drivers/net/ethernet/intel/i40e/i40e.h         |   6 ++
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 116 +++++++++++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_txrx.c    |   2 +-
 3 files changed, 123 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index e312adf..1f48e10 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -240,6 +240,12 @@ struct i40e_fdir_filter {
 	u32 fd_id;
 };
 
+#ifndef FLOW_TYPE_MASK
+#define FLOW_TYPE_MASK  0xFF
+#else
+#error FLOW_TYPE_MASK already defined elsewhere
+#endif
+
 #define I40E_ETH_P_LLDP			0x88cc
 
 #define I40E_DCB_PRIO_TYPE_STRICT	0
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 8e56c43..ada448b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2488,6 +2488,116 @@ static int i40e_del_fdir_entry(struct i40e_vsi *vsi,
 }
 
 /**
+ * i40e_handle_input_set - Detect and handle input set changes
+ * @vsi: pointer to the targeted VSI
+ * @fsp: pointer to RX flow classification spec
+ *
+ * Reads register, detect change in input set based on existing register
+ * value and what user has passed. Update input set mask register if needed.
+ **/
+static int i40e_handle_input_set(struct i40e_vsi *vsi,
+				 struct ethtool_rx_flow_spec *fsp)
+{
+	bool inset_mask_change = false;
+	struct i40e_pf *pf;
+	u64 val;
+	u8 idx;
+
+	if (unlikely(!vsi))
+		return -EINVAL;
+
+	pf = vsi->back;
+	switch (fsp->flow_type & FLOW_TYPE_MASK) {
+	case TCP_V4_FLOW:
+		idx = I40E_FILTER_PCTYPE_NONF_IPV4_TCP;
+		break;
+	case UDP_V4_FLOW:
+		idx = I40E_FILTER_PCTYPE_NONF_IPV4_UDP;
+		break;
+	default:
+		/* for all other flow types */
+		return 0;
+	}
+
+	val = ((u64)i40e_read_rx_ctl(&pf->hw,
+				     I40E_PRTQF_FD_INSET(idx, 1)) << 32) |
+	       (u64)i40e_read_rx_ctl(&pf->hw,
+				     I40E_PRTQF_FD_INSET(idx, 0));
+
+	/* Default input set (TCP/UDP/SCTP) contains following
+	 * fields: srcip + dest ip + src port + dest port
+	 * For SCTP, there is one extra field, "verification tag"
+	 */
+	if (val & I40E_L3_SRC_MASK) {
+		if (!fsp->h_u.tcp_ip4_spec.ip4src) {
+			val &= ~I40E_L3_SRC_MASK;
+			inset_mask_change = true;
+		}
+	} else {
+		if (fsp->h_u.tcp_ip4_spec.ip4src) {
+			val |= I40E_L3_SRC_MASK;
+			inset_mask_change = true;
+		}
+	}
+	if (val & I40E_L3_DST_MASK) {
+		if (!fsp->h_u.tcp_ip4_spec.ip4dst) {
+			val &= ~I40E_L3_DST_MASK;
+			inset_mask_change = true;
+		}
+	} else {
+		if (fsp->h_u.tcp_ip4_spec.ip4dst) {
+			val |= I40E_L3_DST_MASK;
+			inset_mask_change = true;
+		}
+	}
+	if (val & I40E_L4_SRC_MASK) {
+		if (!fsp->h_u.tcp_ip4_spec.psrc) {
+			val &= ~I40E_L4_SRC_MASK;
+			inset_mask_change = true;
+		}
+	} else {
+		if (fsp->h_u.tcp_ip4_spec.psrc) {
+			val |= I40E_L4_SRC_MASK;
+			inset_mask_change = true;
+		}
+	}
+	if (val & I40E_L4_DST_MASK) {
+		if (!fsp->h_u.tcp_ip4_spec.pdst) {
+			val &= ~I40E_L4_DST_MASK;
+			inset_mask_change = true;
+		}
+	} else {
+		if (fsp->h_u.tcp_ip4_spec.pdst) {
+			val |= I40E_L4_DST_MASK;
+			inset_mask_change = true;
+		}
+	}
+
+	if (inset_mask_change) {
+		if (pf->flags & I40E_FLAG_MFP_ENABLED) {
+			netif_err(pf, drv, vsi->netdev, "Change of input set is not supported when MFP mode is enabled\n");
+			return -EOPNOTSUPP;
+		}
+		if (pf->fdir_pf_active_filters) {
+			netif_err(pf, drv, vsi->netdev, "Change of input set is not supported when there are existing filters. Please delete them and re-try\n");
+			return -EOPNOTSUPP;
+		}
+
+		if (I40E_DEBUG_FD & pf->hw.debug_mask)
+			netif_info(pf, drv, vsi->netdev, "FD_INSET mask is changing to 0x%016llx\n",
+				   val);
+		/* Update input mask register since input set mask changed */
+		i40e_write_rx_ctl(&pf->hw, I40E_PRTQF_FD_INSET(idx, 1),
+				  (u32)(val >> 32));
+		i40e_write_rx_ctl(&pf->hw, I40E_PRTQF_FD_INSET(idx, 0),
+				  (u32)val);
+		netif_info(pf, drv, vsi->netdev, "Input set mask change has been successful. Please note that this and all other interfaces on (related and derived from) this part are affected as well.\n");
+	}
+
+	return 0;
+}
+
+/**
  * i40e_add_fdir_ethtool - Add/Remove Flow Director filters
  * @vsi: pointer to the targeted VSI
  * @cmd: command to get or set RX flow classification rules
@@ -2562,6 +2672,12 @@ static int i40e_add_fdir_ethtool(struct i40e_vsi *vsi,
 	input->dst_ip[0] = fsp->h_u.tcp_ip4_spec.ip4src;
 	input->src_ip[0] = fsp->h_u.tcp_ip4_spec.ip4dst;
 
+	ret = i40e_handle_input_set(vsi, fsp);
+	if (ret) {
+		netif_err(pf, drv, vsi->netdev, "Unable to handle change in input set mask\n");
+		goto free_input;
+	}
+
 	if (ntohl(fsp->m_ext.data[1])) {
 		vf_id = ntohl(fsp->h_ext.data[1]);
 		if (vf_id >= pf->num_alloc_vfs) {
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 7cad832..f4af60c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -412,7 +412,7 @@ int i40e_add_del_fdir(struct i40e_vsi *vsi,
 	struct i40e_pf *pf = vsi->back;
 	int ret;
 
-	switch (input->flow_type & ~FLOW_EXT) {
+	switch (input->flow_type & FLOW_TYPE_MASK) {
 	case TCP_V4_FLOW:
 		ret = i40e_add_del_fdir_tcpv4(vsi, input, add);
 		break;
-- 
2.4.3

