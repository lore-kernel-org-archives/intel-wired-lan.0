From: Alice Michael <alice.michael@intel.com>
Date: Thu,  7 Sep 2017 08:05:53 -0400
Subject: [Intel-wired-lan] [next PATCH S80-V3 08/11] i40e: allow XPS with
	QoS enabled
In-Reply-To: <20170907120556.45699-1-alice.michael@intel.com>
References: <20170907120556.45699-1-alice.michael@intel.com>
Message-ID: <20170907120556.45699-8-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Recently, the kernel gained support for enabling XPS and QoS at the
same time. Thus, we no longer need to worry about the number of
traffic classes when enabling XPS.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index a47f4ed..0dcae11 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -2879,23 +2879,18 @@ static void i40e_vsi_free_rx_resources(struct i40e_vsi *vsi)
  **/
 static void i40e_config_xps_tx_ring(struct i40e_ring *ring)
 {
-	struct i40e_vsi *vsi = ring->vsi;
 	int cpu;
 
 	if (!ring->q_vector || !ring->netdev)
 		return;
 
-	if ((vsi->tc_config.numtc <= 1) &&
-	    !test_and_set_bit(__I40E_TX_XPS_INIT_DONE, ring->state)) {
-		cpu = cpumask_local_spread(ring->q_vector->v_idx, -1);
-		netif_set_xps_queue(ring->netdev, get_cpu_mask(cpu),
-				    ring->queue_index);
-	}
+	/* We only initialize XPS once, so as not to overwrite user settings */
+	if (test_and_set_bit(__I40E_TX_XPS_INIT_DONE, ring->state))
+		return;
 
-	/* schedule our worker thread which will take care of
-	 * applying the new filter changes
-	 */
-	i40e_service_event_schedule(vsi->back);
+	cpu = cpumask_local_spread(ring->q_vector->v_idx, -1);
+	netif_set_xps_queue(ring->netdev, get_cpu_mask(cpu),
+			    ring->queue_index);
 }
 
 /**
-- 
2.9.4

