From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Tue, 23 Jul 2019 02:27:48 -0700
Subject: [Intel-wired-lan] [PATCH S24 01/12] ice: Allow egress control
 packets from PF_VSI
Message-ID: <20190723092759.3614-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Dave Ertman <david.m.ertman@intel.com>

For control packets (i.e. LLDP packets) to be able to egress
from the main VSI, a bit has to be set in the TX_descriptor.
This should only be done for the main VSI and only if the
FW LLDP agent is disabled.  A bit to allow this also has to
be set in the VSI context.

Add the logic to add the necessary bits in the VSI context
for the PF_VSI and the TX_descriptors for control packets
egressing the PF_VSI.

Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c  |  7 +++++++
 drivers/net/ethernet/intel/ice/ice_txrx.c | 11 ++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index a62496a74a69..6b5882c49004 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1021,6 +1021,13 @@ static int ice_vsi_init(struct ice_vsi *vsi, bool init_vsi)
 			ICE_AQ_VSI_SEC_FLAG_ENA_MAC_ANTI_SPOOF;
 	}
 
+	/* Allow control frames out of main VSI */
+	if (vsi->type == ICE_VSI_PF) {
+		ctxt->info.sec_flags |= ICE_AQ_VSI_SEC_FLAG_ALLOW_DEST_OVRD;
+		ctxt->info.valid_sections |=
+			cpu_to_le16(ICE_AQ_VSI_PROP_SECURITY_VALID);
+	}
+
 	if (init_vsi) {
 		ret = ice_add_vsi(hw, vsi->idx, ctxt, NULL);
 		if (ret) {
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index f612f1f53c67..7714c16ae689 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -2107,6 +2107,7 @@ static netdev_tx_t
 ice_xmit_frame_ring(struct sk_buff *skb, struct ice_ring *tx_ring)
 {
 	struct ice_tx_offload_params offload = { 0 };
+	struct ice_vsi *vsi = tx_ring->vsi;
 	struct ice_tx_buf *first;
 	unsigned int count;
 	int tso, csum;
@@ -2154,7 +2155,15 @@ ice_xmit_frame_ring(struct sk_buff *skb, struct ice_ring *tx_ring)
 	if (csum < 0)
 		goto out_drop;
 
-	if (tso || offload.cd_tunnel_params) {
+	/* allow CONTROL frames egress from main VSI if FW LLDP disabled */
+	if (unlikely(skb->priority == TC_PRIO_CONTROL &&
+		     vsi->type == ICE_VSI_PF &&
+		     vsi->port_info->is_sw_lldp))
+		offload.cd_qw1 |= (u64)(ICE_TX_DESC_DTYPE_CTX |
+					ICE_TX_CTX_DESC_SWTCH_UPLINK <<
+					ICE_TXD_CTX_QW1_CMD_S);
+
+	if (offload.cd_qw1 & ICE_TX_DESC_DTYPE_CTX) {
 		struct ice_tx_ctx_desc *cdesc;
 		int i = tx_ring->next_to_use;
 
-- 
2.20.1

