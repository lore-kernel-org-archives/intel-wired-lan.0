From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed, 30 May 2018 09:05:12 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: fix possible race in reset subtask
Message-ID: <20180530160512.37220-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Similar to ixgbevf, the same possibility for race exists. Extend the RTNL
lock in ixgbe_reset_subtask() to protect the state bits; this is to make
sure that we get the most up-to-date values for the bits and avoid a
possible race when going down.

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 78926ab35a4e..b47a19de22e8 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -7576,17 +7576,19 @@ static void ixgbe_reset_subtask(struct ixgbe_adapter *adapter)
 	if (!test_and_clear_bit(__IXGBE_RESET_REQUESTED, &adapter->state))
 		return;
 
+	rtnl_lock();
 	/* If we're already down, removing or resetting, just bail */
 	if (test_bit(__IXGBE_DOWN, &adapter->state) ||
 	    test_bit(__IXGBE_REMOVING, &adapter->state) ||
-	    test_bit(__IXGBE_RESETTING, &adapter->state))
+	    test_bit(__IXGBE_RESETTING, &adapter->state)) {
+		rtnl_unlock();
 		return;
+	}
 
 	ixgbe_dump(adapter);
 	netdev_err(adapter->netdev, "Reset adapter\n");
 	adapter->tx_timeout_count++;
 
-	rtnl_lock();
 	ixgbe_reinit_locked(adapter);
 	rtnl_unlock();
 }
-- 
2.13.6

