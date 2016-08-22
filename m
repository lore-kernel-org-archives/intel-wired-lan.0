From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Mon, 22 Aug 2016 16:17:46 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: simplify the logic for setting
	VLAN filtering
Message-ID: <20160822231746.7715.25120.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Simplify the logic for setting VLNCTRL.VFE by checking the  VMDQ flag
and 82598 MAC instead of having to maintain a list of MAC types.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   39 +++++++------------------
 1 file changed, 11 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index d76bc1a..1c88858 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -4105,23 +4105,20 @@ static void ixgbe_vlan_promisc_enable(struct ixgbe_adapter *adapter)
 
 	vlnctrl = IXGBE_READ_REG(hw, IXGBE_VLNCTRL);
 
-	switch (hw->mac.type) {
-	case ixgbe_mac_82599EB:
-	case ixgbe_mac_X540:
-	case ixgbe_mac_X550:
-	case ixgbe_mac_X550EM_x:
-	case ixgbe_mac_x550em_a:
-	default:
-		if (adapter->flags & IXGBE_FLAG_VMDQ_ENABLED)
-			break;
-		/* fall through */
-	case ixgbe_mac_82598EB:
-		/* legacy case, we can just disable VLAN filtering */
+	if (adapter->flags & IXGBE_FLAG_VMDQ_ENABLED) {
+	/* For VMDq and SR-IOV we must leave VLAN filtering enabled */
+		vlnctrl |= IXGBE_VLNCTRL_VFE;
+		IXGBE_WRITE_REG(hw, IXGBE_VLNCTRL, vlnctrl);
+	} else {
 		vlnctrl &= ~IXGBE_VLNCTRL_VFE;
 		IXGBE_WRITE_REG(hw, IXGBE_VLNCTRL, vlnctrl);
 		return;
 	}
 
+	/* Nothing to do for 82598 */
+	if (hw->mac.type == ixgbe_mac_82598EB)
+		return;
+
 	/* We are already in VLAN promisc, nothing to do */
 	if (adapter->flags2 & IXGBE_FLAG2_VLAN_PROMISC)
 		return;
@@ -4129,10 +4126,6 @@ static void ixgbe_vlan_promisc_enable(struct ixgbe_adapter *adapter)
 	/* Set flag so we don't redo unnecessary work */
 	adapter->flags2 |= IXGBE_FLAG2_VLAN_PROMISC;
 
-	/* For VMDq and SR-IOV we must leave VLAN filtering enabled */
-	vlnctrl |= IXGBE_VLNCTRL_VFE;
-	IXGBE_WRITE_REG(hw, IXGBE_VLNCTRL, vlnctrl);
-
 	/* Add PF to all active pools */
 	for (i = IXGBE_VLVF_ENTRIES; --i;) {
 		u32 reg_offset = IXGBE_VLVFB(i * 2 + VMDQ_P(0) / 32);
@@ -4204,19 +4197,9 @@ static void ixgbe_vlan_promisc_disable(struct ixgbe_adapter *adapter)
 	vlnctrl |= IXGBE_VLNCTRL_VFE;
 	IXGBE_WRITE_REG(hw, IXGBE_VLNCTRL, vlnctrl);
 
-	switch (hw->mac.type) {
-	case ixgbe_mac_82599EB:
-	case ixgbe_mac_X540:
-	case ixgbe_mac_X550:
-	case ixgbe_mac_X550EM_x:
-	case ixgbe_mac_x550em_a:
-	default:
-		if (adapter->flags & IXGBE_FLAG_VMDQ_ENABLED)
-			break;
-		/* fall through */
-	case ixgbe_mac_82598EB:
+	if (!(adapter->flags & IXGBE_FLAG_VMDQ_ENABLED) ||
+	    hw->mac.type == ixgbe_mac_82598EB)
 		return;
-	}
 
 	/* We are not in VLAN promisc, nothing to do */
 	if (!(adapter->flags2 & IXGBE_FLAG2_VLAN_PROMISC))

