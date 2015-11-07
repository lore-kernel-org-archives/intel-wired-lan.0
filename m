From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Fri, 06 Nov 2015 16:34:33 -0800
Subject: [Intel-wired-lan] [PATCH] ixgbe: do not report 2.5 Gbps as supported
Message-ID: <20151107003433.20895.67529.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Some X550 devices can connect at 2.5Gbps during fail-over, but only
with certain link partners. Also setting the advertised speed will
not work so we do not report it as supported to avoid confusion.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index d681273..1ed4c9a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -166,8 +166,6 @@ static int ixgbe_get_settings(struct net_device *netdev,
 	/* set the supported link speeds */
 	if (supported_link & IXGBE_LINK_SPEED_10GB_FULL)
 		ecmd->supported |= SUPPORTED_10000baseT_Full;
-	if (supported_link & IXGBE_LINK_SPEED_2_5GB_FULL)
-		ecmd->supported |= SUPPORTED_2500baseX_Full;
 	if (supported_link & IXGBE_LINK_SPEED_1GB_FULL)
 		ecmd->supported |= SUPPORTED_1000baseT_Full;
 	if (supported_link & IXGBE_LINK_SPEED_100_FULL)
@@ -179,8 +177,6 @@ static int ixgbe_get_settings(struct net_device *netdev,
 			ecmd->advertising |= ADVERTISED_100baseT_Full;
 		if (hw->phy.autoneg_advertised & IXGBE_LINK_SPEED_10GB_FULL)
 			ecmd->advertising |= ADVERTISED_10000baseT_Full;
-		if (hw->phy.autoneg_advertised & IXGBE_LINK_SPEED_2_5GB_FULL)
-			ecmd->advertising |= ADVERTISED_2500baseX_Full;
 		if (hw->phy.autoneg_advertised & IXGBE_LINK_SPEED_1GB_FULL)
 			ecmd->advertising |= ADVERTISED_1000baseT_Full;
 	} else {

