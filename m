From: Corinna Vinschen <vinschen@redhat.com>
Date: Fri, 14 Jan 2022 17:51:05 +0100
Subject: [Intel-wired-lan] [PATCH 1/2 net-next v3] igc: avoid kernel warning
 when changing RX ring parameters
In-Reply-To: <20220114165106.1085474-1-vinschen@redhat.com>
References: <20220114165106.1085474-1-vinschen@redhat.com>
Message-ID: <20220114165106.1085474-2-vinschen@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Calling ethtool changing the RX ring parameters like this:

  $ ethtool -G eth0 rx 1024

on igc triggers the "Missing unregister, handled but fix driver" warning in
xdp_rxq_info_reg().

igc_ethtool_set_ringparam() copies the igc_ring structure but neglects to
reset the xdp_rxq_info member before calling igc_setup_rx_resources().
This in turn calls xdp_rxq_info_reg() with an already registered xdp_rxq_info.

Make sure to unregister the xdp_rxq_info structure first in
igc_setup_rx_resources.  Move xdp_rxq_info handling down to bethe last
action, thus allowing to remove the xdp_rxq_info_unreg call in the error path.

Fixes: 73f1071c1d29 ("igc: Add support for XDP_TX action")
Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 2f17f36e94fd..97144f6db36e 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -505,14 +505,6 @@ int igc_setup_rx_resources(struct igc_ring *rx_ring)
 	u8 index = rx_ring->queue_index;
 	int size, desc_len, res;
 
-	res = xdp_rxq_info_reg(&rx_ring->xdp_rxq, ndev, index,
-			       rx_ring->q_vector->napi.napi_id);
-	if (res < 0) {
-		netdev_err(ndev, "Failed to register xdp_rxq index %u\n",
-			   index);
-		return res;
-	}
-
 	size = sizeof(struct igc_rx_buffer) * rx_ring->count;
 	rx_ring->rx_buffer_info = vzalloc(size);
 	if (!rx_ring->rx_buffer_info)
@@ -534,10 +526,20 @@ int igc_setup_rx_resources(struct igc_ring *rx_ring)
 	rx_ring->next_to_clean = 0;
 	rx_ring->next_to_use = 0;
 
+	/* XDP RX-queue info */
+	if (xdp_rxq_info_is_reg(&rx_ring->xdp_rxq))
+		xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
+	res = xdp_rxq_info_reg(&rx_ring->xdp_rxq, ndev, index,
+			       rx_ring->q_vector->napi.napi_id);
+	if (res < 0) {
+		netdev_err(ndev, "Failed to register xdp_rxq index %u\n",
+			   index);
+		return res;
+	}
+
 	return 0;
 
 err:
-	xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
 	vfree(rx_ring->rx_buffer_info);
 	rx_ring->rx_buffer_info = NULL;
 	netdev_err(ndev, "Unable to allocate memory for Rx descriptor ring\n");
-- 
2.27.0

