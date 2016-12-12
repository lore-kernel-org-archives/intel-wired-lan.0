From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 12 Dec 2016 15:44:14 -0800
Subject: [Intel-wired-lan] [next PATCH S57 08/11] i40e: convert to cpu from
	le16 to generate switch_id correctly
In-Reply-To: <1481586257-28872-1-git-send-email-bimmy.pujari@intel.com>
References: <1481586257-28872-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1481586257-28872-9-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

On Big Endian platforms we would incorrectly calculate the wrong switch
id since we did not properly convert the le16 value into CPU format.
Caught by sparse.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Change-ID: I69a2f9fa064a0a91691f7d0e6fcc206adceb8e36
---
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index f1f41f1..267ad25 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -974,7 +974,7 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 			struct i40e_dcbx_config *r_cfg =
 						&pf->hw.remote_dcbx_config;
 			int i, ret;
-			u32 switch_id;
+			u16 switch_id;
 
 			bw_data = kzalloc(sizeof(
 				    struct i40e_aqc_query_port_ets_config_resp),
@@ -986,7 +986,8 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 
 			vsi = pf->vsi[pf->lan_vsi];
 			switch_id =
-				vsi->info.switch_id & I40E_AQ_VSI_SW_ID_MASK;
+				le16_to_cpu(vsi->info.switch_id) &
+					    I40E_AQ_VSI_SW_ID_MASK;
 
 			ret = i40e_aq_query_port_ets_config(&pf->hw,
 							    switch_id,
-- 
2.4.11

