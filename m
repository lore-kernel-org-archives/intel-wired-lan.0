From: Alice Michael <alice.michael@intel.com>
Date: Fri, 14 Jul 2017 09:10:08 -0400
Subject: [Intel-wired-lan] [next PATCH S76-V2 02/13] i40e: remove workaround
	for resetting XPS on newer kernels
In-Reply-To: <20170714131019.52530-1-alice.michael@intel.com>
References: <20170714131019.52530-1-alice.michael@intel.com>
Message-ID: <20170714131019.52530-2-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Since commit 3ffa037d7f78 ("i40e: Set XPS bit mask to zero in DCB mode")
we've tried to reset the XPS settings by building a custom
empty CPU mask.

This workaround is not necessary because we're not really removing the
XPS setting, but simply setting it so that no CPU is valid. Since v4.10
we've had this taken care of for us in the netdev core code.

We recently added a new macro to COMPAT which allows us to wrap the XPS
workaround when it's not necessary.

While we're doing this, we change the ordering of the calls, and add an
early return statement. This helps make the code easier to understand,
and reduces the headache of reading these #ifdefs. This should help
future maintainability.

Second, we shorten the code further by using zalloc_cpumask_var instead
of a separate call to bitmap_zero().

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 9ee1d0f..5004857 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -2875,22 +2875,15 @@ static void i40e_vsi_free_rx_resources(struct i40e_vsi *vsi)
 static void i40e_config_xps_tx_ring(struct i40e_ring *ring)
 {
 	struct i40e_vsi *vsi = ring->vsi;
-	cpumask_var_t mask;
 
 	if (!ring->q_vector || !ring->netdev)
 		return;
 
-	/* Single TC mode enable XPS */
-	if (vsi->tc_config.numtc <= 1) {
-		if (!test_and_set_bit(__I40E_TX_XPS_INIT_DONE, &ring->state))
-			netif_set_xps_queue(ring->netdev,
-					    &ring->q_vector->affinity_mask,
-					    ring->queue_index);
-	} else if (alloc_cpumask_var(&mask, GFP_KERNEL)) {
-		/* Disable XPS to allow selection based on TC */
-		bitmap_zero(cpumask_bits(mask), nr_cpumask_bits);
-		netif_set_xps_queue(ring->netdev, mask, ring->queue_index);
-		free_cpumask_var(mask);
+	if ((vsi->tc_config.numtc <= 1) &&
+	    !test_and_set_bit(__I40E_TX_XPS_INIT_DONE, &ring->state)) {
+		netif_set_xps_queue(ring->netdev,
+				    &ring->q_vector->affinity_mask,
+				    ring->queue_index);
 	}
 
 	/* schedule our worker thread which will take care of
-- 
2.9.3

