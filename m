From: Markus Elfring <Markus.Elfring@web.de>
Date: Thu, 22 Aug 2019 20:30:15 +0200
Subject: [Intel-wired-lan] =?utf-8?q?=5BPATCH=5D_ethernet=3A_Delete_unnec?=
 =?utf-8?q?essary_checks_before_the_macro_call_=E2=80=9Cdev=5Fkfree=5Fskb?=
 =?utf-8?b?4oCd?=
Message-ID: <af1ae1cf-4a01-5e3a-edc2-058668487137@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 22 Aug 2019 20:02:56 +0200

The dev_kfree_skb() function performs also input parameter validation.
Thus the test around the shown calls is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/net/ethernet/amd/ni65.c                   |  6 ++----
 drivers/net/ethernet/broadcom/bcmsysport.c        |  3 +--
 drivers/net/ethernet/broadcom/genet/bcmgenet.c    | 11 +++--------
 drivers/net/ethernet/freescale/gianfar.c          |  3 +--
 drivers/net/ethernet/ibm/ehea/ehea_main.c         | 12 ++++--------
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c  |  3 +--
 drivers/net/ethernet/intel/e1000/e1000_main.c     |  3 +--
 drivers/net/ethernet/intel/e1000e/ethtool.c       |  6 ++----
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c   |  3 +--
 drivers/net/ethernet/intel/igb/igb_main.c         |  3 +--
 drivers/net/ethernet/intel/igc/igc_main.c         |  3 +--
 drivers/net/ethernet/micrel/ks8842.c              |  4 +---
 drivers/net/ethernet/microchip/lan743x_ptp.c      |  3 +--
 drivers/net/ethernet/packetengines/yellowfin.c    |  3 +--
 drivers/net/ethernet/qualcomm/qca_spi.c           |  3 +--
 drivers/net/ethernet/qualcomm/qca_uart.c          |  3 +--
 drivers/net/ethernet/sgi/meth.c                   |  3 +--
 drivers/net/ethernet/smsc/smc91x.c                |  3 +--
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  3 +--
 drivers/net/ethernet/sun/sunvnet_common.c         |  3 +--
 20 files changed, 27 insertions(+), 57 deletions(-)

