From: Yanir Lubetkin <yanirx.lubetkin@intel.com>
Date: Wed, 22 Apr 2015 05:55:43 +0300
Subject: [Intel-wired-lan] [PATCH] e1000e: remove call to do_div and sign
	mismatch warning
Message-ID: <1429671343-13453-1-git-send-email-yanirx.lubetkin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

fixes a warning that was reported by Yanjiang Jin <yanjiang.jin@windriver.com>
by implementing the solution suggested by
Alexander Duyck <alexander.h.duyck@redhat.com>.

Signed-off-by: Yanir Lubetkin <yanirx.lubetkin@intel.com>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index e18443a..b8b0900 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -1014,7 +1014,6 @@ static s32 e1000_platform_pm_pch_lpt(struct e1000_hw *hw, bool link)
 		u16 speed, duplex, scale = 0;
 		u16 max_snoop, max_nosnoop;
 		u16 max_ltr_enc;	/* max LTR latency encoded */
-		s64 lat_ns;	/* latency (ns) */
 		u64 value;
 		u32 rxa;
 
@@ -1040,14 +1039,9 @@ static s32 e1000_platform_pm_pch_lpt(struct e1000_hw *hw, bool link)
 		 * 2^25*(2^10-1) ns.  The scale is encoded as 0=2^0ns,
 		 * 1=2^5ns, 2=2^10ns,...5=2^25ns.
 		 */
-		lat_ns = ((s64)rxa * 1024 -
-			  (2 * (s64)hw->adapter->max_frame_size)) * 8 * 1000;
-		if (lat_ns < 0) {
-			value = 0;
-		} else {
-			value = lat_ns;
-			do_div(value, speed);
-		}
+		rxa *= 512;
+		value = (rxa > hw->adapter->max_frame_size) ?
+			(rxa - hw->adapter->max_frame_size) * (16000 / speed) : 0;
 
 		while (value > PCI_LTR_VALUE_MASK) {
 			scale++;
-- 
2.1.0

---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

