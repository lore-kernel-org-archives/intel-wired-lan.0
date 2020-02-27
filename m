From: Sasha Neftin <sasha.neftin@intel.com>
Date: Thu, 27 Feb 2020 19:19:12 +0200
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove unused
 CTRL_EXT_LINK_MODE_MASK
Message-ID: <20200227171912.11007-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We support only copper mode
Not applicable for i225 parts

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 61ea0db52838..dd0c86ce09ed 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -44,9 +44,6 @@
 /* Wake Up Packet Memory stores the first 128 bytes of the wake up packet */
 #define IGC_WUPM_BYTES	128
 
-/* Physical Func Reset Done Indication */
-#define IGC_CTRL_EXT_LINK_MODE_MASK	0x00C00000
-
 /* Loop limit on how long we wait for auto-negotiation to complete */
 #define COPPER_LINK_UP_LIMIT		10
 #define PHY_AUTO_NEG_LIMIT		45
-- 
2.11.0

