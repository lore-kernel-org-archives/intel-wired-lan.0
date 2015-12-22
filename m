From: Raanan Avargil <raanan.avargil@intel.com>
Date: Tue, 22 Dec 2015 15:35:01 +0200
Subject: [Intel-wired-lan] [PATCH 1/5] e1000e: Increase ULP timer
Message-ID: <1450791305-11285-1-git-send-email-raanan.avargil@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Due to system level changes introduced in Skylake, ULP exit
takes significantly longer to occur.
Therefore, driver must wait longer for.

Signed-off-by: Raanan Avargil <raanan.avargil@intel.com>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index a049e30..c731465 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -1252,9 +1252,9 @@ static s32 e1000_disable_ulp_lpt_lp(struct e1000_hw *hw, bool force)
 			ew32(H2ME, mac_reg);
 		}
 
-		/* Poll up to 100msec for ME to clear ULP_CFG_DONE */
+		/* Poll up to 300msec for ME to clear ULP_CFG_DONE. */
 		while (er32(FWSM) & E1000_FWSM_ULP_CFG_DONE) {
-			if (i++ == 10) {
+			if (i++ == 30) {
 				ret_val = -E1000_ERR_PHY;
 				goto out;
 			}
-- 
2.1.0

---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

