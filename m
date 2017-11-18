From: Ahmad Fatoum <ahmad@a3f.at>
Date: Sat, 18 Nov 2017 21:53:58 +0100
Subject: [Intel-wired-lan] [PATCH] e1000: Fix off-by-one in debug message
Message-ID: <20171118205358.29595-1-ahmad@a3f.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Ahmad Fatoum <ahmad@a3f.at>
---
 drivers/net/ethernet/intel/e1000/e1000_hw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_hw.c b/drivers/net/ethernet/intel/e1000/e1000_hw.c
index 8172cf08cc33..ba04a65d8500 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_hw.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_hw.c
@@ -4307,8 +4307,8 @@ static void e1000_init_rx_addrs(struct e1000_hw *hw)
 
 	rar_num = E1000_RAR_ENTRIES;
 
-	/* Zero out the other 15 receive addresses. */
-	e_dbg("Clearing RAR[1-15]\n");
+	/* Zero out the following 14 receive addresses. RAR[15] is for manageability */
+	e_dbg("Clearing RAR[1-14]\n");
 	for (i = 1; i < rar_num; i++) {
 		E1000_WRITE_REG_ARRAY(hw, RA, (i << 1), 0);
 		E1000_WRITE_FLUSH();
-- 
2.15.0

