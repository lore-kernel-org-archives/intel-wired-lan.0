From: Daniel Walker <danielwa@cisco.com>
Date: Fri, 25 Mar 2016 14:58:46 -0700
Subject: [Intel-wired-lan] [PATCH-RFC] drivers: net: ethernet: intel:
	e1000e: fix ethtool autoneg off for fiber
Message-ID: <1458943126-32258-1-git-send-email-danielwa@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Steve Shih <sshih@cisco.com>

This patch fixes the issues for disabling auto-negotiation and forcing
speed and duplex settings for the fiber media.

For fiber media, e1000_get_settings should return ETH_TP_MDI_INVALID for
eth_tp_mdix_ctrl instead of ETH_TP_MDI_AUTO so subsequent e1000_set_settings
call would not fail with -EOPNOTSUPP.

e1000_set_spd_dplx should not automatically turn autoneg back on for forced
1000 Mbps full duplex settings.

Cc: danielwa at fifo99.com
Cc: xe-kernel at external.cisco.com
Signed-off-by: Steve Shih <sshih@cisco.com>
---
 drivers/net/ethernet/intel/e1000e/ethtool.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
index 6cab1f3..cd03dcd 100644
--- a/drivers/net/ethernet/intel/e1000e/ethtool.c
+++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
@@ -201,6 +201,9 @@ static int e1000_get_settings(struct net_device *netdev,
 	else
 		ecmd->eth_tp_mdix_ctrl = hw->phy.mdix;
 
+	if (hw->phy.media_type != e1000_media_type_copper)
+		ecmd->eth_tp_mdix_ctrl = ETH_TP_MDI_INVALID;
+
 	return 0;
 }
 
@@ -236,8 +239,7 @@ static int e1000_set_spd_dplx(struct e1000_adapter *adapter, u32 spd, u8 dplx)
 		mac->forced_speed_duplex = ADVERTISE_100_FULL;
 		break;
 	case SPEED_1000 + DUPLEX_FULL:
-		mac->autoneg = 1;
-		adapter->hw.phy.autoneg_advertised = ADVERTISE_1000_FULL;
+		mac->forced_speed_duplex = ADVERTISE_1000_FULL;
 		break;
 	case SPEED_1000 + DUPLEX_HALF:	/* not supported */
 	default:
-- 
2.5.0

