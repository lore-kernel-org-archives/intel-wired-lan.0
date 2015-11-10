From: Anjali Singhai Jain <anjali.singhai@intel.com>
Date: Tue, 10 Nov 2015 09:56:40 -0800
Subject: [Intel-wired-lan] [PATCH v4 1/6] i40e: Remove CONFIG_I40E_VXLAN
Message-ID: <1447178205-99510-1-git-send-email-anjali.singhai@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

If the kernel flag CONFIG_VXLAN is true or CONFIG_VXLAN_MODULE is true,
enable VXLAN offload in the driver.

v2: Fix bisection error for this patch series.

Signed-off-by: Kiran Patil <kiran.patil@intel.com>
Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h      |  2 --
 drivers/net/ethernet/intel/i40e/i40e_main.c | 10 ++--------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 8ed759e..6c4d154 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -282,11 +282,9 @@ struct i40e_pf {
 	u32 fd_atr_cnt;
 	u32 fd_tcp_rule;
 
-#if IS_ENABLED(CONFIG_VXLAN)
 	__be16  vxlan_ports[I40E_MAX_PF_UDP_OFFLOAD_PORTS];
 	u16 pending_vxlan_bitmap;
 
-#endif
 	enum i40e_interrupt_policy int_policy;
 	u16 rx_itr_default;
 	u16 tx_itr_default;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index b447af6..0235a8a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -6990,13 +6990,13 @@ static void i40e_handle_mdd_event(struct i40e_pf *pf)
 	i40e_flush(hw);
 }
 
-#if IS_ENABLED(CONFIG_VXLAN)
 /**
  * i40e_sync_vxlan_filters_subtask - Sync the VSI filter list with HW
  * @pf: board private structure
  **/
 static void i40e_sync_vxlan_filters_subtask(struct i40e_pf *pf)
 {
+#if IS_ENABLED(CONFIG_VXLAN)
 	struct i40e_hw *hw = &pf->hw;
 	i40e_status ret;
 	__be16 port;
@@ -7030,9 +7030,9 @@ static void i40e_sync_vxlan_filters_subtask(struct i40e_pf *pf)
 			}
 		}
 	}
+#endif
 }
 
-#endif
 /**
  * i40e_service_task - Run the driver's async subtasks
  * @work: pointer to work_struct containing our data
@@ -7057,9 +7057,7 @@ static void i40e_service_task(struct work_struct *work)
 	i40e_watchdog_subtask(pf);
 	i40e_fdir_reinit_subtask(pf);
 	i40e_sync_filters_subtask(pf);
-#if IS_ENABLED(CONFIG_VXLAN)
 	i40e_sync_vxlan_filters_subtask(pf);
-#endif
 	i40e_clean_adminq_subtask(pf);
 
 	i40e_service_event_complete(pf);
@@ -8433,7 +8431,6 @@ static int i40e_set_features(struct net_device *netdev,
 	return 0;
 }
 
-#if IS_ENABLED(CONFIG_VXLAN)
 /**
  * i40e_get_vxlan_port_idx - Lookup a possibly offloaded for Rx UDP port
  * @pf: board private structure
@@ -8528,7 +8525,6 @@ static void i40e_del_vxlan_port(struct net_device *netdev,
 	}
 }
 
-#endif
 static int i40e_get_phys_port_id(struct net_device *netdev,
 				 struct netdev_phys_item_id *ppid)
 {
@@ -8753,10 +8749,8 @@ static const struct net_device_ops i40e_netdev_ops = {
 	.ndo_get_vf_config	= i40e_ndo_get_vf_config,
 	.ndo_set_vf_link_state	= i40e_ndo_set_vf_link_state,
 	.ndo_set_vf_spoofchk	= i40e_ndo_set_vf_spoofchk,
-#if IS_ENABLED(CONFIG_VXLAN)
 	.ndo_add_vxlan_port	= i40e_add_vxlan_port,
 	.ndo_del_vxlan_port	= i40e_del_vxlan_port,
-#endif
 	.ndo_get_phys_port_id	= i40e_get_phys_port_id,
 	.ndo_fdb_add		= i40e_ndo_fdb_add,
 	.ndo_features_check	= i40e_features_check,
-- 
1.8.1.4

