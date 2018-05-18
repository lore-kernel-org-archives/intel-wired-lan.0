From: Sergey Nemov <sergey.nemov@intel.com>
Date: Fri, 18 May 2018 11:58:40 +0200
Subject: [Intel-wired-lan] [PATCH] igb: Wait 10ms just once after TX queues
 reset
Message-ID: <20180518095840.GA17330@gklab-81-211.igk.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Move 10ms sleep out of function resetting TX queue.
Reset all the TX queues in one turn and
wait for all of them just once.

Use usleep_range() instead of mdelay() in order not to
affect transmission on other interfaces.

Signed-off-by: Sergey Nemov <sergey.nemov@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 715bb32..db05927 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3808,11 +3808,6 @@ void igb_configure_tx_ring(struct igb_adapter *adapter,
 	u64 tdba = ring->dma;
 	int reg_idx = ring->reg_idx;
 
-	/* disable the queue */
-	wr32(E1000_TXDCTL(reg_idx), 0);
-	wrfl();
-	mdelay(10);
-
 	wr32(E1000_TDLEN(reg_idx),
 	     ring->count * sizeof(union e1000_adv_tx_desc));
 	wr32(E1000_TDBAL(reg_idx),
@@ -3843,8 +3838,16 @@ void igb_configure_tx_ring(struct igb_adapter *adapter,
  **/
 static void igb_configure_tx(struct igb_adapter *adapter)
 {
+	struct e1000_hw *hw = &adapter->hw;
 	int i;
 
+	/* disable the queues */
+	for (i = 0; i < adapter->num_tx_queues; i++)
+		wr32(E1000_TXDCTL(adapter->tx_ring[i]->reg_idx), 0);
+
+	wrfl();
+	usleep_range(10000, 20000);
+
 	for (i = 0; i < adapter->num_tx_queues; i++)
 		igb_configure_tx_ring(adapter, adapter->tx_ring[i]);
 }
-- 
1.8.3.1

-------------- next part --------------
From 3b2ac817c6db0e77f44fa38aeac402731a89124d Mon Sep 17 00:00:00 2001
From: Sergey Nemov <sergey.nemov@intel.com>
Date: Mon, 23 Apr 2018 14:56:22 +0200
Subject: [PATCH] igb: Wait 10ms just once after TX queues reset
To: intel-wired-lan@lists.osuosl.org
Cc: sergey.nemov at intel.com

Move 10ms sleep out of function resetting TX queue.
Reset all the TX queues in one turn and
wait for all of them just once.

Use usleep_range() instead of mdelay() in order not to
affect transmission on other interfaces.

Signed-off-by: Sergey Nemov <sergey.nemov@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 715bb32..db05927 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3808,11 +3808,6 @@ void igb_configure_tx_ring(struct igb_adapter *adapter,
 	u64 tdba = ring->dma;
 	int reg_idx = ring->reg_idx;
 
-	/* disable the queue */
-	wr32(E1000_TXDCTL(reg_idx), 0);
-	wrfl();
-	mdelay(10);
-
 	wr32(E1000_TDLEN(reg_idx),
 	     ring->count * sizeof(union e1000_adv_tx_desc));
 	wr32(E1000_TDBAL(reg_idx),
@@ -3843,8 +3838,16 @@ void igb_configure_tx_ring(struct igb_adapter *adapter,
  **/
 static void igb_configure_tx(struct igb_adapter *adapter)
 {
+	struct e1000_hw *hw = &adapter->hw;
 	int i;
 
+	/* disable the queues */
+	for (i = 0; i < adapter->num_tx_queues; i++)
+		wr32(E1000_TXDCTL(adapter->tx_ring[i]->reg_idx), 0);
+
+	wrfl();
+	usleep_range(10000, 20000);
+
 	for (i = 0; i < adapter->num_tx_queues; i++)
 		igb_configure_tx_ring(adapter, adapter->tx_ring[i]);
 }
-- 
1.8.3.1