diff --git a/drivers/net/ethernet/amd/ni65.c b/drivers/net/ethernet/amd/ni65.c
index 87ff5d6d1b22..c6c2a54c1121 100644
--- a/drivers/net/ethernet/amd/ni65.c
+++ b/drivers/net/ethernet/amd/ni65.c
@@ -697,16 +697,14 @@ static void ni65_free_buffer(struct priv *p)
 	for(i=0;i<TMDNUM;i++) {
 		kfree(p->tmdbounce[i]);
 #ifdef XMT_VIA_SKB
-		if(p->tmd_skb[i])
-			dev_kfree_skb(p->tmd_skb[i]);
+		dev_kfree_skb(p->tmd_skb[i]);
 #endif
 	}

 	for(i=0;i<RMDNUM;i++)
 	{
 #ifdef RCV_VIA_SKB
-		if(p->recv_skb[i])
-			dev_kfree_skb(p->recv_skb[i]);
+		dev_kfree_skb(p->recv_skb[i]);
 #else
 		kfree(p->recvbounce[i]);
 #endif
diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index 9483553ce444..6a47daec2302 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -708,8 +708,7 @@ static int bcm_sysport_alloc_rx_bufs(struct bcm_sysport_priv *priv)
 	for (i = 0; i < priv->num_rx_bds; i++) {
 		cb = &priv->rx_cbs[i];
 		skb = bcm_sysport_rx_refill(priv, cb);
-		if (skb)
-			dev_kfree_skb(skb);
+		dev_kfree_skb(skb);
 		if (!cb->skb)
 			return -ENOMEM;
 	}
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index d3a0b614dbfa..8b19ddcdafaa 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2515,19 +2515,14 @@ static int bcmgenet_dma_teardown(struct bcmgenet_priv *priv)
 static void bcmgenet_fini_dma(struct bcmgenet_priv *priv)
 {
 	struct netdev_queue *txq;
-	struct sk_buff *skb;
-	struct enet_cb *cb;
 	int i;

 	bcmgenet_fini_rx_napi(priv);
 	bcmgenet_fini_tx_napi(priv);

-	for (i = 0; i < priv->num_tx_bds; i++) {
-		cb = priv->tx_cbs + i;
-		skb = bcmgenet_free_tx_cb(&priv->pdev->dev, cb);
-		if (skb)
-			dev_kfree_skb(skb);
-	}
+	for (i = 0; i < priv->num_tx_bds; i++)
+		dev_kfree_skb(bcmgenet_free_tx_cb(&priv->pdev->dev,
+						  priv->tx_cbs + i));

 	for (i = 0; i < priv->hw_params->tx_queues; i++) {
 		txq = netdev_get_tx_queue(priv->dev, priv->tx_rings[i].queue);
diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index 7ea19e173339..412c0340fed9 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -2005,8 +2005,7 @@ static void free_skb_rx_queue(struct gfar_priv_rx_q *rx_queue)

 	struct rxbd8 *rxbdp = rx_queue->rx_bd_base;

-	if (rx_queue->skb)
-		dev_kfree_skb(rx_queue->skb);
+	dev_kfree_skb(rx_queue->skb);

 	for (i = 0; i < rx_queue->rx_ring_size; i++) {
 		struct	gfar_rx_buff *rxb = &rx_queue->rx_buff[i];
diff --git a/drivers/net/ethernet/ibm/ehea/ehea_main.c b/drivers/net/ethernet/ibm/ehea/ehea_main.c
index cca71ba7a74a..13e30eba5349 100644
--- a/drivers/net/ethernet/ibm/ehea/ehea_main.c
+++ b/drivers/net/ethernet/ibm/ehea/ehea_main.c
@@ -1577,20 +1577,16 @@ static int ehea_clean_portres(struct ehea_port *port, struct ehea_port_res *pr)
 		ehea_destroy_eq(pr->eq);

 		for (i = 0; i < pr->rq1_skba.len; i++)
-			if (pr->rq1_skba.arr[i])
-				dev_kfree_skb(pr->rq1_skba.arr[i]);
+			dev_kfree_skb(pr->rq1_skba.arr[i]);

 		for (i = 0; i < pr->rq2_skba.len; i++)
-			if (pr->rq2_skba.arr[i])
-				dev_kfree_skb(pr->rq2_skba.arr[i]);
+			dev_kfree_skb(pr->rq2_skba.arr[i]);

 		for (i = 0; i < pr->rq3_skba.len; i++)
-			if (pr->rq3_skba.arr[i])
-				dev_kfree_skb(pr->rq3_skba.arr[i]);
+			dev_kfree_skb(pr->rq3_skba.arr[i]);

 		for (i = 0; i < pr->sq_skba.len; i++)
-			if (pr->sq_skba.arr[i])
-				dev_kfree_skb(pr->sq_skba.arr[i]);
+			dev_kfree_skb(pr->sq_skba.arr[i]);

 		vfree(pr->rq1_skba.arr);
 		vfree(pr->rq2_skba.arr);
diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
index a41008523c98..71d3d8854d8f 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
@@ -937,8 +937,7 @@ static void e1000_free_desc_rings(struct e1000_adapter *adapter)
 						 txdr->buffer_info[i].dma,
 						 txdr->buffer_info[i].length,
 						 DMA_TO_DEVICE);
-			if (txdr->buffer_info[i].skb)
-				dev_kfree_skb(txdr->buffer_info[i].skb);
+			dev_kfree_skb(txdr->buffer_info[i].skb);
 		}
 	}

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 6b6ba1c38235..86493fea56e4 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -4175,8 +4175,7 @@ static bool e1000_clean_jumbo_rx_irq(struct e1000_adapter *adapter,
 				/* an error means any chain goes out the window
 				 * too
 				 */
-				if (rx_ring->rx_skb_top)
-					dev_kfree_skb(rx_ring->rx_skb_top);
+				dev_kfree_skb(rx_ring->rx_skb_top);
 				rx_ring->rx_skb_top = NULL;
 				goto next_desc;
 			}
diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
index 08342698386d..de8c5818a305 100644
--- a/drivers/net/ethernet/intel/e1000e/ethtool.c
+++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
@@ -1126,8 +1126,7 @@ static void e1000_free_desc_rings(struct e1000_adapter *adapter)
 						 buffer_info->dma,
 						 buffer_info->length,
 						 DMA_TO_DEVICE);
