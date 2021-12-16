From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed, 15 Dec 2021 17:56:54 -0800
Subject: [Intel-wired-lan] [PATCH net] iavf: Remove extra
 cancel_delayed_work_sync() call
Message-ID: <20211216015654.20619-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Commit 898ef1cb1cb2 ("iavf: Combine init and watchdog state machines")
did not remove the original call to cancel_delayed_work_sync() for the
watchdog task, remove it now.

Fixes: 898ef1cb1cb2 ("iavf: Combine init and watchdog state machines")
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index dedce7e9793d..a41be069f81e 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -4015,8 +4015,6 @@ static void iavf_remove(struct pci_dev *pdev)
 	iavf_reset_interrupt_capability(adapter);
 	iavf_free_q_vectors(adapter);
 
-	cancel_delayed_work_sync(&adapter->watchdog_task);
-
 	cancel_work_sync(&adapter->adminq_task);
 
 	iavf_free_rss(adapter);
-- 
2.20.1

