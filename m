From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu,  7 May 2020 17:41:02 -0700
Subject: [Intel-wired-lan] [PATCH S41 04/15] ice: only drop link once when
 setting pauseparams
In-Reply-To: <20200508004113.39725-1-anthony.l.nguyen@intel.com>
References: <20200508004113.39725-1-anthony.l.nguyen@intel.com>
Message-ID: <20200508004113.39725-4-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Dave Ertman <david.m.ertman@intel.com>

Currently, the ice driver is setting a PHY configuration,
which causes a link drop, and then additionally it calls
for a nway_reset, which restarts auto-negotiation on the
link, which also causes a link drop.  These two link
events in such close timing is causing the FW to not be
able to generate a link interrupt for the driver to
respond to.

Remove the unnecessary auto-negotiation restart from the
set pauseparams flow.  Also remove error path that
would have performed an ice_down/ice_up as that is
also unnecessary.

Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 66d0bcc51ad9..db547c0c7c6f 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -2977,18 +2977,6 @@ ice_set_pauseparam(struct net_device *netdev, struct ethtool_pauseparam *pause)
 		err = -EAGAIN;
 	}
 
-	if (!test_bit(__ICE_DOWN, pf->state)) {
-		/* Give it a little more time to try to come back. If still
-		 * down, restart autoneg link or reinitialize the interface.
-		 */
-		msleep(75);
-		if (!test_bit(__ICE_DOWN, pf->state))
-			return ice_nway_reset(netdev);
-
-		ice_down(vsi);
-		ice_up(vsi);
-	}
-
 	return err;
 }
 
-- 
2.20.1

