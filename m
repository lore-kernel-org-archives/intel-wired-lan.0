From: Sasha Neftin <sasha.neftin@intel.com>
Date: Tue,  7 Dec 2021 08:19:18 +0200
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove obsolete define
Message-ID: <20211207061918.929674-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

'MII_CR_FULL_DUPLEX' define not in use. This patch comes to tidy up
 obsolete define.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 0666bf4b54d5..ac25dbdd5d76 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -581,7 +581,6 @@
 #define IGC_GEN_POLL_TIMEOUT	1920
 
 /* PHY Control Register */
-#define MII_CR_FULL_DUPLEX	0x0100  /* FDX =1, half duplex =0 */
 #define MII_CR_RESTART_AUTO_NEG	0x0200  /* Restart auto negotiation */
 #define MII_CR_POWER_DOWN	0x0800  /* Power down */
 #define MII_CR_AUTO_NEG_EN	0x1000  /* Auto Neg Enable */
-- 
2.25.1

