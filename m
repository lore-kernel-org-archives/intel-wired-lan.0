From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 25 Aug 2016 14:15:39 -0700
Subject: [Intel-wired-lan] [PATCH] fm10k: wrap long line for alloc_workqueue
Message-ID: <20160825211539.3853-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Trivial change here to cleanup a checkpatch.pl warning that got
introduced when changing to alloc_workqueue.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index ffb8eff51d46..30baebb7a231 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -56,7 +56,8 @@ static int __init fm10k_init_module(void)
 	pr_info("%s\n", fm10k_copyright);
 
 	/* create driver workqueue */
-	fm10k_workqueue = alloc_workqueue("%s", WQ_MEM_RECLAIM, 0, fm10k_driver_name);
+	fm10k_workqueue = alloc_workqueue("%s", WQ_MEM_RECLAIM, 0,
+					  fm10k_driver_name);
 
 	fm10k_dbg_init();
 
-- 
2.10.0.rc0.259.g83512d9

