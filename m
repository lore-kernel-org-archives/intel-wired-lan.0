From: Sasha Neftin <sasha.neftin@intel.com>
Date: Sun, 13 Dec 2020 17:25:26 +0200
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove unused local receiver
 mask
Message-ID: <20201213152526.1386104-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Local receiver mask SR_1000T_LOCAL_RX_STATUS not in use in i225 device
and could be removed

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 882e1e272953..84355a5f79e8 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -129,7 +129,6 @@
 
 /* 1000BASE-T Status Register */
 #define SR_1000T_REMOTE_RX_STATUS	0x1000 /* Remote receiver OK */
-#define SR_1000T_LOCAL_RX_STATUS	0x2000 /* Local receiver OK */
 
 /* PHY GPY 211 registers */
 #define STANDARD_AN_REG_MASK	0x0007 /* MMD */
-- 
2.25.1

