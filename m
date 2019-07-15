From: Taehee Yoo <ap420073@gmail.com>
Date: Mon, 15 Jul 2019 13:57:06 +0900
Subject: [Intel-wired-lan] [PATCH net] ixgbe: fix possible deadlock in
 ixgbe_service_task()
Message-ID: <20190715045706.6140-1-ap420073@gmail.com>
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
I did only compile test because I don't have the hardware.
Could anyone test this patch?
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 57fd9ee6de66..b4888be94dfb 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -7894,9 +7894,7 @@ static void ixgbe_service_task(struct work_struct *work)
 	}
 	if (ixgbe_check_fw_error(adapter)) {
 		if (!test_bit(__IXGBE_DOWN, &adapter->state)) {
-			rtnl_lock();
 			unregister_netdev(adapter->netdev);
-			rtnl_unlock();
 		}
 		ixgbe_service_event_complete(adapter);
 		return;
-- 
2.17.1

