From: Alice Michael <alice.michael@intel.com>
Date: Tue, 14 May 2019 10:37:04 -0700
Subject: [Intel-wired-lan] [next PATCH S5 iavf 06/11] iavf: Move commands
 processing to the separate function
In-Reply-To: <20190514173709.62431-1-alice.michael@intel.com>
References: <20190514173709.62431-1-alice.michael@intel.com>
Message-ID: <20190514173709.62431-6-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jakub Pawlak <jakub.pawlak@intel.com>

Move the commands processing outside the watchdog_task()
function. This reduce length and complexity of the function
which is mainly designed to process the watchdog state machine.

Signed-off-by: Jakub Pawlak <jakub.pawlak@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 197 +++++++++++---------
 1 file changed, 105 insertions(+), 92 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 8a37b9f604e2..f1b51d87ee71 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1546,123 +1546,66 @@ static void iavf_watchdog_timer(struct timer_list *t)
 }
 
 /**
- * iavf_watchdog_task - Periodic call-back task
- * @work: pointer to work_struct
+ * iavf_process_aq_command - process aq_required flags
+ * and sends aq command
+ * @adapter: pointer to iavf adapter structure
+ *
+ * Returns 0 on success
+ * Returns error code if no command was sent
+ * or error code if the command failed.
  **/
