From: Jarod Wilson <jarod@redhat.com>
Date: Tue, 26 Jul 2016 14:25:35 -0400
Subject: [Intel-wired-lan] [PATCH net-next v3 2/2] e1000e: fix PTP on
	e1000_pch_lpt variants
In-Reply-To: <1469557535-63429-1-git-send-email-jarod@redhat.com>
References: <1469292274-59237-1-git-send-email-jarod@redhat.com>
 <1469557535-63429-1-git-send-email-jarod@redhat.com>
Message-ID: <1469557535-63429-3-git-send-email-jarod@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

I've got reports that the Intel I-218V NIC in Intel NUC5i5RYH systems used
as a PTP slave experiences random ~10 hour clock jumps, which are resolved
if the same workaround for the 82574 and 82583 is employed, so set the
appropriate flag2 in e1000_pch_lpt_info too.

Reported-by: Rupesh Patel <rupatel@redhat.com>
CC: Jesse Brandeburg <jesse.brandeburg@intel.com>
CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
CC: intel-wired-lan at lists.osuosl.org
CC: netdev at vger.kernel.org
Signed-off-by: Jarod Wilson <jarod@redhat.com>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index 3e11322..f3aaca7 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -5885,7 +5885,8 @@ const struct e1000_info e1000_pch_lpt_info = {
 				  | FLAG_HAS_JUMBO_FRAMES
 				  | FLAG_APME_IN_WUC,
 	.flags2			= FLAG2_HAS_PHY_STATS
-				  | FLAG2_HAS_EEE,
+				  | FLAG2_HAS_EEE
+				  | FLAG2_CHECK_SYSTIM_OVERFLOW,
 	.pba			= 26,
 	.max_hw_frame_size	= 9022,
 	.get_variants		= e1000_get_variants_ich8lan,
-- 
1.8.3.1

