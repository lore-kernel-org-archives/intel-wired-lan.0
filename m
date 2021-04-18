From: Sasha Neftin <sasha.neftin@intel.com>
Date: Sun, 18 Apr 2021 14:40:56 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove unused asymmetric
 pause bit from igc defines
Message-ID: <20210418114056.832012-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The CR_1000T_ASYM_PAUSE bit from igc defines is not used so remove it.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 9d80f2550329..7cc48321bb70 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -128,7 +128,6 @@
 #define NWAY_LPAR_ASM_DIR	0x0800 /* LP Asymmetric Pause Direction bit */
 
 /* 1000BASE-T Control Register */
-#define CR_1000T_ASYM_PAUSE	0x0080 /* Advertise asymmetric pause bit */
 #define CR_1000T_HD_CAPS	0x0100 /* Advertise 1000T HD capability */
 #define CR_1000T_FD_CAPS	0x0200 /* Advertise 1000T FD capability  */
 
-- 
2.25.1

