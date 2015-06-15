From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 15 Jun 2015 15:00:52 -0700
Subject: [Intel-wired-lan] [PATCH 2/6] [TRIVIAL] fm10k: remove comment about
	rtnl_lock around mbx operations
In-Reply-To: <1434405656-10465-1-git-send-email-jacob.e.keller@intel.com>
References: <1434405656-10465-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1434405656-10465-2-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This comment is no longer true due to a couple of mailbox locking
refactors, and we now don't actually do any rtnl protected operations
directly in the mailbox path. Remove this comment as it is factually
incorrect and confusing.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index c7ffb2635f92..37cd78f3ce24 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -259,8 +259,6 @@ static void fm10k_watchdog_update_host_state(struct fm10k_intfc *interface)
  * @interface: board private structure
  *
  * This function will process both the upstream and downstream mailboxes.
- * It is necessary for us to hold the rtnl_lock while doing this as the
- * mailbox accesses are protected by this lock.
  **/
 static void fm10k_mbx_subtask(struct fm10k_intfc *interface)
 {
@@ -483,7 +481,7 @@ static void fm10k_service_task(struct work_struct *work)
 
 	interface = container_of(work, struct fm10k_intfc, service_task);
 
-	/* tasks always capable of running, but must be rtnl protected */
+	/* tasks run even when interface is down */
 	fm10k_mbx_subtask(interface);
 	fm10k_detach_subtask(interface);
 	fm10k_reset_subtask(interface);
-- 
2.4.2

