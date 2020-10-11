From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Sun, 11 Oct 2020 22:23:26 +0100
Subject: [Intel-wired-lan] [PATCH] e1000: drop unneeded assignment in
 e1000_set_itr()
Message-ID: <20201011212326.2758-1-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The variable 'current_itr' is assigned to 0 before jumping to
'set_itr_now' but it has not been used after the jump. So, remove the
unneeded assignement.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/net/ethernet/intel/e1000/e1000_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 5e28cf4fa2cd..042de276e632 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -2632,7 +2632,6 @@ static void e1000_set_itr(struct e1000_adapter *adapter)
 
 	/* for non-gigabit speeds, just fix the interrupt rate at 4000 */
 	if (unlikely(adapter->link_speed != SPEED_1000)) {
-		current_itr = 0;
 		new_itr = 4000;
 		goto set_itr_now;
 	}
-- 
2.11.0

