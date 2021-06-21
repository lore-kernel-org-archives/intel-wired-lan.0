From: =?unknown-8bit?q?J=C4=99drzej?= Jagielski <jedrzej.jagielski@intel.com>
Date: Mon, 21 Jun 2021 08:33:34 +0000
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix creation of first queue
 by omitting it if is not power of two
Message-ID: <1624264414-10328-1-git-send-email-jedrzej.jagielski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Reject TCs creation with proper message if the first queue
assignment is not equal to the power of two.
The first queue number was checked too late in the second queue
iteration, if second queue was configured at all. Now if first queue value
is not a power of two, then trying to create qdisc will be rejected.

Fixes: 8f88b3034db3 ("i40e: Add infrastructure for queue channel support")
Signed-off-by: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
Signed-off-by: J??drzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 59 ++++++++++-------------------
 1 file changed, 19 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 7a0a740..7ddd414 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5786,24 +5786,6 @@ static void i40e_remove_queue_channels(struct i40e_vsi *vsi)
 }
 
 /**
- * i40e_is_any_channel - channel exist or not
- * @vsi: ptr to VSI to which channels are associated with
- *
- * Returns true or false if channel(s) exist for associated VSI or not
- **/
-static bool i40e_is_any_channel(struct i40e_vsi *vsi)
-{
-	struct i40e_channel *ch, *ch_tmp;
-
-	list_for_each_entry_safe(ch, ch_tmp, &vsi->ch_list, list) {
-		if (ch->initialized)
-			return true;
-	}
-
-	return false;
-}
-
-/**
  * i40e_get_max_queues_for_channel
  * @vsi: ptr to VSI to which channels are associated with
  *
@@ -6309,26 +6291,15 @@ int i40e_create_queue_channel(struct i40e_vsi *vsi,
 	/* By default we are in VEPA mode, if this is the first VF/VMDq
 	 * VSI to be added switch to VEB mode.
 	 */
-	if ((!(pf->flags & I40E_FLAG_VEB_MODE_ENABLED)) ||
-	    (!i40e_is_any_channel(vsi))) {
-		if (!is_power_of_2(vsi->tc_config.tc_info[0].qcount)) {
-			dev_dbg(&pf->pdev->dev,
-				"Failed to create channel. Override queues (%u) not power of 2\n",
-				vsi->tc_config.tc_info[0].qcount);
-			return -EINVAL;
-		}
 
-		if (!(pf->flags & I40E_FLAG_VEB_MODE_ENABLED)) {
-			pf->flags |= I40E_FLAG_VEB_MODE_ENABLED;
+	if (!(pf->flags & I40E_FLAG_VEB_MODE_ENABLED)) {
+		pf->flags |= I40E_FLAG_VEB_MODE_ENABLED;
 
-			if (vsi->type == I40E_VSI_MAIN) {
-				if (pf->flags & I40E_FLAG_TC_MQPRIO)
-					i40e_do_reset(pf, I40E_PF_RESET_FLAG,
-						      true);
-				else
-					i40e_do_reset_safe(pf,
-							   I40E_PF_RESET_FLAG);
-			}
+		if (vsi->type == I40E_VSI_MAIN) {
+			if (pf->flags & I40E_FLAG_TC_MQPRIO)
+				i40e_do_reset(pf, I40E_PF_RESET_FLAG, true);
+			else
+				i40e_do_reset_safe(pf, I40E_PF_RESET_FLAG);
 		}
 		/* now onwards for main VSI, number of queues will be value
 		 * of TC0's queue count
@@ -7979,12 +7950,20 @@ config_tc:
 			    vsi->seid);
 		need_reset = true;
 		goto exit;
-	} else {
-		dev_info(&vsi->back->pdev->dev,
-			 "Setup channel (id:%u) utilizing num_queues %d\n",
-			 vsi->seid, vsi->tc_config.tc_info[0].qcount);
+	} else if (enabled_tc &&
+		   (!is_power_of_2(vsi->tc_config.tc_info[0].qcount))) {
+		netdev_info(netdev,
+			    "Failed to create channel. Override queues (%u) not power of 2\n",
+			    vsi->tc_config.tc_info[0].qcount);
+		ret = -EINVAL;
+		need_reset = true;
+		goto exit;
 	}
 
+	dev_info(&vsi->back->pdev->dev,
+		 "Setup channel (id:%u) utilizing num_queues %d\n",
+		 vsi->seid, vsi->tc_config.tc_info[0].qcount);
+
 	if (pf->flags & I40E_FLAG_TC_MQPRIO) {
 		if (vsi->mqprio_qopt.max_rate[0]) {
 			u64 max_tx_rate = vsi->mqprio_qopt.max_rate[0];
-- 
1.8.3.1

