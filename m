From: Alice Michael <alice.michael@intel.com>
Date: Fri, 16 Mar 2018 01:26:35 -0700
Subject: [Intel-wired-lan] [next PATCH S89 6/8] i40e: hold the RTNL lock
 while changing interrupt schemes
In-Reply-To: <20180316082637.49915-1-alice.michael@intel.com>
References: <20180316082637.49915-1-alice.michael@intel.com>
Message-ID: <20180316082637.49915-6-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

When we suspend and resume, we need to clear and re-enable the interrupt
scheme. This was previously not done while holding the RTNL lock, which
could be problematic, because we are actually destroying and re-creating
queues.

Hold the RTNL lock for the entire sequence of preparing for reset, and
when resuming. This additionally protects the flags related to interrupt
scheme under RTNL lock so that their modification is properly threaded.

This is part of a larger effort to remove the need for cmpxchg64 in
i40e_set_priv_flags().

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index debc3a3..79ab522 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -14348,7 +14348,13 @@ static int __maybe_unused i40e_suspend(struct device *dev)
 	if (pf->wol_en && (pf->hw_features & I40E_HW_WOL_MC_MAGIC_PKT_WAKE))
 		i40e_enable_mc_magic_wake(pf);
 
-	i40e_prep_for_reset(pf, false);
+	/* Since we're going to destroy queues during the
+	 * i40e_clear_interrupt_scheme() we should hold the RTNL lock for this
+	 * whole section
+	 */
+	rtnl_lock();
+
+	i40e_prep_for_reset(pf, true);
 
 	wr32(hw, I40E_PFPM_APM, (pf->wol_en ? I40E_PFPM_APM_APME_MASK : 0));
 	wr32(hw, I40E_PFPM_WUFC, (pf->wol_en ? I40E_PFPM_WUFC_MAG_MASK : 0));
@@ -14360,6 +14366,8 @@ static int __maybe_unused i40e_suspend(struct device *dev)
 	 */
 	i40e_clear_interrupt_scheme(pf);
 
+	rtnl_unlock();
+
 	return 0;
 }
 
@@ -14377,6 +14385,11 @@ static int __maybe_unused i40e_resume(struct device *dev)
 	if (!test_bit(__I40E_SUSPENDED, pf->state))
 		return 0;
 
+	/* We need to hold the RTNL lock prior to restoring interrupt schemes,
+	 * since we're going to be restoring queues
+	 */
+	rtnl_lock();
+
 	/* We cleared the interrupt scheme when we suspended, so we need to
 	 * restore it now to resume device functionality.
 	 */
@@ -14387,7 +14400,9 @@ static int __maybe_unused i40e_resume(struct device *dev)
 	}
 
 	clear_bit(__I40E_DOWN, pf->state);
-	i40e_reset_and_rebuild(pf, false, false);
+	i40e_reset_and_rebuild(pf, false, true);
+
+	rtnl_unlock();
 
 	/* Clear suspended state last after everything is recovered */
 	clear_bit(__I40E_SUSPENDED, pf->state);
-- 
2.9.5

