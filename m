From: Neerav Parikh <neerav.parikh@intel.com>
Date: Tue, 08 Dec 2015 22:13:58 -0800
Subject: [Intel-wired-lan] [PATCH v2] ixgbe: Fix MDD events generated when
 FCoE+SRIOV are enabled
Message-ID: <20151209061358.17965.8368.stgit@neerav-dbg1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When FCoE is enabled with SR-IOV on the X550 NIC the hardware
generates MDD events.

This patch fixes these by setting the expected values in the
Tx context descriptors for FCoE/FIP frames and adding a flush
after writing the RDLEN register.

Changes in v2:
- Removed updating the skb network header for FIP frames

Signed-off-by: Neerav Parikh <neerav.parikh@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c |    5 ++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    3 +++
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |    1 +
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
index 5f98870..78ffef4 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
@@ -517,6 +517,7 @@ int ixgbe_fso(struct ixgbe_ring *tx_ring,
 	u32 vlan_macip_lens;
 	u32 fcoe_sof_eof = 0;
 	u32 mss_l4len_idx;
+	u32 type_tucmd = IXGBE_ADVTXT_TUCMD_FCOE;
 	u8 sof, eof;
 
 	if (skb_is_gso(skb) && (skb_shinfo(skb)->gso_type != SKB_GSO_FCOE)) {
@@ -593,6 +594,8 @@ int ixgbe_fso(struct ixgbe_ring *tx_ring,
 					       skb_shinfo(skb)->gso_size);
 		first->bytecount += (first->gso_segs - 1) * *hdr_len;
 		first->tx_flags |= IXGBE_TX_FLAGS_TSO;
+		/* Hardware expects L4T to be RSV for FCoE TSO */
+		type_tucmd |= IXGBE_ADVTXD_TUCMD_L4T_RSV;
 	}
 
 	/* set flag indicating FCOE to ixgbe_tx_map call */
@@ -610,7 +613,7 @@ int ixgbe_fso(struct ixgbe_ring *tx_ring,
 
 	/* write context desc */
 	ixgbe_tx_ctxtdesc(tx_ring, vlan_macip_lens, fcoe_sof_eof,
-			  IXGBE_ADVTXT_TUCMD_FCOE, mss_l4len_idx);
+			  type_tucmd, mss_l4len_idx);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index ebd4522..ed566e4 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -3619,6 +3619,9 @@ void ixgbe_configure_rx_ring(struct ixgbe_adapter *adapter,
 	IXGBE_WRITE_REG(hw, IXGBE_RDBAH(reg_idx), (rdba >> 32));
 	IXGBE_WRITE_REG(hw, IXGBE_RDLEN(reg_idx),
 			ring->count * sizeof(union ixgbe_adv_rx_desc));
+	/* Force flushing of IXGBE_RDLEN to prevent MDD */
+	IXGBE_WRITE_FLUSH(hw);
+
 	IXGBE_WRITE_REG(hw, IXGBE_RDH(reg_idx), 0);
 	IXGBE_WRITE_REG(hw, IXGBE_RDT(reg_idx), 0);
 	ring->tail = adapter->io_addr + IXGBE_RDT(reg_idx);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 1329edd..e93c264 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -2780,6 +2780,7 @@ struct ixgbe_adv_tx_context_desc {
 #define IXGBE_ADVTXD_TUCMD_L4T_UDP   0x00000000  /* L4 Packet TYPE of UDP */
 #define IXGBE_ADVTXD_TUCMD_L4T_TCP   0x00000800  /* L4 Packet TYPE of TCP */
 #define IXGBE_ADVTXD_TUCMD_L4T_SCTP  0x00001000  /* L4 Packet TYPE of SCTP */
+#define IXGBE_ADVTXD_TUCMD_L4T_RSV     0x00001800 /* RSV L4 Packet TYPE */
 #define IXGBE_ADVTXD_TUCMD_MKRREQ    0x00002000 /*Req requires Markers and CRC*/
 #define IXGBE_ADVTXD_POPTS_IPSEC      0x00000400 /* IPSec offload request */
 #define IXGBE_ADVTXD_TUCMD_IPSEC_TYPE_ESP 0x00002000 /* IPSec Type ESP */

