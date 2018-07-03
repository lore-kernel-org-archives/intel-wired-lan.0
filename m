From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Mon,  2 Jul 2018 17:09:30 -0700
Subject: [Intel-wired-lan] [PATCH next-queue] ixgbe: add ipsec security
 registers into ethtool register dump
Message-ID: <1530576570-17065-1-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add the ixgbe's security configuration registers into
the register dump.

Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index bd1ba88..1d68884 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -511,7 +511,7 @@ static void ixgbe_set_msglevel(struct net_device *netdev, u32 data)
 
 static int ixgbe_get_regs_len(struct net_device *netdev)
 {
-#define IXGBE_REGS_LEN  1139
+#define IXGBE_REGS_LEN  1145
 	return IXGBE_REGS_LEN * sizeof(u32);
 }
 
@@ -874,6 +874,14 @@ static void ixgbe_get_regs(struct net_device *netdev,
 	/* X540 specific DCB registers  */
 	regs_buff[1137] = IXGBE_READ_REG(hw, IXGBE_RTTQCNCR);
 	regs_buff[1138] = IXGBE_READ_REG(hw, IXGBE_RTTQCNTG);
+
+	/* Security config registers */
+	regs_buff[1139] = IXGBE_READ_REG(hw, IXGBE_SECTXCTRL);
+	regs_buff[1140] = IXGBE_READ_REG(hw, IXGBE_SECTXSTAT);
+	regs_buff[1141] = IXGBE_READ_REG(hw, IXGBE_SECTXBUFFAF);
+	regs_buff[1142] = IXGBE_READ_REG(hw, IXGBE_SECTXMINIFG);
+	regs_buff[1143] = IXGBE_READ_REG(hw, IXGBE_SECRXCTRL);
+	regs_buff[1144] = IXGBE_READ_REG(hw, IXGBE_SECRXSTAT);
 }
 
 static int ixgbe_get_eeprom_len(struct net_device *netdev)
-- 
2.7.4

