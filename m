From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu,  8 Aug 2019 07:39:37 -0700
Subject: [Intel-wired-lan] [PATCH S27 14/15] ice: small efficiency fixes
In-Reply-To: <20190808143938.4968-1-anthony.l.nguyen@intel.com>
References: <20190808143938.4968-1-anthony.l.nguyen@intel.com>
Message-ID: <20190808143938.4968-14-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

Add a small bit of efficiency to the code by adding a
prefetch of the port_info structure in order to help
avoid a cache miss a little later on in execution.

Also add an unlikely statement to a branch which
generally will never happen in normal operation.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index ec581b1f0fcb..33dd103035dc 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1226,6 +1226,8 @@ ice_update_itr(struct ice_q_vector *q_vector, struct ice_ring_container *rc)
 	if (time_after(next_update, rc->next_update))
 		goto clear_counts;
 
+	prefetch(q_vector->vsi->port_info);
+
 	packets = rc->total_pkts;
 	bytes = rc->total_bytes;
 
@@ -1486,7 +1488,7 @@ int ice_napi_poll(struct napi_struct *napi, int budget)
 			clean_complete = false;
 
 	/* Handle case where we are called by netpoll with a budget of 0 */
-	if (budget <= 0)
+	if (unlikely(budget <= 0))
 		return budget;
 
 	/* normally we have 1 Rx ring per q_vector */
-- 
2.20.1

