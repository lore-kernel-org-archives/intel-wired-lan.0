From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Wed, 26 Aug 2015 15:14:13 -0400
Subject: [Intel-wired-lan] [next PATCH S11 07/15] i40e: make
	i40e_init_pf_fcoe to void
In-Reply-To: <1440616461-110869-1-git-send-email-catherine.sullivan@intel.com>
References: <1440616461-110869-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1440616461-110869-8-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

i40e_init_pf_fcoe() didn't return anything except 0, it prints enough
error info already, and no driver logic depends on the return value,
so this can be void.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Change-ID: Ie6afad849857d87a7064c42c3cce14c74c2f29d8
---
 drivers/net/ethernet/intel/i40e/i40e.h      |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_fcoe.c | 10 ++++------
 drivers/net/ethernet/intel/i40e/i40e_main.c |  8 ++------
 3 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 12c96da..5e546f9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -742,7 +742,7 @@ int i40e_fcoe_vsi_init(struct i40e_vsi *vsi, struct i40e_vsi_context *ctxt);
 u8 i40e_get_fcoe_tc_map(struct i40e_pf *pf);
 void i40e_fcoe_config_netdev(struct net_device *netdev, struct i40e_vsi *vsi);
 void i40e_fcoe_vsi_setup(struct i40e_pf *pf);
-int i40e_init_pf_fcoe(struct i40e_pf *pf);
+void i40e_init_pf_fcoe(struct i40e_pf *pf);
 int i40e_fcoe_setup_ddp_resources(struct i40e_vsi *vsi);
 void i40e_fcoe_free_ddp_resources(struct i40e_vsi *vsi);
 int i40e_fcoe_handle_offload(struct i40e_ring *rx_ring,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_fcoe.c b/drivers/net/ethernet/intel/i40e/i40e_fcoe.c
index 5ea75dd..2398d9b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_fcoe.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_fcoe.c
@@ -272,10 +272,8 @@ out:
 /**
  * i40e_fcoe_sw_init - sets up the HW for FCoE
  * @pf: pointer to PF
- *
- * Returns 0 if FCoE is supported otherwise the error code
  **/
-int i40e_init_pf_fcoe(struct i40e_pf *pf)
+void i40e_init_pf_fcoe(struct i40e_pf *pf)
 {
 	struct i40e_hw *hw = &pf->hw;
 	u32 val;
@@ -287,13 +285,13 @@ int i40e_init_pf_fcoe(struct i40e_pf *pf)
 
 	if (!pf->hw.func_caps.fcoe) {
 		dev_info(&pf->pdev->dev, "FCoE capability is disabled\n");
-		return 0;
+		return;
 	}
 
 	if (!pf->hw.func_caps.dcb) {
 		dev_warn(&pf->pdev->dev,
 			 "Hardware is not DCB capable not enabling FCoE.\n");
-		return 0;
+		return;
 	}
 
 	/* enable FCoE hash filter */
@@ -326,7 +324,7 @@ int i40e_init_pf_fcoe(struct i40e_pf *pf)
 	wr32(hw, I40E_GLFCOE_RCTL, val);
 
 	dev_info(&pf->pdev->dev, "FCoE is supported.\n");
-	return 0;
+	return;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index bf181e9..f7da41b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -6426,9 +6426,7 @@ static void i40e_reset_and_rebuild(struct i40e_pf *pf, bool reinit)
 	}
 #endif /* CONFIG_I40E_DCB */
 #ifdef I40E_FCOE
-	ret = i40e_init_pf_fcoe(pf);
-	if (ret)
-		dev_info(&pf->pdev->dev, "init_pf_fcoe failed: %d\n", ret);
+	i40e_init_pf_fcoe(pf);
 
 #endif
 	/* do basic switch setup */
@@ -7824,9 +7822,7 @@ static int i40e_sw_init(struct i40e_pf *pf)
 	}
 
 #ifdef I40E_FCOE
-	err = i40e_init_pf_fcoe(pf);
-	if (err)
-		dev_info(&pf->pdev->dev, "init_pf_fcoe failed: %d\n", err);
+	i40e_init_pf_fcoe(pf);
 
 #endif /* I40E_FCOE */
 #ifdef CONFIG_PCI_IOV
-- 
1.9.3

