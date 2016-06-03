From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri,  3 Jun 2016 15:42:19 -0700
Subject: [Intel-wired-lan] [PATCH v1 09/18] fm10k: wait for queues to drain
	fully before stop_hw
In-Reply-To: <20160603224228.10192-1-jacob.e.keller@intel.com>
References: <20160603224228.10192-1-jacob.e.keller@intel.com>
Message-ID: <20160603224228.10192-10-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

It turns out that VFs also suffer from the same queue issue as PFs, and
can't simply perform a datapath reset. Add a looping delay for queueus
which will sleep and then check the queues to see if they are drained
before calling stop_hw. If they take longer than 50 loops (~500ms,
longest delay I found necessary while testing), issue a dev_err message
and continue with the reset. For PFs, this should trigger a datapath
reset and a recovery. For VFs this will likely cause the VF to be stuck
and need re-creating. Unfortunately there isn't anything else the driver
can do in response.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k.h      |  1 +
 drivers/net/ethernet/intel/fm10k/fm10k_main.c |  2 +-
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c  | 37 +++++++++++++++++++++++----
 3 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k.h b/drivers/net/ethernet/intel/fm10k/fm10k.h
index c8d0817766bf..c4cf08dcf5af 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k.h
+++ b/drivers/net/ethernet/intel/fm10k/fm10k.h
@@ -458,6 +458,7 @@ __be16 fm10k_tx_encap_offload(struct sk_buff *skb);
 netdev_tx_t fm10k_xmit_frame_ring(struct sk_buff *skb,
 				  struct fm10k_ring *tx_ring);
 void fm10k_tx_timeout_reset(struct fm10k_intfc *interface);
+u64 fm10k_get_tx_pending(struct fm10k_ring *ring);
 bool fm10k_check_tx_hang(struct fm10k_ring *tx_ring);
 void fm10k_alloc_rx_buffers(struct fm10k_ring *rx_ring, u16 cleaned_count);
 
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index c6a464551577..c85fc98945fa 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -1128,7 +1128,7 @@ static u64 fm10k_get_tx_completed(struct fm10k_ring *ring)
 	return ring->stats.packets;
 }
 
-static u64 fm10k_get_tx_pending(struct fm10k_ring *ring)
+u64 fm10k_get_tx_pending(struct fm10k_ring *ring)
 {
 	struct fm10k_intfc *interface = ring->q_vector->interface;
 	struct fm10k_hw *hw = &interface->hw;
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 4dfd1284a8de..469122cdb7db 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -1613,7 +1613,7 @@ void fm10k_down(struct fm10k_intfc *interface)
 {
 	struct net_device *netdev = interface->netdev;
 	struct fm10k_hw *hw = &interface->hw;
-	int err;
+	int err, i = 0, count = 0;
 
 	/* signal that we are down to the interrupt handler and service task */
 	if (test_and_set_bit(__FM10K_DOWN, &interface->state))
@@ -1629,9 +1629,36 @@ void fm10k_down(struct fm10k_intfc *interface)
 	/* reset Rx filters */
 	fm10k_reset_rx_state(interface);
 
-	/* allow 10ms for device to quiesce */
-	usleep_range(10000, 20000);
+	/* skip waiting for TX DMA if we lost PCIe link */
+	if (FM10K_REMOVED(hw->hw_addr))
+		goto skip_tx_dma_drain;
 
+	/* in some circumstances it can take up to 500ms for the Tx queues to
+	 * quiesce and stop the Tx DMA engine. To avoid forcing a long sleep,
+	 * we'll repeat checking the Tx queues every few milliseconds. If we
+	 * exceed too long a delay we'll log an error message. For PF, this
+	 * should result in a data path reset. For VF, this may result in the
+	 * VF being disabled, as there is no equivalent data path reset.
+	 */
+#define TX_DMA_DRAIN_RETRIES 50
+	for (count = 0; count < TX_DMA_DRAIN_RETRIES; count++) {
+		usleep_range(10000, 20000);
+
+		/* start checking@the last ring to have pending Tx */
+		for (; i < interface->num_tx_queues; i++)
+			if (fm10k_get_tx_pending(interface->tx_ring[i]))
+				break;
+
+		/* if all the queues are drained, we can break now */
+		if (i == interface->num_tx_queues)
+			break;
+	}
+
+	if (count == TX_DMA_DRAIN_RETRIES)
+		dev_err(&interface->pdev->dev,
+			"Tx queues failed to drain after ~500ms. Tx DMA is probably hung.\n");
+
+skip_tx_dma_drain:
 	/* disable polling routines */
 	fm10k_napi_disable_all(interface);
 
@@ -1645,8 +1672,8 @@ void fm10k_down(struct fm10k_intfc *interface)
 	/* Disable DMA engine for Tx/Rx */
 	err = hw->mac.ops.stop_hw(hw);
 	if (err == FM10K_ERR_REQUESTS_PENDING)
-		dev_info(&interface->pdev->dev,
-			 "due to pending requests hw was not shut down gracefully\n");
+		dev_err(&interface->pdev->dev,
+			"due to pending requests hw was not shut down gracefully\n");
 	else if (err)
 		dev_err(&interface->pdev->dev, "stop_hw failed: %d\n", err);
 
-- 
2.8.2.820.gd1c5f70

