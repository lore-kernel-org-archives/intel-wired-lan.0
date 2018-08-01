From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 31 Jul 2018 20:47:26 -0700
Subject: [Intel-wired-lan] [PATCH v3 10/13] ice: Update to interrupts
 enabled in OICR
In-Reply-To: <20180801034729.3864-1-anirudh.venkataramanan@intel.com>
References: <20180801034729.3864-1-anirudh.venkataramanan@intel.com>
Message-ID: <20180801034729.3864-11-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

Remove the following interrupt causes that are not applicable or not
handled:
- PFINT_OICR_HLP_RDY_M
- PFINT_OICR_CPM_RDY_M
- PFINT_OICR_GPIO_M
- PFINT_OICR_STORM_DETECT_M

Add the following interrupt cause that's actually handled in ice_misc_intr:
- PFINT_OICR_PE_CRITERR_M

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> Removed defines from ice_hw_autogen.h]
---
 drivers/net/ethernet/intel/ice/ice_hw_autogen.h | 8 --------
 drivers/net/ethernet/intel/ice/ice_main.c       | 9 +++------
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
index 499904874b3f..6076fc87df9d 100644
--- a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
+++ b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
@@ -121,10 +121,6 @@
 #define PFINT_FW_CTL_CAUSE_ENA_S	30
 #define PFINT_FW_CTL_CAUSE_ENA_M	BIT(PFINT_FW_CTL_CAUSE_ENA_S)
 #define PFINT_OICR			0x0016CA00
-#define PFINT_OICR_HLP_RDY_S		14
-#define PFINT_OICR_HLP_RDY_M		BIT(PFINT_OICR_HLP_RDY_S)
-#define PFINT_OICR_CPM_RDY_S		15
-#define PFINT_OICR_CPM_RDY_M		BIT(PFINT_OICR_CPM_RDY_S)
 #define PFINT_OICR_ECC_ERR_S		16
 #define PFINT_OICR_ECC_ERR_M		BIT(PFINT_OICR_ECC_ERR_S)
 #define PFINT_OICR_MAL_DETECT_S		19
@@ -133,10 +129,6 @@
 #define PFINT_OICR_GRST_M		BIT(PFINT_OICR_GRST_S)
 #define PFINT_OICR_PCI_EXCEPTION_S	21
 #define PFINT_OICR_PCI_EXCEPTION_M	BIT(PFINT_OICR_PCI_EXCEPTION_S)
-#define PFINT_OICR_GPIO_S		22
-#define PFINT_OICR_GPIO_M		BIT(PFINT_OICR_GPIO_S)
-#define PFINT_OICR_STORM_DETECT_S	24
-#define PFINT_OICR_STORM_DETECT_M	BIT(PFINT_OICR_STORM_DETECT_S)
 #define PFINT_OICR_HMC_ERR_S		26
 #define PFINT_OICR_HMC_ERR_M		BIT(PFINT_OICR_HMC_ERR_S)
 #define PFINT_OICR_PE_CRITERR_S		28
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 989d5fc4d410..1487aac09e99 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1702,15 +1702,12 @@ static void ice_ena_misc_vector(struct ice_pf *pf)
 	wr32(hw, PFINT_OICR_ENA, 0);	/* disable all */
 	rd32(hw, PFINT_OICR);		/* read to clear */
 
-	val = (PFINT_OICR_HLP_RDY_M |
-	       PFINT_OICR_CPM_RDY_M |
-	       PFINT_OICR_ECC_ERR_M |
+	val = (PFINT_OICR_ECC_ERR_M |
 	       PFINT_OICR_MAL_DETECT_M |
 	       PFINT_OICR_GRST_M |
 	       PFINT_OICR_PCI_EXCEPTION_M |
-	       PFINT_OICR_GPIO_M |
-	       PFINT_OICR_STORM_DETECT_M |
-	       PFINT_OICR_HMC_ERR_M);
+	       PFINT_OICR_HMC_ERR_M |
+	       PFINT_OICR_PE_CRITERR_M);
 
 	wr32(hw, PFINT_OICR_ENA, val);
 
-- 
2.17.1

