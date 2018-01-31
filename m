From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Tue, 30 Jan 2018 16:51:38 -0800
Subject: [Intel-wired-lan] [PATCH 6/9] ixgbevf: make sure all frames fit
 minimum size requirements
In-Reply-To: <20180131005015.19264.44085.stgit@localhost6.localdomain6>
References: <20180131005015.19264.44085.stgit@localhost6.localdomain6>
Message-ID: <20180131005138.19264.10068.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Similar to commit a50c29dd09ed
("ixgbe: Make certain that all frames fit minimum size requirements")

Make sure that any packet we attempt to transmit will meet minimum
size requirements.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   30 ++++++++++++++++++---
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index d797265..b381127 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -3779,11 +3779,10 @@ static int ixgbevf_maybe_stop_tx(struct ixgbevf_ring *tx_ring, int size)
 	return __ixgbevf_maybe_stop_tx(tx_ring, size);
 }
 
-static int ixgbevf_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
+static int ixgbevf_xmit_frame_ring(struct sk_buff *skb,
+				   struct ixgbevf_ring *tx_ring)
 {
-	struct ixgbevf_adapter *adapter = netdev_priv(netdev);
 	struct ixgbevf_tx_buffer *first;
-	struct ixgbevf_ring *tx_ring;
 	int tso;
 	u32 tx_flags = 0;
 	u16 count = TXD_USE_COUNT(skb_headlen(skb));
@@ -3798,8 +3797,6 @@ static int ixgbevf_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
 		return NETDEV_TX_OK;
 	}
 
-	tx_ring = adapter->tx_ring[skb->queue_mapping];
-
 	/* need: 1 descriptor per page * PAGE_SIZE/IXGBE_MAX_DATA_PER_TXD,
 	 *       + 1 desc for skb_headlen/IXGBE_MAX_DATA_PER_TXD,
 	 *       + 2 desc gap to keep tail from touching head,
@@ -3852,6 +3849,29 @@ static int ixgbevf_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
 	return NETDEV_TX_OK;
 }
 
+static int ixgbevf_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
+{
+	struct ixgbevf_adapter *adapter = netdev_priv(netdev);
+	struct ixgbevf_ring *tx_ring;
+
+	if (skb->len <= 0) {
+		dev_kfree_skb_any(skb);
+		return NETDEV_TX_OK;
+	}
+
+	/* The minimum packet size for olinfo paylen is 17 so pad the skb
+	 * in order to meet this minimum size requirement.
+	 */
+	if (skb->len < 17) {
+		if (skb_padto(skb, 17))
+			return NETDEV_TX_OK;
+		skb->len = 17;
+	}
+
+	tx_ring = adapter->tx_ring[skb->queue_mapping];
+	return ixgbevf_xmit_frame_ring(skb, tx_ring);
+}
+
 /**
  * ixgbevf_set_mac - Change the Ethernet Address of the NIC
  * @netdev: network interface device structure

