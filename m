From: Joshua Hay <joshua.a.hay@intel.com>
Date: Wed,  9 Dec 2015 15:50:31 -0800
Subject: [Intel-wired-lan] [next PATCH S23 11/13] i40e: Cleanup the code
	with respect to restarting autoneg
In-Reply-To: <1449705033-4968-1-git-send-email-joshua.a.hay@intel.com>
References: <1449705033-4968-1-git-send-email-joshua.a.hay@intel.com>
Message-ID: <1449705033-4968-12-git-send-email-joshua.a.hay@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anjali Singhai Jain <anjali.singhai@intel.com>

The restart-autoneg work around does not apply to X722.
Added a flag to set it only for the right MAC and right FW version
where the work around should be applied.

Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
Change-ID: I942c3ff40cccd1e56f424b1da776b020fe3c9d2a
---
 drivers/net/ethernet/intel/i40e/i40e.h      |  1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c | 12 ++++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 4747219..bf3776f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -336,6 +336,7 @@ struct i40e_pf {
 #define I40E_FLAG_VEB_MODE_ENABLED		BIT_ULL(40)
 #define I40E_FLAG_NO_PCI_LINK_CHECK		BIT_ULL(41)
 #define I40E_FLAG_100M_SGMII_CAPABLE		BIT_ULL(42)
+#define I40E_FLAG_RESTART_AUTONEG	        BIT_ULL(43)
 
 	/* tracks features that get auto disabled by errors */
 	u64 auto_disable_flags;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 44bbfd8..747387f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -6882,8 +6882,7 @@ static void i40e_reset_and_rebuild(struct i40e_pf *pf, bool reinit)
 		wr32(hw, I40E_REG_MSS, val);
 	}
 
-	if (((pf->hw.aq.fw_maj_ver == 4) && (pf->hw.aq.fw_min_ver < 33)) ||
-	    (pf->hw.aq.fw_maj_ver < 4)) {
+	if (pf->flags & I40E_FLAG_RESTART_AUTONEG) {
 		msleep(75);
 		ret = i40e_aq_set_link_restart_an(&pf->hw, true, NULL);
 		if (ret)
@@ -8362,6 +8361,12 @@ static int i40e_sw_init(struct i40e_pf *pf)
 				 pf->hw.func_caps.fd_filters_best_effort;
 	}
 
+	if (((pf->hw.mac.type == I40E_MAC_X710) ||
+	     (pf->hw.mac.type == I40E_MAC_XL710)) &&
+	    (((pf->hw.aq.fw_maj_ver == 4) && (pf->hw.aq.fw_min_ver < 33)) ||
+	    (pf->hw.aq.fw_maj_ver < 4)))
+		pf->flags |= I40E_FLAG_RESTART_AUTONEG;
+
 	if (pf->hw.func_caps.vmdq) {
 		pf->num_vmdq_vsis = I40E_DEFAULT_NUM_VMDQ_VSI;
 		pf->flags |= I40E_FLAG_VMDQ_ENABLED;
@@ -10791,8 +10796,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		wr32(hw, I40E_REG_MSS, val);
 	}
 
-	if (((pf->hw.aq.fw_maj_ver == 4) && (pf->hw.aq.fw_min_ver < 33)) ||
-	    (pf->hw.aq.fw_maj_ver < 4)) {
+	if (pf->flags & I40E_FLAG_RESTART_AUTONEG) {
 		msleep(75);
 		err = i40e_aq_set_link_restart_an(&pf->hw, true, NULL);
 		if (err)
-- 
2.1.0

