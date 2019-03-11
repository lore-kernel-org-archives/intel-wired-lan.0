From: Kangjie Lu <kjlu@umn.edu>
Date: Mon, 11 Mar 2019 01:17:32 -0500
Subject: [Intel-wired-lan] [PATCH] net: fm10k: fix a potential NULL pointer
 dereference
Message-ID: <20190311061732.19064-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In case alloc_workqueue fails, the fix returns -ENOMEM to avoid
potential NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/ethernet/intel/fm10k/fm10k_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index 5a0419421511..215f232674f1 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -41,6 +41,8 @@ static int __init fm10k_init_module(void)
 	/* create driver workqueue */
 	fm10k_workqueue = alloc_workqueue("%s", WQ_MEM_RECLAIM, 0,
 					  fm10k_driver_name);
+	if (unlikely(!fm10k_workqueue))
+		return -ENOMEM;
 
 	fm10k_dbg_init();
 
-- 
2.17.1

