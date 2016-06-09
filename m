From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu,  9 Jun 2016 15:42:36 -0700
Subject: [Intel-wired-lan] [PATCH] fm10k: use variadic form of
	alloc_workqueue
Message-ID: <20160609224236.23438-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index a4ea84273ea1..6805f6fd0843 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -56,7 +56,7 @@ static int __init fm10k_init_module(void)
 	pr_info("%s\n", fm10k_copyright);
 
 	/* create driver workqueue */
-	fm10k_workqueue = alloc_workqueue("fm10k", WQ_MEM_RECLAIM, 0);
+	fm10k_workqueue = alloc_workqueue("%s", WQ_MEM_RECLAIM, 0, fm10k_driver_name);
 
 	fm10k_dbg_init();
 
-- 
2.9.0.rc1.405.g81f467e

