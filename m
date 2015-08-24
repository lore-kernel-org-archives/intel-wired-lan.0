From: Anjali Singhai Jain <anjali.singhai@intel.com>
Date: Mon, 24 Aug 2015 13:26:53 -0700
Subject: [Intel-wired-lan] [PATCH] i40e: Fix a memory leak in X722 rss
	config path
Message-ID: <1440448013-196583-1-git-send-email-anjali.singhai@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In any case free the memory allocated before exiting.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 7b41e1a..c333ad5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -7475,7 +7475,7 @@ static int i40e_config_rss_aq(struct i40e_vsi *vsi, const u8 *seed)
 			 "Cannot set RSS key, err %s aq_err %s\n",
 			 i40e_stat_str(&pf->hw, ret),
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
-		return ret;
+		goto config_rss_aq_out;
 	}
 
 	if (vsi->type == I40E_VSI_MAIN)
@@ -7489,6 +7489,8 @@ static int i40e_config_rss_aq(struct i40e_vsi *vsi, const u8 *seed)
 			 i40e_stat_str(&pf->hw, ret),
 			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 
+config_rss_aq_out:
+	kfree(rss_lut);
 	return ret;
 }
 
-- 
1.8.1.4

