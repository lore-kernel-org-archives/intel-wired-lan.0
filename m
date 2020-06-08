From: Sasha Levin <sashal@kernel.org>
Date: Mon,  8 Jun 2020 19:05:53 -0400
Subject: [Intel-wired-lan] [PATCH AUTOSEL 5.7 260/274] ice: Fix inability to
 set channels when down
In-Reply-To: <20200608230607.3361041-1-sashal@kernel.org>
References: <20200608230607.3361041-1-sashal@kernel.org>
Message-ID: <20200608230607.3361041-260-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

[ Upstream commit 765dd7a1827c687b782e6ab3dd6daf4d13a4780f ]

Currently the driver prevents a user from doing
modprobe ice
ethtool -L eth0 combined 5
ip link set eth0 up

The ethtool command fails, because the driver is checking to see if the
interface is down before allowing the get_channels to proceed (even for
a set_channels).

Remove this check and allow the user to configure the interface
before bringing it up, which is a much better usability case.

Fixes: 87324e747fde ("ice: Implement ethtool ops for channels")
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 593fb37bd59e..153e3565e313 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3171,10 +3171,6 @@ ice_get_channels(struct net_device *dev, struct ethtool_channels *ch)
 	struct ice_vsi *vsi = np->vsi;
 	struct ice_pf *pf = vsi->back;
 
-	/* check to see if VSI is active */
-	if (test_bit(__ICE_DOWN, vsi->state))
-		return;
-
 	/* report maximum channels */
 	ch->max_rx = ice_get_max_rxq(pf);
 	ch->max_tx = ice_get_max_txq(pf);
-- 
2.25.1

