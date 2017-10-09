From: Alan Brady <alan.brady@intel.com>
Date: Mon,  9 Oct 2017 15:48:45 -0700
Subject: [Intel-wired-lan] [PATCH net-next] i40e: fix u64 division usage
Message-ID: <20171009224845.3216-1-alan.brady@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Commit 52eb1ff93e98 ("i40e: Add support setting TC max bandwidth rates")
and commit 1ea6f21ae530 ("i40e: Refactor VF BW rate limiting") add some
needed functionality for TC bandwidth rate limiting.  Unfortunately they
introduce several usages of unsigned 64-bit division which needs to be
handled special by the kernel to support all architectures.

Fixes: 52eb1ff93e98 ("i40e: Add support setting TC max bandwidth
rates")
Fixes: 1ea6f21ae530 ("i40e: Refactor VF BW rate limiting")

Signed-off-by: Alan Brady <alan.brady@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h      |  3 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c | 59 +++++++++++++++++++----------
 2 files changed, 42 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 266e1dc5e786..eb017763646d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -130,7 +130,8 @@
 
 /* BW rate limiting */
 #define I40E_BW_CREDIT_DIVISOR		50 /* 50Mbps per BW credit */
-#define I40E_MAX_BW_INACTIVE_ACCUM	4  /* accumulate 4 credits max */
+#define I40E_BW_MBPS_DIVISOR		125000 /* rate / (1000000 / 8) Mbps */
+#define I40E_MAX_BW_INACTIVE_ACCUM	4 /* accumulate 4 credits max */
 
 /* driver state flags */
 enum i40e_state_t {
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index b8ab17d18cd6..303c8885d987 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5442,6 +5442,7 @@ int i40e_get_link_speed(struct i40e_vsi *vsi)
 int i40e_set_bw_limit(struct i40e_vsi *vsi, u16 seid, u64 max_tx_rate)
 {
 	struct i40e_pf *pf = vsi->back;
+	u64 credits = 0;
 	int speed = 0;
 	int ret = 0;
 
@@ -5459,8 +5460,9 @@ int i40e_set_bw_limit(struct i40e_vsi *vsi, u16 seid, u64 max_tx_rate)
 	}
 
 	/* Tx rate credits are in values of 50Mbps, 0 is disabled */
-	ret = i40e_aq_config_vsi_bw_limit(&pf->hw, seid,
-					  max_tx_rate / I40E_BW_CREDIT_DIVISOR,
+	credits = max_tx_rate;
+	do_div(credits, I40E_BW_CREDIT_DIVISOR);
+	ret = i40e_aq_config_vsi_bw_limit(&pf->hw, seid, credits,
 					  I40E_MAX_BW_INACTIVE_ACCUM, NULL);
 	if (ret)
 		dev_err(&pf->pdev->dev,
@@ -6063,13 +6065,17 @@ int i40e_create_queue_channel(struct i40e_vsi *vsi,
 
 	/* configure VSI for BW limit */
 	if (ch->max_tx_rate) {
+		u64 credits = ch->max_tx_rate;
+
 		if (i40e_set_bw_limit(vsi, ch->seid, ch->max_tx_rate))
 			return -EINVAL;
 
+		do_div(credits, I40E_BW_CREDIT_DIVISOR);
 		dev_dbg(&pf->pdev->dev,
 			"Set tx rate of %llu Mbps (count of 50Mbps %llu) for vsi->seid %u\n",
 			ch->max_tx_rate,
-			ch->max_tx_rate / I40E_BW_CREDIT_DIVISOR, ch->seid);
+			credits,
+			ch->seid);
 	}
 
 	/* in case of VF, this will be main SRIOV VSI */
@@ -6090,6 +6096,7 @@ int i40e_create_queue_channel(struct i40e_vsi *vsi,
 static int i40e_configure_queue_channels(struct i40e_vsi *vsi)
 {
 	struct i40e_channel *ch;
+	u64 max_rate = 0;
 	int ret = 0, i;
 
 	/* Create app vsi with the TCs. Main VSI with TC0 is already set up */
@@ -6110,8 +6117,9 @@ static int i40e_configure_queue_channels(struct i40e_vsi *vsi)
 			/* Bandwidth limit through tc interface is in bytes/s,
 			 * change to Mbit/s
 			 */
-			ch->max_tx_rate =
-				vsi->mqprio_qopt.max_rate[i] / (1000000 / 8);
+			max_rate = vsi->mqprio_qopt.max_rate[i];
+			do_div(max_rate, I40E_BW_MBPS_DIVISOR);
+			ch->max_tx_rate = max_rate;
 
 			list_add_tail(&ch->list, &vsi->ch_list);
 
@@ -6540,6 +6548,7 @@ static int i40e_validate_mqprio_qopt(struct i40e_vsi *vsi,
 				     struct tc_mqprio_qopt_offload *mqprio_qopt)
 {
 	u64 sum_max_rate = 0;
+	u64 max_rate = 0;
 	int i;
 
 	if ((mqprio_qopt->qopt.offset[0] != 0) ||
@@ -6554,7 +6563,9 @@ static int i40e_validate_mqprio_qopt(struct i40e_vsi *vsi,
 				"Invalid min tx rate (greater than 0) specified\n");
 			return -EINVAL;
 		}
-		sum_max_rate += (mqprio_qopt->max_rate[i] / (1000000 / 8));
+		max_rate = mqprio_qopt->max_rate[i];
+		do_div(max_rate, I40E_BW_MBPS_DIVISOR);
+		sum_max_rate += max_rate;
 
 		if (i >= mqprio_qopt->qopt.num_tc - 1)
 			break;
@@ -6698,14 +6709,18 @@ static int i40e_setup_tc(struct net_device *netdev, void *type_data)
 
 	if (pf->flags & I40E_FLAG_TC_MQPRIO) {
 		if (vsi->mqprio_qopt.max_rate[0]) {
-			u64 max_tx_rate = vsi->mqprio_qopt.max_rate[0] /
-								(1000000 / 8);
+			u64 max_tx_rate = vsi->mqprio_qopt.max_rate[0];
+
+			do_div(max_tx_rate, I40E_BW_MBPS_DIVISOR);
 			ret = i40e_set_bw_limit(vsi, vsi->seid, max_tx_rate);
 			if (!ret) {
+				u64 credits = max_tx_rate;
+
+				do_div(credits, I40E_BW_CREDIT_DIVISOR);
 				dev_dbg(&vsi->back->pdev->dev,
 					"Set tx rate of %llu Mbps (count of 50Mbps %llu) for vsi->seid %u\n",
 					max_tx_rate,
-					max_tx_rate / I40E_BW_CREDIT_DIVISOR,
+					credits,
 					vsi->seid);
 			} else {
 				need_reset = true;
@@ -8166,15 +8181,17 @@ static int i40e_rebuild_channels(struct i40e_vsi *vsi)
 			return ret;
 		}
 		if (ch->max_tx_rate) {
+			u64 credits = ch->max_tx_rate;
+
 			if (i40e_set_bw_limit(vsi, ch->seid,
 					      ch->max_tx_rate))
 				return -EINVAL;
 
+			do_div(credits, I40E_BW_CREDIT_DIVISOR);
 			dev_dbg(&vsi->back->pdev->dev,
 				"Set tx rate of %llu Mbps (count of 50Mbps %llu) for vsi->seid %u\n",
 				ch->max_tx_rate,
-				ch->max_tx_rate /
-						I40E_BW_CREDIT_DIVISOR,
+				credits,
 				ch->seid);
 		}
 	}
@@ -8447,17 +8464,21 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
 	}
 
 	if (vsi->mqprio_qopt.max_rate[0]) {
-		u64 max_tx_rate = vsi->mqprio_qopt.max_rate[0] / (1000000 / 8);
+		u64 max_tx_rate = vsi->mqprio_qopt.max_rate[0];
+		u64 credits = 0;
 
+		do_div(max_tx_rate, I40E_BW_MBPS_DIVISOR);
 		ret = i40e_set_bw_limit(vsi, vsi->seid, max_tx_rate);
-		if (!ret)
-			dev_dbg(&vsi->back->pdev->dev,
-				"Set tx rate of %llu Mbps (count of 50Mbps %llu) for vsi->seid %u\n",
-				max_tx_rate,
-				max_tx_rate / I40E_BW_CREDIT_DIVISOR,
-				vsi->seid);
-		else
+		if (ret)
 			goto end_unlock;
+
+		credits = max_tx_rate;
+		do_div(credits, I40E_BW_CREDIT_DIVISOR);
+		dev_dbg(&vsi->back->pdev->dev,
+			"Set tx rate of %llu Mbps (count of 50Mbps %llu) for vsi->seid %u\n",
+			max_tx_rate,
+			credits,
+			vsi->seid);
 	}
 
 	/* PF Main VSI is rebuild by now, go ahead and rebuild channel VSIs
-- 
2.14.1

