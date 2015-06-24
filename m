From: Tom Barbette <tom.barbette@ulg.ac.be>
Date: Wed, 24 Jun 2015 15:45:16 +0200
Subject: [Intel-wired-lan] [PATCH net-next] ixgbe support for ethtool
	set_rxfh
Message-ID: <CAO1kT88R2wqLsjrvzS2gfa69vm2Z0V0ZvTSpoOU2S8PX0M5Lrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Allows to change the rxfh indirection table and/or key using ethtool interface

Signed-off-by: Tom Barbette <tom.barbette@ulg.ac.be>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h         |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 40 ++++++++++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |  2 +-
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index ac3ac2a..4314799 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -967,4 +967,5 @@ netdev_tx_t ixgbe_xmit_frame_ring(struct sk_buff *skb,
   struct ixgbe_adapter *adapter,
   struct ixgbe_ring *tx_ring);
 u32 ixgbe_rss_indir_tbl_entries(struct ixgbe_adapter *adapter);
+void ixgbe_store_reta(struct ixgbe_adapter *adapter);
 #endif /* _IXGBE_H_ */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index ec7b232..1d373b9 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -2907,6 +2907,45 @@ static int ixgbe_get_rxfh(struct net_device
*netdev, u32 *indir, u8 *key,
  return 0;
 }

+static int ixgbe_set_rxfh(struct net_device *netdev, const u32 *indir,
+                        const u8 *key, const u8 hfunc)
+{
+        struct ixgbe_adapter *adapter = netdev_priv(netdev);
+ u32 reta_entries = ixgbe_rss_indir_tbl_entries(adapter);
+        int i;
+ u32 num_queues;
+
+ num_queues = adapter->num_rx_queues;
+
+ /*
+ * Allow at least 2 queues w/ SR-IOV.
+ */
+ if ((adapter->flags & IXGBE_FLAG_SRIOV_ENABLED) && (num_queues < 2))
+ num_queues = 2;
+
+ if (hfunc)
+ return -EINVAL;
+
+ /* Fill out the redirection table */
+ if (indir) {
+        /* Verify user input. */
+        for (i = 0; i < reta_entries; i++)
+        if (indir[i] >= num_queues)
+                return -EINVAL;
+
+ for (i = 0; i < reta_entries; i++)
+ adapter->rss_indir_tbl[i] = indir[i];
+    }
+
+ /* Fill out the rss hash key */
+ if (key)
+ memcpy(adapter->rss_key, key, ixgbe_get_rxfh_key_size(netdev));
+
+ ixgbe_store_reta(adapter);
+
+        return 0;
+}
+
 static int ixgbe_get_ts_info(struct net_device *dev,
      struct ethtool_ts_info *info)
 {
@@ -3167,6 +3206,7 @@ static const struct ethtool_ops ixgbe_ethtool_ops = {
  .get_rxfh_indir_size = ixgbe_rss_indir_size,
  .get_rxfh_key_size = ixgbe_get_rxfh_key_size,
  .get_rxfh = ixgbe_get_rxfh,
+ .set_rxfh = ixgbe_set_rxfh,
  .get_channels = ixgbe_get_channels,
  .set_channels = ixgbe_set_channels,
  .get_ts_info = ixgbe_get_ts_info,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 9aa6104..0fdeb76 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -3287,7 +3287,7 @@ u32 ixgbe_rss_indir_tbl_entries(struct
ixgbe_adapter *adapter)
  *
  * Write the RSS redirection table stored in adapter.rss_indir_tbl[] to HW.
  */
-static void ixgbe_store_reta(struct ixgbe_adapter *adapter)
+void ixgbe_store_reta(struct ixgbe_adapter *adapter)
 {
  u32 i, reta_entries = ixgbe_rss_indir_tbl_entries(adapter);
  struct ixgbe_hw *hw = &adapter->hw;
