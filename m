From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 24 Aug 2015 17:01:59 -0700
Subject: [Intel-wired-lan] [next-queue] fm10k: Correct MTU for jumbo frames
In-Reply-To: <1440460921-28318-1-git-send-email-jacob.e.keller@intel.com>
References: <1440460921-28318-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1440460921-28318-2-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Based on hardware testing, the host interface can support up to 15368
bytes on the wire. Subtracting 8 for an internal switch tag and 14 for
the L2 header shows that the MTU should not be allowed to be set above
15346 bytes.

Signed-off-by: Matthew Vick <matthew.vick@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k.h b/drivers/net/ethernet/intel/fm10k/fm10k.h
index 14440200499b..9e05a36783e5 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k.h
+++ b/drivers/net/ethernet/intel/fm10k/fm10k.h
@@ -33,7 +33,7 @@
 #include "fm10k_pf.h"
 #include "fm10k_vf.h"
 
-#define FM10K_MAX_JUMBO_FRAME_SIZE	15358	/* Maximum supported size 15K */
+#define FM10K_MAX_JUMBO_FRAME_SIZE	15346	/* Maximum supported size 15K */
 
 #define MAX_QUEUES	FM10K_MAX_QUEUES_PF
 
-- 
2.5.0.280.g4aaba03

