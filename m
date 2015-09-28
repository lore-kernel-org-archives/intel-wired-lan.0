From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 28 Sep 2015 14:16:59 -0400
Subject: [Intel-wired-lan] [next PATCH S17 10/11] i40e: Move error message
	to debug level
In-Reply-To: <1443464220-148318-1-git-send-email-catherine.sullivan@intel.com>
References: <1443464220-148318-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1443464220-148318-11-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

There is an error coming back from get_phy_capabilities that does not
seem to have any functional implications. We will continue looking into
why this error message is occurring, but in the meantime, we will move it
to debug to avoid confusion.

Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
Change-ID: I9091754bf62c066ddedeb249923d85606e2d68ed
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index fcbe719..8d12328 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -751,9 +751,9 @@ static int i40e_set_settings(struct net_device *netdev,
 
 		status = i40e_update_link_info(hw);
 		if (status)
-			netdev_info(netdev, "Updating link info failed with err %s aq_err %s\n",
-				    i40e_stat_str(hw, status),
-				    i40e_aq_str(hw, hw->aq.asq_last_status));
+			netdev_dbg(netdev, "Updating link info failed with err %s aq_err %s\n",
+				   i40e_stat_str(hw, status),
+				   i40e_aq_str(hw, hw->aq.asq_last_status));
 
 	} else {
 		netdev_info(netdev, "Nothing changed, exiting without setting anything.\n");
-- 
1.9.3

