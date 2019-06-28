From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 28 Jun 2019 08:03:21 -0700
Subject: [Intel-wired-lan] [PATCH S23 v2 03/15] ice: Assume that more than
 one Rx queue is rare in ice_napi_poll
In-Reply-To: <20190628150332.59155-1-anthony.l.nguyen@intel.com>
References: <20190628150332.59155-1-anthony.l.nguyen@intel.com>
Message-ID: <20190628150332.59155-3-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Currently we divide budget by the number of Rx queues per Rx ring
container in ice_napi_poll even if there is only 1. This is an
unnecessary divide for the normal case of 1 Rx ring per Rx ring
container. Fix this by using an unlikely() call in the case where we
actually need to divide.

Also, we will always set budget_per_ring even if there are no Rx rings
in the Rx ring container so we don't need to initialize it to 0.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index f625d9887f88..7229dea0b83f 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1717,8 +1717,8 @@ int ice_napi_poll(struct napi_struct *napi, int budget)
 				container_of(napi, struct ice_q_vector, napi);
 	struct ice_vsi *vsi = q_vector->vsi;
 	bool clean_complete = true;
-	int budget_per_ring = 0;
 	struct ice_ring *ring;
+	int budget_per_ring;
 	int work_done = 0;
 
 	/* Since the actual Tx work is minimal, we can give the Tx a larger
@@ -1737,11 +1737,16 @@ int ice_napi_poll(struct napi_struct *napi, int budget)
 	if (budget <= 0)
 		return budget;
 
-	/* We attempt to distribute budget to each Rx queue fairly, but don't
-	 * allow the budget to go below 1 because that would exit polling early.
-	 */
-	if (q_vector->num_ring_rx)
+	/* normally we have 1 Rx ring per q_vector */
+	if (unlikely(q_vector->num_ring_rx > 1))
+		/* We attempt to distribute budget to each Rx queue fairly, but
+		 * don't allow the budget to go below 1 because that would exit
+		 * polling early.
+		 */
 		budget_per_ring = max(budget / q_vector->num_ring_rx, 1);
+	else
+		/* Max of 1 Rx ring in this q_vector so give it the budget */
+		budget_per_ring = budget;
 
 	ice_for_each_ring(ring, q_vector->rx) {
 		int cleaned;
-- 
2.20.1

