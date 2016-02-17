From: Doron Shikmoni <doron.shikmoni@gmail.com>
Date: Wed, 17 Feb 2016 09:34:25 +0200
Subject: [Intel-wired-lan] [PATCH] igb: Garbled output for "ethtool -m"
Message-ID: <1455694465-1226-1-git-send-email-doron.shikmoni@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello,

Garbled output for "ethtool -m ethX", in igb-driven NICs with module /
plugin EEPROM (i.e. SFP information). Each output data byte appears
duplicated.

In igb_ethtool.c, igb_get_module_eeprom() is reading the EEPROM via i2c;
the eeprom offset for each word that's read via igb_read_phy_reg_i2c()
was passed in #words, whereas it needs to be a byte offset.
This patches fixes the bug.

Signed-off-by: Doron Shikmoni <doron.shikmoni@gmail.com>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 1d329f1..7bcc0e1e 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -2831,7 +2831,7 @@ static int igb_get_module_eeprom(struct net_device *netdev,
 
 	/* Read EEPROM block, SFF-8079/SFF-8472, word at a time */
 	for (i = 0; i < last_word - first_word + 1; i++) {
-		status = igb_read_phy_reg_i2c(hw, first_word + i, &dataword[i]);
+		status = igb_read_phy_reg_i2c(hw, (first_word + i) * 2, &dataword[i]);
 		if (status) {
 			/* Error occurred while reading module */
 			kfree(dataword);
-- 
1.7.10.4

