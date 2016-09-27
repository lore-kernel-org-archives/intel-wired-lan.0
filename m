From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue, 27 Sep 2016 11:28:52 -0700
Subject: [Intel-wired-lan] [next PATCH S48 5/7] i40e: Fix for long link down
	notification time
In-Reply-To: <1475000934-27335-1-git-send-email-bimmy.pujari@intel.com>
References: <1475000934-27335-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1475000934-27335-6-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Carolyn Wyborny <carolyn.wyborny@intel.com>

This patch fixes a problem where it could take a very
long time (>100 msec) to print the link down notification.
This problem is fixed by changing how often we update link
info from fw, when link is down. Without this patch, it can
take over 100msec to notify user link is down.

Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
Change-ID: Ib876eb30834c7080792becd13ee093b9cbb35d78
---
Testing Hints : Check msec to link down notification appearance. 
Should be less than 100msec vs.more before.

 drivers/net/ethernet/intel/i40e/i40e_common.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index fe8100b..a475946 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -2494,7 +2494,10 @@ i40e_status i40e_update_link_info(struct i40e_hw *hw)
 	if (status)
 		return status;
 
-	if (hw->phy.link_info.link_info & I40E_AQ_MEDIA_AVAILABLE) {
+	/* extra checking needed to ensure link info to user is timely */
+	if ((hw->phy.link_info.link_info & I40E_AQ_MEDIA_AVAILABLE) &&
+	    ((hw->phy.link_info.link_info & I40E_AQ_LINK_UP) ||
+	     !(hw->phy.link_info_old.link_info & I40E_AQ_LINK_UP))) {
 		status = i40e_aq_get_phy_capabilities(hw, false, false,
 						      &abilities, NULL);
 		if (status)
-- 
2.4.11