-			if (buffer_info->skb)
-				dev_kfree_skb(buffer_info->skb);
+			dev_kfree_skb(buffer_info->skb);
 		}
 	}

@@ -1139,8 +1138,7 @@ static void e1000_free_desc_rings(struct e1000_adapter *adapter)
 				dma_unmap_single(&pdev->dev,
 						 buffer_info->dma,
 						 2048, DMA_FROM_DEVICE);
-			if (buffer_info->skb)
-				dev_kfree_skb(buffer_info->skb);
+			dev_kfree_skb(buffer_info->skb);
 		}
 	}

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
index d3e85480f46d..09f7a246e134 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -253,8 +253,7 @@ static void fm10k_clean_rx_ring(struct fm10k_ring *rx_ring)
 	if (!rx_ring->rx_buffer)
 		return;

-	if (rx_ring->skb)
-		dev_kfree_skb(rx_ring->skb);
+	dev_kfree_skb(rx_ring->skb);
 	rx_ring->skb = NULL;

 	/* Free all the Rx ring sk_buffs */
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index b63e77528a91..105b0624081a 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -4731,8 +4731,7 @@ static void igb_clean_rx_ring(struct igb_ring *rx_ring)
 {
 	u16 i = rx_ring->next_to_clean;

-	if (rx_ring->skb)
-		dev_kfree_skb(rx_ring->skb);
+	dev_kfree_skb(rx_ring->skb);
 	rx_ring->skb = NULL;

 	/* Free all the Rx ring sk_buffs */
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index e5114bebd30b..251552855c40 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -352,8 +352,7 @@ static void igc_clean_rx_ring(struct igc_ring *rx_ring)
 {
 	u16 i = rx_ring->next_to_clean;

-	if (rx_ring->skb)
-		dev_kfree_skb(rx_ring->skb);
+	dev_kfree_skb(rx_ring->skb);
 	rx_ring->skb = NULL;

 	/* Free all the Rx ring sk_buffs */
diff --git a/drivers/net/ethernet/micrel/ks8842.c b/drivers/net/ethernet/micrel/ks8842.c
index ccd06702cc56..da329ca115cc 100644
--- a/drivers/net/ethernet/micrel/ks8842.c
+++ b/drivers/net/ethernet/micrel/ks8842.c
@@ -580,9 +580,7 @@ static int __ks8842_start_new_rx_dma(struct net_device *netdev)
 		dma_unmap_single(adapter->dev, sg_dma_address(sg),
 			DMA_BUFFER_SIZE, DMA_FROM_DEVICE);
 	sg_dma_address(sg) = 0;
-	if (ctl->skb)
-		dev_kfree_skb(ctl->skb);
-
+	dev_kfree_skb(ctl->skb);
 	ctl->skb = NULL;

 	printk(KERN_ERR DRV_NAME": Failed to start RX DMA: %d\n", err);
diff --git a/drivers/net/ethernet/microchip/lan743x_ptp.c b/drivers/net/ethernet/microchip/lan743x_ptp.c
index b2109eca81fd..57b26c2acf87 100644
--- a/drivers/net/ethernet/microchip/lan743x_ptp.c
+++ b/drivers/net/ethernet/microchip/lan743x_ptp.c
@@ -963,8 +963,7 @@ void lan743x_ptp_close(struct lan743x_adapter *adapter)
 		index++) {
 		struct sk_buff *skb = ptp->tx_ts_skb_queue[index];

-		if (skb)
-			dev_kfree_skb(skb);
+		dev_kfree_skb(skb);
 		ptp->tx_ts_skb_queue[index] = NULL;
 		ptp->tx_ts_seconds_queue[index] = 0;
 		ptp->tx_ts_nseconds_queue[index] = 0;
diff --git a/drivers/net/ethernet/packetengines/yellowfin.c b/drivers/net/ethernet/packetengines/yellowfin.c
index 6f8d6584f809..5113ee647090 100644
--- a/drivers/net/ethernet/packetengines/yellowfin.c
+++ b/drivers/net/ethernet/packetengines/yellowfin.c
@@ -1258,8 +1258,7 @@ static int yellowfin_close(struct net_device *dev)
 		yp->rx_skbuff[i] = NULL;
 	}
 	for (i = 0; i < TX_RING_SIZE; i++) {
-		if (yp->tx_skbuff[i])
-			dev_kfree_skb(yp->tx_skbuff[i]);
+		dev_kfree_skb(yp->tx_skbuff[i]);
 		yp->tx_skbuff[i] = NULL;
 	}

diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/ethernet/qualcomm/qca_spi.c
index b28360bc2255..5ecf61df78bd 100644
--- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -837,8 +837,7 @@ qcaspi_netdev_uninit(struct net_device *dev)

 	kfree(qca->rx_buffer);
 	qca->buffer_size = 0;
-	if (qca->rx_skb)
-		dev_kfree_skb(qca->rx_skb);
+	dev_kfree_skb(qca->rx_skb);
 }

 static const struct net_device_ops qcaspi_netdev_ops = {
diff --git a/drivers/net/ethernet/qualcomm/qca_uart.c b/drivers/net/ethernet/qualcomm/qca_uart.c
index 590616846cd1..0981068504fa 100644
--- a/drivers/net/ethernet/qualcomm/qca_uart.c
+++ b/drivers/net/ethernet/qualcomm/qca_uart.c
@@ -285,8 +285,7 @@ static void qcauart_netdev_uninit(struct net_device *dev)
 {
 	struct qcauart *qca = netdev_priv(dev);

-	if (qca->rx_skb)
-		dev_kfree_skb(qca->rx_skb);
+	dev_kfree_skb(qca->rx_skb);
 }

 static const struct net_device_ops qcauart_netdev_ops = {
diff --git a/drivers/net/ethernet/sgi/meth.c b/drivers/net/ethernet/sgi/meth.c
index 00660dd820e2..539bc5db989c 100644
--- a/drivers/net/ethernet/sgi/meth.c
+++ b/drivers/net/ethernet/sgi/meth.c
@@ -247,8 +247,7 @@ static void meth_free_tx_ring(struct meth_private *priv)

 	/* Remove any pending skb */
 	for (i = 0; i < TX_RING_ENTRIES; i++) {
-		if (priv->tx_skbs[i])
-			dev_kfree_skb(priv->tx_skbs[i]);
+		dev_kfree_skb(priv->tx_skbs[i]);
 		priv->tx_skbs[i] = NULL;
 	}
 	dma_free_coherent(&priv->pdev->dev, TX_RING_BUFFER_SIZE, priv->tx_ring,
diff --git a/drivers/net/ethernet/smsc/smc91x.c b/drivers/net/ethernet/smsc/smc91x.c
index 601e76ad99a0..3a6761131f4c 100644
--- a/drivers/net/ethernet/smsc/smc91x.c
+++ b/drivers/net/ethernet/smsc/smc91x.c
@@ -378,8 +378,7 @@ static void smc_shutdown(struct net_device *dev)
 	pending_skb = lp->pending_tx_skb;
 	lp->pending_tx_skb = NULL;
 	spin_unlock_irq(&lp->lock);
-	if (pending_skb)
-		dev_kfree_skb(pending_skb);
+	dev_kfree_skb(pending_skb);

 	/* and tell the card to stay away from that nasty outside world */
 	SMC_SELECT_BANK(lp, 0);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index bd1078433448..06ccd216ae90 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3519,8 +3519,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		if (unlikely(error && (status & rx_not_ls)))
 			goto read_again;
 		if (unlikely(error)) {
-			if (skb)
-				dev_kfree_skb(skb);
+			dev_kfree_skb(skb);
 			continue;
 		}

diff --git a/drivers/net/ethernet/sun/sunvnet_common.c b/drivers/net/ethernet/sun/sunvnet_common.c
index 646e67236b65..8b94d9ad9e2b 100644
--- a/drivers/net/ethernet/sun/sunvnet_common.c
+++ b/drivers/net/ethernet/sun/sunvnet_common.c
@@ -1532,8 +1532,7 @@ sunvnet_start_xmit_common(struct sk_buff *skb, struct net_device *dev,
 	else if (port)
 		del_timer(&port->clean_timer);
 	rcu_read_unlock();
-	if (skb)
-		dev_kfree_skb(skb);
+	dev_kfree_skb(skb);
 	vnet_free_skbs(freeskbs);
 	dev->stats.tx_dropped++;
 	return NETDEV_TX_OK;
--
2.23.0

