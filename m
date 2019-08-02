From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri,  2 Aug 2019 01:25:23 -0700
Subject: [Intel-wired-lan] [PATCH S26 05/15] ice: Rework ice_ena_msix_range
In-Reply-To: <20190802082533.23083-1-anthony.l.nguyen@intel.com>
References: <20190802082533.23083-1-anthony.l.nguyen@intel.com>
Message-ID: <20190802082533.23083-5-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>

The current implementation of ice_ena_msix_range is difficult to read
and has subtle issues. This patch reworks the said function for
clarity and correctness.

More specifically,

1. Add more checks to bail out of 'needed' is greater than 'v_left'.

2. Simplify fallback logic

3. Do not set pf->num_avail_sw_msix in ice_ena_msix_range as it
   gets overwritten by ice_init_interrupt_scheme.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 32 +++++++++++++++--------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 0eefac05eae1..0d850d92cd5c 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2317,13 +2317,18 @@ static int ice_ena_msix_range(struct ice_pf *pf)
 
 	/* reserve one vector for miscellaneous handler */
 	needed = 1;
+	if (v_left < needed)
+		goto no_hw_vecs_left_err;
 	v_budget += needed;
 	v_left -= needed;
 
 	/* reserve vectors for LAN traffic */
-	pf->num_lan_msix = min_t(int, num_online_cpus(), v_left);
-	v_budget += pf->num_lan_msix;
-	v_left -= pf->num_lan_msix;
+	needed = min_t(int, num_online_cpus(), v_left);
+	if (v_left < needed)
+		goto no_hw_vecs_left_err;
+	pf->num_lan_msix = needed;
+	v_budget += needed;
+	v_left -= needed;
 
 	pf->msix_entries = devm_kcalloc(&pf->pdev->dev, v_budget,
 					sizeof(*pf->msix_entries), GFP_KERNEL);
@@ -2348,18 +2353,18 @@ static int ice_ena_msix_range(struct ice_pf *pf)
 
 	if (v_actual < v_budget) {
 		dev_warn(&pf->pdev->dev,
-			 "not enough vectors. requested = %d, obtained = %d\n",
+			 "not enough OS MSI-X vectors. requested = %d, obtained = %d\n",
 			 v_budget, v_actual);
-		if (v_actual >= (pf->num_lan_msix + 1)) {
-			pf->num_avail_sw_msix = v_actual -
-						(pf->num_lan_msix + 1);
-		} else if (v_actual >= 2) {
-			pf->num_lan_msix = 1;
-			pf->num_avail_sw_msix = v_actual - 2;
-		} else {
+/* 2 vectors for LAN (traffic + OICR) */
+#define ICE_MIN_LAN_VECS 2
+
+		if (v_actual < ICE_MIN_LAN_VECS) {
+			/* error if we can't get minimum vectors */
 			pci_disable_msix(pf->pdev);
 			err = -ERANGE;
 			goto msix_err;
+		} else {
+			pf->num_lan_msix = ICE_MIN_LAN_VECS;
 		}
 	}
 
@@ -2369,6 +2374,11 @@ static int ice_ena_msix_range(struct ice_pf *pf)
 	devm_kfree(&pf->pdev->dev, pf->msix_entries);
 	goto exit_err;
 
+no_hw_vecs_left_err:
+	dev_err(&pf->pdev->dev,
+		"not enough device MSI-X vectors. requested = %d, available = %d\n",
+		needed, v_left);
+	err = -ERANGE;
 exit_err:
 	pf->num_lan_msix = 0;
 	return err;
-- 
2.20.1

