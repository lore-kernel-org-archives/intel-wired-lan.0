From: John Fastabend <john.fastabend@gmail.com>
Date: Mon, 01 May 2017 22:06:34 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: prevent driver configuration
 changes while XDP is loaded
Message-ID: <20170502050634.7459.50968.stgit@john-Precision-Tower-5810>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

XDP checks to ensure the MTU is valid and LRO is disabled when it is
loaded. But user configuration after XDP is loaded could change these
and cause a misconfiguration.

This patch adds checks to ensure config changes are valid.

Signed-off-by: John Fastabend <john.r.fastabend@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index ee20a2b..156357e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -6437,6 +6437,19 @@ static void ixgbe_free_all_rx_resources(struct ixgbe_adapter *adapter)
 static int ixgbe_change_mtu(struct net_device *netdev, int new_mtu)
 {
 	struct ixgbe_adapter *adapter = netdev_priv(netdev);
+	int i, frame_size = new_mtu + ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN;
+
+	/* If XDP is running enforce MTU limitations */
+	for (i = 0; i < adapter->num_rx_queues; i++) {
+		struct ixgbe_ring *ring = adapter->rx_ring[i];
+
+		if (frame_size > ixgbe_rx_bufsz(ring)) {
+			e_warn(probe,
+			       "Setting MTU > %i with XDP is not supported\n",
+			       ixgbe_rx_bufsz(ring));
+			return -EINVAL;
+		}
+	}
 
 	/*
 	 * For 82599EB we cannot allow legacy VFs to enable their receive
@@ -9291,6 +9304,10 @@ static netdev_features_t ixgbe_fix_features(struct net_device *netdev,
 	if (!(adapter->flags2 & IXGBE_FLAG2_RSC_CAPABLE))
 		features &= ~NETIF_F_LRO;
 
+	/* If XDP is enabled we can not enable LRO */
+	if (adapter->xdp_prog)
+		features &= ~NETIF_F_LRO;
+
 	return features;
 }
 

