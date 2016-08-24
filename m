From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Wed, 24 Aug 2016 11:33:47 -0700
Subject: [Intel-wired-lan] [next PATCH S44 2/6] i40e: fix "dump port"
	command when NPAR enabled
In-Reply-To: <1472063631-9033-1-git-send-email-bimmy.pujari@intel.com>
References: <1472063631-9033-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1472063631-9033-3-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alan Brady <alan.brady@intel.com>

When using the debugfs to issue the "dump port" command
with NPAR enabled, the firmware reports back with invalid argument.

The issue occurs because the pf->mac_seid was used to perform the query.
This is fine when NPAR is disabled because the switch ID == pf->mac_seid,
however this is not the case when NPAR is enabled.  This fix instead
goes through the VSI to determine the correct ID to use in either case.

HSD-number: 7661076

Signed-off-by: Alan Brady <alan.brady@intel.com>
Change-ID: I0cd67913a7f2c4a2962e06d39e32e7447cc55b6a
---
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index 05cf9a7..8555f04 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -1054,6 +1054,7 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 			struct i40e_dcbx_config *r_cfg =
 						&pf->hw.remote_dcbx_config;
 			int i, ret;
+			u32 switch_id;
 
 			bw_data = kzalloc(sizeof(
 				    struct i40e_aqc_query_port_ets_config_resp),
@@ -1063,8 +1064,12 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 				goto command_write_done;
 			}
 
+			vsi = pf->vsi[pf->lan_vsi];
+			switch_id =
+				vsi->info.switch_id & I40E_AQ_VSI_SW_ID_MASK;
+
 			ret = i40e_aq_query_port_ets_config(&pf->hw,
-							    pf->mac_seid,
+							    switch_id,
 							    bw_data, NULL);
 			if (ret) {
 				dev_info(&pf->pdev->dev,
-- 
2.4.11

