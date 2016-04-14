From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 14 Apr 2016 13:17:27 -0700
Subject: [Intel-wired-lan] [PATCH] fm10k: don't use BIT() macro where the
	value isn't a bitmask
Message-ID: <1460665047-24907-1-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The FM10K_MAX_DATA_PER_TXD is really just using a bitshift as a power of
2 operation in an efficient manner. We shouldn't represent this as a BIT()
because that obscures the intention of the operation.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k.h b/drivers/net/ethernet/intel/fm10k/fm10k.h
index fcf106e545c5..e98b86bf0ca1 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k.h
+++ b/drivers/net/ethernet/intel/fm10k/fm10k.h
@@ -406,7 +406,7 @@ static inline u16 fm10k_desc_unused(struct fm10k_ring *ring)
 	 (&(((union fm10k_rx_desc *)((R)->desc))[i]))
 
 #define FM10K_MAX_TXD_PWR	14
-#define FM10K_MAX_DATA_PER_TXD	BIT(FM10K_MAX_TXD_PWR)
+#define FM10K_MAX_DATA_PER_TXD	(1u << FM10K_MAX_TXD_PWR)
 
 /* Tx Descriptors needed, worst case */
 #define TXD_USE_COUNT(S)	DIV_ROUND_UP((S), FM10K_MAX_DATA_PER_TXD)
-- 
2.8.1.102.ga49ec4a

