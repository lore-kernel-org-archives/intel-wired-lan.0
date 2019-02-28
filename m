From: Alice Michael <alice.michael@intel.com>
Date: Thu, 28 Feb 2019 09:52:47 -0800
Subject: [Intel-wired-lan] [next PATCH S3 1/9] i40e: Fix for allowing too
 many MDD events on VF
Message-ID: <20190228175255.54754-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Carolyn Wyborny <carolyn.wyborny@intel.com>

This patch changes the driver behavior when detecting a VF MDD event.
It now disables the VF after one event, which indicates a hw detected
problem in the VF.  Before this change, the PF would allow a couple of
events before doing the reset.

Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 278eb0add0b0..f4d58a197445 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -9767,6 +9767,9 @@ static void i40e_handle_mdd_event(struct i40e_pf *pf)
 			vf->num_mdd_events++;
 			dev_info(&pf->pdev->dev, "TX driver issue detected on VF %d\n",
 				 i);
+			dev_info(&pf->pdev->dev,
+				 "Use PF Control I/F to re-enable the VF\n");
+			set_bit(I40E_VF_STATE_DISABLED, &vf->vf_states);
 		}
 
 		reg = rd32(hw, I40E_VP_MDET_RX(i));
@@ -9775,11 +9778,6 @@ static void i40e_handle_mdd_event(struct i40e_pf *pf)
 			vf->num_mdd_events++;
 			dev_info(&pf->pdev->dev, "RX driver issue detected on VF %d\n",
 				 i);
-		}
-
-		if (vf->num_mdd_events > I40E_DEFAULT_NUM_MDD_EVENTS_ALLOWED) {
-			dev_info(&pf->pdev->dev,
-				 "Too many MDD events on VF %d, disabled\n", i);
 			dev_info(&pf->pdev->dev,
 				 "Use PF Control I/F to re-enable the VF\n");
 			set_bit(I40E_VF_STATE_DISABLED, &vf->vf_states);
-- 
2.19.2

