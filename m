From: Taehee Yoo <ap420073@gmail.com>
Date: Thu,  8 Aug 2019 00:48:23 +0900
Subject: [Intel-wired-lan] [PATCH net v2] ixgbe: fix possible deadlock in
 ixgbe_service_task()
Message-ID: <20190807154823.24470-1-ap420073@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

ixgbe_service_task() calls unregister_netdev() under rtnl_lock().
But unregister_netdev() internally calls rtnl_lock().
So deadlock would occur.

Fixes: 59dd45d550c5 ("ixgbe: firmware recovery mode")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v2: remove unnecessary curly braces.

 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index cbaf712d6529..7882148abb43 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -7897,11 +7897,8 @@ static void ixgbe_service_task(struct work_struct *work)
 		return;
 	}
 	if (ixgbe_check_fw_error(adapter)) {
-		if (!test_bit(__IXGBE_DOWN, &adapter->state)) {
-			rtnl_lock();
+		if (!test_bit(__IXGBE_DOWN, &adapter->state))
 			unregister_netdev(adapter->netdev);
-			rtnl_unlock();
-		}
 		ixgbe_service_event_complete(adapter);
 		return;
 	}
-- 
2.17.1

