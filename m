From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed, 29 Jul 2020 17:19:14 -0700
Subject: [Intel-wired-lan] [PATCH S51 05/13] ice: add useful statistics
In-Reply-To: <20200730001922.52568-1-anthony.l.nguyen@intel.com>
References: <20200730001922.52568-1-anthony.l.nguyen@intel.com>
Message-ID: <20200730001922.52568-5-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

Display and count some useful hot-path statistics. The usefulness is as
follows:

- tx_restart: use to determine if the transmit ring size is too small or
  if the transmit interrupt rate is too low.
- rx_gro_dropped: use to count drops from GRO layer, which previously were
  completely uncounted when occurring.
- tx_busy: use to determine when the driver is miscounting number of
  descriptors needed for an skb.
- tx_timeout: as our other drivers, count the number of times we've reset
  due to timeout because the kernel only prints a warning once per netdev.

Several of these were already counted but not displayed.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h          | 1 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 4 ++++
 drivers/net/ethernet/intel/ice/ice_main.c     | 4 +++-
 drivers/net/ethernet/intel/ice/ice_txrx.h     | 1 +
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 7 ++++++-
 5 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 7d194d2a031a..fe140ff38f74 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -256,6 +256,7 @@ struct ice_vsi {
 	u32 tx_busy;
 	u32 rx_buf_failed;
 	u32 rx_page_failed;
+	u32 rx_gro_dropped;
 	u16 num_q_vectors;
 	u16 base_vector;		/* IRQ base for OS reserved vectors */
 	enum ice_vsi_type type;
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 06b93e97892d..9e8e9531cd87 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -59,8 +59,11 @@ static const struct ice_stats ice_gstrings_vsi_stats[] = {
 	ICE_VSI_STAT("rx_unknown_protocol", eth_stats.rx_unknown_protocol),
 	ICE_VSI_STAT("rx_alloc_fail", rx_buf_failed),
 	ICE_VSI_STAT("rx_pg_alloc_fail", rx_page_failed),
+	ICE_VSI_STAT("rx_gro_dropped", rx_gro_dropped),
 	ICE_VSI_STAT("tx_errors", eth_stats.tx_errors),
 	ICE_VSI_STAT("tx_linearize", tx_linearize),
+	ICE_VSI_STAT("tx_busy", tx_busy),
+	ICE_VSI_STAT("tx_restart", tx_restart),
 };
 
 enum ice_ethtool_test_id {
@@ -100,6 +103,7 @@ static const struct ice_stats ice_gstrings_pf_stats[] = {
 	ICE_PF_STAT("rx_broadcast.nic", stats.eth.rx_broadcast),
 	ICE_PF_STAT("tx_broadcast.nic", stats.eth.tx_broadcast),
 	ICE_PF_STAT("tx_errors.nic", stats.eth.tx_errors),
+	ICE_PF_STAT("tx_timeout.nic", tx_timeout_count),
 	ICE_PF_STAT("rx_size_64.nic", stats.rx_size_64),
 	ICE_PF_STAT("tx_size_64.nic", stats.tx_size_64),
 	ICE_PF_STAT("rx_size_127.nic", stats.rx_size_127),
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index bd2a2df25def..22bbd84eef64 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5290,6 +5290,7 @@ static void ice_update_vsi_ring_stats(struct ice_vsi *vsi)
 	vsi->tx_linearize = 0;
 	vsi->rx_buf_failed = 0;
 	vsi->rx_page_failed = 0;
+	vsi->rx_gro_dropped = 0;
 
 	rcu_read_lock();
 
@@ -5304,6 +5305,7 @@ static void ice_update_vsi_ring_stats(struct ice_vsi *vsi)
 		vsi_stats->rx_bytes += bytes;
 		vsi->rx_buf_failed += ring->rx_stats.alloc_buf_failed;
 		vsi->rx_page_failed += ring->rx_stats.alloc_page_failed;
+		vsi->rx_gro_dropped += ring->rx_stats.gro_dropped;
 	}
 
 	/* update XDP Tx rings counters */
@@ -5335,7 +5337,7 @@ void ice_update_vsi_stats(struct ice_vsi *vsi)
 	ice_update_eth_stats(vsi);
 
 	cur_ns->tx_errors = cur_es->tx_errors;
-	cur_ns->rx_dropped = cur_es->rx_discards;
+	cur_ns->rx_dropped = cur_es->rx_discards + vsi->rx_gro_dropped;
 	cur_ns->tx_dropped = cur_es->tx_discards;
 	cur_ns->multicast = cur_es->rx_multicast;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index 77c94daeb434..51b4df7a59d2 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -193,6 +193,7 @@ struct ice_rxq_stats {
 	u64 non_eop_descs;
 	u64 alloc_page_failed;
 	u64 alloc_buf_failed;
+	u64 gro_dropped; /* GRO returned dropped */
 };
 
 /* this enum matches hardware bits and is meant to be used by DYN_CTLN
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index 02b12736ea80..bc2f4390b51d 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -191,7 +191,12 @@ ice_receive_skb(struct ice_ring *rx_ring, struct sk_buff *skb, u16 vlan_tag)
 	if ((rx_ring->netdev->features & NETIF_F_HW_VLAN_CTAG_RX) &&
 	    (vlan_tag & VLAN_VID_MASK))
 		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vlan_tag);
-	napi_gro_receive(&rx_ring->q_vector->napi, skb);
+	if (napi_gro_receive(&rx_ring->q_vector->napi, skb) == GRO_DROP) {
+		/* this is tracked separately to help us debug stack drops */
+		rx_ring->rx_stats.gro_dropped++;
+		netdev_dbg(rx_ring->netdev, "Receive Queue %d: Dropped packet from GRO\n",
+			   rx_ring->q_index);
+	}
 }
 
 /**
-- 
2.20.1

