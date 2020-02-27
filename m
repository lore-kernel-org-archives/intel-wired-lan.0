From: Sasha Neftin <sasha.neftin@intel.com>
Date: Thu, 27 Feb 2020 18:57:23 +0200
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove unused MDIC_DEST mask
Message-ID: <20200227165723.21378-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Formally Destination bit should be kept reserved to
support legacy drivers and ignore on write/read
operation
Not applicable for i225 parts

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 0746fa42ff3f..61ea0db52838 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -510,7 +510,6 @@
 #define IGC_MDIC_READY		0x10000000
 #define IGC_MDIC_INT_EN		0x20000000
 #define IGC_MDIC_ERROR		0x40000000
-#define IGC_MDIC_DEST		0x80000000
 
 #define IGC_N0_QUEUE		-1
 
-- 
2.11.0

