From: Grzegorz Siwik <grzegorz.siwik@intel.com>
Date: Fri, 30 Apr 2021 14:41:30 +0200
Subject: [Intel-wired-lan] [PATCH net-next v2] igb: Add counter to i21x
 doublecheck
Message-ID: <1619786490-418369-1-git-send-email-grzegorz.siwik@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add failed_counter to i21x_doublecheck(). There is possibility that
loop will never end.
With this patch the loop will stop after maximum 3 retries
to write to MTA_REGISTER

Signed-off-by: Grzegorz Siwik <grzegorz.siwik@intel.com>
---
v2: Changed retries counting method
Moved hw_dbg info
---
 drivers/net/ethernet/intel/igb/e1000_mac.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_mac.c b/drivers/net/ethernet/intel/igb/e1000_mac.c
index e63ee3c..1277c5c 100644
--- a/drivers/net/ethernet/intel/igb/e1000_mac.c
+++ b/drivers/net/ethernet/intel/igb/e1000_mac.c
@@ -492,6 +492,7 @@ static u32 igb_hash_mc_addr(struct e1000_hw *hw, u8 *mc_addr)
  **/
 static void igb_i21x_hw_doublecheck(struct e1000_hw *hw)
 {
+	int failed_cnt = 3;
 	bool is_failed;
 	int i;
 
@@ -502,9 +503,12 @@ static void igb_i21x_hw_doublecheck(struct e1000_hw *hw)
 				is_failed = true;
 				array_wr32(E1000_MTA, i, hw->mac.mta_shadow[i]);
 				wrfl();
-				break;
 			}
 		}
+		if (is_failed && --failed_cnt <= 0) {
+			hw_dbg("Failed to update MTA_REGISTER, too many retries");
+			break;
+		}
 	} while (is_failed);
 }
 
-- 
1.8.3.1

