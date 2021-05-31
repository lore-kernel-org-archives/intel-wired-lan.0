From: =?unknown-8bit?q?Micha=C5=82_Ma=C5=82oszewski?= <michal.maloszewski@intel.com>
Date: Mon, 31 May 2021 16:55:49 +0000
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Add additional info to PHY
 type error
Message-ID: <1622480149-29979-1-git-send-email-michal.maloszewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Lukasz Cieplicki <lukaszx.cieplicki@intel.com>

In case of PHY type error occurs, the message was too generic.
Add additional info to PHY type error indicating that it can be
wrong cable connected.

Fixes: 124ed15bf126 ("i40e: Add dual speed module support")
Signed-off-by: Lukasz Cieplicki <lukaszx.cieplicki@intel.com>
Signed-off-by: Michal Maloszewski <michal.maloszewski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 45f5dc2..7a1d2d5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -971,7 +971,7 @@ static void i40e_get_settings_link_up(struct i40e_hw *hw,
 	default:
 		/* if we got here and link is up something bad is afoot */
 		netdev_info(netdev,
-			    "WARNING: Link is up but PHY type 0x%x is not recognized.\n",
+			    "WARNING: Link is up but PHY type 0x%x is not recognized, or incorrect cable is in use\n",
 			    hw_link_info->phy_type);
 	}
 
-- 
1.8.3.1

