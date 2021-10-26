From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Mon, 25 Oct 2021 17:08:25 -0700
Subject: [Intel-wired-lan] [PATCH net-next v1 3/4] ice: tighter control over
 VSI_DOWN state
In-Reply-To: <20211026000826.156803-1-jesse.brandeburg@intel.com>
References: <20211026000826.156803-1-jesse.brandeburg@intel.com>
Message-ID: <20211026000826.156803-4-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The driver had comments to the effect of: This flag should be set before
calling this function. While reviewing code it was found that there were
several violations of this policy, which could introduce hard to find
bugs or races.

Fix the violations of the "VSI DOWN state must be set before calling
ice_down" and make checking the state into code with a WARN_ON.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
Testing Hints (Required if no HSD): legacy-rx private flag
disable/enable forgot to set this previously and is a way to trigger the
down/up path.
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 6 ++++--
 drivers/net/ethernet/intel/ice/ice_main.c    | 7 ++++---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 870d02adcfe8..473f025c1cb5 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -1279,8 +1279,10 @@ static int ice_set_priv_flags(struct net_device *netdev, u32 flags)
 	}
 	if (test_bit(ICE_FLAG_LEGACY_RX, change_flags)) {
 		/* down and up VSI so that changes of Rx cfg are reflected. */
-		ice_down(vsi);
-		ice_up(vsi);
+		if (!test_and_set_bit(ICE_VSI_DOWN, vsi->state)) {
+			ice_down(vsi);
+			ice_up(vsi);
+		}
 	}
 	/* don't allow modification of this flag when a single VF is in
 	 * promiscuous mode because it's not supported
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 28815e5a7770..b82dc2642d99 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6212,14 +6212,15 @@ static void ice_napi_disable_all(struct ice_vsi *vsi)
 /**
  * ice_down - Shutdown the connection
  * @vsi: The VSI being stopped
+ *
+ * Caller of this function is expected to set the vsi->state ICE_DOWN bit
  */
 int ice_down(struct ice_vsi *vsi)
 {
 	int i, tx_err, rx_err, link_err = 0;
 
-	/* Caller of this function is expected to set the
-	 * vsi->state ICE_DOWN bit
-	 */
+	WARN_ON(!test_bit(ICE_VSI_DOWN, vsi->state));
+
 	if (vsi->netdev && vsi->type == ICE_VSI_PF) {
 		if (!ice_is_e810(&vsi->back->hw))
 			ice_ptp_link_change(vsi->back, vsi->back->hw.pf_id, false);
-- 
2.31.1

