From: =?unknown-8bit?q?J=C4=99drzej?= Jagielski <jedrzej.jagielski@intel.com>
Date: Fri, 11 Jun 2021 22:42:17 +0000
Subject: [Intel-wired-lan] [PATCH net v1] igb: Fix position of assignment to
 *ring
Message-ID: <20210611224217.94872-1-jedrzej.jagielski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Assignment to *ring should be done after correctness check of the
argument queue.

Fixes: 91db364236c8 ("igb: Refactor igb_configure_cbs()")
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index e6fa1e3c8..e49b2bda1 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -1683,14 +1683,15 @@ static bool is_any_txtime_enabled(struct igb_adapter *adapter)
  **/
 static void igb_config_tx_modes(struct igb_adapter *adapter, int queue)
 {
-	struct igb_ring *ring = adapter->tx_ring[queue];
 	struct net_device *netdev = adapter->netdev;
 	struct e1000_hw *hw = &adapter->hw;
+	struct igb_ring *ring;
 	u32 tqavcc, tqavctrl;
 	u16 value;
 
 	WARN_ON(hw->mac.type != e1000_i210);
 	WARN_ON(queue < 0 || queue > 1);
+	ring = adapter->tx_ring[queue];
 
 	/* If any of the Qav features is enabled, configure queues as SR and
 	 * with HIGH PRIO. If none is, then configure them with LOW PRIO and
-- 
2.27.0

