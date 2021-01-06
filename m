From: Sasha Neftin <sasha.neftin@intel.com>
Date: Wed,  6 Jan 2021 19:27:04 +0200
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Fix TDBAL register show
 incorrect value
Message-ID: <20210106172704.3106880-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fixed a typo which caused the registers dump function to read the
RDBAL register when printing TDBAL register values.
_reg_dump method has been partially derived from i210 and have
same typo.

Suggested-by: Gal Hammer <ghammer@redhat.com>
Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_dump.c b/drivers/net/ethernet/intel/igc/igc_dump.c
index 4b9ec7d0b727..495bed47ed0a 100644
--- a/drivers/net/ethernet/intel/igc/igc_dump.c
+++ b/drivers/net/ethernet/intel/igc/igc_dump.c
@@ -75,7 +75,7 @@ static void igc_regdump(struct igc_hw *hw, struct igc_reg_info *reginfo)
 		break;
 	case IGC_TDBAL(0):
 		for (n = 0; n < 4; n++)
-			regs[n] = rd32(IGC_RDBAL(n));
+			regs[n] = rd32(IGC_TDBAL(n));
 		break;
 	case IGC_TDBAH(0):
 		for (n = 0; n < 4; n++)
-- 
2.25.1

