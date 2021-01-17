From: Sasha Neftin <sasha.neftin@intel.com>
Date: Sun, 17 Jan 2021 10:16:45 +0200
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove unused MII_CR_SPEED
Message-ID: <20210117081645.4120780-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Force PHY speed not supported for i225 devices.
MII_CR_SPEED masks not in use in i225 device and can be removed.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 58fc207dc995..c5b36ec7bcff 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -442,9 +442,6 @@
 #define MII_CR_POWER_DOWN	0x0800  /* Power down */
 #define MII_CR_AUTO_NEG_EN	0x1000  /* Auto Neg Enable */
 #define MII_CR_LOOPBACK		0x4000  /* 0 = normal, 1 = loopback */
-#define MII_CR_SPEED_1000	0x0040
-#define MII_CR_SPEED_100	0x2000
-#define MII_CR_SPEED_10		0x0000
 
 /* PHY Status Register */
 #define MII_SR_LINK_STATUS	0x0004 /* Link Status 1 = link */
-- 
2.25.1

