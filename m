From: Gal Hammer <ghammer@redhat.com>
Date: Wed,  6 Jan 2021 11:28:26 +0200
Subject: [Intel-wired-lan] [PATCH] igb: fix TDBAL register show incorrect
 value
Message-ID: <20210106092826.345172-1-ghammer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fixed a typo which caused the registers dump function to read the
RDBAL register when printing TDBAL register values.

Signed-off-by: Gal Hammer <ghammer@redhat.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 03f78fdb0dcd..006f5cb839f3 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -316,7 +316,7 @@ static void igb_regdump(struct e1000_hw *hw, struct igb_reg_info *reginfo)
 		break;
 	case E1000_TDBAL(0):
 		for (n = 0; n < 4; n++)
-			regs[n] = rd32(E1000_RDBAL(n));
+			regs[n] = rd32(E1000_TDBAL(n));
 		break;
 	case E1000_TDBAH(0):
 		for (n = 0; n < 4; n++)
-- 
2.26.2

