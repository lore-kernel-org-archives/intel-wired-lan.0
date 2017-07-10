From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 10 Jul 2017 13:23:11 -0700
Subject: [Intel-wired-lan] [PATCH v3 08/16] fm10k: avoid divide by zero in
	rare cases when device is resetting
In-Reply-To: <20170710202319.22110-1-jacob.e.keller@intel.com>
References: <20170710202319.22110-1-jacob.e.keller@intel.com>
Message-ID: <20170710202319.22110-8-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

It is possible that under rare circumstances the device is undergoing
a reset, such as when a PFLR occurs, and the device may be transmitting
simultaneously. In this case, we might attempt to divide by zero when
finding the proper r_idx. Instead, lets read the num_tx_queues once,
and make sure it's non-zero.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
index 5e37387c7082..1154a920f127 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -643,9 +643,13 @@ int fm10k_close(struct net_device *netdev)
 static netdev_tx_t fm10k_xmit_frame(struct sk_buff *skb, struct net_device *dev)
 {
 	struct fm10k_intfc *interface = netdev_priv(dev);
+	int num_tx_queues = READ_ONCE(interface->num_tx_queues);
 	unsigned int r_idx = skb->queue_mapping;
 	int err;
 
+	if (!num_tx_queues)
+		return NETDEV_TX_BUSY;
+
 	if ((skb->protocol == htons(ETH_P_8021Q)) &&
 	    !skb_vlan_tag_present(skb)) {
 		/* FM10K only supports hardware tagging, any tags in frame
@@ -698,8 +702,8 @@ static netdev_tx_t fm10k_xmit_frame(struct sk_buff *skb, struct net_device *dev)
 		__skb_put(skb, pad_len);
 	}
 
-	if (r_idx >= interface->num_tx_queues)
-		r_idx %= interface->num_tx_queues;
+	if (r_idx >= num_tx_queues)
+		r_idx %= num_tx_queues;
 
 	err = fm10k_xmit_frame_ring(skb, interface->tx_ring[r_idx]);
 
-- 
2.13.0.615.gb09ed6e59a40

