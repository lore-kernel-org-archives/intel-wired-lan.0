From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 16 Apr 2019 10:21:22 -0700
Subject: [Intel-wired-lan] [PATCH S18 09/15] ice: Remove __always_unused
 attribute
In-Reply-To: <20190416172128.27184-1-anirudh.venkataramanan@intel.com>
References: <20190416172128.27184-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190416172128.27184-10-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Tony Nguyen <anthony.l.nguyen@intel.com>

The variable netdev is being used in this function; remove the
__always_unused attribute from it.

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 08ec2f3c5977..1341fde8d53f 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -1251,7 +1251,7 @@ ice_get_settings_link_up(struct ethtool_link_ksettings *ks,
  */
 static void
 ice_get_settings_link_down(struct ethtool_link_ksettings *ks,
-			   struct net_device __always_unused *netdev)
+			   struct net_device *netdev)
 {
 	/* link is down and the driver needs to fall back on
 	 * supported PHY types to figure out what info to display
-- 
2.20.1

