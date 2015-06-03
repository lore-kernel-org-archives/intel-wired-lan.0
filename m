From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed,  3 Jun 2015 15:56:39 -0700
Subject: [Intel-wired-lan] [PATCH 13/15] fm10k: fix incorrect DIR_NEVATIVE
	bit in 1588 code
In-Reply-To: <1433372201-12007-1-git-send-email-jacob.e.keller@intel.com>
References: <1433372201-12007-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1433372201-12007-13-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The SYSTIME_CFG.Adjust Direction bit is actually supposed to indicate
that the adjustment is positive. Fix the code to align correctly with
hardware and documentation.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c   | 4 ++--
 drivers/net/ethernet/intel/fm10k/fm10k_type.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
index 3b942061a339..ab81c00327b2 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
@@ -1792,8 +1792,8 @@ static s32 fm10k_adjust_systime_pf(struct fm10k_hw *hw, s32 ppb)
 	if (systime_adjust > FM10K_SW_SYSTIME_ADJUST_MASK)
 		return FM10K_ERR_PARAM;
 
-	if (ppb < 0)
-		systime_adjust |= FM10K_SW_SYSTIME_ADJUST_DIR_NEGATIVE;
+	if (ppb > 0)
+		systime_adjust |= FM10K_SW_SYSTIME_ADJUST_DIR_POSITIVE;
 
 	fm10k_write_sw_reg(hw, FM10K_SW_SYSTIME_ADJUST, (u32)systime_adjust);
 
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_type.h b/drivers/net/ethernet/intel/fm10k/fm10k_type.h
index 4af96686c584..2a17d82fa37d 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_type.h
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_type.h
@@ -369,7 +369,7 @@ struct fm10k_hw;
 /* Registers contained in BAR 4 for Switch management */
 #define FM10K_SW_SYSTIME_ADJUST	0x0224D
 #define FM10K_SW_SYSTIME_ADJUST_MASK		0x3FFFFFFF
-#define FM10K_SW_SYSTIME_ADJUST_DIR_NEGATIVE	0x80000000
+#define FM10K_SW_SYSTIME_ADJUST_DIR_POSITIVE	0x80000000
 #define FM10K_SW_SYSTIME_PULSE(_n)	((_n) + 0x02252)
 
 enum fm10k_int_source {
-- 
2.1.0

