From: =?unknown-8bit?q?J=CE=B5an?= Sacren <sakiwit@gmail.com>
Date: Mon, 14 Sep 2015 00:27:50 -0600
Subject: [Intel-wired-lan] [next-queue 8/8] e1000: get rid of duplicate exit
	path
In-Reply-To: <1442212070-24937-1-git-send-email-sakiwit@gmail.com>
References: <1442212070-24937-1-git-send-email-sakiwit@gmail.com>
Message-ID: <1442212070-24937-9-git-send-email-sakiwit@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jean Sacren <sakiwit@gmail.com>

By using goto statement, we can achieve sharing the same exit path so
that code duplication could be minimized.

Signed-off-by: Jean Sacren <sakiwit@gmail.com>
---
 drivers/net/ethernet/intel/e1000/e1000_hw.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_hw.c b/drivers/net/ethernet/intel/e1000/e1000_hw.c
index a67a2c4499eb..737d5c79256b 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_hw.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_hw.c
@@ -2824,14 +2824,13 @@ s32 e1000_read_phy_reg(struct e1000_hw *hw, u32 reg_addr, u16 *phy_data)
 	    (reg_addr > MAX_PHY_MULTI_PAGE_REG)) {
 		ret_val = e1000_write_phy_reg_ex(hw, IGP01E1000_PHY_PAGE_SELECT,
 						 (u16) reg_addr);
-		if (ret_val) {
-			spin_unlock_irqrestore(&e1000_phy_lock, flags);
-			return ret_val;
-		}
+		if (ret_val)
+			goto out;
 	}
 
 	ret_val = e1000_read_phy_reg_ex(hw, MAX_PHY_REG_ADDRESS & reg_addr,
 					phy_data);
+out:
 	spin_unlock_irqrestore(&e1000_phy_lock, flags);
 
 	return ret_val;
