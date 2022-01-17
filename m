From: Corinna Vinschen <vinschen@redhat.com>
Date: Mon, 17 Jan 2022 19:29:15 +0100
Subject: [Intel-wired-lan] [PATCH 3/3 net-next v5] igb/igc: RX queues: fix
 DMA leak in error case
In-Reply-To: <20220117182915.1283151-1-vinschen@redhat.com>
References: <20220117182915.1283151-1-vinschen@redhat.com>
Message-ID: <20220117182915.1283151-4-vinschen@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When setting up the rx queues, igb and igc neglect to free DMA memory
in error case.  Add matching dma_free_coherent calls.

Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 1 +
 drivers/net/ethernet/intel/igc/igc_main.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index cea89d301bfd..343568d4ff7f 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -4389,6 +4389,7 @@ int igb_setup_rx_resources(struct igb_ring *rx_ring)
 	return 0;
 
 err:
+	dma_free_coherent(dev, rx_ring->size, rx_ring->desc, rx_ring->dma);
 	vfree(rx_ring->rx_buffer_info);
 	rx_ring->rx_buffer_info = NULL;
 	dev_err(dev, "Unable to allocate memory for the Rx descriptor ring\n");
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 56ed0f1463e5..f323cec0b74f 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -540,6 +540,7 @@ int igc_setup_rx_resources(struct igc_ring *rx_ring)
 	return 0;
 
 err:
+	dma_free_coherent(dev, rx_ring->size, rx_ring->desc, rx_ring->dma);
 	vfree(rx_ring->rx_buffer_info);
 	rx_ring->rx_buffer_info = NULL;
 	netdev_err(ndev, "Unable to allocate memory for Rx descriptor ring\n");
-- 
2.27.0

