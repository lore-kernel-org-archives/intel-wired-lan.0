From: Yanjiang Jin <yanjiang.jin@windriver.com>
Date: Fri, 03 Apr 2015 04:43:03 -0700
Subject: [Intel-wired-lan] [net-next] e1000e: define lat_ns as u64 instead
	of s64
Message-ID: <20150403114233.15851.28992.stgit@nnlmsdk142.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

do_div() expects the type of "n" to be uint64_t, define "lat_ns" as u64 to
avoid the below warning, also update its correlative operations and data.

In file included from ./arch/powerpc/include/asm/div64.h:1:0,
                 from include/linux/kernel.h:124,
                 from include/linux/list.h:8,
                 from include/linux/timer.h:4,
                 from drivers/net/ethernet/intel/e1000e/e1000.h:29,
                 from drivers/net/ethernet/intel/e1000e/ich8lan.c:59:
drivers/net/ethernet/intel/e1000e/ich8lan.c: In function 'e1000_platform_pm_pch_lpt':
include/asm-generic/div64.h:43:28: warning: comparison of distinct pointer types lacks a cast [enabled by default]
  (void)(((typeof((n)) *)0) == ((uint64_t *)0)); \
                            ^
drivers/net/ethernet/intel/e1000e/ich8lan.c:1016:4: note: in expansion of macro 'do_div'
    do_div(lat_ns, speed);

Signed-off-by: Yanjiang Jin <yanjiang.jin@windriver.com>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index 9d81c03..8899b20 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -1014,8 +1014,8 @@ static s32 e1000_platform_pm_pch_lpt(struct e1000_hw *hw, bool link)
 		u16 speed, duplex, scale = 0;
 		u16 max_snoop, max_nosnoop;
 		u16 max_ltr_enc;	/* max LTR latency encoded */
-		s64 lat_ns;	/* latency (ns) */
-		s64 value;
+		u64 lat_ns;	/* latency (ns) */
+		u64 value;
 		u32 rxa;
 
 		if (!hw->adapter->max_frame_size) {
@@ -1040,8 +1040,8 @@ static s32 e1000_platform_pm_pch_lpt(struct e1000_hw *hw, bool link)
 		 * 2^25*(2^10-1) ns.  The scale is encoded as 0=2^0ns,
 		 * 1=2^5ns, 2=2^10ns,...5=2^25ns.
 		 */
-		lat_ns = ((s64)rxa * 1024 -
-			  (2 * (s64)hw->adapter->max_frame_size)) * 8 * 1000;
+		lat_ns = ((u64)rxa * 1024 -
+			  (2 * (u64)hw->adapter->max_frame_size)) * 8 * 1000;
 		if (lat_ns < 0)
 			lat_ns = 0;
 		else

