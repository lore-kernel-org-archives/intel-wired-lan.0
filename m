From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 12 Dec 2016 15:44:09 -0800
Subject: [Intel-wired-lan] [next PATCH S57 03/11] i40e: remove unnecessary
	call to i40e_update_link_info
In-Reply-To: <1481586257-28872-1-git-send-email-bimmy.pujari@intel.com>
References: <1481586257-28872-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1481586257-28872-4-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

This call is made just prior to running i40e_link_event. In
i40e_link_event, we set hw->phy.get_link_info to true just prior to
calling i40e_get_link_status, which conveniently runs
i40e_update_link_info for us. Thus, we are running i40e_update_link_info
twice, which seems like something we don't need to do...

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Change-ID: I36467a570f44b7546d218c99e134ff97c2709315
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 51a962c..128a21e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -10777,7 +10777,6 @@ static int i40e_setup_pf_switch(struct i40e_pf *pf, bool reinit)
 		i40e_pf_config_rss(pf);
 
 	/* fill in link information and enable LSE reporting */
-	i40e_update_link_info(&pf->hw);
 	i40e_link_event(pf);
 
 	/* Initialize user-specific link properties */
-- 
2.4.11

