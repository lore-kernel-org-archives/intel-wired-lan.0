From: Andre Guedes <andre.guedes@intel.com>
Date: Fri,  3 Apr 2020 11:17:40 -0700
Subject: [Intel-wired-lan] [PATCH 1/4] igc: Rename IGC_VLAPQF macro
In-Reply-To: <20200403181743.23447-1-andre.guedes@intel.com>
References: <20200403181743.23447-1-andre.guedes@intel.com>
Message-ID: <20200403181743.23447-2-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch renames the IGC_VLAPQF macro to IGC_VLANPQF as well as
related macros so they match the register name and fields described in
the datasheet.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h |  6 +++---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 21 ++++++++++----------
 drivers/net/ethernet/intel/igc/igc_regs.h    |  2 +-
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 63d3d34763da..a4edf344bd63 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -514,9 +514,9 @@
 #define IGC_MAX_MAC_HDR_LEN	127
 #define IGC_MAX_NETWORK_HDR_LEN	511
 
-#define IGC_VLAPQF_QUEUE_SEL(_n, q_idx) ((q_idx) << ((_n) * 4))
-#define IGC_VLAPQF_P_VALID(_n)	(0x1 << (3 + (_n) * 4))
-#define IGC_VLAPQF_QUEUE_MASK	0x03
+#define IGC_VLANPQF_QSEL(_n, q_idx) ((q_idx) << ((_n) * 4))
+#define IGC_VLANPQF_VALID(_n)	(0x1 << (3 + (_n) * 4))
+#define IGC_VLANPQF_QUEUE_MASK	0x03
 
 #define IGC_ADVTXD_MACLEN_SHIFT		9  /* Adv ctxt desc mac len shift */
 #define IGC_ADVTXD_TUCMD_L4T_UDP	0x00000000  /* L4 Packet TYPE of UDP */
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 47115d73ea61..9811b26f3c59 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1229,23 +1229,23 @@ static int igc_rxnfc_write_vlan_prio_filter(struct igc_adapter *adapter,
 	u16 queue_index;
 	u32 vlapqf;
 
-	vlapqf = rd32(IGC_VLAPQF);
+	vlapqf = rd32(IGC_VLANPQF);
 	vlan_priority = (ntohs(input->filter.vlan_tci) & VLAN_PRIO_MASK)
 				>> VLAN_PRIO_SHIFT;
-	queue_index = (vlapqf >> (vlan_priority * 4)) & IGC_VLAPQF_QUEUE_MASK;
+	queue_index = (vlapqf >> (vlan_priority * 4)) & IGC_VLANPQF_QUEUE_MASK;
 
 	/* check whether this vlan prio is already set */
-	if (vlapqf & IGC_VLAPQF_P_VALID(vlan_priority) &&
+	if (vlapqf & IGC_VLANPQF_VALID(vlan_priority) &&
 	    queue_index != input->action) {
 		netdev_err(adapter->netdev,
 			   "ethtool rxnfc set vlan prio filter failed");
 		return -EEXIST;
 	}
 
-	vlapqf |= IGC_VLAPQF_P_VALID(vlan_priority);
-	vlapqf |= IGC_VLAPQF_QUEUE_SEL(vlan_priority, input->action);
+	vlapqf |= IGC_VLANPQF_VALID(vlan_priority);
+	vlapqf |= IGC_VLANPQF_QSEL(vlan_priority, input->action);
 
-	wr32(IGC_VLAPQF, vlapqf);
+	wr32(IGC_VLANPQF, vlapqf);
 
 	return 0;
 }
@@ -1313,12 +1313,11 @@ static void igc_clear_vlan_prio_filter(struct igc_adapter *adapter,
 
 	vlan_priority = (vlan_tci & VLAN_PRIO_MASK) >> VLAN_PRIO_SHIFT;
 
-	vlapqf = rd32(IGC_VLAPQF);
-	vlapqf &= ~IGC_VLAPQF_P_VALID(vlan_priority);
-	vlapqf &= ~IGC_VLAPQF_QUEUE_SEL(vlan_priority,
-						IGC_VLAPQF_QUEUE_MASK);
+	vlapqf = rd32(IGC_VLANPQF);
+	vlapqf &= ~IGC_VLANPQF_VALID(vlan_priority);
+	vlapqf &= ~IGC_VLANPQF_QSEL(vlan_priority, IGC_VLANPQF_QUEUE_MASK);
 
-	wr32(IGC_VLAPQF, vlapqf);
+	wr32(IGC_VLANPQF, vlapqf);
 }
 
 int igc_erase_filter(struct igc_adapter *adapter, struct igc_nfc_filter *input)
diff --git a/drivers/net/ethernet/intel/igc/igc_regs.h b/drivers/net/ethernet/intel/igc/igc_regs.h
index 7bfba20bf207..ab8ac46d381a 100644
--- a/drivers/net/ethernet/intel/igc/igc_regs.h
+++ b/drivers/net/ethernet/intel/igc/igc_regs.h
@@ -123,7 +123,7 @@
 #define IGC_UTA			0x0A000  /* Unicast Table Array - RW */
 #define IGC_RAL(_n)		(0x05400 + ((_n) * 0x08))
 #define IGC_RAH(_n)		(0x05404 + ((_n) * 0x08))
-#define IGC_VLAPQF		0x055B0  /* VLAN Priority Queue Filter VLAPQF */
+#define IGC_VLANPQF		0x055B0  /* VLAN Priority Queue Filter - RW */
 
 /* Transmit Register Descriptions */
 #define IGC_TCTL		0x00400  /* Tx Control - RW */
-- 
2.26.0

