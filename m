From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Tue, 23 Nov 2021 00:19:26 +0800
Subject: [Intel-wired-lan] [PATCH 2/3] Revert "e1000e: Add polling mechanism
 to indicate CSME DPG exit"
In-Reply-To: <20211122161927.874291-1-kai.heng.feng@canonical.com>
References: <20211122161927.874291-1-kai.heng.feng@canonical.com>
Message-ID: <20211122161927.874291-2-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This reverts commit ef407b86d3cc7ab7ad37658c1c7a094cb8f3b6b4.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=214821
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.h |  1 -
 drivers/net/ethernet/intel/e1000e/netdev.c  | 24 ---------------------
 drivers/net/ethernet/intel/e1000e/regs.h    |  1 -
 3 files changed, 26 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.h b/drivers/net/ethernet/intel/e1000e/ich8lan.h
index 2504b11c3169f..1dfa1d28dae64 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.h
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.h
@@ -41,7 +41,6 @@
 #define E1000_FWSM_WLOCK_MAC_MASK	0x0380
 #define E1000_FWSM_WLOCK_MAC_SHIFT	7
 #define E1000_FWSM_ULP_CFG_DONE		0x00000400	/* Low power cfg done */
-#define E1000_EXFWSM_DPG_EXIT_DONE	0x00000001
 
 /* Shared Receive Address Registers */
 #define E1000_SHRAL_PCH_LPT(_i)		(0x05408 + ((_i) * 8))
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index e16b7c0d98089..242314809e59c 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6483,10 +6483,8 @@ static void e1000e_s0ix_entry_flow(struct e1000_adapter *adapter)
 static void e1000e_s0ix_exit_flow(struct e1000_adapter *adapter)
 {
 	struct e1000_hw *hw = &adapter->hw;
-	bool firmware_bug = false;
 	u32 mac_data;
 	u16 phy_data;
-	u32 i = 0;
 
 	if (er32(FWSM) & E1000_ICH_FWSM_FW_VALID) {
 		/* Request ME unconfigure the device from S0ix */
@@ -6494,28 +6492,6 @@ static void e1000e_s0ix_exit_flow(struct e1000_adapter *adapter)
 		mac_data &= ~E1000_H2ME_START_DPG;
 		mac_data |= E1000_H2ME_EXIT_DPG;
 		ew32(H2ME, mac_data);
-
-		/* Poll up to 2.5 seconds for ME to unconfigure DPG.
-		 * If this takes more than 1 second, show a warning indicating a
-		 * firmware bug
-		 */
-		while (!(er32(EXFWSM) & E1000_EXFWSM_DPG_EXIT_DONE)) {
-			if (i > 100 && !firmware_bug)
-				firmware_bug = true;
-
-			if (i++ == 250) {
-				e_dbg("Timeout (firmware bug): %d msec\n",
-				      i * 10);
-				break;
-			}
-
-			usleep_range(10000, 11000);
-		}
-		if (firmware_bug)
-			e_warn("DPG_EXIT_DONE took %d msec. This is a firmware bug\n",
-			       i * 10);
-		else
-			e_dbg("DPG_EXIT_DONE cleared after %d msec\n", i * 10);
 	} else {
 		/* Request driver unconfigure the device from S0ix */
 
diff --git a/drivers/net/ethernet/intel/e1000e/regs.h b/drivers/net/ethernet/intel/e1000e/regs.h
index 6c0cd8cab3ef2..8165ba2619a4d 100644
--- a/drivers/net/ethernet/intel/e1000e/regs.h
+++ b/drivers/net/ethernet/intel/e1000e/regs.h
@@ -213,7 +213,6 @@
 #define E1000_FACTPS	0x05B30	/* Function Active and Power State to MNG */
 #define E1000_SWSM	0x05B50	/* SW Semaphore */
 #define E1000_FWSM	0x05B54	/* FW Semaphore */
-#define E1000_EXFWSM	0x05B58	/* Extended FW Semaphore */
 /* Driver-only SW semaphore (not used by BOOT agents) */
 #define E1000_SWSM2	0x05B58
 #define E1000_FFLT_DBG	0x05F04	/* Debug Register */
-- 
2.32.0

