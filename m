From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 14 Mar 2018 11:19:18 -0700
Subject: [Intel-wired-lan] [PATCH S88 8/8] i40e: Fix the polling mechanism
 of GLGEN_RSTAT.DEVSTATE
In-Reply-To: <20180314181918.21582-1-jeffrey.t.kirsher@intel.com>
References: <20180314181918.21582-1-jeffrey.t.kirsher@intel.com>
Message-ID: <20180314181918.21582-8-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Pawe? Jab?o?ski <pawel.jablonski@intel.com>

This fixes the polling mechanism of GLGEN_RSTAT.DEVSTATE in the
PF Reset path when Global Reset is in progress. While the driver
is polling for the end of the PF Reset and the Global Reset is
triggered, abandon the PF Reset path and prepare for the
upcoming Global Reset.

Signed-off-by: Pawe? Jab?o?ski <pawel.jablonski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 35 ++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 27d4d208bd04..b70a6d583c2f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1209,6 +1209,29 @@ static enum i40e_media_type i40e_get_media_type(struct i40e_hw *hw)
 	return media;
 }
 
+/**
+ * i40e_poll_globr - Poll for Global Reset completion
+ * @hw: pointer to the hardware structure
+ * @retry_limit: how many times to retry before failure
+ **/
+static i40e_status i40e_poll_globr(struct i40e_hw *hw,
+				   u32 retry_limit)
+{
+	u32 cnt, reg = 0;
+
+	for (cnt = 0; cnt < retry_limit; cnt++) {
+		reg = rd32(hw, I40E_GLGEN_RSTAT);
+		if (!(reg & I40E_GLGEN_RSTAT_DEVSTATE_MASK))
+			return 0;
+		msleep(100);
+	}
+
+	hw_dbg(hw, "Global reset failed.\n");
+	hw_dbg(hw, "I40E_GLGEN_RSTAT = 0x%x\n", reg);
+
+	return I40E_ERR_RESET_FAILED;
+}
+
 #define I40E_PF_RESET_WAIT_COUNT_A0	200
 #define I40E_PF_RESET_WAIT_COUNT	200
 /**
@@ -1285,14 +1308,14 @@ i40e_status i40e_pf_reset(struct i40e_hw *hw)
 			if (!(reg & I40E_PFGEN_CTRL_PFSWR_MASK))
 				break;
 			reg2 = rd32(hw, I40E_GLGEN_RSTAT);
-			if (reg2 & I40E_GLGEN_RSTAT_DEVSTATE_MASK) {
-				hw_dbg(hw, "Core reset upcoming. Skipping PF reset request.\n");
-				hw_dbg(hw, "I40E_GLGEN_RSTAT = 0x%x\n", reg2);
-				return I40E_ERR_NOT_READY;
-			}
+			if (reg2 & I40E_GLGEN_RSTAT_DEVSTATE_MASK)
+				break;
 			usleep_range(1000, 2000);
 		}
-		if (reg & I40E_PFGEN_CTRL_PFSWR_MASK) {
+		if (reg2 & I40E_GLGEN_RSTAT_DEVSTATE_MASK) {
+			if (i40e_poll_globr(hw, grst_del))
+				return I40E_ERR_RESET_FAILED;
+		} else if (reg & I40E_PFGEN_CTRL_PFSWR_MASK) {
 			hw_dbg(hw, "PF reset polling failed to complete.\n");
 			return I40E_ERR_RESET_FAILED;
 		}
-- 
2.14.3

