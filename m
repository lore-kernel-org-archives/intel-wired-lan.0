From: Alexander Duyck <alexander.h.duyck@intel.com>
Date: Thu, 11 Aug 2016 14:51:56 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: Force VLNCTRL.VFE to be set in all
	VMDq paths
Message-ID: <147095231662.4841.672399088639313718.stgit@ahduyck-desk.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When I was adding the code for enabling VLAN promiscuous mode with SR-IOV
enabled I had inadvertently left the VLNCTRL.VFE bit unchanged as I has
assumed there was code in another path that was setting it when we enabled
SR-IOV.  This wasn't the case and as a result we were just disabling VLAN
filtering for all the VFs apparently.

Also the previous patches were always clearing CFIEN which was always set
to 0 by the hardware anyway so I am dropping the redundant bit clearing.

Fixes: 16369564915a ("ixgbe: Add support for VLAN promiscuous with SR-IOV")
Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index e06ca55..fa7fa09 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -4102,6 +4102,8 @@ static void ixgbe_vlan_promisc_enable(struct ixgbe_adapter *adapter)
 	struct ixgbe_hw *hw = &adapter->hw;
 	u32 vlnctrl, i;
 
+	vlnctrl = IXGBE_READ_REG(hw, IXGBE_VLNCTRL);
+
 	switch (hw->mac.type) {
 	case ixgbe_mac_82599EB:
 	case ixgbe_mac_X540:
@@ -4114,8 +4116,7 @@ static void ixgbe_vlan_promisc_enable(struct ixgbe_adapter *adapter)
 		/* fall through */
 	case ixgbe_mac_82598EB:
 		/* legacy case, we can just disable VLAN filtering */
-		vlnctrl = IXGBE_READ_REG(hw, IXGBE_VLNCTRL);
-		vlnctrl &= ~(IXGBE_VLNCTRL_VFE | IXGBE_VLNCTRL_CFIEN);
+		vlnctrl &= ~IXGBE_VLNCTRL_VFE;
 		IXGBE_WRITE_REG(hw, IXGBE_VLNCTRL, vlnctrl);
 		return;
 	}
@@ -4127,6 +4128,10 @@ static void ixgbe_vlan_promisc_enable(struct ixgbe_adapter *adapter)
 	/* Set flag so we don't redo unnecessary work */
 	adapter->flags2 |= IXGBE_FLAG2_VLAN_PROMISC;
 
+	/* For VMDq and SR-IOV we must leave VLAN filtering enabled */
+	vlnctrl |= IXGBE_VLNCTRL_VFE;
+	IXGBE_WRITE_REG(hw, IXGBE_VLNCTRL, vlnctrl);
+
 	/* Add PF to all active pools */
 	for (i = IXGBE_VLVF_ENTRIES; --i;) {
 		u32 reg_offset = IXGBE_VLVFB(i * 2 + VMDQ_P(0) / 32);
@@ -4193,6 +4198,11 @@ static void ixgbe_vlan_promisc_disable(struct ixgbe_adapter *adapter)
 	struct ixgbe_hw *hw = &adapter->hw;
 	u32 vlnctrl, i;
 
+	/* Set VLAN filtering to enabled */
+	vlnctrl = IXGBE_READ_REG(hw, IXGBE_VLNCTRL);
+	vlnctrl |= IXGBE_VLNCTRL_VFE;
+	IXGBE_WRITE_REG(hw, IXGBE_VLNCTRL, vlnctrl);
+
 	switch (hw->mac.type) {
 	case ixgbe_mac_82599EB:
 	case ixgbe_mac_X540:
@@ -4204,10 +4214,6 @@ static void ixgbe_vlan_promisc_disable(struct ixgbe_adapter *adapter)
 			break;
 		/* fall through */
 	case ixgbe_mac_82598EB:
-		vlnctrl = IXGBE_READ_REG(hw, IXGBE_VLNCTRL);
-		vlnctrl &= ~IXGBE_VLNCTRL_CFIEN;
-		vlnctrl |= IXGBE_VLNCTRL_VFE;
-		IXGBE_WRITE_REG(hw, IXGBE_VLNCTRL, vlnctrl);
 		return;
 	}
 

