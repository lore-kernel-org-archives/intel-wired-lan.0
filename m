From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Thu, 17 Dec 2015 17:32:55 -0800
Subject: [Intel-wired-lan] [PATCH] ixgbevf: use bit operations for setting
	and checking resets
Message-ID: <20151218013255.24602.41039.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Move the reset flags to adapter->state in order to make use of bit
operations.

This is an alternative patch to the one previously submitted by
John Greene.

Suggested-by: Alexander Duyck <aduyck@mirantis.com>
Reported-by: Scott Otto <otts62@yahoo.com>
Reported-by: John Greene <jogreene@redhat.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      |    9 ++-------
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   15 ++++++---------
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
index 68ec7daa..f72dd1f 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
@@ -403,13 +403,6 @@ struct ixgbevf_adapter {
 	u32 alloc_rx_page_failed;
 	u32 alloc_rx_buff_failed;
 
-	/* Some features need tri-state capability,
-	 * thus the additional *_CAPABLE flags.
-	 */
-	u32 flags;
-#define IXGBEVF_FLAG_RESET_REQUESTED		(u32)(1)
-#define IXGBEVF_FLAG_QUEUE_RESET_REQUESTED	(u32)(1 << 2)
-
 	struct msix_entry *msix_entries;
 
 	/* OS defined structs */
@@ -461,6 +454,8 @@ enum ixbgevf_state_t {
 	__IXGBEVF_REMOVING,
 	__IXGBEVF_SERVICE_SCHED,
 	__IXGBEVF_SERVICE_INITED,
+	__IXGBEVF_RESET_REQUESTED,
+	__IXGBEVF_QUEUE_RESET_REQUESTED,
 };
 
 enum ixgbevf_boards {
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 3558f01..0b451d9 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -268,7 +268,7 @@ static void ixgbevf_tx_timeout_reset(struct ixgbevf_adapter *adapter)
 {
 	/* Do the reset outside of interrupt context */
 	if (!test_bit(__IXGBEVF_DOWN, &adapter->state)) {
-		adapter->flags |= IXGBEVF_FLAG_RESET_REQUESTED;
+		set_bit(__IXGBEVF_RESET_REQUESTED, &adapter->state);
 		ixgbevf_service_event_schedule(adapter);
 	}
 }
@@ -1984,7 +1984,7 @@ static int ixgbevf_configure_dcb(struct ixgbevf_adapter *adapter)
 		hw->mbx.timeout = 0;
 
 		/* wait for watchdog to come around and bail us out */
-		adapter->flags |= IXGBEVF_FLAG_QUEUE_RESET_REQUESTED;
+		set_bit(__IXGBEVF_QUEUE_RESET_REQUESTED, &adapter->state);
 	}
 
 	return 0;
@@ -2749,11 +2749,9 @@ static void ixgbevf_service_timer(unsigned long data)
 
 static void ixgbevf_reset_subtask(struct ixgbevf_adapter *adapter)
 {
-	if (!(adapter->flags & IXGBEVF_FLAG_RESET_REQUESTED))
+	if (!test_and_clear_bit(__IXGBEVF_RESET_REQUESTED, &adapter->state))
 		return;
 
-	adapter->flags &= ~IXGBEVF_FLAG_RESET_REQUESTED;
-
 	/* If we're already down or resetting, just bail */
 	if (test_bit(__IXGBEVF_DOWN, &adapter->state) ||
 	    test_bit(__IXGBEVF_RESETTING, &adapter->state))
@@ -2821,7 +2819,7 @@ static void ixgbevf_watchdog_update_link(struct ixgbevf_adapter *adapter)
 
 	/* if check for link returns error we will need to reset */
 	if (err && time_after(jiffies, adapter->last_reset + (10 * HZ))) {
-		adapter->flags |= IXGBEVF_FLAG_RESET_REQUESTED;
+		set_bit(__IXGBEVF_RESET_REQUESTED, &adapter->state);
 		link_up = false;
 	}
 
@@ -3222,11 +3220,10 @@ static void ixgbevf_queue_reset_subtask(struct ixgbevf_adapter *adapter)
 {
 	struct net_device *dev = adapter->netdev;
 
-	if (!(adapter->flags & IXGBEVF_FLAG_QUEUE_RESET_REQUESTED))
+	if (!test_and_clear_bit(__IXGBEVF_QUEUE_RESET_REQUESTED,
+				&adapter->state))
 		return;
 
-	adapter->flags &= ~IXGBEVF_FLAG_QUEUE_RESET_REQUESTED;
-
 	/* if interface is down do nothing */
 	if (test_bit(__IXGBEVF_DOWN, &adapter->state) ||
 	    test_bit(__IXGBEVF_RESETTING, &adapter->state))

