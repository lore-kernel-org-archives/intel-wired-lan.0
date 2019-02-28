From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Thu, 28 Feb 2019 15:24:28 -0800
Subject: [Intel-wired-lan] [PATCH S16 07/11] ice: Add priority information
 into VLAN header
In-Reply-To: <20190228232432.31659-1-anirudh.venkataramanan@intel.com>
References: <20190228232432.31659-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190228232432.31659-8-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch introduces a new function ice_tx_prepare_vlan_flags_dcb to
insert 802.1p priority information into the VLAN header

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 39 ++++++++++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_dcb_lib.h | 10 +++++++
 drivers/net/ethernet/intel/ice/ice_txrx.c    |  6 ++---
 drivers/net/ethernet/intel/ice/ice_txrx.h    |  2 ++
 4 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index 68df3d78a534..fe4765483040 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -359,6 +359,45 @@ int ice_init_pf_dcb(struct ice_pf *pf)
 	return err;
 }
 
+/**
+ * ice_tx_prepare_vlan_flags_dcb - prepare VLAN tagging for DCB
+ * @tx_ring: ring to send buffer on
+ * @first: pointer to struct ice_tx_buf
+ */
+int
+ice_tx_prepare_vlan_flags_dcb(struct ice_ring *tx_ring,
+			      struct ice_tx_buf *first)
+{
+	struct sk_buff *skb = first->skb;
+
+	if (!test_bit(ICE_FLAG_DCB_ENA, tx_ring->vsi->back->flags))
+		return 0;
+
+	/* Insert 802.1p priority into VLAN header */
+	if ((first->tx_flags & (ICE_TX_FLAGS_HW_VLAN | ICE_TX_FLAGS_SW_VLAN)) ||
+	    skb->priority != TC_PRIO_CONTROL) {
+		first->tx_flags &= ~ICE_TX_FLAGS_VLAN_PR_M;
+		/* Mask the lower 3 bits to set the 802.1p priority */
+		first->tx_flags |= (skb->priority & 0x7) <<
+				   ICE_TX_FLAGS_VLAN_PR_S;
+		if (first->tx_flags & ICE_TX_FLAGS_SW_VLAN) {
+			struct vlan_ethhdr *vhdr;
+			int rc;
+
+			rc = skb_cow_head(skb, 0);
+			if (rc < 0)
+				return rc;
+			vhdr = (struct vlan_ethhdr *)skb->data;
+			vhdr->h_vlan_TCI = htons(first->tx_flags >>
+						 ICE_TX_FLAGS_VLAN_S);
+		} else {
+			first->tx_flags |= ICE_TX_FLAGS_HW_VLAN;
+		}
+	}
+
+	return 0;
+}
+
 /**
  * ice_dcb_process_lldp_set_mib_change - Process MIB change
  * @pf: ptr to ice_pf
diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.h b/drivers/net/ethernet/intel/ice/ice_dcb_lib.h
index 449e3735ca1b..1a430a45acf7 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.h
@@ -12,6 +12,9 @@ u8 ice_dcb_get_ena_tc(struct ice_dcbx_cfg *dcbcfg);
 u8 ice_dcb_get_num_tc(struct ice_dcbx_cfg *dcbcfg);
 void ice_vsi_cfg_dcb_rings(struct ice_vsi *vsi);
 int ice_init_pf_dcb(struct ice_pf *pf);
+int
+ice_tx_prepare_vlan_flags_dcb(struct ice_ring *tx_ring,
+			      struct ice_tx_buf *first);
 void
 ice_dcb_process_lldp_set_mib_change(struct ice_pf *pf,
 				    struct ice_rq_event_info *event);
@@ -37,6 +40,13 @@ static inline int ice_init_pf_dcb(struct ice_pf *pf)
 	return -EOPNOTSUPP;
 }
 
+static inline int
+ice_tx_prepare_vlan_flags_dcb(struct ice_ring __always_unused *tx_ring,
+			      struct ice_tx_buf __always_unused *first)
+{
+	return 0;
+}
+
 #define ice_vsi_cfg_dcb_rings(vsi) do {} while (0)
 #define ice_dcb_process_lldp_set_mib_change(pf, event) do {} while (0)
 #define ice_set_cgd_num(tlan_ctx, ring) do {} while (0)
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 35ac0b84a6b4..4b08cb3be28e 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -6,6 +6,7 @@
 #include <linux/prefetch.h>
 #include <linux/mm.h>
 #include "ice.h"
+#include "ice_dcb_lib.h"
 
 #define ICE_RX_HDR_SIZE		256
 
@@ -1798,7 +1799,7 @@ ice_tx_prepare_vlan_flags(struct ice_ring *tx_ring, struct ice_tx_buf *first)
 		 * to the encapsulated ethertype.
 		 */
 		skb->protocol = vlan_get_protocol(skb);
-		goto out;
+		return 0;
 	}
 
 	/* if we have a HW VLAN tag being added, default to the HW one */
@@ -1820,8 +1821,7 @@ ice_tx_prepare_vlan_flags(struct ice_ring *tx_ring, struct ice_tx_buf *first)
 		first->tx_flags |= ICE_TX_FLAGS_SW_VLAN;
 	}
 
-out:
-	return 0;
+	return ice_tx_prepare_vlan_flags_dcb(tx_ring, first);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index 53903f846834..c75d9fd12a68 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -45,6 +45,8 @@
 #define ICE_TX_FLAGS_HW_VLAN	BIT(1)
 #define ICE_TX_FLAGS_SW_VLAN	BIT(2)
 #define ICE_TX_FLAGS_VLAN_M	0xffff0000
+#define ICE_TX_FLAGS_VLAN_PR_M	0xe0000000
+#define ICE_TX_FLAGS_VLAN_PR_S	29
 #define ICE_TX_FLAGS_VLAN_S	16
 
 #define ICE_RX_DMA_ATTR \
-- 
2.14.5

