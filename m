From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Wed, 11 Apr 2018 12:21:33 -0700
Subject: [Intel-wired-lan] [PATCH v2] ice: Do not check INTEVENT bit for
 OICR interrupts
Message-ID: <20180411192133.25503-1-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Ben Shelton <benjamin.h.shelton@intel.com>

According to the hardware spec, checking the INTEVENT bit isn't a
reliable way to detect if an OICR interrupt has occurred. This is
because this bit can be cleared by the hardware/firmware before the
interrupt service routine has run. So instead, just check for OICR
events everytime.

Fixes: 940b61af02f4 ("ice: Initialize PF and setup miscellaneous
interrupt")

Signed-off-by: Ben Shelton <benjamin.h.shelton@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>

---
v2: Add credits to the original author and fix formatting for "Fixes"
---
 drivers/net/ethernet/intel/ice/ice_hw_autogen.h | 2 --
 drivers/net/ethernet/intel/ice/ice_main.c       | 4 ----
 2 files changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
index 1b9e2ef48a9d..499904874b3f 100644
--- a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
+++ b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
@@ -121,8 +121,6 @@
 #define PFINT_FW_CTL_CAUSE_ENA_S	30
 #define PFINT_FW_CTL_CAUSE_ENA_M	BIT(PFINT_FW_CTL_CAUSE_ENA_S)
 #define PFINT_OICR			0x0016CA00
-#define PFINT_OICR_INTEVENT_S		0
-#define PFINT_OICR_INTEVENT_M		BIT(PFINT_OICR_INTEVENT_S)
 #define PFINT_OICR_HLP_RDY_S		14
 #define PFINT_OICR_HLP_RDY_M		BIT(PFINT_OICR_HLP_RDY_S)
 #define PFINT_OICR_CPM_RDY_S		15
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 210b7910f1cd..5299caf55a7f 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1722,9 +1722,6 @@ static irqreturn_t ice_misc_intr(int __always_unused irq, void *data)
 	oicr = rd32(hw, PFINT_OICR);
 	ena_mask = rd32(hw, PFINT_OICR_ENA);
 
-	if (!(oicr & PFINT_OICR_INTEVENT_M))
-		goto ena_intr;
-
 	if (oicr & PFINT_OICR_GRST_M) {
 		u32 reset;
 		/* we have a reset warning */
@@ -1782,7 +1779,6 @@ static irqreturn_t ice_misc_intr(int __always_unused irq, void *data)
 	}
 	ret = IRQ_HANDLED;
 
-ena_intr:
 	/* re-enable interrupt causes that are not handled during this pass */
 	wr32(hw, PFINT_OICR_ENA, ena_mask);
 	if (!test_bit(__ICE_DOWN, pf->state)) {
-- 
2.14.3

