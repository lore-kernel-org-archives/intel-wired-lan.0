From: Sasha Neftin <sasha.neftin@intel.com>
Date: Wed,  8 Jul 2020 09:53:14 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Clean up the _hw_stats
 structure
Message-ID: <20200708065314.27514-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Remove icrxptc, icrxatc, ictxptc, ictxatc, ictxqec, ictxqmtc,
icrxdmtc and icrxoc fields from the _hw_stats structure.
Accordance to the i225 device specification these fields not
in use.
This patch come to clean up the driver code.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_hw.h   | 8 --------
 drivers/net/ethernet/intel/igc/igc_mac.c  | 3 ---
 drivers/net/ethernet/intel/igc/igc_main.c | 2 --
 drivers/net/ethernet/intel/igc/igc_regs.h | 2 --
 4 files changed, 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_hw.h b/drivers/net/ethernet/intel/igc/igc_hw.h
index 24412a6c2289..79e05b8c551e 100644
--- a/drivers/net/ethernet/intel/igc/igc_hw.h
+++ b/drivers/net/ethernet/intel/igc/igc_hw.h
@@ -268,14 +268,6 @@ struct igc_hw_stats {
 	u64 tsctc;
 	u64 tsctfc;
 	u64 iac;
-	u64 icrxptc;
-	u64 icrxatc;
-	u64 ictxptc;
-	u64 ictxatc;
-	u64 ictxqec;
-	u64 ictxqmtc;
-	u64 icrxdmtc;
-	u64 icrxoc;
 	u64 cbtmpc;
 	u64 htdpmc;
 	u64 cbrdpc;
diff --git a/drivers/net/ethernet/intel/igc/igc_mac.c b/drivers/net/ethernet/intel/igc/igc_mac.c
index 02bbb8ac4f68..674b8ad21fea 100644
--- a/drivers/net/ethernet/intel/igc/igc_mac.c
+++ b/drivers/net/ethernet/intel/igc/igc_mac.c
@@ -296,9 +296,6 @@ void igc_clear_hw_cntrs_base(struct igc_hw *hw)
 
 	rd32(IGC_IAC);
 
-	rd32(IGC_ICTXPTC);
-	rd32(IGC_ICTXATC);
-
 	rd32(IGC_RPTHC);
 	rd32(IGC_TLPIC);
 	rd32(IGC_RLPIC);
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index db3cbb5de128..ab5b302d6655 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -3731,8 +3731,6 @@ void igc_update_stats(struct igc_adapter *adapter)
 	adapter->stats.tsctc += rd32(IGC_TSCTC);
 
 	adapter->stats.iac += rd32(IGC_IAC);
-	adapter->stats.ictxptc += rd32(IGC_ICTXPTC);
-	adapter->stats.ictxatc += rd32(IGC_ICTXATC);
 
 	/* Fill out the OS statistics structure */
 	net_stats->multicast = adapter->stats.mprc;
diff --git a/drivers/net/ethernet/intel/igc/igc_regs.h b/drivers/net/ethernet/intel/igc/igc_regs.h
index 5ff3316717c7..b52dd9d737e8 100644
--- a/drivers/net/ethernet/intel/igc/igc_regs.h
+++ b/drivers/net/ethernet/intel/igc/igc_regs.h
@@ -172,8 +172,6 @@
 #define IGC_BPTC	0x040F4  /* Broadcast Packets Tx Count - R/clr */
 #define IGC_TSCTC	0x040F8  /* TCP Segmentation Context Tx - R/clr */
 #define IGC_IAC		0x04100  /* Interrupt Assertion Count */
-#define IGC_ICTXPTC	0x0410C  /* Interrupt Cause Tx Pkt Timer Expire Count */
-#define IGC_ICTXATC	0x04110  /* Interrupt Cause Tx Abs Timer Expire Count */
 #define IGC_RPTHC	0x04104  /* Rx Packets To Host */
 #define IGC_TLPIC	0x04148  /* EEE Tx LPI Count */
 #define IGC_RLPIC	0x0414C  /* EEE Rx LPI Count */
-- 
2.11.0

