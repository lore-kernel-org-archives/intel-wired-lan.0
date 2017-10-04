From: Alan Brady <alan.brady@intel.com>
Date: Wed,  4 Oct 2017 10:58:28 -0700
Subject: [Intel-wired-lan] [PATCH 02/13 net-next] i40e: remove ifdef
	SPEED_25000
In-Reply-To: <20171004175839.28364-1-alan.brady@intel.com>
References: <20171004175839.28364-1-alan.brady@intel.com>
Message-ID: <20171004175839.28364-3-alan.brady@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This 'ifdef' doesn't accomplish anything so remove it.

Signed-off-by: Alan Brady <alan.brady@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 4ed5deab7e68..4fda529a464b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -531,12 +531,7 @@ static void i40e_get_settings_link_up(struct i40e_hw *hw,
 		ks->base.speed = SPEED_40000;
 		break;
 	case I40E_LINK_SPEED_25GB:
-#ifdef SPEED_25000
 		ks->base.speed = SPEED_25000;
-#else
-		netdev_info(netdev,
-			    "Speed is 25G, display not supported by this version of ethtool.\n");
-#endif
 		break;
 	case I40E_LINK_SPEED_20GB:
 		ks->base.speed = SPEED_20000;
-- 
2.14.1

