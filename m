From: Wilczynski, Michal <michal.wilczynski@intel.com>
Date: Thu, 5 May 2022 08:32:16 +0200
Subject: [Intel-wired-lan] [PATCH net v4] ice: Fix interrupt moderation
 settings getting cleared
In-Reply-To: <20220420075452.126-1-michal.wilczynski@intel.com>
References: <20220420075452.126-1-michal.wilczynski@intel.com>
Message-ID: <b5307c42-8f1c-228a-a3c8-17d65f3b9def@intel.com>
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

v4:
-Moved Singed-off-by tag to the end of the commit

v3:
-Added proper Fixes tag

v2:
-Changed argument to ice_write_itr to rc->itr_setting,
instead of settings in order not to pass unnecessary bits

Fixes: 61dc79ced7aa ("ice: Restore interrupt throttle settings after VSI 
rebuild")
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
drivers/net/ethernet/intel/ice/ice_lib.c | 16 ++++++++--------
drivers/net/ethernet/intel/ice/ice_txrx.h | 11 ++++++++---
2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c 
b/drivers/net/ethernet/intel/ice/ice_lib.c
index b897926f817d..8c2c3b164df0 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -3037,8 +3037,8 @@ ice_vsi_rebuild_get_coalesce(struct ice_vsi *vsi,
ice_for_each_q_vector(vsi, i) {
struct ice_q_vector *q_vector = vsi->q_vectors[i];
- coalesce[i].itr_tx = q_vector->tx.itr_setting;
- coalesce[i].itr_rx = q_vector->rx.itr_setting;
+ coalesce[i].itr_tx = q_vector->tx.itr_settings;
+ coalesce[i].itr_rx = q_vector->rx.itr_settings;
coalesce[i].intrl = q_vector->intrl;
if (i < vsi->num_txq)
@@ -3094,21 +3094,21 @@ ice_vsi_rebuild_set_coalesce(struct ice_vsi *vsi,
*/
if (i < vsi->alloc_rxq && coalesce[i].rx_valid) {
rc = &vsi->q_vectors[i]->rx;
- rc->itr_setting = coalesce[i].itr_rx;
+ rc->itr_settings = coalesce[i].itr_rx;
ice_write_itr(rc, rc->itr_setting);
} else if (i < vsi->alloc_rxq) {
rc = &vsi->q_vectors[i]->rx;
- rc->itr_setting = coalesce[0].itr_rx;
+ rc->itr_settings = coalesce[0].itr_rx;
ice_write_itr(rc, rc->itr_setting);
}
if (i < vsi->alloc_txq && coalesce[i].tx_valid) {
rc = &vsi->q_vectors[i]->tx;
- rc->itr_setting = coalesce[i].itr_tx;
+ rc->itr_settings = coalesce[i].itr_tx;
ice_write_itr(rc, rc->itr_setting);
} else if (i < vsi->alloc_txq) {
rc = &vsi->q_vectors[i]->tx;
- rc->itr_setting = coalesce[0].itr_tx;
+ rc->itr_settings = coalesce[0].itr_tx;
ice_write_itr(rc, rc->itr_setting);
}
@@ -3122,12 +3122,12 @@ ice_vsi_rebuild_set_coalesce(struct ice_vsi *vsi,
for (; i < vsi->num_q_vectors; i++) {
/* transmit */
rc = &vsi->q_vectors[i]->tx;
- rc->itr_setting = coalesce[0].itr_tx;
+ rc->itr_settings = coalesce[0].itr_tx;
ice_write_itr(rc, rc->itr_setting);
/* receive */
rc = &vsi->q_vectors[i]->rx;
- rc->itr_setting = coalesce[0].itr_rx;
+ rc->itr_settings = coalesce[0].itr_rx;
ice_write_itr(rc, rc->itr_setting);
vsi->q_vectors[i]->intrl = coalesce[0].intrl;
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h 
b/drivers/net/ethernet/intel/ice/ice_txrx.h
index cead3eb149bd..ffb3f6a589da 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -384,9 +384,14 @@ struct ice_ring_container {
/* this matches the maximum number of ITR bits, but in usec
* values, so it is shifted left one bit (bit zero is ignored)
*/
- u16 itr_setting:13;
- u16 itr_reserved:2;
- u16 itr_mode:1;
+ union {
+ struct {
+ u16 itr_setting:13;
+ u16 itr_reserved:2;
+ u16 itr_mode:1;
+ };
+ u16 itr_settings;
+ };
enum ice_container_type type;
};

-- 
2.27.0

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.
