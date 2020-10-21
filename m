From: Vitaly Lifshits <vitaly.lifshits@intel.com>
Date: Wed, 21 Oct 2020 14:59:37 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] e1000e: add rtnl_lock() to
 e1000_reset_task
Message-ID: <20201021115937.40428-1-vitaly.lifshits@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

A possible race condition was found in e1000_reset_task,
after discovering a similar issue in igb driver
(024a8168b7 igb: reinit_locked() should be called with rtnl_lock).

Added rtnl_lock() and rtnl_unlock() to avoid this.

Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index ee6a5f0cb16c..ab2cf4540425 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -5990,15 +5990,19 @@ static void e1000_reset_task(struct work_struct *work)
 	struct e1000_adapter *adapter;
 	adapter = container_of(work, struct e1000_adapter, reset_task);
 
+	rtnl_lock();
 	/* don't run the task if already down */
-	if (test_bit(__E1000_DOWN, &adapter->state))
+	if (test_bit(__E1000_DOWN, &adapter->state)) {
+		rtnl_unlock();
 		return;
+	}
 
 	if (!(adapter->flags & FLAG_RESTART_NOW)) {
 		e1000e_dump(adapter);
 		e_err("Reset adapter unexpectedly\n");
 	}
 	e1000e_reinit_locked(adapter);
+	rtnl_unlock();
 }
 
 /**
-- 
2.11.0

