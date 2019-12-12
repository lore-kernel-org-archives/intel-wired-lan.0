From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 12 Dec 2019 03:13:06 -0800
Subject: [Intel-wired-lan] [PATCH S35 14/15] ice: Add a boundary check in
 ice_xsk_umem()
In-Reply-To: <20191212111307.33566-1-anthony.l.nguyen@intel.com>
References: <20191212111307.33566-1-anthony.l.nguyen@intel.com>
Message-ID: <20191212111307.33566-14-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Krzysztof Kazimierczak <krzysztof.kazimierczak@intel.com>

In ice_xsk_umem(), variable qid which is later used as an array index,
is not validated for a possible boundary exceedance. Because of that,
a calling function might receive an invalid address, which causes
general protection fault when dereferenced.

To address this, add a boundary check to see if qid is greater than the
size of a UMEM array. Also, don't let user change vsi->num_xsk_umems
just by trying to setup a second UMEM if its value is already set up
(i.e. UMEM region has already been allocated for this VSI).

While at it, make sure that ring->zca.free pointer is always zeroed out
if there is no UMEM on a specified ring.

Signed-off-by: Krzysztof Kazimierczak <krzysztof.kazimierczak@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h      | 5 +++--
 drivers/net/ethernet/intel/ice/ice_base.c | 1 +
 drivers/net/ethernet/intel/ice/ice_xsk.c  | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index b2b1f7b1d932..3dc523fff034 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -476,12 +476,13 @@ static inline void ice_set_ring_xdp(struct ice_ring *ring)
 static inline struct xdp_umem *ice_xsk_umem(struct ice_ring *ring)
 {
 	struct xdp_umem **umems = ring->vsi->xsk_umems;
-	int qid = ring->q_index;
+	u16 qid = ring->q_index;
 
 	if (ice_ring_is_xdp(ring))
 		qid -= ring->vsi->num_xdp_txq;
 
-	if (!umems || !umems[qid] || !ice_is_xdp_ena_vsi(ring->vsi))
+	if (qid >= ring->vsi->num_xsk_umems || !umems || !umems[qid] ||
+	    !ice_is_xdp_ena_vsi(ring->vsi))
 		return NULL;
 
 	return umems[qid];
diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index d4559d45288f..25f2e0fb3833 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -326,6 +326,7 @@ int ice_setup_rx_ctx(struct ice_ring *ring)
 			dev_info(&vsi->back->pdev->dev, "Registered XDP mem model MEM_TYPE_ZERO_COPY on Rx ring %d\n",
 				 ring->q_index);
 		} else {
+			ring->zca.free = NULL;
 			if (!xdp_rxq_info_is_reg(&ring->xdp_rxq))
 				xdp_rxq_info_reg(&ring->xdp_rxq,
 						 ring->netdev,
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index cf9b8b22d24f..be787efaa9d5 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -414,7 +414,8 @@ ice_xsk_umem_enable(struct ice_vsi *vsi, struct xdp_umem *umem, u16 qid)
 	if (vsi->type != ICE_VSI_PF)
 		return -EINVAL;
 
-	vsi->num_xsk_umems = min_t(u16, vsi->num_rxq, vsi->num_txq);
+	if (!vsi->num_xsk_umems)
+		vsi->num_xsk_umems = min_t(u16, vsi->num_rxq, vsi->num_txq);
 	if (qid >= vsi->num_xsk_umems)
 		return -EINVAL;
 
-- 
2.20.1

