From: Sasha Neftin <sasha.neftin@intel.com>
Date: Mon,  3 Feb 2020 10:11:50 +0200
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Add comment
Message-ID: <20200203081150.34595-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Separate interrupt and flag definitions.
Made the code clear.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 7202c3761068..be607a4ec9ae 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -57,6 +57,8 @@ extern char igc_driver_version[];
 
 /* Interrupt defines */
 #define IGC_START_ITR			648 /* ~6000 ints/sec */
+
+/* Flags definitions */
 #define IGC_FLAG_HAS_MSI		BIT(0)
 #define IGC_FLAG_QUEUE_PAIRS		BIT(3)
 #define IGC_FLAG_DMAC			BIT(4)
-- 
2.11.0

