From: YueHaibing <yuehaibing@huawei.com>
Date: Tue, 2 Jul 2019 14:20:21 +0800
Subject: [Intel-wired-lan] [PATCH net-next] iavf: remove unused debug
 function iavf_debug_d
Message-ID: <20190702062021.41524-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

There is no caller of function iavf_debug_d() in tree since
commit 75051ce4c5d8 ("iavf: Fix up debug print macro"),
so it can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 881561b..327dda8 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -143,28 +143,6 @@ enum iavf_status iavf_free_virt_mem_d(struct iavf_hw *hw,
 }
 
 /**
- * iavf_debug_d - OS dependent version of debug printing
- * @hw:  pointer to the HW structure
- * @mask: debug level mask
- * @fmt_str: printf-type format description
- **/
-void iavf_debug_d(void *hw, u32 mask, char *fmt_str, ...)
-{
-	char buf[512];
-	va_list argptr;
-
-	if (!(mask & ((struct iavf_hw *)hw)->debug_mask))
-		return;
-
-	va_start(argptr, fmt_str);
-	vsnprintf(buf, sizeof(buf), fmt_str, argptr);
-	va_end(argptr);
-
-	/* the debug string is already formatted with a newline */
-	pr_info("%s", buf);
-}
-
-/**
  * iavf_schedule_reset - Set the flags and schedule a reset event
  * @adapter: board private structure
  **/
-- 
2.7.4


