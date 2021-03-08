From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 08 Mar 2021 12:41:56 -0800
Subject: [Intel-wired-lan] [net PATCH] ixgbe: Fix NULL pointer dereference
 in ethtool loopback test
Message-ID: <161523611656.36376.3641992659589167121.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexanderduyck@fb.com>

The ixgbe driver currently generates a NULL pointer dereference when
performing the ethtool loopback test. This is due to the fact that there
isn't a q_vector associated with the test ring when it is setup as
interrupts are not normally added to the test rings.

To address this I have added code that will check for a q_vector before
returning a napi_id value. If a q_vector is not present it will return a
value of 0.

Fixes: b02e5a0ebb17 ("xsk: Propagate napi_id to XDP socket Rx path")
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index fae84202d870..724cdd669957 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -6534,6 +6534,13 @@ static int ixgbe_setup_all_tx_resources(struct ixgbe_adapter *adapter)
 	return err;
 }
 
+static int ixgbe_rx_napi_id(struct ixgbe_ring *rx_ring)
+{
+	struct ixgbe_q_vector *q_vector = rx_ring->q_vector;
+
+	return q_vector ? q_vector->napi.napi_id : 0;
+}
+
 /**
  * ixgbe_setup_rx_resources - allocate Rx resources (Descriptors)
  * @adapter: pointer to ixgbe_adapter
@@ -6582,7 +6589,7 @@ int ixgbe_setup_rx_resources(struct ixgbe_adapter *adapter,
 
 	/* XDP RX-queue info */
 	if (xdp_rxq_info_reg(&rx_ring->xdp_rxq, adapter->netdev,
-			     rx_ring->queue_index, rx_ring->q_vector->napi.napi_id) < 0)
+			     rx_ring->queue_index, ixgbe_rx_napi_id(rx_ring)) < 0)
 		goto err;
 
 	rx_ring->xdp_prog = adapter->xdp_prog;


