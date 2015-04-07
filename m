From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Tue,  7 Apr 2015 19:45:41 -0400
Subject: [Intel-wired-lan]  [net-next S3 12/13] i40e: Use new 40G speeds
In-Reply-To: <1428450342-48517-1-git-send-email-catherine.sullivan@intel.com>
References: <1428450342-48517-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1428450342-48517-12-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Greg Rose <gregory.v.rose@intel.com>

The kernel has added SPEED_40000 for ethtool.
Go ahead and use the new #define.

Signed-off-by: Greg Rose <gregory.v.rose@intel.com>
Change-ID: Ic7e16e5c9e91085afe539f11ee1b7668adc4d0ef
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 7d60587..4cbaaeb 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -356,8 +356,7 @@ static void i40e_get_settings_link_up(struct i40e_hw *hw,
 	/* Set speed and duplex */
 	switch (link_speed) {
 	case I40E_LINK_SPEED_40GB:
-		/* need a SPEED_40000 in ethtool.h */
-		ethtool_cmd_speed_set(ecmd, 40000);
+		ethtool_cmd_speed_set(ecmd, SPEED_40000);
 		break;
 	case I40E_LINK_SPEED_20GB:
 		ethtool_cmd_speed_set(ecmd, SPEED_20000);
-- 
1.9.3

