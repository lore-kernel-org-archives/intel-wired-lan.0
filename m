From: Alice Michael <alice.michael@intel.com>
Date: Wed,  7 Jun 2017 05:43:08 -0400
Subject: [Intel-wired-lan] [next PATCH S72-V3 08/13] i40e: genericize the
	partition bandwidth control
In-Reply-To: <20170607094313.32060-1-alice.michael@intel.com>
References: <20170607094313.32060-1-alice.michael@intel.com>
Message-ID: <20170607094313.32060-8-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

Partition bandwidth control is not in just one form of MFP (multi-function
partitioning), so make the code more generic and be sure to nudge the Tx
scheduler for all MFP.

Copyright updated to 2017.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h      | 13 +++++----
 drivers/net/ethernet/intel/i40e/i40e_main.c | 41 ++++++++++++++---------------
 2 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 4250ab5..76395e6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -1,7 +1,7 @@
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Driver
- * Copyright(c) 2013 - 2016 Intel Corporation.
+ * Copyright(c) 2013 - 2017 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -516,9 +516,8 @@ struct i40e_pf {
 	bool ptp_tx;
 	bool ptp_rx;
 	u16 rss_table_size; /* HW RSS table size */
-	/* These are only valid in NPAR modes */
-	u32 npar_max_bw;
-	u32 npar_min_bw;
+	u32 max_bw;
+	u32 min_bw;
 
 	u32 ioremap_len;
 	u32 fd_inv;
@@ -971,9 +970,9 @@ int i40e_ptp_get_ts_config(struct i40e_pf *pf, struct ifreq *ifr);
 void i40e_ptp_init(struct i40e_pf *pf);
 void i40e_ptp_stop(struct i40e_pf *pf);
 int i40e_is_vsi_uplink_mode_veb(struct i40e_vsi *vsi);
-i40e_status i40e_get_npar_bw_setting(struct i40e_pf *pf);
-i40e_status i40e_set_npar_bw_setting(struct i40e_pf *pf);
-i40e_status i40e_commit_npar_bw_setting(struct i40e_pf *pf);
+i40e_status i40e_get_partition_bw_setting(struct i40e_pf *pf);
+i40e_status i40e_set_partition_bw_setting(struct i40e_pf *pf);
+i40e_status i40e_commit_partition_bw_setting(struct i40e_pf *pf);
 void i40e_print_link_message(struct i40e_vsi *vsi, bool isup);
 
 static inline bool i40e_enabled_xdp_vsi(struct i40e_vsi *vsi)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 9f4763d..18a9be6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1,7 +1,7 @@
 /*******************************************************************************
  *
  * Intel Ethernet Controller XL710 Family Linux Driver
- * Copyright(c) 2013 - 2016 Intel Corporation.
+ * Copyright(c) 2013 - 2017 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -8739,10 +8739,10 @@ int i40e_reconfig_rss_queues(struct i40e_pf *pf, int queue_count)
 }
 
 /**
- * i40e_get_npar_bw_setting - Retrieve BW settings for this PF partition
+ * i40e_get_partition_bw_setting - Retrieve BW settings for this PF partition
  * @pf: board private structure
  **/
-i40e_status i40e_get_npar_bw_setting(struct i40e_pf *pf)
+i40e_status i40e_get_partition_bw_setting(struct i40e_pf *pf)
 {
 	i40e_status status;
 	bool min_valid, max_valid;
@@ -8753,27 +8753,27 @@ i40e_status i40e_get_npar_bw_setting(struct i40e_pf *pf)
 
 	if (!status) {
 		if (min_valid)
-			pf->npar_min_bw = min_bw;
+			pf->min_bw = min_bw;
 		if (max_valid)
-			pf->npar_max_bw = max_bw;
+			pf->max_bw = max_bw;
 	}
 
 	return status;
 }
 
 /**
- * i40e_set_npar_bw_setting - Set BW settings for this PF partition
+ * i40e_set_partition_bw_setting - Set BW settings for this PF partition
  * @pf: board private structure
  **/
-i40e_status i40e_set_npar_bw_setting(struct i40e_pf *pf)
+i40e_status i40e_set_partition_bw_setting(struct i40e_pf *pf)
 {
 	struct i40e_aqc_configure_partition_bw_data bw_data;
 	i40e_status status;
 
 	/* Set the valid bit for this PF */
 	bw_data.pf_valid_bits = cpu_to_le16(BIT(pf->hw.pf_id));
-	bw_data.max_bw[pf->hw.pf_id] = pf->npar_max_bw & I40E_ALT_BW_VALUE_MASK;
-	bw_data.min_bw[pf->hw.pf_id] = pf->npar_min_bw & I40E_ALT_BW_VALUE_MASK;
+	bw_data.max_bw[pf->hw.pf_id] = pf->max_bw & I40E_ALT_BW_VALUE_MASK;
+	bw_data.min_bw[pf->hw.pf_id] = pf->min_bw & I40E_ALT_BW_VALUE_MASK;
 
 	/* Set the new bandwidths */
 	status = i40e_aq_configure_partition_bw(&pf->hw, &bw_data, NULL);
@@ -8782,10 +8782,10 @@ i40e_status i40e_set_npar_bw_setting(struct i40e_pf *pf)
 }
 
 /**
- * i40e_commit_npar_bw_setting - Commit BW settings for this PF partition
+ * i40e_commit_partition_bw_setting - Commit BW settings for this PF partition
  * @pf: board private structure
  **/
-i40e_status i40e_commit_npar_bw_setting(struct i40e_pf *pf)
+i40e_status i40e_commit_partition_bw_setting(struct i40e_pf *pf)
 {
 	/* Commit temporary BW setting to permanent NVM image */
 	enum i40e_admin_queue_err last_aq_status;
@@ -8904,16 +8904,19 @@ static int i40e_sw_init(struct i40e_pf *pf)
 	if (pf->hw.func_caps.npar_enable || pf->hw.func_caps.flex10_enable) {
 		pf->flags |= I40E_FLAG_MFP_ENABLED;
 		dev_info(&pf->pdev->dev, "MFP mode Enabled\n");
-		if (i40e_get_npar_bw_setting(pf))
+		if (i40e_get_partition_bw_setting(pf)) {
 			dev_warn(&pf->pdev->dev,
-				 "Could not get NPAR bw settings\n");
-		else
+				 "Could not get partition bw settings\n");
+		} else {
 			dev_info(&pf->pdev->dev,
-				 "Min BW = %8.8x, Max BW = %8.8x\n",
-				 pf->npar_min_bw, pf->npar_max_bw);
+				 "Partition BW Min = %8.8x, Max = %8.8x\n",
+				 pf->min_bw, pf->max_bw);
+
+			/* nudge the Tx scheduler */
+			i40e_set_partition_bw_setting(pf);
+		}
 	}
 
-	/* FW/NVM is not yet fixed in this regard */
 	if ((pf->hw.func_caps.fd_filters_guaranteed > 0) ||
 	    (pf->hw.func_caps.fd_filters_best_effort > 0)) {
 		pf->flags |= I40E_FLAG_FD_ATR_ENABLED;
@@ -9016,10 +9019,6 @@ static int i40e_sw_init(struct i40e_pf *pf)
 
 	mutex_init(&pf->switch_mutex);
 
-	/* If NPAR is enabled nudge the Tx scheduler */
-	if (pf->hw.func_caps.npar_enable && (!i40e_get_npar_bw_setting(pf)))
-		i40e_set_npar_bw_setting(pf);
-
 sw_init_done:
 	return err;
 }
-- 
2.9.3

