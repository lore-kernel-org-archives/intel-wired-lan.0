From: =?unknown-8bit?q?J=CE=B5an?= Sacren <sakiwit@gmail.com>
Date: Sat, 19 Sep 2015 05:08:46 -0600
Subject: [Intel-wired-lan] [next-queue v2 7/8] e1000: fix kernel-doc
	argument being missing
In-Reply-To: <1442660927-30431-1-git-send-email-sakiwit@gmail.com>
References: <1442660927-30431-1-git-send-email-sakiwit@gmail.com>
Message-ID: <1442660927-30431-7-git-send-email-sakiwit@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jean Sacren <sakiwit@gmail.com>

Due to historical reason, 'phy_data' has never been included in the
kernel doc. Fix it so that the requirement could be fulfilled.

Signed-off-by: Jean Sacren <sakiwit@gmail.com>
---
v2: No changes.

 drivers/net/ethernet/intel/e1000/e1000_hw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_hw.c b/drivers/net/ethernet/intel/e1000/e1000_hw.c
index 59d1769d4816..dbae55e926e7 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_hw.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_hw.c
@@ -2806,6 +2806,7 @@ static u16 e1000_shift_in_mdi_bits(struct e1000_hw *hw)
  * e1000_read_phy_reg - read a phy register
  * @hw: Struct containing variables accessed by shared code
  * @reg_addr: address of the PHY register to read
+ * @phy_data: pointer to the value on the PHY register
  *
  * Reads the value from a PHY register, if the value is on a specific non zero
  * page, sets the page first.
