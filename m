From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Thu, 17 May 2018 11:22:47 -0700
Subject: [Intel-wired-lan] [RFC PATCH 3/6] ixgbe: add VF IPsec offload
 request message handling
In-Reply-To: <1526581370-30307-1-git-send-email-shannon.nelson@oracle.com>
References: <1526581370-30307-1-git-send-email-shannon.nelson@oracle.com>
Message-ID: <1526581370-30307-4-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add an add and a delete message for IPsec offload requests from
the VF.  These call into the ipsec functions that can translate
the message buffer into a useful IPsec offload.

These new messages bump the mbox API version to 1.4.

Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h       |  9 +++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h   |  5 +++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 17 ++++++++++++++++-
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 4f08c71..b75ae5d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -1030,6 +1030,9 @@ void ixgbe_ipsec_rx(struct ixgbe_ring *rx_ring,
 		    struct sk_buff *skb);
 int ixgbe_ipsec_tx(struct ixgbe_ring *tx_ring, struct ixgbe_tx_buffer *first,
 		   struct ixgbe_ipsec_tx_data *itd);
+void ixgbe_ipsec_vf_clear(struct ixgbe_adapter *adapter, u32 vf);
+int ixgbe_ipsec_vf_add_sa(struct ixgbe_adapter *adapter, u32 *mbuf, u32 vf);
+int ixgbe_ipsec_vf_del_sa(struct ixgbe_adapter *adapter, u32 *mbuf, u32 vf);
 #else
 static inline void ixgbe_init_ipsec_offload(struct ixgbe_adapter *adapter) { };
 static inline void ixgbe_stop_ipsec_offload(struct ixgbe_adapter *adapter) { };
