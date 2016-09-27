From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue, 27 Sep 2016 11:28:51 -0700
Subject: [Intel-wired-lan] [next PATCH S48 4/7] i40e: Correctly restore LED
	status after ethtool identify
In-Reply-To: <1475000934-27335-1-git-send-email-bimmy.pujari@intel.com>
References: <1475000934-27335-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1475000934-27335-5-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Henry Tieman <henry.w.tieman@intel.com>

Restore the activity LED status after using "ethtool -p device".

A previous commit incorrectly swapped the parameters for
i40e_led_set(). This results in a failure to restore the LED status
properly after using "ethtool -p" and the activity LED will remain
off until a reset occurs.

Fix the parameter ordering to restore the LED status after the
ethtool identify operation.

Signed-off-by: Henry Tieman <henry.w.tieman@intel.com>
Change-ID: I3fc9ac419e67a53e401d8a70fb20fd6cff3af82c
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 8b6eaf4..1705eec 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1938,7 +1938,7 @@ static int i40e_set_phys_id(struct net_device *netdev,
 		break;
 	case ETHTOOL_ID_INACTIVE:
 		if (!(pf->flags & I40E_FLAG_HAVE_BASET_PHY)) {
-			i40e_led_set(hw, false, pf->led_status);
+			i40e_led_set(hw, pf->led_status, false);
 		} else {
 			ret = i40e_led_set_phy(hw, false, pf->led_status,
 					       (pf->phy_led_val |
-- 
2.4.11

