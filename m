From: Jagielski, Jedrzej <jedrzej.jagielski@intel.com>
Date: Tue, 22 Feb 2022 11:43:04 +0000
Subject: [Intel-wired-lan] [PATCH net v1] ice: Fix curr_link_speed
 advertised speed
Message-ID: <20220222114304.126803-1-jedrzej.jagielski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Change curr_link_speed advertised speed, due to
link_info.link_speed is not equal phy.curr_user_speed_req.
Without this patch it is impossible to set adverised
speed to same as link_speed.

Testing Hints: Try to set advertised speed
to 25G only with 25G default link (use ethtool -s 0x80000000)

Fixes: 48cb27f2fd18 ("ice: Implement handlers for ethtool PHY/link operations")
Signed-off-by: Grzegorz Siwik <grzegorz.siwik@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index e2e3ef7fba7f..a5dc9824e255 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -2298,7 +2298,7 @@ ice_set_link_ksettings(struct net_device *netdev,
 	if (err)
 		goto done;
 
-	curr_link_speed = pi->phy.link_info.link_speed;
+	curr_link_speed = pi->phy.curr_user_speed_req;
 	adv_link_speed = ice_ksettings_find_adv_link_speed(ks);
 
 	/* If speed didn't get set, set it to what it currently is.
-- 
2.27.0

