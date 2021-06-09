From: Karen Sornek <karen.sornek@intel.com>
Date: Wed,  9 Jun 2021 12:51:01 +0200
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix for failed to init
 adminq while VF reset and for sync VF driver reset
Message-ID: <20210609105101.88005-1-karen.sornek@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fix for failed to init adminq: -53 while VF is resetting via MAC
address changing procedure.
Added sync module to avoid reading deadbeef value in reinit adminq
during software reset.
Fix for sync VF driver reset before trigger next one by PF.
Change VF in reset state detection from check VFR state
register to examination of enable admin queue interrupt.
ADMINQ is enabled by VF after completely reinit admin queue.

Fixes: b40c82e6ae85 ("i40e: Fix inconsistent use of PF/VF vs pf/vf")
Signed-off-by: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
Signed-off-by: Karen Sornek <karen.sornek@intel.com>
---
 .../net/ethernet/intel/i40e/i40e_register.h   | 10 +++++
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 45 ++++++++++++++++++-
 .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |  1 +
 3 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_register.h b/drivers/net/ethernet/intel/i40e/i40e_register.h
index 8d0588a27..b5c741e76 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_register.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_register.h
@@ -371,6 +371,16 @@
 #define I40E_PFINT_ICR0_ENA_VFLR_MASK I40E_MASK(0x1, I40E_PFINT_ICR0_ENA_VFLR_SHIFT)
 #define I40E_PFINT_ICR0_ENA_ADMINQ_SHIFT 30
 #define I40E_PFINT_ICR0_ENA_ADMINQ_MASK I40E_MASK(0x1, I40E_PFINT_ICR0_ENA_ADMINQ_SHIFT)
+#define I40E_VFINT_ICR0_ADMINQ_SHIFT 30
+#define I40E_VFINT_ICR0_ADMINQ_MASK I40E_MASK(0x1, I40E_VFINT_ICR0_ADMINQ_SHIFT)
+#define I40E_VFINT_ICR0_ENA(_VF) (0x0002C000 + ((_VF) * 4)) /* _i=0...127 */ /* Reset: CORER */
+#define I40E_VFINT_ICR0_ENA_MAX_INDEX 127
+#define I40E_VFINT_ICR0_ENA_LINK_STAT_CHANGE_SHIFT 25
+#define I40E_VFINT_ICR0_ENA_LINK_STAT_CHANGE_MASK I40E_MASK(0x1, I40E_VFINT_ICR0_ENA_LINK_STAT_CHANGE_SHIFT)
+#define I40E_VFINT_ICR0_ENA_ADMINQ_SHIFT 30
+#define I40E_VFINT_ICR0_ENA_ADMINQ_MASK I40E_MASK(0x1, I40E_VFINT_ICR0_ENA_ADMINQ_SHIFT)
+#define I40E_VFINT_ICR0_ENA_RSVD_SHIFT 31
+#define I40E_VFINT_ICR0_ENA_RSVD_MASK I40E_MASK(0x1, I40E_VFINT_ICR0_ENA_RSVD_SHIFT)
 #define I40E_PFINT_ITR0(_i) (0x00038000 + ((_i) * 128)) /* _i=0...2 */ /* Reset: PFR */
 #define I40E_PFINT_ITRN(_i, _INTPF) (0x00030000 + ((_i) * 2048 + (_INTPF) * 4)) /* _i=0...2, _INTPF=0...511 */ /* Reset: PFR */
 #define I40E_PFINT_LNKLST0 0x00038500 /* Reset: PFR */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index edfdce5f6..e6d6ebd82 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1376,6 +1376,32 @@ static i40e_status i40e_config_vf_promiscuous_mode(struct i40e_vf *vf,
 	return aq_ret;
 }
 
+/**
+ * i40e_sync_vfr_reset
+ * @hw: pointer to hw struct
+ * @vf_id: VF identifier
+ *
+ * Before trigger hardware reset, we need to know if no other process has
+ * reserved the hardware for any reset operations. This check is done by
+ * examining the status of the ADMINQ bit in VF interrupt register.
+ **/
+static int i40e_sync_vfr_reset(struct i40e_hw *hw, int vf_id)
+{
+	u32 reg;
+	int i;
+
+	for (i = 0; i < I40E_VFR_WAIT_COUNT; i++) {
+		reg = rd32(hw, I40E_VFINT_ICR0_ENA(vf_id)) &
+			   I40E_VFINT_ICR0_ADMINQ_MASK;
+		if (reg != VIRTCHNL_VFR_INPROGRESS)
+			return 0;
+
+		usleep_range(100, 200);
+	}
+
+	return -EAGAIN;
+}
+
 /**
  * i40e_trigger_vf_reset
  * @vf: pointer to the VF structure
@@ -1390,9 +1416,11 @@ static void i40e_trigger_vf_reset(struct i40e_vf *vf, bool flr)
 	struct i40e_pf *pf = vf->pf;
 	struct i40e_hw *hw = &pf->hw;
 	u32 reg, reg_idx, bit_idx;
+	bool vf_active;
+	u32 radq;
 
 	/* warn the VF */
-	clear_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states);
+	vf_active = test_and_clear_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states);
 
 	/* Disable VF's configuration API during reset. The flag is re-enabled
 	 * in i40e_alloc_vf_res(), when it's safe again to access VF's VSI.
@@ -1406,7 +1434,18 @@ static void i40e_trigger_vf_reset(struct i40e_vf *vf, bool flr)
 	 * just need to clean up, so don't hit the VFRTRIG register.
 	 */
 	if (!flr) {
-		/* reset VF using VPGEN_VFRTRIG reg */
+		/* Sync VFR reset before trigger next one */
+		radq = rd32(hw, I40E_VFINT_ICR0_ENA(vf->vf_id)) &
+			     I40E_VFINT_ICR0_ADMINQ_MASK;
+		if (vf_active && !radq)
+			/* waiting for finish reset by virtual driver */
+			if (i40e_sync_vfr_reset(hw, vf->vf_id))
+				dev_info(&pf->pdev->dev,
+					 "Reset VF %d never finished\n",
+					 vf->vf_id);
+
+		/* Reset VF using VPGEN_VFRTRIG reg. It is also setting
+		 * in progress state in rstat1 register */
 		reg = rd32(hw, I40E_VPGEN_VFRTRIG(vf->vf_id));
 		reg |= I40E_VPGEN_VFRTRIG_VFSWR_MASK;
 		wr32(hw, I40E_VPGEN_VFRTRIG(vf->vf_id), reg);
@@ -1473,8 +1512,10 @@ static void i40e_cleanup_reset_vf(struct i40e_vf *vf)
 	/* Tell the VF driver the reset is done. This needs to be done only
 	 * after VF has been fully initialized, because the VF driver may
 	 * request resources immediately after setting this flag.
+	 * Let's give it some time to finish it.
 	 */
 	wr32(hw, I40E_VFGEN_RSTAT1(vf->vf_id), VIRTCHNL_VFR_VFACTIVE);
+	usleep_range(20000, 40000);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
index 49575a640..03c42fd0f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
@@ -19,6 +19,7 @@
 #define I40E_MAX_VF_PROMISC_FLAGS	3
 
 #define I40E_VF_STATE_WAIT_COUNT	20
+#define I40E_VFR_WAIT_COUNT		100
 
 /* Various queue ctrls */
 enum i40e_queue_ctrl {
-- 
2.27.0

