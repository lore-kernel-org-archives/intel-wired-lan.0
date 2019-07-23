From: Alice Michael <alice.michael@intel.com>
Date: Tue, 23 Jul 2019 06:03:36 -0400
Subject: [Intel-wired-lan] [next PATCH S8 03/12] i40e: check_recovery_mode
 had wrong if statement
In-Reply-To: <20190723100345.57522-1-alice.michael@intel.com>
References: <20190723100345.57522-1-alice.michael@intel.com>
Message-ID: <20190723100345.57522-3-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Adrian Podlawski <adrian.podlawski@intel.com>

Function check_recovery_mode had wrong if statement.
Now we check proper FWS1B register values, which are responsible for
the recovery mode. Recovery mode has 4 values for FVL and 2 for FPK.
That's why we need 6 different flags which are defined in shared code.
Now in if statement we recognize type of mac address
and register value.
Without those changes driver could show wrong state.

Signed-off-by: Adrian Podlawski <adrian.podlawski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c     | 17 ++++++++++++++---
 drivers/net/ethernet/intel/i40e/i40e_register.h |  6 ++++++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index b807dd6b1417..4551d97771c9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -14578,9 +14578,20 @@ void i40e_set_fec_in_flags(u8 fec_cfg, u32 *flags)
  **/
 static bool i40e_check_recovery_mode(struct i40e_pf *pf)
 {
-	u32 val = rd32(&pf->hw, I40E_GL_FWSTS);
-
-	if (val & I40E_GL_FWSTS_FWS1B_MASK) {
+	u32 val = rd32(&pf->hw, I40E_GL_FWSTS) & I40E_GL_FWSTS_FWS1B_MASK;
+	bool is_recovery_mode = false;
+
+	if (pf->hw.mac.type == I40E_MAC_XL710)
+		is_recovery_mode =
+		val == I40E_XL710_GL_FWSTS_FWS1B_REC_MOD_CORER_MASK ||
+		val == I40E_XL710_GL_FWSTS_FWS1B_REC_MOD_GLOBR_MASK ||
+		val == I40E_XL710_GL_FWSTS_FWS1B_REC_MOD_TRANSITION_MASK ||
+		val == I40E_XL710_GL_FWSTS_FWS1B_REC_MOD_NVM_MASK;
+	if (pf->hw.mac.type == I40E_MAC_X722)
+		is_recovery_mode =
+		val == I40E_X722_GL_FWSTS_FWS1B_REC_MOD_CORER_MASK ||
+		val == I40E_X722_GL_FWSTS_FWS1B_REC_MOD_GLOBR_MASK;
+	if (is_recovery_mode) {
 		dev_notice(&pf->pdev->dev, "Firmware recovery mode detected. Limiting functionality.\n");
 		dev_notice(&pf->pdev->dev, "Refer to the Intel(R) Ethernet Adapters and Devices User Guide for details on firmware recovery mode.\n");
 		set_bit(__I40E_RECOVERY_MODE, pf->state);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_register.h b/drivers/net/ethernet/intel/i40e/i40e_register.h
index 330ac19a5dae..d35d690ca10f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_register.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_register.h
@@ -363,6 +363,12 @@
 #define I40E_GL_FWSTS_FWRI_MASK I40E_MASK(0x1, I40E_GL_FWSTS_FWRI_SHIFT)
 #define I40E_GL_FWSTS_FWS1B_SHIFT 16
 #define I40E_GL_FWSTS_FWS1B_MASK I40E_MASK(0xFF, I40E_GL_FWSTS_FWS1B_SHIFT)
+#define I40E_XL710_GL_FWSTS_FWS1B_REC_MOD_CORER_MASK I40E_MASK(0x30, I40E_GL_FWSTS_FWS1B_SHIFT)
+#define I40E_XL710_GL_FWSTS_FWS1B_REC_MOD_GLOBR_MASK I40E_MASK(0x31, I40E_GL_FWSTS_FWS1B_SHIFT)
+#define I40E_XL710_GL_FWSTS_FWS1B_REC_MOD_TRANSITION_MASK I40E_MASK(0x32, I40E_GL_FWSTS_FWS1B_SHIFT)
+#define I40E_XL710_GL_FWSTS_FWS1B_REC_MOD_NVM_MASK I40E_MASK(0x33, I40E_GL_FWSTS_FWS1B_SHIFT)
+#define I40E_X722_GL_FWSTS_FWS1B_REC_MOD_CORER_MASK I40E_MASK(0xB, I40E_GL_FWSTS_FWS1B_SHIFT)
+#define I40E_X722_GL_FWSTS_FWS1B_REC_MOD_GLOBR_MASK I40E_MASK(0xC, I40E_GL_FWSTS_FWS1B_SHIFT)
 #define I40E_GLGEN_CLKSTAT 0x000B8184 /* Reset: POR */
 #define I40E_GLGEN_CLKSTAT_CLKMODE_SHIFT 0
 #define I40E_GLGEN_CLKSTAT_CLKMODE_MASK I40E_MASK(0x1, I40E_GLGEN_CLKSTAT_CLKMODE_SHIFT)
-- 
2.21.0

