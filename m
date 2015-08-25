From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 25 Aug 2015 13:49:11 -0700
Subject: [Intel-wired-lan] [next-queue v2] fm10k: Correct MTU for jumbo
	frames
Message-ID: <1440535751-12074-1-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Based on hardware testing, the host interface supports up to 15368 bytes
as the maximum frame size. To determine the correct MTU, we subtract 8
for the internal switch tag, 14 for the L2 header, and 4 for the
appended FCS header, resulting in 15342 bytes of payload for our maximum
MTU on jumbo frames.

Signed-off-by: Matthew Vick <matthew.vick@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k.h b/drivers/net/ethernet/intel/fm10k/fm10k.h
index 14440200499b..48809e5d3f79 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k.h
+++ b/drivers/net/ethernet/intel/fm10k/fm10k.h
@@ -33,7 +33,7 @@
 #include "fm10k_pf.h"
 #include "fm10k_vf.h"
 
-#define FM10K_MAX_JUMBO_FRAME_SIZE	15358	/* Maximum supported size 15K */
+#define FM10K_MAX_JUMBO_FRAME_SIZE	15342	/* Maximum supported size 15K */
 
 #define MAX_QUEUES	FM10K_MAX_QUEUES_PF
 
-- 
2.5.0.280.g4aaba03

