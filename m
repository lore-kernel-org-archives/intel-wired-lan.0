From: Sasha Neftin <sasha.neftin@intel.com>
Date: Mon, 20 Apr 2020 14:38:53 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove obsolete circuit
 breaker registers
Message-ID: <20200420113853.35732-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Part of circuit breaker registers is obsolete
and not applicable for i225 device.
This patch comes to clean up these registers.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_mac.c  | 4 ----
 drivers/net/ethernet/intel/igc/igc_regs.h | 7 -------
 2 files changed, 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_mac.c b/drivers/net/ethernet/intel/igc/igc_mac.c
index 2cd52b5c203d..018548c7e51c 100644
--- a/drivers/net/ethernet/intel/igc/igc_mac.c
+++ b/drivers/net/ethernet/intel/igc/igc_mac.c
@@ -307,12 +307,8 @@ void igc_clear_hw_cntrs_base(struct igc_hw *hw)
 	rd32(IGC_ICTXQMTC);
 	rd32(IGC_ICRXDMTC);
 
-	rd32(IGC_CBTMPC);
-	rd32(IGC_HTDPMC);
-	rd32(IGC_CBRMPC);
 	rd32(IGC_RPTHC);
 	rd32(IGC_HGPTC);
-	rd32(IGC_HTCBDPC);
 	rd32(IGC_HGORCL);
 	rd32(IGC_HGORCH);
 	rd32(IGC_HGOTCL);
diff --git a/drivers/net/ethernet/intel/igc/igc_regs.h b/drivers/net/ethernet/intel/igc/igc_regs.h
index 76ec08b082bb..f2989946d9dc 100644
--- a/drivers/net/ethernet/intel/igc/igc_regs.h
+++ b/drivers/net/ethernet/intel/igc/igc_regs.h
@@ -68,13 +68,6 @@
 #define IGC_ICRXDMTC		0x04120  /* Rx Descriptor Min Threshold Count */
 #define IGC_ICRXOC		0x04124  /* Receiver Overrun Count */
 
-#define IGC_CBTMPC		0x0402C  /* Circuit Breaker TX Packet Count */
-#define IGC_HTDPMC		0x0403C  /* Host Transmit Discarded Packets */
-#define IGC_CBRMPC		0x040FC  /* Circuit Breaker RX Packet Count */
-#define IGC_RPTHC		0x04104  /* Rx Packets To Host */
-#define IGC_HGPTC		0x04118  /* Host Good Packets TX Count */
-#define IGC_HTCBDPC		0x04124  /* Host TX Circ.Breaker Drop Count */
-
 /* MSI-X Table Register Descriptions */
 #define IGC_PBACL		0x05B68  /* MSIx PBA Clear - R/W 1 to clear */
 
-- 
2.11.0

