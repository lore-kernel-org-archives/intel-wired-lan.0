From: Aaron Sierra <asierra@xes-inc.com>
Date: Tue, 3 Nov 2015 12:37:18 -0600 (CST)
Subject: [Intel-wired-lan] [PATCH 2/5] igb: Don't add PHY address to PCDL
	address
In-Reply-To: <197584129.304313.1446575155971.JavaMail.zimbra@xes-inc.com>
Message-ID: <1064069608.305775.1446575838742.JavaMail.zimbra@xes-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

There is no reason to add the PHY address into the PCDL register address.

Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
---
 drivers/net/ethernet/intel/igb/e1000_phy.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_phy.c b/drivers/net/ethernet/intel/igb/e1000_phy.c
index ec1aea5..407d44a 100644
--- a/drivers/net/ethernet/intel/igb/e1000_phy.c
+++ b/drivers/net/ethernet/intel/igb/e1000_phy.c
@@ -1734,8 +1734,7 @@ s32 igb_get_cable_length_m88_gen2(struct e1000_hw *hw)
 			goto out;
 
 		/* Get cable length from PHY Cable Diagnostics Control Reg */
-		ret_val = phy->ops.read_reg(hw, (I347AT4_PCDL + phy->addr),
-					    &phy_data);
+		ret_val = phy->ops.read_reg(hw, I347AT4_PCDL, &phy_data);
 		if (ret_val)
 			goto out;
 
-- 
1.9.1

