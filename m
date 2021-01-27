From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Tue, 26 Jan 2021 16:22:17 -0800
Subject: [Intel-wired-lan] [PATCH net-next] ice: Improve MSI-X fallback logic
Message-ID: <20210127002217.18392-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Currently if the driver is unable to get all the MSI-X vectors it wants, it
falls back to the minimum configuration which equates to a single Tx/Rx
traffic queue pair. Instead of using the minimum configuration, if given
more vectors than the minimum, utilize those vectors for additional traffic
queues after accounting for other interrupts.

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 40 ++++++++++++++---------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 8308770c61a7..6145a08f60a0 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3397,28 +3397,20 @@ static int ice_init_pf(struct ice_pf *pf)
  */
 static int ice_ena_msix_range(struct ice_pf *pf)
 {
+	int v_left, v_actual, v_other, v_budget = 0;
 	struct device *dev = ice_pf_to_dev(pf);
-	int v_left, v_actual, v_budget = 0;
 	int needed, err, i;
 
 	v_left = pf->hw.func_caps.common_cap.num_msix_vectors;
 
-	/* reserve one vector for miscellaneous handler */
-	needed = 1;
+	/* reserve for LAN miscellaneous handler */
+	needed = ICE_MIN_LAN_OICR_MSIX;
 	if (v_left < needed)
 		goto no_hw_vecs_left_err;
 	v_budget += needed;
 	v_left -= needed;
 
-	/* reserve vectors for LAN traffic */
-	needed = min_t(int, num_online_cpus(), v_left);
-	if (v_left < needed)
-		goto no_hw_vecs_left_err;
-	pf->num_lan_msix = needed;
-	v_budget += needed;
-	v_left -= needed;
-
-	/* reserve one vector for flow director */
+	/* reserve for flow director */
 	if (test_bit(ICE_FLAG_FD_ENA, pf->flags)) {
 		needed = ICE_FDIR_MSIX;
 		if (v_left < needed)
@@ -3427,9 +3419,19 @@ static int ice_ena_msix_range(struct ice_pf *pf)
 		v_left -= needed;
 	}
 
+	/* total used for non-traffic vectors */
+	v_other = v_budget;
+
+	/* reserve vectors for LAN traffic */
+	needed = min_t(int, num_online_cpus(), v_left);
+	if (v_left < needed)
+		goto no_hw_vecs_left_err;
+	pf->num_lan_msix = needed;
+	v_budget += needed;
+	v_left -= needed;
+
 	pf->msix_entries = devm_kcalloc(dev, v_budget,
 					sizeof(*pf->msix_entries), GFP_KERNEL);
-
 	if (!pf->msix_entries) {
 		err = -ENOMEM;
 		goto exit_err;
@@ -3441,7 +3443,6 @@ static int ice_ena_msix_range(struct ice_pf *pf)
 	/* actually reserve the vectors */
 	v_actual = pci_enable_msix_range(pf->pdev, pf->msix_entries,
 					 ICE_MIN_MSIX, v_budget);
-
 	if (v_actual < 0) {
 		dev_err(dev, "unable to reserve MSI-X vectors\n");
 		err = v_actual;
@@ -3458,7 +3459,16 @@ static int ice_ena_msix_range(struct ice_pf *pf)
 			err = -ERANGE;
 			goto msix_err;
 		} else {
-			pf->num_lan_msix = ICE_MIN_LAN_TXRX_MSIX;
+			int v_traffic = v_actual - v_other;
+
+			if (v_actual == ICE_MIN_MSIX ||
+			    v_traffic < ICE_MIN_LAN_TXRX_MSIX)
+				pf->num_lan_msix = ICE_MIN_LAN_TXRX_MSIX;
+			else
+				pf->num_lan_msix = v_traffic;
+
+			dev_notice(dev, "Enabled %d MSI-X vectors for LAN traffic.\n",
+				   pf->num_lan_msix);
 		}
 	}
 
-- 
2.20.1

