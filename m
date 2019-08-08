From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu,  8 Aug 2019 07:39:28 -0700
Subject: [Intel-wired-lan] [PATCH S27 05/15] ice: Report stats when VSI is
 down
In-Reply-To: <20190808143938.4968-1-anthony.l.nguyen@intel.com>
References: <20190808143938.4968-1-anthony.l.nguyen@intel.com>
Message-ID: <20190808143938.4968-5-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Dave Ertman <david.m.ertman@intel.com>

There is currently a check in get_ndo_stats that
returns before updating stats if the VSI is down
or there are no Tx or Rx queues.  This causes the
netdev to report zero stats with the netdev is down.

Remove the check so that the behavior of reporting
stats is the same as it was in IXGBE.

Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index e0aa34064283..7514a3d2cd34 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3513,12 +3513,16 @@ void ice_get_stats64(struct net_device *netdev, struct rtnl_link_stats64 *stats)
 
 	vsi_stats = &vsi->net_stats;
 
-	if (test_bit(__ICE_DOWN, vsi->state) || !vsi->num_txq || !vsi->num_rxq)
+	if (!vsi->num_txq || !vsi->num_rxq)
 		return;
+
 	/* netdev packet/byte stats come from ring counter. These are obtained
 	 * by summing up ring counters (done by ice_update_vsi_ring_stats).
+	 * But, only call the update routine and read the registers if VSI is
+	 * not down.
 	 */
-	ice_update_vsi_ring_stats(vsi);
+	if (!test_bit(__ICE_DOWN, vsi->state))
+		ice_update_vsi_ring_stats(vsi);
 	stats->tx_packets = vsi_stats->tx_packets;
 	stats->tx_bytes = vsi_stats->tx_bytes;
 	stats->rx_packets = vsi_stats->rx_packets;
-- 
2.20.1

