From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Fri, 29 Jul 2016 10:30:11 -0700
Subject: [Intel-wired-lan] [PATCH 2/3] ixgbevf: change hw_dbg to use
	netdev_dbg
In-Reply-To: <20160729173006.25548.93033.stgit@localhost6.localdomain6>
References: <20160729173006.25548.93033.stgit@localhost6.localdomain6>
Message-ID: <20160729173011.25548.74817.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Instead of the home brewed macro make use of netdev_dbg same as
the ixgbe driver.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      |   11 ++++-------
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |    1 +
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
index be52f59..5639fbe 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
@@ -502,12 +502,9 @@ extern void ixgbevf_write_eitr(struct ixgbevf_q_vector *q_vector);
 void ixgbe_napi_add_all(struct ixgbevf_adapter *adapter);
 void ixgbe_napi_del_all(struct ixgbevf_adapter *adapter);
 
-#ifdef DEBUG
-char *ixgbevf_get_hw_dev_name(struct ixgbe_hw *hw);
-#define hw_dbg(hw, format, arg...) \
-	printk(KERN_DEBUG "%s: " format, ixgbevf_get_hw_dev_name(hw), ##arg)
-#else
-#define hw_dbg(hw, format, arg...) do {} while (0)
-#endif
+#define ixgbevf_hw_to_netdev(hw) \
+	(((struct ixgbevf_adapter *)(hw)->back)->netdev)
 
+#define hw_dbg(hw, format, arg...) \
+	netdev_dbg(ixgbevf_hw_to_netdev(hw), format, ## arg)
 #endif /* _IXGBEVF_H_ */
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index d9d6616..8d4f535 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -2993,6 +2993,7 @@ static void ixgbevf_free_all_tx_resources(struct ixgbevf_adapter *adapter)
  **/
 int ixgbevf_setup_tx_resources(struct ixgbevf_ring *tx_ring)
 {
+	struct ixgbevf_adapter *adapter = netdev_priv(tx_ring->netdev);
 	int size;
 
 	size = sizeof(struct ixgbevf_tx_buffer) * tx_ring->count;

