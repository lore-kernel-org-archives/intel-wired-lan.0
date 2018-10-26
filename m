From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri, 26 Oct 2018 10:40:52 -0700
Subject: [Intel-wired-lan] [PATCH S8 03/16] ice: Fix dead device link issue
 with flow control
In-Reply-To: <20181026174105.11628-1-anirudh.venkataramanan@intel.com>
References: <20181026174105.11628-1-anirudh.venkataramanan@intel.com>
Message-ID: <20181026174105.11628-4-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>

Setting Rx or Tx pause parameter currently results in link loss on the
interface, requiring the platform/host to be cold power cycled. Fix it.

Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> rewrote commit message]
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 96923580f2a6..648acdb4c644 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -1517,10 +1517,15 @@ ice_set_pauseparam(struct net_device *netdev, struct ethtool_pauseparam *pause)
 	}
 
 	if (!test_bit(__ICE_DOWN, pf->state)) {
-		/* Give it a little more time to try to come back */
+		/* Give it a little more time to try to come back. If still
+		 * down, restart autoneg link or reinitialize the interface.
+		 */
 		msleep(75);
 		if (!test_bit(__ICE_DOWN, pf->state))
 			return ice_nway_reset(netdev);
+
+		ice_down(vsi);
+		ice_up(vsi);
 	}
 
 	return err;
-- 
2.14.3

