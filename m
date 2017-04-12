From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed, 12 Apr 2017 13:21:07 -0700
Subject: [Intel-wired-lan] [PATCH 3/3] ixgbevf: Check for RSS key before
	setting value
In-Reply-To: <20170412202107.55834-1-anthony.l.nguyen@intel.com>
References: <20170412202107.55834-1-anthony.l.nguyen@intel.com>
Message-ID: <20170412202107.55834-3-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The RSS key is being repopulated every time the interface is brought up
regardless of whether there is an existing value. If the user sets the RSS
key and the interface is brought up (e.g. reset), the user specified RSS
key will be overwritten.

This patch changes the rss_key to a pointer so we can check to see if the
key has been populated and preserve it accordingly.

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ethtool.c      |  3 ++-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      |  2 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 33 +++++++++++++++++++++--
 3 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ethtool.c b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
index 43b70cd..ff9d05f 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
@@ -855,7 +855,8 @@ static int ixgbevf_get_rxfh(struct net_device *netdev, u32 *indir, u8 *key,
 
 	if (adapter->hw.mac.type >= ixgbe_mac_X550_vf) {
 		if (key)
-			memcpy(key, adapter->rss_key, sizeof(adapter->rss_key));
+			memcpy(key, adapter->rss_key,
+			       ixgbevf_get_rxfh_key_size(netdev));
 
 		if (indir) {
 			int i;
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
index a8cbc2d..581f44b 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
@@ -319,7 +319,7 @@ struct ixgbevf_adapter {
 	spinlock_t mbx_lock;
 	unsigned long last_reset;
 
-	u32 rss_key[IXGBEVF_VFRSSRK_REGS];
+	u32 *rss_key;
 	u8 rss_indir_tbl[IXGBEVF_X550_VFRETA_SIZE];
 };
 
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index d478858..f2cc728 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -1661,6 +1661,28 @@ static void ixgbevf_rx_desc_queue_enable(struct ixgbevf_adapter *adapter,
 		       reg_idx);
 }
 
+/**
+ * ixgbevf_init_rss_key - Initialize adapter RSS key
+ * @adapter: device handle
+ *
+ * Allocates and initializes the RSS key if it is not allocated.
+ **/
+static inline bool ixgbevf_init_rss_key(struct ixgbevf_adapter *adapter)
+{
+	u32 *rss_key;
+
+	if (!adapter->rss_key) {
+		rss_key = kzalloc(IXGBEVF_RSS_HASH_KEY_SIZE, GFP_KERNEL);
+		if (unlikely(!rss_key))
+			return -ENOMEM;
+
+		netdev_rss_key_fill(rss_key, IXGBEVF_RSS_HASH_KEY_SIZE);
+		adapter->rss_key = rss_key;
+	}
+
+	return 0;
+}
+
 static void ixgbevf_setup_vfmrqc(struct ixgbevf_adapter *adapter)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
@@ -1669,9 +1691,8 @@ static void ixgbevf_setup_vfmrqc(struct ixgbevf_adapter *adapter)
 	u8 i, j;
 
 	/* Fill out hash function seeds */
-	netdev_rss_key_fill(adapter->rss_key, sizeof(adapter->rss_key));
 	for (i = 0; i < IXGBEVF_VFRSSRK_REGS; i++)
-		IXGBE_WRITE_REG(hw, IXGBE_VFRSSRK(i), adapter->rss_key[i]);
+		IXGBE_WRITE_REG(hw, IXGBE_VFRSSRK(i), *(adapter->rss_key + i));
 
 	for (i = 0, j = 0; i < IXGBEVF_X550_VFRETA_SIZE; i++, j++) {
 		if (j == rss_i)
@@ -2612,6 +2633,12 @@ static int ixgbevf_sw_init(struct ixgbevf_adapter *adapter)
 
 	hw->mbx.ops.init_params(hw);
 
+	if (hw->mac.type >= ixgbe_mac_X550_vf) {
+		err = ixgbevf_init_rss_key(adapter);
+		if (err)
+			goto out;
+	}
+
 	/* assume legacy case in which PF would only give VF 2 queues */
 	hw->mac.max_tx_queues = 2;
 	hw->mac.max_rx_queues = 2;
@@ -4142,6 +4169,7 @@ static int ixgbevf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 err_sw_init:
 	ixgbevf_reset_interrupt_capability(adapter);
 	iounmap(adapter->io_addr);
+	kfree(adapter->rss_key);
 err_ioremap:
 	disable_dev = !test_and_set_bit(__IXGBEVF_DISABLED, &adapter->state);
 	free_netdev(netdev);
@@ -4188,6 +4216,7 @@ static void ixgbevf_remove(struct pci_dev *pdev)
 
 	hw_dbg(&adapter->hw, "Remove complete\n");
 
+	kfree(adapter->rss_key);
 	disable_dev = !test_and_set_bit(__IXGBEVF_DISABLED, &adapter->state);
 	free_netdev(netdev);
 
-- 
2.9.3