@@ -1040,5 +1043,11 @@ static inline void ixgbe_ipsec_rx(struct ixgbe_ring *rx_ring,
 static inline int ixgbe_ipsec_tx(struct ixgbe_ring *tx_ring,
 				 struct ixgbe_tx_buffer *first,
 				 struct ixgbe_ipsec_tx_data *itd) { return 0; };
+static inline void ixgbe_ipsec_vf_clear(struct ixgbe_adapter *adapter,
+					u32 vf) { };
+static inline int ixgbe_ipsec_vf_add_sa(struct ixgbe_adapter *adapter,
+					u32 *mbuf, u32 vf) { return -EACCES; };
+static inline int ixgbe_ipsec_vf_del_sa(struct ixgbe_adapter *adapter,
+					u32 *mbuf, u32 vf) { return -EACCES; };
 #endif /* CONFIG_XFRM_OFFLOAD */
 #endif /* _IXGBE_H_ */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h
index c4628b6..ad9aeaf 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h
@@ -76,6 +76,7 @@ enum ixgbe_pfvf_api_rev {
 	ixgbe_mbox_api_11,	/* API version 1.1, linux/freebsd VF driver */
 	ixgbe_mbox_api_12,	/* API version 1.2, linux/freebsd VF driver */
 	ixgbe_mbox_api_13,	/* API version 1.3, linux/freebsd VF driver */
+	ixgbe_mbox_api_14,	/* API version 1.4, linux/freebsd VF driver */
 	/* This value should always be last */
 	ixgbe_mbox_api_unknown,	/* indicates that API version is not known */
 };
@@ -106,6 +107,10 @@ enum ixgbe_pfvf_api_rev {
 
 #define IXGBE_VF_UPDATE_XCAST_MODE	0x0c
 
+/* mailbox API, version 1.4 VF requests */
+#define IXGBE_VF_IPSEC_ADD	0x0d
+#define IXGBE_VF_IPSEC_DEL	0x0e
+
 /* length of permanent address message returned from PF */
 #define IXGBE_VF_PERMADDR_MSG_LEN 4
 /* word in permanent address message with the current multicast type */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index 008aa07..7d992361 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -515,6 +515,7 @@ static s32 ixgbe_set_vf_lpe(struct ixgbe_adapter *adapter, u32 *msgbuf, u32 vf)
 		case ixgbe_mbox_api_11:
 		case ixgbe_mbox_api_12:
 		case ixgbe_mbox_api_13:
+		case ixgbe_mbox_api_14:
 			/* Version 1.1 supports jumbo frames on VFs if PF has
 			 * jumbo frames enabled which means legacy VFs are
 			 * disabled
@@ -742,6 +743,9 @@ static inline void ixgbe_vf_reset_event(struct ixgbe_adapter *adapter, u32 vf)
 	/* reset multicast table array for vf */
 	adapter->vfinfo[vf].num_vf_mc_hashes = 0;
 
+	/* clear any ipsec table info */
+	ixgbe_ipsec_vf_clear(adapter, vf);
+
 	/* Flush and reset the mta with the new values */
 	ixgbe_set_rx_mode(adapter->netdev);
 
@@ -996,6 +1000,7 @@ static int ixgbe_negotiate_vf_api(struct ixgbe_adapter *adapter,
 	case ixgbe_mbox_api_11:
 	case ixgbe_mbox_api_12:
 	case ixgbe_mbox_api_13:
+	case ixgbe_mbox_api_14:
 		adapter->vfinfo[vf].vf_api = api;
 		return 0;
 	default:
@@ -1021,6 +1026,7 @@ static int ixgbe_get_vf_queues(struct ixgbe_adapter *adapter,
 	case ixgbe_mbox_api_11:
 	case ixgbe_mbox_api_12:
 	case ixgbe_mbox_api_13:
+	case ixgbe_mbox_api_14:
 		break;
 	default:
 		return -1;
@@ -1061,6 +1067,7 @@ static int ixgbe_get_vf_reta(struct ixgbe_adapter *adapter, u32 *msgbuf, u32 vf)
 
 	/* verify the PF is supporting the correct API */
 	switch (adapter->vfinfo[vf].vf_api) {
+	case ixgbe_mbox_api_14:
 	case ixgbe_mbox_api_13:
 	case ixgbe_mbox_api_12:
 		break;
@@ -1093,6 +1100,7 @@ static int ixgbe_get_vf_rss_key(struct ixgbe_adapter *adapter,
 
 	/* verify the PF is supporting the correct API */
 	switch (adapter->vfinfo[vf].vf_api) {
+	case ixgbe_mbox_api_14:
 	case ixgbe_mbox_api_13:
 	case ixgbe_mbox_api_12:
 		break;
@@ -1118,8 +1126,9 @@ static int ixgbe_update_vf_xcast_mode(struct ixgbe_adapter *adapter,
 		/* promisc introduced in 1.3 version */
 		if (xcast_mode == IXGBEVF_XCAST_MODE_PROMISC)
 			return -EOPNOTSUPP;
-		/* Fall threw */
+		/* Fall through */
 	case ixgbe_mbox_api_13:
+	case ixgbe_mbox_api_14:
 		break;
 	default:
 		return -EOPNOTSUPP;
@@ -1245,6 +1254,12 @@ static int ixgbe_rcv_msg_from_vf(struct ixgbe_adapter *adapter, u32 vf)
 	case IXGBE_VF_UPDATE_XCAST_MODE:
 		retval = ixgbe_update_vf_xcast_mode(adapter, msgbuf, vf);
 		break;
+	case IXGBE_VF_IPSEC_ADD:
+		retval = ixgbe_ipsec_vf_add_sa(adapter, msgbuf, vf);
+		break;
+	case IXGBE_VF_IPSEC_DEL:
+		retval = ixgbe_ipsec_vf_del_sa(adapter, msgbuf, vf);
+		break;
 	default:
 		e_err(drv, "Unhandled Msg %8.8x\n", msgbuf[0]);
 		retval = IXGBE_ERR_MBX;
-- 
2.7.4

