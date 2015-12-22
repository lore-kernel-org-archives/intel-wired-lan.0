From: Bruce Allan <bruce.w.allan@intel.com>
Date: Tue, 22 Dec 2015 14:55:26 -0800
Subject: [Intel-wired-lan] [next-queue PATCH] fm10k: cleanup
 SPACE_BEFORE_TAB checkpatch warning
Message-ID: <20151222225526.141575.85632.stgit@bwallan-cwp1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_ptp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_ptp.c b/drivers/net/ethernet/intel/fm10k/fm10k_ptp.c
index b4945e8..1c1ccad 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_ptp.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_ptp.c
@@ -416,7 +416,7 @@ void fm10k_ptp_register(struct fm10k_intfc *interface)
 	/* This math is simply the inverse of the math in
 	 * fm10k_adjust_systime_pf applied to an adjustment value
 	 * of 2^30 - 1 which is the maximum value of the register:
-	 * 	max_ppb == ((2^30 - 1) * 5^9) / 2^31
+	 *	max_ppb == ((2^30 - 1) * 5^9) / 2^31
 	 */
 	ptp_caps->max_adj	= 976562;
 	ptp_caps->adjfreq	= fm10k_ptp_adjfreq;

