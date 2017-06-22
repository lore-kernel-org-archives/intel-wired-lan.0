From: Michael Moese <michael.moese@men.de>
Date: Thu, 22 Jun 2017 15:23:56 +0200
Subject: [Intel-wired-lan] [PATCH] Added SIOCSMIIREG (mii write) support to
	intel igb driver
Message-ID: <20170622132356.2567-1-michael.moese@men.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Andreas Werner <andreas.werner@men.de>

Signed-off-by: Andreas Werner <andreas.werner@men.de>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 1cf74aa4ebd9..87e496eeefb1 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -7716,6 +7716,10 @@ static int igb_mii_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
 			return -EIO;
 		break;
 	case SIOCSMIIREG:
+		if (igb_write_phy_reg(&adapter->hw, data->reg_num & 0x1F,
+				      data->val_in))
+			return -EIO;
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
-- 
2.12.3

