From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 24 Mar 2015 21:30:19 -0700
Subject: [Intel-wired-lan] [next-queue S2 09/15] i40e: Don't
	register/de-register apps on NIC partitions in MFP mode
In-Reply-To: <1427257825-24519-1-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1427257825-24519-1-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <1427257825-24519-9-git-send-email-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Neerav Parikh <neerav.parikh@intel.com>

Do not register or try to de-register DCB applications with the DCBNL
layer in case of NIC partitions when adapter is in MFP mode.

Change-ID: I603d042a61983a6562be471c6a2b181572504118
Signed-off-by: Neerav Parikh <neerav.parikh@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c b/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
index 400fb28..bd5079d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
@@ -178,6 +178,10 @@ void i40e_dcbnl_set_all(struct i40e_vsi *vsi)
 	if (!(pf->flags & I40E_FLAG_DCB_ENABLED))
 		return;
 
+	/* MFP mode but not an iSCSI PF so return */
+	if ((pf->flags & I40E_FLAG_MFP_ENABLED) && !(pf->hw.func_caps.iscsi))
+		return;
+
 	dcbxcfg = &hw->local_dcbx_config;
 
 	/* Set up all the App TLVs if DCBx is negotiated */
@@ -282,6 +286,10 @@ void i40e_dcbnl_flush_apps(struct i40e_pf *pf,
 	struct i40e_dcb_app_priority_table app;
 	int i;
 
+	/* MFP mode but not an iSCSI PF so return */
+	if ((pf->flags & I40E_FLAG_MFP_ENABLED) && !(pf->hw.func_caps.iscsi))
+		return;
+
 	for (i = 0; i < old_cfg->numapps; i++) {
 		app = old_cfg->app[i];
 		/* The APP is not available anymore delete it */
-- 
1.9.3

