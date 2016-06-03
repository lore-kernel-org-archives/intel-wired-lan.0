From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri,  3 Jun 2016 15:42:12 -0700
Subject: [Intel-wired-lan] [PATCH v1 02/18] fm10k: avoid possible null
	pointer dereference in fm10k_update_stats
In-Reply-To: <20160603224228.10192-1-jacob.e.keller@intel.com>
References: <20160603224228.10192-1-jacob.e.keller@intel.com>
Message-ID: <20160603224228.10192-3-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

It's currently possible for fm10k_update_stats to be called during the
window when we go down and the rings are removed. This can result in
a null pointer dereference. In fm10k_get_stats64 we work around this by
using ACCESS_ONCE and a null pointer check inside the loop. Use this
same flow in the fm10k_update_stats to avoid the potential null pointer.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 610c313610c8..be0b7dea6e72 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -377,7 +377,10 @@ void fm10k_update_stats(struct fm10k_intfc *interface)
 
 	/* gather some stats to the interface struct that are per queue */
 	for (bytes = 0, pkts = 0, i = 0; i < interface->num_tx_queues; i++) {
-		struct fm10k_ring *tx_ring = interface->tx_ring[i];
+		struct fm10k_ring *tx_ring = READ_ONCE(interface->tx_ring[i]);
+
+		if (!tx_ring)
+			continue;
 
 		restart_queue += tx_ring->tx_stats.restart_queue;
 		tx_busy += tx_ring->tx_stats.tx_busy;
@@ -396,7 +399,10 @@ void fm10k_update_stats(struct fm10k_intfc *interface)
 
 	/* gather some stats to the interface struct that are per queue */
 	for (bytes = 0, pkts = 0, i = 0; i < interface->num_rx_queues; i++) {
-		struct fm10k_ring *rx_ring = interface->rx_ring[i];
+		struct fm10k_ring *rx_ring = READ_ONCE(interface->rx_ring[i]);
+
+		if (!rx_ring)
+			continue;
 
 		bytes += rx_ring->stats.bytes;
 		pkts += rx_ring->stats.packets;
-- 
2.8.2.820.gd1c5f70

