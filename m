From: Alexander Duyck <alexander.h.duyck@intel.com>
Date: Tue, 03 Apr 2018 17:16:09 -0400
Subject: [Intel-wired-lan] [iwl next-queue PATCH 03/10] macvlan: Use
 software path for offloaded local, broadcast, and multicast traffic
In-Reply-To: <20180403211519.7880.70243.stgit@ahduyck-green-test.jf.intel.com>
References: <20180403211519.7880.70243.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <20180403211609.7880.1015.stgit@ahduyck-green-test.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This change makes it so that we use a software path for packets that are
going to be locally switched between two macvlan interfaces on the same
device. In addition we resort to software replication of broadcast and
multicast packets instead of offloading that to hardware.

The general idea is that using the device for east/west traffic local to
the system is extremely inefficient. We can only support up to whatever the
PCIe limit is for any given device so this caps us at somewhere around 20G
for devices supported by ixgbe. This is compounded even further when you
take broadcast and multicast into account as a single 10G port can come to
a crawl as a packet is replicated up to 60+ times in some cases. In order
to get away from that I am implementing changes so that we handle
broadcast/multicast replication and east/west local traffic all in
software.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c |    4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c   |   39 +++++--------------
 drivers/net/macvlan.c                           |   47 ++++++++++-------------
 3 files changed, 33 insertions(+), 57 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
index 4579349..ee645ba 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -1254,7 +1254,7 @@ void fm10k_restore_rx_state(struct fm10k_intfc *interface)
 			glort = l2_accel->dglort + 1 + i;
 
 			hw->mac.ops.update_xcast_mode(hw, glort,
-						      FM10K_XCAST_MODE_MULTI);
+						      FM10K_XCAST_MODE_NONE);
 			fm10k_queue_mac_request(interface, glort,
 						sdev->dev_addr,
 						hw->mac.default_vid, true);
@@ -1515,7 +1515,7 @@ static void *fm10k_dfwd_add_station(struct net_device *dev,
 
 	if (fm10k_host_mbx_ready(interface)) {
 		hw->mac.ops.update_xcast_mode(hw, glort,
-					      FM10K_XCAST_MODE_MULTI);
+					      FM10K_XCAST_MODE_NONE);
 		fm10k_queue_mac_request(interface, glort, sdev->dev_addr,
 					hw->mac.default_vid, true);
 	}
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index c08e6b5..6172c1b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -4211,7 +4211,8 @@ static void ixgbe_setup_psrtype(struct ixgbe_adapter *adapter)
 static void ixgbe_configure_virtualization(struct ixgbe_adapter *adapter)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
-	u32 reg_offset, vf_shift;
+	u16 pool = adapter->num_rx_pools;
+	u32 reg_offset, vf_shift, vmolr;
 	u32 gcr_ext, vmdctl;
 	int i;
 
@@ -4225,6 +4226,13 @@ static void ixgbe_configure_virtualization(struct ixgbe_adapter *adapter)
 	vmdctl |= IXGBE_VT_CTL_REPLEN;
 	IXGBE_WRITE_REG(hw, IXGBE_VT_CTL, vmdctl);
 
+	/* accept untagged packets until a vlan tag is
+	 * specifically set for the VMDQ queue/pool
+	 */
+	vmolr = IXGBE_VMOLR_AUPE;
+	while (pool--)
+		IXGBE_WRITE_REG(hw, IXGBE_VMOLR(VMDQ_P(pool)), vmolr);
+
 	vf_shift = VMDQ_P(0) % 32;
 	reg_offset = (VMDQ_P(0) >= 32) ? 1 : 0;
 
@@ -5271,28 +5279,6 @@ static void ixgbe_fdir_filter_restore(struct ixgbe_adapter *adapter)
 	spin_unlock(&adapter->fdir_perfect_lock);
 }
 
-static void ixgbe_macvlan_set_rx_mode(struct net_device *dev, unsigned int pool,
-				      struct ixgbe_adapter *adapter)
-{
-	struct ixgbe_hw *hw = &adapter->hw;
-	u32 vmolr;
-
-	/* No unicast promiscuous support for VMDQ devices. */
-	vmolr = IXGBE_READ_REG(hw, IXGBE_VMOLR(pool));
-	vmolr |= (IXGBE_VMOLR_ROMPE | IXGBE_VMOLR_BAM | IXGBE_VMOLR_AUPE);
-
-	/* clear the affected bit */
-	vmolr &= ~IXGBE_VMOLR_MPE;
-
-	if (dev->flags & IFF_ALLMULTI) {
-		vmolr |= IXGBE_VMOLR_MPE;
-	} else {
-		vmolr |= IXGBE_VMOLR_ROMPE;
-		hw->mac.ops.update_mc_addr_list(hw, dev);
-	}
-	IXGBE_WRITE_REG(hw, IXGBE_VMOLR(pool), vmolr);
-}
-
 /**
  * ixgbe_clean_rx_ring - Free Rx Buffers per Queue
  * @rx_ring: ring to free buffers from
@@ -5376,10 +5362,8 @@ static int ixgbe_fwd_ring_up(struct net_device *vdev,
 	 */
 	err = ixgbe_add_mac_filter(adapter, vdev->dev_addr,
 				   VMDQ_P(accel->pool));
-	if (err >= 0) {
-		ixgbe_macvlan_set_rx_mode(vdev, accel->pool, adapter);
+	if (err >= 0)
 		return 0;
-	}
 
 	for (i = 0; i < adapter->num_rx_queues_per_pool; i++)
 		adapter->rx_ring[baseq + i]->netdev = NULL;
