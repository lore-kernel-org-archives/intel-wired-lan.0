From: Benjamin Poirier <bpoirier@suse.com>
Date: Thu, 12 Jan 2017 17:04:14 -0800
Subject: [Intel-wired-lan] [PATCH] i40e: Invoke softirqs after
	napi_reschedule
Message-ID: <20170113010414.22708-1-bpoirier@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The following message is logged from time to time when using i40e:
NOHZ: local_softirq_pending 08

i40e may schedule napi from a workqueue. Afterwards, softirqs are not run
in a deterministic time frame. The problem is the same as what was
described in commit ec13ee80145c ("virtio_net: invoke softirqs after
__napi_schedule") and this patch applies the same fix to i40e.

Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index ad4cf63..d65488c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -4621,8 +4621,10 @@ static void i40e_detect_recover_hung_queue(int q_idx, struct i40e_vsi *vsi)
 	 */
 	if ((!tx_pending_hw) && i40e_get_tx_pending(tx_ring, true) &&
 	    (!(val & I40E_PFINT_DYN_CTLN_INTENA_MASK))) {
+		local_bh_disable();
 		if (napi_reschedule(&tx_ring->q_vector->napi))
 			tx_ring->tx_stats.tx_lost_interrupt++;
+		local_bh_enable();
 	}
 }
 
-- 
2.10.2

