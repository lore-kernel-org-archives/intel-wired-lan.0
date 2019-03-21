From: Stefan Assmann <sassmann@kpanic.de>
Date: Thu, 21 Mar 2019 13:45:35 +0100
Subject: [Intel-wired-lan] [PATCH] i40e: fix WoL support check
Message-ID: <20190321124535.18311-1-sassmann@kpanic.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The current check for WoL on i40e is broken. Code comment says only
magic packet is supported, so only check for that.

Fixes: 540a152da762 (i40e/ixgbe/igb: fail on new WoL flag setting WAKE_MAGICSECURE)

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 4c885801fa26..7874d0ec7fb0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2573,8 +2573,7 @@ static int i40e_set_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
 		return -EOPNOTSUPP;
 
 	/* only magic packet is supported */
-	if (wol->wolopts && (wol->wolopts != WAKE_MAGIC)
-			  | (wol->wolopts != WAKE_FILTER))
+	if (wol->wolopts & ~WAKE_MAGIC)
 		return -EOPNOTSUPP;
 
 	/* is this a new value? */
-- 
2.20.1

