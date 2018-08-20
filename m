From: Alice Michael <alice.michael@intel.com>
Date: Mon, 20 Aug 2018 08:12:22 -0700
Subject: [Intel-wired-lan] [next PATCH S95 01/12] i40e: Fix VF's link state
 notification
Message-ID: <20180820151233.14629-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mariusz Stachura <mariusz.stachura@intel.com>

This patch moves saving old link status information after the call to
i40e_get_link_status(). Mentioned function updates both old and the new
link info, so reading it before results in not notifying VF about the
PF link state change.

Signed-off-by: Mariusz Stachura <mariusz.stachura@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 456c917..969fb93 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8446,14 +8446,9 @@ static void i40e_link_event(struct i40e_pf *pf)
 	i40e_status status;
 	bool new_link, old_link;
 
-	/* save off old link status information */
-	pf->hw.phy.link_info_old = pf->hw.phy.link_info;
-
 	/* set this to force the get_link_status call to refresh state */
 	pf->hw.phy.get_link_info = true;
-
 	old_link = (pf->hw.phy.link_info_old.link_info & I40E_AQ_LINK_UP);
-
 	status = i40e_get_link_status(&pf->hw, &new_link);
 
 	/* On success, disable temp link polling */
-- 
2.9.5

