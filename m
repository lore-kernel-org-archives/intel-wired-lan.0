From: Peter Senna Tschudin <peter.senna@collabora.com>
Date: Mon,  2 Jan 2017 18:26:06 +0100
Subject: [Intel-wired-lan] [PATCH 1/1] igb: Fix hw_dbg logging in
	igb_update_flash_i210
Message-ID: <14a3078ac22994d9c3dcd56c822555acfdb53b91.1483377891.git.peter.senna@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Hannu Lounento <hannu.lounento@ge.com>

Fix an if statement with hw_dbg lines where the logic was inverted with
regards to the corresponding return value used in the if statement.

Signed-off-by: Hannu Lounento <hannu.lounento@ge.com>
Signed-off-by: Peter Senna Tschudin <peter.senna@collabora.com>
---
 drivers/net/ethernet/intel/igb/e1000_i210.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_i210.c b/drivers/net/ethernet/intel/igb/e1000_i210.c
index 8aa7987..07d48f2 100644
--- a/drivers/net/ethernet/intel/igb/e1000_i210.c
+++ b/drivers/net/ethernet/intel/igb/e1000_i210.c
@@ -699,9 +699,9 @@ static s32 igb_update_flash_i210(struct e1000_hw *hw)
 
 	ret_val = igb_pool_flash_update_done_i210(hw);
 	if (ret_val)
-		hw_dbg("Flash update complete\n");
-	else
 		hw_dbg("Flash update time out\n");
+	else
+		hw_dbg("Flash update complete\n");
 
 out:
 	return ret_val;
-- 
2.5.5

