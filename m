From: Michal Wilczynski <michal.wilczynski@intel.com>
Date: Sun,  8 May 2022 19:33:48 -0400
Subject: [Intel-wired-lan] [PATCH net v1] ice: Fix interrupt moderation
 settings getting cleared
Message-ID: <20220508233348.546388-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Adaptive-rx and Adaptive-tx are interrupt moderation settings
that can be enabled/disabled using ethtool:
ethtool -C ethX adaptive-rx on/off adaptive-tx on/off

Unfortunately those settings are getting cleared after
changing number of queues, or in ethtool world 'channels':
ethtool -L ethX rx 1 tx 1

Clearing was happening due to introduction of bit fields
in ice_ring_container struct. This way only itr_setting
bits were rebuilt during ice_vsi_rebuild_set_coalesce().

Introduce an anonymous struct of bitfields and create a
union to refer to them as a single variable.
This way variable can be easily saved and restored.

Fixes: 61dc79ced7aa ("ice: Restore interrupt throttle settings after VSI rebuild")
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
Internal-review:

v4:
-Moved Singed-off-by tag to the end of the commit

v3:
-Added proper Fixes tag

v2:
-Changed argument to ice_write_itr to rc->itr_setting,
 instead of settings in order not to pass unnecessary bits

 drivers/net/ethernet/intel/ice/ice_lib.c  | 16 ++++++++--------
 drivers/net/ethernet/intel/ice/ice_txrx.h | 11 ++++++++---
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 6d19c58ccacd..454e01ae09b9 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -3043,8 +3043,8 @@ ice_vsi_rebuild_get_coalesce(struct ice_vsi *vsi,
 	ice_for_each_q_vector(vsi, i) {
 		struct ice_q_vector *q_vector = vsi->q_vectors[i];
 
-		coalesce[i].itr_tx = q_vector->tx.itr_setting;
-		coalesce[i].itr_rx = q_vector->rx.itr_setting;
+		coalesce[i].itr_tx = q_vector->tx.itr_settings;
+		coalesce[i].itr_rx = q_vector->rx.itr_settings;
 		coalesce[i].intrl = q_vector->intrl;
 
 		if (i < vsi->num_txq)
@@ -3100,21 +3100,21 @@ ice_vsi_rebuild_set_coalesce(struct ice_vsi *vsi,
 		 */
 		if (i < vsi->alloc_rxq && coalesce[i].rx_valid) {
 			rc = &vsi->q_vectors[i]->rx;
-			rc->itr_setting = coalesce[i].itr_rx;
+			rc->itr_settings = coalesce[i].itr_rx;
 			ice_write_itr(rc, rc->itr_setting);
 		} else if (i < vsi->alloc_rxq) {
 			rc = &vsi->q_vectors[i]->rx;
-			rc->itr_setting = coalesce[0].itr_rx;
+			rc->itr_settings = coalesce[0].itr_rx;
 			ice_write_itr(rc, rc->itr_setting);
 		}
 
 		if (i < vsi->alloc_txq && coalesce[i].tx_valid) {
 			rc = &vsi->q_vectors[i]->tx;
-			rc->itr_setting = coalesce[i].itr_tx;
+			rc->itr_settings = coalesce[i].itr_tx;
 			ice_write_itr(rc, rc->itr_setting);
 		} else if (i < vsi->alloc_txq) {
 			rc = &vsi->q_vectors[i]->tx;
-			rc->itr_setting = coalesce[0].itr_tx;
+			rc->itr_settings = coalesce[0].itr_tx;
 			ice_write_itr(rc, rc->itr_setting);
 		}
 
@@ -3128,12 +3128,12 @@ ice_vsi_rebuild_set_coalesce(struct ice_vsi *vsi,
 	for (; i < vsi->num_q_vectors; i++) {
 		/* transmit */
 		rc = &vsi->q_vectors[i]->tx;
-		rc->itr_setting = coalesce[0].itr_tx;
+		rc->itr_settings = coalesce[0].itr_tx;
 		ice_write_itr(rc, rc->itr_setting);
 
 		/* receive */
 		rc = &vsi->q_vectors[i]->rx;
-		rc->itr_setting = coalesce[0].itr_rx;
+		rc->itr_settings = coalesce[0].itr_rx;
 		ice_write_itr(rc, rc->itr_setting);
 
 		vsi->q_vectors[i]->intrl = coalesce[0].intrl;
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index f5a906c03669..ca902af54bb4 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -385,9 +385,14 @@ struct ice_ring_container {
 	/* this matches the maximum number of ITR bits, but in usec
 	 * values, so it is shifted left one bit (bit zero is ignored)
 	 */
-	u16 itr_setting:13;
-	u16 itr_reserved:2;
-	u16 itr_mode:1;
+	union {
+		struct {
+			u16 itr_setting:13;
+			u16 itr_reserved:2;
+			u16 itr_mode:1;
+		};
+		u16 itr_settings;
+	};
 	enum ice_container_type type;
 };
 
-- 
2.27.0

