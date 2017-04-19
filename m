From: Alice Michael <alice.michael@intel.com>
Date: Wed, 19 Apr 2017 09:25:51 -0400
Subject: [Intel-wired-lan] [next PATCH S71 02/10] i40e: Reprogram port
	offloads after reset
In-Reply-To: <20170419132559.20459-1-alice.michael@intel.com>
References: <20170419132559.20459-1-alice.michael@intel.com>
Message-ID: <20170419132559.20459-2-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

This patch corrects a major oversight in that we were not reprogramming the
ports after a reset.  As a result we completely lost all of the Rx tunnel
offloads on receive including Rx checksum, RSS on inner headers, and ATR.

The fix for this is pretty standard as all we needed to do is reset the
filter bits to pending for all active filters and schedule the sync event.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 0630442..f44affc 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -7331,6 +7331,23 @@ static void i40e_handle_mdd_event(struct i40e_pf *pf)
 }
 
 /**
+ * i40e_sync_udp_filters - Trigger a sync event for existing UDP filters
+ * @pf: board private structure
+ **/
+static void i40e_sync_udp_filters(struct i40e_pf *pf)
+{
+	int i;
+
+	/* loop through and set pending bit for all active UDP filters */
+	for (i = 0; i < I40E_MAX_PF_UDP_OFFLOAD_PORTS; i++) {
+		if (pf->udp_ports[i].port)
+			pf->pending_udp_bitmap |= BIT_ULL(i);
+	}
+
+	pf->flags |= I40E_FLAG_UDP_FILTER_SYNC;
+}
+
+/**
  * i40e_sync_udp_filters_subtask - Sync the VSI filter list with HW
  * @pf: board private structure
  **/
@@ -10738,6 +10755,9 @@ static int i40e_setup_pf_switch(struct i40e_pf *pf, bool reinit)
 
 	i40e_ptp_init(pf);
 
+	/* repopulate tunnel port filters */
+	i40e_sync_udp_filters(pf);
+
 	return ret;
 }
 
-- 
2.9.3

