From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Wed,  3 Aug 2016 10:20:11 -0700
Subject: [Intel-wired-lan] [next PATCH S41 1/5] i40e: use alloc_workqueue
	instead of create_singlethread_workqueue
In-Reply-To: <1470244815-31174-1-git-send-email-bimmy.pujari@intel.com>
References: <1470244815-31174-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1470244815-31174-2-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Replace calls to create_singlethread_workqueue instead with alloc_workqueue
as is style with other Intel drivers. This provides more control over
workqueue creation, and allows explicit setting of the desired mode of
operation. It also makes it more obvious that driver name constant is
passed to a format "%s".

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Change-ID: I6192b44caf5140336cd54c5b350d51c73b541fdb
---
 drivers/net/ethernet/intel/i40e/i40e_main.c     | 3 ++-
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 1c5a4c0..b83070f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -11577,7 +11577,8 @@ static int __init i40e_init_module(void)
 	 * it can't be any worse than using the system workqueue which
 	 * was already single threaded
 	 */
-	i40e_wq = create_singlethread_workqueue(i40e_driver_name);
+	i40e_wq = alloc_workqueue("%s", WQ_UNBOUND | WQ_MEM_RECLAIM, 1,
+				  i40e_driver_name);
 	if (!i40e_wq) {
 		pr_err("%s: Failed to create workqueue\n", i40e_driver_name);
 		return -ENOMEM;
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index fd4a47b..bef688f 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -2833,7 +2833,8 @@ static int __init i40evf_init_module(void)
 
 	pr_info("%s\n", i40evf_copyright);
 
-	i40evf_wq = create_singlethread_workqueue(i40evf_driver_name);
+	i40evf_wq = alloc_workqueue("%s", WQ_UNBOUND | WQ_MEM_RECLAIM, 1,
+				    i40evf_driver_name);
 	if (!i40evf_wq) {
 		pr_err("%s: Failed to create workqueue\n", i40evf_driver_name);
 		return -ENOMEM;
-- 
2.4.11

