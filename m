From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue,  3 Nov 2015 11:35:02 -0800
Subject: [Intel-wired-lan] [PATCH v2] fm10k: don't initialize
	fm10k_workqueue at global level
Message-ID: <1446579302-11494-1-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

Cleans up checkpatch GLOBAL_INITIALIZERS error

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
-v2
* Fix title from checkpatch complaint

 drivers/net/ethernet/intel/fm10k/fm10k_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index e13d0fe1f17f..03607ecf0653 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -42,7 +42,7 @@ MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_VERSION);
 
 /* single workqueue for entire fm10k driver */
-struct workqueue_struct *fm10k_workqueue = NULL;
+struct workqueue_struct *fm10k_workqueue;
 
 /**
  * fm10k_init_module - Driver Registration Routine
@@ -56,8 +56,7 @@ static int __init fm10k_init_module(void)
 	pr_info("%s\n", fm10k_copyright);
 
 	/* create driver workqueue */
-	if (!fm10k_workqueue)
-		fm10k_workqueue = create_workqueue("fm10k");
+	fm10k_workqueue = create_workqueue("fm10k");
 
 	fm10k_dbg_init();
 
@@ -80,7 +79,6 @@ static void __exit fm10k_exit_module(void)
 	/* destroy driver workqueue */
 	flush_workqueue(fm10k_workqueue);
 	destroy_workqueue(fm10k_workqueue);
-	fm10k_workqueue = NULL;
 }
 module_exit(fm10k_exit_module);
 
-- 
2.6.1.264.gbab76a9

