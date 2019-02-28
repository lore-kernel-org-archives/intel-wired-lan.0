From: Alice Michael <alice.michael@intel.com>
Date: Thu, 28 Feb 2019 09:52:48 -0800
Subject: [Intel-wired-lan] [next PATCH S3 2/9] i40e: change behavior on PF
 in response to MDD event
In-Reply-To: <20190228175255.54754-1-alice.michael@intel.com>
References: <20190228175255.54754-1-alice.michael@intel.com>
Message-ID: <20190228175255.54754-2-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Carolyn Wyborny <carolyn.wyborny@intel.com>

TX MDD events reported on the PF are the result of the
PF misconfiguring a descriptor and not because of "bad actions"
by anything else.  No need to reset now because if it
results in a tx hang, the tx hang check will take care of it.

Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index f4d58a197445..e53b18b3ad6b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -9696,7 +9696,6 @@ static void i40e_handle_mdd_event(struct i40e_pf *pf)
 {
 	struct i40e_hw *hw = &pf->hw;
 	bool mdd_detected = false;
-	bool pf_mdd_detected = false;
 	struct i40e_vf *vf;
 	u32 reg;
 	int i;
@@ -9742,19 +9741,12 @@ static void i40e_handle_mdd_event(struct i40e_pf *pf)
 		reg = rd32(hw, I40E_PF_MDET_TX);
 		if (reg & I40E_PF_MDET_TX_VALID_MASK) {
 			wr32(hw, I40E_PF_MDET_TX, 0xFFFF);
-			dev_info(&pf->pdev->dev, "TX driver issue detected, PF reset issued\n");
-			pf_mdd_detected = true;
+			dev_dbg(&pf->pdev->dev, "TX driver issue detected on PF\n");
 		}
 		reg = rd32(hw, I40E_PF_MDET_RX);
 		if (reg & I40E_PF_MDET_RX_VALID_MASK) {
 			wr32(hw, I40E_PF_MDET_RX, 0xFFFF);
-			dev_info(&pf->pdev->dev, "RX driver issue detected, PF reset issued\n");
-			pf_mdd_detected = true;
-		}
-		/* Queue belongs to the PF, initiate a reset */
-		if (pf_mdd_detected) {
-			set_bit(__I40E_PF_RESET_REQUESTED, pf->state);
-			i40e_service_event_schedule(pf);
+			dev_dbg(&pf->pdev->dev, "RX driver issue detected on PF\n");
 		}
 	}
 
-- 
2.19.2