-static void iavf_watchdog_task(struct work_struct *work)
+static int iavf_process_aq_command(struct iavf_adapter *adapter)
 {
-	struct iavf_adapter *adapter = container_of(work,
-						      struct iavf_adapter,
-						      watchdog_task);
-	struct iavf_hw *hw = &adapter->hw;
-	u32 reg_val;
-
-	if (test_and_set_bit(__IAVF_IN_CRITICAL_TASK, &adapter->crit_section))
-		goto restart_watchdog;
-
-	if (adapter->flags & IAVF_FLAG_PF_COMMS_FAILED) {
-		reg_val = rd32(hw, IAVF_VFGEN_RSTAT) &
-			  IAVF_VFGEN_RSTAT_VFR_STATE_MASK;
-		if ((reg_val == VIRTCHNL_VFR_VFACTIVE) ||
-		    (reg_val == VIRTCHNL_VFR_COMPLETED)) {
-			/* A chance for redemption! */
-			dev_err(&adapter->pdev->dev, "Hardware came out of reset. Attempting reinit.\n");
-			adapter->state = __IAVF_STARTUP;
-			adapter->flags &= ~IAVF_FLAG_PF_COMMS_FAILED;
-			schedule_delayed_work(&adapter->init_task, 10);
-			clear_bit(__IAVF_IN_CRITICAL_TASK,
-				  &adapter->crit_section);
-			/* Don't reschedule the watchdog, since we've restarted
-			 * the init task. When init_task contacts the PF and
-			 * gets everything set up again, it'll restart the
-			 * watchdog for us. Down, boy. Sit. Stay. Woof.
-			 */
-			return;
-		}
-		adapter->aq_required = 0;
-		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
-		goto watchdog_done;
-	}
-
-	if ((adapter->state < __IAVF_DOWN) ||
-	    (adapter->flags & IAVF_FLAG_RESET_PENDING))
-		goto watchdog_done;
-
-	/* check for reset */
-	reg_val = rd32(hw, IAVF_VF_ARQLEN1) & IAVF_VF_ARQLEN1_ARQENABLE_MASK;
-	if (!(adapter->flags & IAVF_FLAG_RESET_PENDING) && !reg_val) {
-		adapter->state = __IAVF_RESETTING;
-		adapter->flags |= IAVF_FLAG_RESET_PENDING;
-		dev_err(&adapter->pdev->dev, "Hardware reset detected\n");
-		schedule_work(&adapter->reset_task);
-		adapter->aq_required = 0;
-		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
-		goto watchdog_done;
-	}
-
-	/* Process admin queue tasks. After init, everything gets done
-	 * here so we don't race on the admin queue.
-	 */
-	if (adapter->current_op) {
-		if (!iavf_asq_done(hw)) {
-			dev_dbg(&adapter->pdev->dev, "Admin queue timeout\n");
-			iavf_send_api_ver(adapter);
-		}
-		goto watchdog_done;
-	}
-	if (adapter->aq_required & IAVF_FLAG_AQ_GET_CONFIG) {
-		iavf_send_vf_config_msg(adapter);
-		goto watchdog_done;
-	}
-
+	if (adapter->aq_required & IAVF_FLAG_AQ_GET_CONFIG)
+		return iavf_send_vf_config_msg(adapter);
 	if (adapter->aq_required & IAVF_FLAG_AQ_DISABLE_QUEUES) {
 		iavf_disable_queues(adapter);
-		goto watchdog_done;
+		return 0;
 	}
 
 	if (adapter->aq_required & IAVF_FLAG_AQ_MAP_VECTORS) {
 		iavf_map_queues(adapter);
-		goto watchdog_done;
+		return 0;
 	}
 
 	if (adapter->aq_required & IAVF_FLAG_AQ_ADD_MAC_FILTER) {
 		iavf_add_ether_addrs(adapter);
-		goto watchdog_done;
+		return 0;
 	}
 
 	if (adapter->aq_required & IAVF_FLAG_AQ_ADD_VLAN_FILTER) {
 		iavf_add_vlans(adapter);
-		goto watchdog_done;
+		return 0;
 	}
 
 	if (adapter->aq_required & IAVF_FLAG_AQ_DEL_MAC_FILTER) {
 		iavf_del_ether_addrs(adapter);
-		goto watchdog_done;
+		return 0;
 	}
 
 	if (adapter->aq_required & IAVF_FLAG_AQ_DEL_VLAN_FILTER) {
 		iavf_del_vlans(adapter);
-		goto watchdog_done;
+		return 0;
 	}
 
 	if (adapter->aq_required & IAVF_FLAG_AQ_ENABLE_VLAN_STRIPPING) {
 		iavf_enable_vlan_stripping(adapter);
-		goto watchdog_done;
+		return 0;
 	}
 
 	if (adapter->aq_required & IAVF_FLAG_AQ_DISABLE_VLAN_STRIPPING) {
 		iavf_disable_vlan_stripping(adapter);
-		goto watchdog_done;
+		return 0;
 	}
 
 	if (adapter->aq_required & IAVF_FLAG_AQ_CONFIGURE_QUEUES) {
 		iavf_configure_queues(adapter);
-		goto watchdog_done;
+		return 0;
 	}
 
 	if (adapter->aq_required & IAVF_FLAG_AQ_ENABLE_QUEUES) {
 		iavf_enable_queues(adapter);
-		goto watchdog_done;
+		return 0;
 	}
 
 	if (adapter->aq_required & IAVF_FLAG_AQ_CONFIGURE_RSS) {
@@ -1670,68 +1613,138 @@ static void iavf_watchdog_task(struct work_struct *work)
 		 * PF, so we don't have to set current_op as we will
 		 * not get a response through the ARQ.
 		 */
-		iavf_init_rss(adapter);
 		adapter->aq_required &= ~IAVF_FLAG_AQ_CONFIGURE_RSS;
-		goto watchdog_done;
+		return 0;
 	}
 	if (adapter->aq_required & IAVF_FLAG_AQ_GET_HENA) {
 		iavf_get_hena(adapter);
-		goto watchdog_done;
+		return 0;
 	}
 	if (adapter->aq_required & IAVF_FLAG_AQ_SET_HENA) {
 		iavf_set_hena(adapter);
-		goto watchdog_done;
+		return 0;
 	}
 	if (adapter->aq_required & IAVF_FLAG_AQ_SET_RSS_KEY) {
 		iavf_set_rss_key(adapter);
-		goto watchdog_done;
+		return 0;
 	}
 	if (adapter->aq_required & IAVF_FLAG_AQ_SET_RSS_LUT) {
 		iavf_set_rss_lut(adapter);
-		goto watchdog_done;
+		return 0;
 	}
 
 	if (adapter->aq_required & IAVF_FLAG_AQ_REQUEST_PROMISC) {
 		iavf_set_promiscuous(adapter, FLAG_VF_UNICAST_PROMISC |
 				       FLAG_VF_MULTICAST_PROMISC);
-		goto watchdog_done;
+		return 0;
 	}
 
 	if (adapter->aq_required & IAVF_FLAG_AQ_REQUEST_ALLMULTI) {
 		iavf_set_promiscuous(adapter, FLAG_VF_MULTICAST_PROMISC);
-		goto watchdog_done;
+		return 0;
 	}
 
 	if ((adapter->aq_required & IAVF_FLAG_AQ_RELEASE_PROMISC) &&
 	    (adapter->aq_required & IAVF_FLAG_AQ_RELEASE_ALLMULTI)) {
 		iavf_set_promiscuous(adapter, 0);
-		goto watchdog_done;
+		return 0;
 	}
 
 	if (adapter->aq_required & IAVF_FLAG_AQ_ENABLE_CHANNELS) {
 		iavf_enable_channels(adapter);
-		goto watchdog_done;
+		return 0;
 	}
 
 	if (adapter->aq_required & IAVF_FLAG_AQ_DISABLE_CHANNELS) {
 		iavf_disable_channels(adapter);
-		goto watchdog_done;
+		return 0;
 	}
-
 	if (adapter->aq_required & IAVF_FLAG_AQ_ADD_CLOUD_FILTER) {
 		iavf_add_cloud_filter(adapter);
-		goto watchdog_done;
+		return 0;
 	}
 
 	if (adapter->aq_required & IAVF_FLAG_AQ_DEL_CLOUD_FILTER) {
 		iavf_del_cloud_filter(adapter);
+		return 0;
+	}
+
+	return -EAGAIN;
+}
+
+/**
+ * iavf_watchdog_task - Periodic call-back task
+ * @work: pointer to work_struct
+ **/
+static void iavf_watchdog_task(struct work_struct *work)
+{
+	struct iavf_adapter *adapter = container_of(work,
+						      struct iavf_adapter,
+						      watchdog_task);
+	struct iavf_hw *hw = &adapter->hw;
+	u32 reg_val;
+
+	if (test_and_set_bit(__IAVF_IN_CRITICAL_TASK, &adapter->crit_section))
+		goto restart_watchdog;
+
+	if (adapter->flags & IAVF_FLAG_PF_COMMS_FAILED) {
+		reg_val = rd32(hw, IAVF_VFGEN_RSTAT) &
+			  IAVF_VFGEN_RSTAT_VFR_STATE_MASK;
+		if (reg_val == VIRTCHNL_VFR_VFACTIVE ||
+		    reg_val == VIRTCHNL_VFR_COMPLETED) {
+			/* A chance for redemption! */
+			dev_err(&adapter->pdev->dev, "Hardware came out of reset. Attemptingreinit.\n");
+			adapter->state = __IAVF_STARTUP;
+			adapter->flags &= ~IAVF_FLAG_PF_COMMS_FAILED;
+			schedule_delayed_work(&adapter->init_task, 10);
+			clear_bit(__IAVF_IN_CRITICAL_TASK,
+				  &adapter->crit_section);
+			/* Don't reschedule the watchdog, since we've restarted
+			 * the init task. When init_task contacts the PF and
+			 * gets everything set up again, it'll restart the
+			 * watchdog for us. Down, boy. Sit. Stay. Woof.
+			 */
+			return;
+		}
+		adapter->aq_required = 0;
+		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
 		goto watchdog_done;
 	}
 
-	schedule_delayed_work(&adapter->client_task, msecs_to_jiffies(5));
+	if (adapter->state < __IAVF_DOWN ||
+	    (adapter->flags & IAVF_FLAG_RESET_PENDING))
+		goto watchdog_done;
 
-	if (adapter->state == __IAVF_RUNNING)
+	/* check for reset */
+	reg_val = rd32(hw, IAVF_VF_ARQLEN1) & IAVF_VF_ARQLEN1_ARQENABLE_MASK;
+	if (!(adapter->flags & IAVF_FLAG_RESET_PENDING) && !reg_val) {
+		adapter->state = __IAVF_RESETTING;
+		adapter->flags |= IAVF_FLAG_RESET_PENDING;
+		dev_err(&adapter->pdev->dev, "Hardware reset detected\n");
+		schedule_work(&adapter->reset_task);
+		adapter->aq_required = 0;
+		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
+		goto watchdog_done;
+	}
+
+	/* Process admin queue tasks. After init, everything gets done
+	 * here so we don't race on the admin queue.
+	 * The check is made against -EAGAIN, as it's the error code that
+	 * would be returned on no op to run. Failures of called functions
+	 * return other values.
+	 */
+	if (adapter->current_op) {
+		if (!iavf_asq_done(hw)) {
+			dev_dbg(&adapter->pdev->dev, "Admin queue timeout\n");
+			iavf_send_api_ver(adapter);
+		}
+	} else if (iavf_process_aq_command(adapter) == -EAGAIN &&
+		   adapter->state == __IAVF_RUNNING) {
 		iavf_request_stats(adapter);
+	}
+
+	schedule_delayed_work(&adapter->client_task, msecs_to_jiffies(5));
+
 watchdog_done:
 	if (adapter->state == __IAVF_RUNNING)
 		iavf_detect_recover_hung(&adapter->vsi);
-- 
2.19.2

