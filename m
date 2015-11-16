From: Anjali Singhai Jain <anjali.singhai@intel.com>
Date: Sun, 15 Nov 2015 16:02:51 -0800
Subject: [Intel-wired-lan] [PATCH v5 3/7] i40e: Remove CONFIG_I40E_VXLAN
In-Reply-To: <1447632175-9477-1-git-send-email-anjali.singhai@intel.com>
References: <1447632175-9477-1-git-send-email-anjali.singhai@intel.com>
Message-ID: <1447632175-9477-3-git-send-email-anjali.singhai@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

If the kernel flag CONFIG_VXLAN is true or CONFIG_VXLAN_MODULE is true,
enable VXLAN offload in the driver.

Signed-off-by: Kiran Patil <kiran.patil@intel.com>
Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
---
 drivers/net/ethernet/intel/Kconfig          | 11 -----------
 drivers/net/ethernet/intel/i40e/i40e.h      |  4 ----
 drivers/net/ethernet/intel/i40e/i40e_main.c | 12 +++---------
 3 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index 4163b16..061e4e0 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -269,17 +269,6 @@ config I40E
 	  To compile this driver as a module, choose M here. The module
 	  will be called i40e.
 
-config I40E_VXLAN
-	bool "Virtual eXtensible Local Area Network Support"
-	default n
-	depends on I40E && VXLAN && !(I40E=y && VXLAN=m)
-	---help---
-	  This allows one to create VXLAN virtual interfaces that provide
-	  Layer 2 Networks over Layer 3 Networks. VXLAN is often used
-	  to tunnel virtual network infrastructure in virtualized environments.
-	  Say Y here if you want to use Virtual eXtensible Local Area Network
-	  (VXLAN) in the driver.
-
 config I40E_DCB
 	bool "Data Center Bridging (DCB) Support"
 	default n
diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 4ca85d5..6c4d154 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -282,11 +282,9 @@ struct i40e_pf {
 	u32 fd_atr_cnt;
 	u32 fd_tcp_rule;
 
-#ifdef CONFIG_I40E_VXLAN
 	__be16  vxlan_ports[I40E_MAX_PF_UDP_OFFLOAD_PORTS];
 	u16 pending_vxlan_bitmap;
 
-#endif
 	enum i40e_interrupt_policy int_policy;
 	u16 rx_itr_default;
 	u16 tx_itr_default;
@@ -323,9 +321,7 @@ struct i40e_pf {
 #define I40E_FLAG_FD_ATR_ENABLED		BIT_ULL(22)
 #define I40E_FLAG_PTP				BIT_ULL(25)
 #define I40E_FLAG_MFP_ENABLED			BIT_ULL(26)
-#ifdef CONFIG_I40E_VXLAN
 #define I40E_FLAG_VXLAN_FILTER_SYNC		BIT_ULL(27)
-#endif
 #define I40E_FLAG_PORT_ID_VALID			BIT_ULL(28)
 #define I40E_FLAG_DCB_CAPABLE			BIT_ULL(29)
 #define I40E_FLAG_RSS_AQ_CAPABLE		BIT_ULL(31)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 9937ad3..ce46be8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -27,7 +27,7 @@
 /* Local includes */
 #include "i40e.h"
 #include "i40e_diag.h"
-#ifdef CONFIG_I40E_VXLAN
+#if IS_ENABLED(CONFIG_VXLAN)
 #include <net/vxlan.h>
 #endif
 #include <net/protocol.h>
@@ -6989,13 +6989,13 @@ static void i40e_handle_mdd_event(struct i40e_pf *pf)
 	i40e_flush(hw);
 }
 
-#ifdef CONFIG_I40E_VXLAN
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
@@ -7029,9 +7029,9 @@ static void i40e_sync_vxlan_filters_subtask(struct i40e_pf *pf)
 			}
 		}
 	}
+#endif
 }
 
-#endif
 /**
  * i40e_service_task - Run the driver's async subtasks
  * @work: pointer to work_struct containing our data
@@ -7056,9 +7056,7 @@ static void i40e_service_task(struct work_struct *work)
 	i40e_watchdog_subtask(pf);
 	i40e_fdir_reinit_subtask(pf);
 	i40e_sync_filters_subtask(pf);
-#ifdef CONFIG_I40E_VXLAN
 	i40e_sync_vxlan_filters_subtask(pf);
-#endif
 	i40e_clean_adminq_subtask(pf);
 
 	i40e_service_event_complete(pf);
@@ -8432,7 +8430,6 @@ static int i40e_set_features(struct net_device *netdev,
 	return 0;
 }
 
-#ifdef CONFIG_I40E_VXLAN
 /**
  * i40e_get_vxlan_port_idx - Lookup a possibly offloaded for Rx UDP port
  * @pf: board private structure
@@ -8527,7 +8524,6 @@ static void i40e_del_vxlan_port(struct net_device *netdev,
 	}
 }
 
-#endif
 static int i40e_get_phys_port_id(struct net_device *netdev,
 				 struct netdev_phys_item_id *ppid)
 {
@@ -8752,10 +8748,8 @@ static const struct net_device_ops i40e_netdev_ops = {
 	.ndo_get_vf_config	= i40e_ndo_get_vf_config,
 	.ndo_set_vf_link_state	= i40e_ndo_set_vf_link_state,
 	.ndo_set_vf_spoofchk	= i40e_ndo_set_vf_spoofchk,
-#ifdef CONFIG_I40E_VXLAN
 	.ndo_add_vxlan_port	= i40e_add_vxlan_port,
 	.ndo_del_vxlan_port	= i40e_del_vxlan_port,
-#endif
 	.ndo_get_phys_port_id	= i40e_get_phys_port_id,
 	.ndo_fdb_add		= i40e_ndo_fdb_add,
 	.ndo_features_check	= i40e_features_check,
-- 
1.8.1.4

