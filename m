From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 25 Mar 2021 15:35:16 -0700
Subject: [Intel-wired-lan] [PATCH S57 13/14] ice: Remove rx_gro_dropped stat
In-Reply-To: <20210325223517.17722-1-anthony.l.nguyen@intel.com>
References: <20210325223517.17722-1-anthony.l.nguyen@intel.com>
Message-ID: <20210325223517.17722-13-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>

Tracking of the rx_gro_dropped statistic was removed in
commit f73fc40327c0 ("ice: drop dead code in ice_receive_skb()").
Remove the associated variables and its reporting to ethtool stats.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h         | 1 -
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 1 -
 drivers/net/ethernet/intel/ice/ice_main.c    | 4 +---
 drivers/net/ethernet/intel/ice/ice_txrx.h    | 1 -
 4 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 79652b72c38b..a3289dc3bcbf 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -266,7 +266,6 @@ struct ice_vsi {
 	u32 tx_busy;
 	u32 rx_buf_failed;
 	u32 rx_page_failed;
-	u32 rx_gro_dropped;
 	u16 num_q_vectors;
 	u16 base_vector;		/* IRQ base for OS reserved vectors */
 	enum ice_vsi_type type;
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index d5b20764d24a..f2bc8f1e86cc 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -60,7 +60,6 @@ static const struct ice_stats ice_gstrings_vsi_stats[] = {
 	ICE_VSI_STAT("rx_unknown_protocol", eth_stats.rx_unknown_protocol),
 	ICE_VSI_STAT("rx_alloc_fail", rx_buf_failed),
 	ICE_VSI_STAT("rx_pg_alloc_fail", rx_page_failed),
-	ICE_VSI_STAT("rx_gro_dropped", rx_gro_dropped),
 	ICE_VSI_STAT("tx_errors", eth_stats.tx_errors),
 	ICE_VSI_STAT("tx_linearize", tx_linearize),
 	ICE_VSI_STAT("tx_busy", tx_busy),
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d84a0e05a0c0..b3229202a300 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5375,7 +5375,6 @@ static void ice_update_vsi_ring_stats(struct ice_vsi *vsi)
 	vsi->tx_linearize = 0;
 	vsi->rx_buf_failed = 0;
 	vsi->rx_page_failed = 0;
-	vsi->rx_gro_dropped = 0;
 
 	rcu_read_lock();
 
@@ -5390,7 +5389,6 @@ static void ice_update_vsi_ring_stats(struct ice_vsi *vsi)
 		vsi_stats->rx_bytes += bytes;
 		vsi->rx_buf_failed += ring->rx_stats.alloc_buf_failed;
 		vsi->rx_page_failed += ring->rx_stats.alloc_page_failed;
-		vsi->rx_gro_dropped += ring->rx_stats.gro_dropped;
 	}
 
 	/* update XDP Tx rings counters */
@@ -5422,7 +5420,7 @@ void ice_update_vsi_stats(struct ice_vsi *vsi)
 	ice_update_eth_stats(vsi);
 
 	cur_ns->tx_errors = cur_es->tx_errors;
-	cur_ns->rx_dropped = cur_es->rx_discards + vsi->rx_gro_dropped;
+	cur_ns->rx_dropped = cur_es->rx_discards;
 	cur_ns->tx_dropped = cur_es->tx_discards;
 	cur_ns->multicast = cur_es->rx_multicast;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index a13eb8cf1731..681cc4a3ece7 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -192,7 +192,6 @@ struct ice_rxq_stats {
 	u64 non_eop_descs;
 	u64 alloc_page_failed;
 	u64 alloc_buf_failed;
-	u64 gro_dropped; /* GRO returned dropped */
 };
 
 enum ice_ring_state_t {
-- 
2.20.1

