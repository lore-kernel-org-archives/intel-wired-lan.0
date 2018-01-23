From: Amritha Nambiar <amritha.nambiar@intel.com>
Date: Mon, 22 Jan 2018 16:19:35 -0800
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH] i40e: Fix channel
 addition in reset flow
Message-ID: <151666677499.45899.13180796073390048717.stgit@anamdev.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fix recreating the channel VSIs during the reset flow to reconfigure
the Tx rings and the queue context associated with the channel VSI.
Also update the next_base_queue for the VSI while rebuilding the
channel VSIs after a reset.

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 7808659..7be7d71 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -9083,6 +9083,17 @@ static int i40e_rebuild_channels(struct i40e_vsi *vsi)
 				 vsi->uplink_seid);
 			return ret;
 		}
+		/* Reconfigure TX queues using QTX_CTL register */
+		ret = i40e_channel_config_tx_ring(vsi->back, vsi, ch);
+		if (ret) {
+			dev_info(&vsi->back->pdev->dev,
+				 "failed to configure TX rings for channel %u\n",
+				 ch->seid);
+			return ret;
+		}
+		/* update 'next_base_queue' */
+		vsi->next_base_queue = vsi->next_base_queue +
+							ch->num_queue_pairs;
 		if (ch->max_tx_rate) {
 			u64 credits = ch->max_tx_rate;
 

