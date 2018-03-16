From: Alice Michael <alice.michael@intel.com>
Date: Fri, 16 Mar 2018 01:26:34 -0700
Subject: [Intel-wired-lan] [next PATCH S89 5/8] i40e: move client flags into
 state bits
In-Reply-To: <20180316082637.49915-1-alice.michael@intel.com>
References: <20180316082637.49915-1-alice.michael@intel.com>
Message-ID: <20180316082637.49915-5-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

The iWarp client flags are all potentially changed when the RTNL lock is
not held, so they should not be part of the pf->flags variable. Instead,
move them into the state field so that we can use atomic bit operations.

This is part of a larger effort to remove cmpxchg64 in
i40e_set_priv_flags()

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h        |  7 ++++---
 drivers/net/ethernet/intel/i40e/i40e_client.c |  7 +++----
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 22 ++++++++++------------
 3 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 2dd89f8..029554e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -167,6 +167,9 @@ enum i40e_state_t {
 	__I40E_MACVLAN_SYNC_PENDING,
 	__I40E_UDP_FILTER_SYNC_PENDING,
 	__I40E_TEMP_LINK_POLLING,
+	__I40E_CLIENT_SERVICE_REQUESTED,
+	__I40E_CLIENT_L2_CHANGE,
+	__I40E_CLIENT_RESET,
 	/* This must be last as it determines the size of the BITMAP */
 	__I40E_STATE_SIZE__,
 };
@@ -539,9 +542,7 @@ struct i40e_pf {
 #define I40E_FLAG_LEGACY_RX			BIT_ULL(21)
 #define I40E_FLAG_PTP				BIT_ULL(22)
 #define I40E_FLAG_IWARP_ENABLED			BIT_ULL(23)
-#define I40E_FLAG_SERVICE_CLIENT_REQUESTED	BIT_ULL(24)
-#define I40E_FLAG_CLIENT_L2_CHANGE		BIT_ULL(25)
-#define I40E_FLAG_CLIENT_RESET			BIT_ULL(26)
+/* Gap for BIT_ULL(24) through BIT_ULL(26) */
 #define I40E_FLAG_LINK_DOWN_ON_CLOSE_ENABLED	BIT_ULL(27)
 #define I40E_FLAG_SOURCE_PRUNING_DISABLED	BIT_ULL(28)
 #define I40E_FLAG_TC_MQPRIO			BIT_ULL(29)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
index a04bbfc..0484c7e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_client.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
@@ -376,9 +376,8 @@ void i40e_client_subtask(struct i40e_pf *pf)
 	struct i40e_vsi *vsi = pf->vsi[pf->lan_vsi];
 	int ret = 0;
 
-	if (!(pf->flags & I40E_FLAG_SERVICE_CLIENT_REQUESTED))
+	if (!test_and_clear_bit(__I40E_CLIENT_SERVICE_REQUESTED, pf->state))
 		return;
-	pf->flags &= ~I40E_FLAG_SERVICE_CLIENT_REQUESTED;
 	cdev = pf->cinst;
 
 	/* If we're down or resetting, just bail */
@@ -459,7 +458,7 @@ int i40e_lan_add_device(struct i40e_pf *pf)
 	 * added, we can schedule a subtask to go initiate the clients if
 	 * they can be launched at probe time.
 	 */
-	pf->flags |= I40E_FLAG_SERVICE_CLIENT_REQUESTED;
+	set_bit(__I40E_CLIENT_SERVICE_REQUESTED, pf->state);
 	i40e_service_event_schedule(pf);
 
 out:
@@ -554,7 +553,7 @@ static void i40e_client_prepare(struct i40e_client *client)
 		pf = ldev->pf;
 		i40e_client_add_instance(pf);
 		/* Start the client subtask */
-		pf->flags |= I40E_FLAG_SERVICE_CLIENT_REQUESTED;
+		set_bit(__I40E_CLIENT_SERVICE_REQUESTED, pf->state);
 		i40e_service_event_schedule(pf);
 	}
 	mutex_unlock(&i40e_device_mutex);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 01ecd9d..debc3a3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -2634,8 +2634,8 @@ static int i40e_change_mtu(struct net_device *netdev, int new_mtu)
 	netdev->mtu = new_mtu;
 	if (netif_running(netdev))
 		i40e_vsi_reinit_locked(vsi);
