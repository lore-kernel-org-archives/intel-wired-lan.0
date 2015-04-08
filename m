From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 08 Apr 2015 13:58:37 -0700
Subject: [Intel-wired-lan] [PATCH] e1000e: fix call to do_div() to use u64
	arg
Message-ID: <20150408205837.4329.94829.stgit@jtkirshe-mobl.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We were using s64 for lat_ns (latency nano-second value) since in
our calculations a negative value could be a resultant.  For negative
values, we then assign lat_ns to be zero, so the value passed to
do_div() was never negative, but do_div() expects the argument type
to be u64, so do a cast to resolve a compile warning seen on
PowerPC.

CC: Yanjiang Jin <yanjiang.jin@windriver.com>
CC: Yanir Lubetkin <yanirx.lubetkin@intel.com>
Reported-by: Yanjiang Jin <yanjiang.jin@windriver.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index 9d81c03..30d277a 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -1045,7 +1045,7 @@ static s32 e1000_platform_pm_pch_lpt(struct e1000_hw *hw, bool link)
 		if (lat_ns < 0)
 			lat_ns = 0;
 		else
-			do_div(lat_ns, speed);
+			do_div((u64)lat_ns, speed);
 
 		value = lat_ns;
 		while (value > PCI_LTR_VALUE_MASK) {

