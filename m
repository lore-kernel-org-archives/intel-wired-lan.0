From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
Date: Wed, 13 Apr 2016 03:08:25 -0700
Subject: [Intel-wired-lan] [next PATCH S34 05/12] i40e: Flow-based side-band
	filter count and its use for input set change
In-Reply-To: <1460542112-20166-1-git-send-email-harshitha.ramamurthy@intel.com>
References: <1460542112-20166-1-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <1460542112-20166-6-git-send-email-harshitha.ramamurthy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Kiran Patil <kiran.patil@intel.com>

This patch keeps track of side-band filters based on flow-type.
It is used to handle detection of input set mask changes per
flow-type.

Signed-off-by: Kiran Patil <kiran.patil@intel.com>
Change-Id: I5f308dbd33d3c6ae9f5db301b5989b6089f61dce
---
Testing Hints :
	ethtool -N p5p2 flow-type tcp4 src-ip 192.168.0.2 \
		 dst-ip 192.168.0.1 action 40
	ethtool -N p5p2 flow-type udp4 src-ip 192.168.0.2 \
		 dst-ip 192.168.0.1 src-port 1000 action 41
Made sure that, able to change input set mask independently based on
flow-type.

 drivers/net/ethernet/intel/i40e/i40e.h         |  9 +++++++++
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  9 +++++++--
 drivers/net/ethernet/intel/i40e/i40e_txrx.c    | 24 +++++++++++++++++++++---
 3 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 1f48e10..ceb848a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -308,6 +308,15 @@ struct i40e_pf {
 	u32 fd_atr_cnt;
 	u32 fd_tcp_rule;
 
+	/* Book-keeping of side-band filter count per flow-type.
+	 * This is used to detect and handle input set changes for
+	 * respective flow-type.
+	 */
+	u16 fd_tcp4_filter_cnt;
+	u16 fd_udp4_filter_cnt;
+	u16 fd_sctp4_filter_cnt;
+	u16 fd_ip4_filter_cnt;
+
 	struct i40e_udp_port_config udp_ports[I40E_MAX_PF_UDP_OFFLOAD_PORTS];
 	u16 pending_udp_bitmap;
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index ada448b..865c8db 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2500,6 +2500,7 @@ static int i40e_handle_input_set(struct i40e_vsi *vsi,
 {
 	bool inset_mask_change = false;
 	struct i40e_pf *pf;
+	u16 filter_cnt;
 	u64 val;
 	u8 idx;
 
@@ -2510,9 +2511,11 @@ static int i40e_handle_input_set(struct i40e_vsi *vsi,
 	switch (fsp->flow_type & FLOW_TYPE_MASK) {
 	case TCP_V4_FLOW:
 		idx = I40E_FILTER_PCTYPE_NONF_IPV4_TCP;
+		filter_cnt = pf->fd_tcp4_filter_cnt;
 		break;
 	case UDP_V4_FLOW:
 		idx = I40E_FILTER_PCTYPE_NONF_IPV4_UDP;
+		filter_cnt = pf->fd_udp4_filter_cnt;
 		break;
 	default:
 		/* for all other flow types */
@@ -2578,8 +2581,10 @@ static int i40e_handle_input_set(struct i40e_vsi *vsi,
 			netif_err(pf, drv, vsi->netdev, "Change of input set is not supported when MFP mode is enabled\n");
 			return -EOPNOTSUPP;
 		}
-		if (pf->fdir_pf_active_filters) {
-			netif_err(pf, drv, vsi->netdev, "Change of input set is not supported when there are existing filters. Please delete them and re-try\n");
+
+		if (filter_cnt) {
+			netif_err(pf, drv, vsi->netdev, "Change of input set is not supported when there are existing filter(%u) for specified flow-type: %u. Please delete them and re-try\n",
+				  filter_cnt, fsp->flow_type & FLOW_TYPE_MASK);
 			return -EOPNOTSUPP;
 		}
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 05293f6..808922b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -235,8 +235,14 @@ static int i40e_add_del_fdir_udpv4(struct i40e_vsi *vsi,
 				 "Filter deleted for PCTYPE %d loc = %d\n",
 				 fd_data->pctype, fd_data->fd_id);
 	}
-	if (err)
+	if (err) {
 		kfree(raw_packet);
+	} else {
+		if (add)
+			pf->fd_udp4_filter_cnt++;
+		else
+			pf->fd_udp4_filter_cnt--;
+	}
 
 	return err ? -EOPNOTSUPP : 0;
 }
@@ -315,8 +321,14 @@ static int i40e_add_del_fdir_tcpv4(struct i40e_vsi *vsi,
 				 fd_data->pctype, fd_data->fd_id);
 	}
 
-	if (err)
+	if (err) {
 		kfree(raw_packet);
+	} else {
+		if (add)
+			pf->fd_tcp4_filter_cnt++;
+		else
+			pf->fd_tcp4_filter_cnt--;
+	}
 
 	return err ? -EOPNOTSUPP : 0;
 }
@@ -393,8 +405,14 @@ static int i40e_add_del_fdir_ipv4(struct i40e_vsi *vsi,
 		}
 	}
 
-	if (err)
+	if (err) {
 		kfree(raw_packet);
+	} else {
+		if (add)
+			pf->fd_ip4_filter_cnt++;
+		else
+			pf->fd_ip4_filter_cnt--;
+	}
 
 	return err ? -EOPNOTSUPP : 0;
 }
-- 
2.4.3

