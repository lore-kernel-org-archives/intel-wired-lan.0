From: Sasha Neftin <sasha.neftin@intel.com>
Date: Mon,  7 Jan 2019 16:40:17 +0200
Subject: [Intel-wired-lan] [PATCH 1/1] igc: Remove unused code
Message-ID: <20190107144017.30762-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Remove unused igc_adv_data_desc definition from igc_base.h file.
Descriptors definition will be added per demand.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_base.h | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_base.h b/drivers/net/ethernet/intel/igc/igc_base.h
index a5d3f57274a8..76d4991d7284 100644
--- a/drivers/net/ethernet/intel/igc/igc_base.h
+++ b/drivers/net/ethernet/intel/igc/igc_base.h
@@ -36,28 +36,6 @@ union igc_adv_tx_desc {
 
 #define IGC_RAR_ENTRIES		16
 
-struct igc_adv_data_desc {
-	__le64 buffer_addr;    /* Address of the descriptor's data buffer */
-	union {
-		u32 data;
-		struct {
-			u32 datalen:16; /* Data buffer length */
-			u32 rsvd:4;
-			u32 dtyp:4;  /* Descriptor type */
-			u32 dcmd:8;  /* Descriptor command */
-		} config;
-	} lower;
-	union {
-		u32 data;
-		struct {
-			u32 status:4;  /* Descriptor status */
-			u32 idx:4;
-			u32 popts:6;  /* Packet Options */
-			u32 paylen:18; /* Payload length */
-		} options;
-	} upper;
-};
-
 /* Receive Descriptor - Advanced */
 union igc_adv_rx_desc {
 	struct {
-- 
2.11.0

