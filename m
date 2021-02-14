From: Sasha Neftin <sasha.neftin@intel.com>
Date: Sun, 14 Feb 2021 09:17:49 +0200
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove unused MII_CR_LOOPBACK
Message-ID: <20210214071749.4068885-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

MII_CR_LOOPBACK masks not in use in i225 device and can be removed.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index c5b36ec7bcff..153561291166 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -441,7 +441,6 @@
 #define MII_CR_RESTART_AUTO_NEG	0x0200  /* Restart auto negotiation */
 #define MII_CR_POWER_DOWN	0x0800  /* Power down */
 #define MII_CR_AUTO_NEG_EN	0x1000  /* Auto Neg Enable */
-#define MII_CR_LOOPBACK		0x4000  /* 0 = normal, 1 = loopback */
 
 /* PHY Status Register */
 #define MII_SR_LINK_STATUS	0x0004 /* Link Status 1 = link */
-- 
2.25.1

