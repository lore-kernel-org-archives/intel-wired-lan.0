From: Sasha Neftin <sasha.neftin@intel.com>
Date: Fri, 28 Feb 2020 19:50:07 +0200
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Fix double definition
Message-ID: <20200228175007.31144-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

IGC_START_ITR has beed defined twice
This patch come to fix it

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 0d4ffbb74214..b6137648471d 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -246,9 +246,6 @@ extern char igc_driver_version[];
 /* flags controlling PTP/1588 function */
 #define IGC_PTP_ENABLED		BIT(0)
 
-/* Interrupt defines */
-#define IGC_START_ITR			648 /* ~6000 ints/sec */
-
 /* Flags definitions */
 #define IGC_FLAG_HAS_MSI		BIT(0)
 #define IGC_FLAG_QUEUE_PAIRS		BIT(3)
@@ -270,6 +267,7 @@ extern char igc_driver_version[];
 #define IGC_MRQC_RSS_FIELD_IPV4_UDP	0x00400000
 #define IGC_MRQC_RSS_FIELD_IPV6_UDP	0x00800000
 
+/* Interrupt defines */
 #define IGC_START_ITR			648 /* ~6000 ints/sec */
 #define IGC_4K_ITR			980
 #define IGC_20K_ITR			196
-- 
2.11.0