@@ -9816,9 +9800,6 @@ static void ixgbe_fwd_del(struct net_device *pdev, void *priv)
 	ixgbe_del_mac_filter(adapter, accel->netdev->dev_addr,
 			     VMDQ_P(accel->pool));
 
-	/* disable ability to receive packets for this pool */
-	IXGBE_WRITE_REG(&adapter->hw, IXGBE_VMOLR(accel->pool), 0);
-
 	/* Allow remaining Rx packets to get flushed out of the
 	 * Rx FIFO before we drop the netdev for the ring.
 	 */
diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 7ddc94f..adde8fc 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -514,6 +514,7 @@ static int macvlan_queue_xmit(struct sk_buff *skb, struct net_device *dev)
 	const struct macvlan_dev *vlan = netdev_priv(dev);
 	const struct macvlan_port *port = vlan->port;
 	const struct macvlan_dev *dest;
+	void *accel_priv = NULL;
 
 	if (vlan->mode == MACVLAN_MODE_BRIDGE) {
 		const struct ethhdr *eth = (void *)skb->data;
@@ -533,9 +534,14 @@ static int macvlan_queue_xmit(struct sk_buff *skb, struct net_device *dev)
 		}
 	}
 
+	/* For packets that are non-multicast and not bridged we will pass
+	 * the necessary information so that the lowerdev can distinguish
+	 * the source of the packets via the accel_priv value.
+	 */
+	accel_priv = vlan->accel_priv;
 xmit_world:
 	skb->dev = vlan->lowerdev;
-	return dev_queue_xmit(skb);
+	return dev_queue_xmit_accel(skb, accel_priv);
 }
 
 static inline netdev_tx_t macvlan_netpoll_send_skb(struct macvlan_dev *vlan, struct sk_buff *skb)
@@ -552,19 +558,14 @@ static inline netdev_tx_t macvlan_netpoll_send_skb(struct macvlan_dev *vlan, str
 static netdev_tx_t macvlan_start_xmit(struct sk_buff *skb,
 				      struct net_device *dev)
 {
+	struct macvlan_dev *vlan = netdev_priv(dev);
 	unsigned int len = skb->len;
 	int ret;
-	struct macvlan_dev *vlan = netdev_priv(dev);
 
 	if (unlikely(netpoll_tx_running(dev)))
 		return macvlan_netpoll_send_skb(vlan, skb);
 
-	if (vlan->accel_priv) {
-		skb->dev = vlan->lowerdev;
-		ret = dev_queue_xmit_accel(skb, vlan->accel_priv);
-	} else {
-		ret = macvlan_queue_xmit(skb, dev);
-	}
+	ret = macvlan_queue_xmit(skb, dev);
 
 	if (likely(ret == NET_XMIT_SUCCESS || ret == NET_XMIT_CN)) {
 		struct vlan_pcpu_stats *pcpu_stats;
@@ -620,26 +621,20 @@ static int macvlan_open(struct net_device *dev)
 	/* Attempt to populate accel_priv which is used to offload the L2
 	 * forwarding requests for unicast packets.
 	 */
-	if (lowerdev->features & NETIF_F_HW_L2FW_DOFFLOAD) {
+	if (lowerdev->features & NETIF_F_HW_L2FW_DOFFLOAD)
 		vlan->accel_priv =
 		      lowerdev->netdev_ops->ndo_dfwd_add_station(lowerdev, dev);
 
-		/* If we get a NULL pointer back, or if we get an error
-		 * then we should just fall through to the non accelerated path
-		 */
-		if (IS_ERR_OR_NULL(vlan->accel_priv))
-			vlan->accel_priv = NULL;
-		else
-			return 0;
+	/* If earlier attempt to offload failed, or accel_priv is not
+	 * populated we must add the unicast address to the lower device.
+	 */
+	if (IS_ERR_OR_NULL(vlan->accel_priv)) {
+		vlan->accel_priv = NULL;
+		err = dev_uc_add(lowerdev, dev->dev_addr);
+		if (err < 0)
+			goto out;
 	}
 
-	err = -EBUSY;
-	if (macvlan_addr_busy(vlan->port, dev->dev_addr))
-		goto out;
-
-	err = dev_uc_add(lowerdev, dev->dev_addr);
-	if (err < 0)
-		goto out;
 	if (dev->flags & IFF_ALLMULTI) {
 		err = dev_set_allmulti(lowerdev, 1);
 		if (err < 0)
@@ -660,13 +655,14 @@ static int macvlan_open(struct net_device *dev)
 	if (dev->flags & IFF_ALLMULTI)
 		dev_set_allmulti(lowerdev, -1);
 del_unicast:
-	dev_uc_del(lowerdev, dev->dev_addr);
-out:
 	if (vlan->accel_priv) {
 		lowerdev->netdev_ops->ndo_dfwd_del_station(lowerdev,
 							   vlan->accel_priv);
 		vlan->accel_priv = NULL;
+	} else {
+		dev_uc_del(lowerdev, dev->dev_addr);
 	}
+out:
 	return err;
 }
 
@@ -679,7 +675,6 @@ static int macvlan_stop(struct net_device *dev)
 		lowerdev->netdev_ops->ndo_dfwd_del_station(lowerdev,
 							   vlan->accel_priv);
 		vlan->accel_priv = NULL;
-		return 0;
 	}
 
 	dev_uc_unsync(lowerdev, dev);