-	pf->flags |= (I40E_FLAG_SERVICE_CLIENT_REQUESTED |
-		      I40E_FLAG_CLIENT_L2_CHANGE);
+	set_bit(__I40E_CLIENT_SERVICE_REQUESTED, pf->state);
+	set_bit(__I40E_CLIENT_L2_CHANGE, pf->state);
 	return 0;
 }
 
@@ -4722,9 +4722,9 @@ static void i40e_vsi_close(struct i40e_vsi *vsi)
 	i40e_vsi_free_tx_resources(vsi);
 	i40e_vsi_free_rx_resources(vsi);
 	vsi->current_netdev_flags = 0;
-	pf->flags |= I40E_FLAG_SERVICE_CLIENT_REQUESTED;
+	set_bit(__I40E_CLIENT_SERVICE_REQUESTED, pf->state);
 	if (test_bit(__I40E_RESET_RECOVERY_PENDING, pf->state))
-		pf->flags |=  I40E_FLAG_CLIENT_RESET;
+		set_bit(__I40E_CLIENT_RESET, pf->state);
 }
 
 /**
@@ -6495,7 +6495,7 @@ static int i40e_up_complete(struct i40e_vsi *vsi)
 	/* On the next run of the service_task, notify any clients of the new
 	 * opened netdev
 	 */
-	pf->flags |= I40E_FLAG_SERVICE_CLIENT_REQUESTED;
+	set_bit(__I40E_CLIENT_SERVICE_REQUESTED, pf->state);
 	i40e_service_event_schedule(pf);
 
 	return 0;
@@ -8037,8 +8037,8 @@ static int i40e_handle_lldp_event(struct i40e_pf *pf,
 		i40e_service_event_schedule(pf);
 	} else {
 		i40e_pf_unquiesce_all_vsi(pf);
-	pf->flags |= (I40E_FLAG_SERVICE_CLIENT_REQUESTED |
-		      I40E_FLAG_CLIENT_L2_CHANGE);
+	set_bit(__I40E_CLIENT_SERVICE_REQUESTED, pf->state);
+	set_bit(__I40E_CLIENT_L2_CHANGE, pf->state);
 	}
 
 exit:
@@ -9785,17 +9785,15 @@ static void i40e_service_task(struct work_struct *work)
 	i40e_vc_process_vflr_event(pf);
 	i40e_watchdog_subtask(pf);
 	i40e_fdir_reinit_subtask(pf);
-	if (pf->flags & I40E_FLAG_CLIENT_RESET) {
+	if (test_and_clear_bit(__I40E_CLIENT_RESET, pf->state)) {
 		/* Client subtask will reopen next time through. */
 		i40e_notify_client_of_netdev_close(pf->vsi[pf->lan_vsi], true);
-		pf->flags &= ~I40E_FLAG_CLIENT_RESET;
 	} else {
 		i40e_client_subtask(pf);
-		if (pf->flags & I40E_FLAG_CLIENT_L2_CHANGE) {
+		if (test_and_clear_bit(__I40E_CLIENT_L2_CHANGE,
+				       pf->state))
 			i40e_notify_client_of_l2_param_changes(
 							pf->vsi[pf->lan_vsi]);
-			pf->flags &= ~I40E_FLAG_CLIENT_L2_CHANGE;
-		}
 	}
 	i40e_sync_filters_subtask(pf);
 	i40e_sync_udp_filters_subtask(pf);
-- 
2.9.5

