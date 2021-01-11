From: Sasha Neftin <sasha.neftin@intel.com>
Date: Mon, 11 Jan 2021 07:17:53 +0200
Subject: [Intel-wired-lan] [PATCH v2 1/1] igc: Remove unused MII_CR_RESET
Message-ID: <20210111051753.3531291-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

MII_CR_RESET mask not in use in i225 device and can it removed

v1->v2:
Fix commit message

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 4fc9ef978ad3..58fc207dc995 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -442,7 +442,6 @@
 #define MII_CR_POWER_DOWN	0x0800  /* Power down */
 #define MII_CR_AUTO_NEG_EN	0x1000  /* Auto Neg Enable */
 #define MII_CR_LOOPBACK		0x4000  /* 0 = normal, 1 = loopback */
-#define MII_CR_RESET		0x8000  /* 0 = normal, 1 = PHY reset */
 #define MII_CR_SPEED_1000	0x0040
 #define MII_CR_SPEED_100	0x2000
 #define MII_CR_SPEED_10		0x0000
-- 
2.25.1

