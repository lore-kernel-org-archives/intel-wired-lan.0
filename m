From: Sasha Neftin <sasha.neftin@intel.com>
Date: Sun, 12 Apr 2020 17:21:58 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove unused registers
Message-ID: <20200412142158.32900-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Tx data FIFO Head/Tail, Saved and Packet Count registers
not applicable for i225 LAN controller.
This patch comes to clean up these registers.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_dump.c | 4 ----
 drivers/net/ethernet/intel/igc/igc_regs.h | 5 -----
 2 files changed, 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_dump.c b/drivers/net/ethernet/intel/igc/igc_dump.c
index d6990d63c8bb..4f1f96c31aa3 100644
--- a/drivers/net/ethernet/intel/igc/igc_dump.c
+++ b/drivers/net/ethernet/intel/igc/igc_dump.c
@@ -35,10 +35,6 @@ static const struct igc_reg_info igc_reg_info_tbl[] = {
 	{IGC_TDH(0), "TDH"},
 	{IGC_TDT(0), "TDT"},
 	{IGC_TXDCTL(0), "TXDCTL"},
-	{IGC_TDFH, "TDFH"},
-	{IGC_TDFT, "TDFT"},
-	{IGC_TDFHS, "TDFHS"},
-	{IGC_TDFPC, "TDFPC"},
 
 	/* List Terminator */
 	{}
diff --git a/drivers/net/ethernet/intel/igc/igc_regs.h b/drivers/net/ethernet/intel/igc/igc_regs.h
index 1cbd428adfbe..76ec08b082bb 100644
--- a/drivers/net/ethernet/intel/igc/igc_regs.h
+++ b/drivers/net/ethernet/intel/igc/igc_regs.h
@@ -17,11 +17,6 @@
 /* Internal Packet Buffer Size Registers */
 #define IGC_RXPBS		0x02404  /* Rx Packet Buffer Size - RW */
 #define IGC_TXPBS		0x03404  /* Tx Packet Buffer Size - RW */
-#define IGC_TDFH		0x03410  /* Tx Data FIFO Head - RW */
-#define IGC_TDFT		0x03418  /* Tx Data FIFO Tail - RW */
-#define IGC_TDFHS		0x03420  /* Tx Data FIFO Head Saved - RW */
-#define IGC_TDFTS		0x03428  /* Tx Data FIFO Tail Saved - RW */
-#define IGC_TDFPC		0x03430  /* Tx Data FIFO Packet Count - RW */
 
 /* NVM  Register Descriptions */
 #define IGC_EERD		0x12014  /* EEprom mode read - RW */
-- 
2.11.0

