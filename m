From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 27 Feb 2020 10:14:59 -0800
Subject: [Intel-wired-lan] [PATCH S40 09/15] ice: Correct setting VLAN
 pruning
In-Reply-To: <20200227181505.61720-1-anthony.l.nguyen@intel.com>
References: <20200227181505.61720-1-anthony.l.nguyen@intel.com>
Message-ID: <20200227181505.61720-9-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

VLAN pruning is not always being set correctly due to a previous change
that set Tx antispoof off. ice_vsi_is_vlan_pruning_ena() currently checks
for both Tx antispoof and Rx pruning. The expectation for this function is
to only check Rx pruning so fix the check.

Fixes: cd6d6b83316a ("ice: Fix VF spoofchk")
Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 7005a11f0c7d..7fdea256722b 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1912,20 +1912,14 @@ int ice_vsi_stop_xdp_tx_rings(struct ice_vsi *vsi)
  * ice_vsi_is_vlan_pruning_ena - check if VLAN pruning is enabled or not
  * @vsi: VSI to check whether or not VLAN pruning is enabled.
  *
- * returns true if Rx VLAN pruning and Tx VLAN anti-spoof is enabled and false
- * otherwise.
+ * returns true if Rx VLAN pruning is enabled and false otherwise.
  */
 bool ice_vsi_is_vlan_pruning_ena(struct ice_vsi *vsi)
 {
-	u8 rx_pruning = ICE_AQ_VSI_SW_FLAG_RX_VLAN_PRUNE_ENA;
-	u8 tx_pruning = ICE_AQ_VSI_SEC_TX_VLAN_PRUNE_ENA <<
-		ICE_AQ_VSI_SEC_TX_PRUNE_ENA_S;
-
 	if (!vsi)
 		return false;
 
-	return ((vsi->info.sw_flags2 & rx_pruning) &&
-		(vsi->info.sec_flags & tx_pruning));
+	return (vsi->info.sw_flags2 & ICE_AQ_VSI_SW_FLAG_RX_VLAN_PRUNE_ENA);
 }
 
 /**
-- 
2.20.1

