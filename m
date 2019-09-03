From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Tue,  3 Sep 2019 01:31:02 -0700
Subject: [Intel-wired-lan] [PATCH S28 v2 3/9] ice: Check for DCB capability
 before initializing DCB
In-Reply-To: <20190903083108.19593-1-anthony.l.nguyen@intel.com>
References: <20190903083108.19593-1-anthony.l.nguyen@intel.com>
Message-ID: <20190903083108.19593-3-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>

Check the ICE_FLAG_DCB_CAPABLE before calling ice_init_pf_dcb.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c |  3 ---
 drivers/net/ethernet/intel/ice/ice_main.c    | 15 ++++++++-------
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index e922adf1fa15..20f440a64650 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -474,7 +474,6 @@ int ice_init_pf_dcb(struct ice_pf *pf, bool locked)
 		}
 
 		pf->dcbx_cap = DCB_CAP_DCBX_HOST | DCB_CAP_DCBX_VER_IEEE;
-		set_bit(ICE_FLAG_DCB_CAPABLE, pf->flags);
 		return 0;
 	}
 
@@ -483,8 +482,6 @@ int ice_init_pf_dcb(struct ice_pf *pf, bool locked)
 	/* DCBX in FW and LLDP enabled in FW */
 	pf->dcbx_cap = DCB_CAP_DCBX_LLD_MANAGED | DCB_CAP_DCBX_VER_IEEE;
 
-	set_bit(ICE_FLAG_DCB_CAPABLE, pf->flags);
-
 	err = ice_dcb_init_cfg(pf, locked);
 	if (err)
 		goto dcb_init_err;
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 703fc7bf2b31..8bb3b81876a9 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2252,6 +2252,8 @@ static void ice_deinit_pf(struct ice_pf *pf)
 static int ice_init_pf(struct ice_pf *pf)
 {
 	bitmap_zero(pf->flags, ICE_PF_FLAGS_NBITS);
+	if (pf->hw.func_caps.common_cap.dcb)
+		set_bit(ICE_FLAG_DCB_CAPABLE, pf->flags);
 #ifdef CONFIG_PCI_IOV
 	if (pf->hw.func_caps.common_cap.sr_iov_1_1) {
 		struct ice_hw *hw = &pf->hw;
@@ -2529,13 +2531,12 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 		goto err_init_pf_unroll;
 	}
 
-	err = ice_init_pf_dcb(pf, false);
-	if (err) {
-		clear_bit(ICE_FLAG_DCB_CAPABLE, pf->flags);
-		clear_bit(ICE_FLAG_DCB_ENA, pf->flags);
-
-		/* do not fail overall init if DCB init fails */
-		err = 0;
+	if (test_bit(ICE_FLAG_DCB_CAPABLE, pf->flags)) {
+		/* Note: DCB init failure is non-fatal to load */
+		if (ice_init_pf_dcb(pf, false)) {
+			clear_bit(ICE_FLAG_DCB_CAPABLE, pf->flags);
+			clear_bit(ICE_FLAG_DCB_ENA, pf->flags);
+		}
 	}
 
 	ice_determine_q_usage(pf);
-- 
2.20.1

