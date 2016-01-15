From: Joshua Hay <joshua.a.hay@intel.com>
Date: Fri, 15 Jan 2016 14:33:17 -0800
Subject: [Intel-wired-lan] [next PATCH S28 10/15] i40e: expand comment
In-Reply-To: <1452897202-15204-1-git-send-email-joshua.a.hay@intel.com>
References: <1452897202-15204-1-git-send-email-joshua.a.hay@intel.com>
Message-ID: <1452897202-15204-11-git-send-email-joshua.a.hay@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

Explain why we cannot remove this code, even though it works differently
than any of our other interrupt cause handling code.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: Ie66203bd037a466066036611c31d44f759ec5176
---
Testing Hints: Comment only. No code change.

 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 597f209..5dcd198 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2037,7 +2037,11 @@ int i40e_vc_process_vflr_event(struct i40e_pf *pf)
 	if (!test_bit(__I40E_VFLR_EVENT_PENDING, &pf->state))
 		return 0;
 
-	/* re-enable vflr interrupt cause */
+	/* Re-enable the VFLR interrupt cause here, before looking for which
+	 * VF got reset. Otherwise, if another VF gets a reset while the
+	 * first one is being processed, that interrupt will be lost, and
+	 * that VF will be stuck in reset forever.
+	 */
 	reg = rd32(hw, I40E_PFINT_ICR0_ENA);
 	reg |= I40E_PFINT_ICR0_ENA_VFLR_MASK;
 	wr32(hw, I40E_PFINT_ICR0_ENA, reg);
-- 
2.1.0

