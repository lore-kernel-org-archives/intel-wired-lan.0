From: Anjali Singhai Jain <anjali.singhai@intel.com>
Date: Thu, 20 Aug 2015 11:46:20 -0700
Subject: [Intel-wired-lan] [PATCH 1/4] i40e: Remove CONFIG_I40E_VXLAN
Message-ID: <1440096383-8915-1-git-send-email-anjali.singhai@intel.com>
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
 drivers/net/ethernet/intel/i40e/i40e_main.c | 14 ++++----------
 3 files changed, 4 insertions(+), 25 deletions(-)

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
index c9fa289..257f7d8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -274,11 +274,9 @@ struct i40e_pf {
 	u32 fd_atr_cnt;
 	u32 fd_tcp_rule;
 
-#ifdef CONFIG_I40E_VXLAN
 	__be16  vxlan_ports[I40E_MAX_PF_UDP_OFFLOAD_PORTS];
 	u16 pending_vxlan_bitmap;
 
-#endif
 	enum i40e_interrupt_policy int_policy;
 	u16 rx_itr_default;
 	u16 tx_itr_default;
@@ -316,9 +314,7 @@ struct i40e_pf {
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
index aef0a4c..05081d1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -28,7 +28,7 @@
 #include "i40e.h"
 #include "i40e_helper.h"
 #include "i40e_diag.h"
-#ifdef CONFIG_I40E_VXLAN
+#if defined(CONFIG_VXLAN) || defined(CONFIG_VXLAN_MODULE)
 #include <net/vxlan.h>
 #endif
 
@@ -4934,7 +4934,7 @@ int i40e_open(struct net_device *netdev)
 						       TCP_FLAG_CWR) >> 16);
 	wr32(&pf->hw, I40E_GLLAN_TSOMSK_L, be32_to_cpu(TCP_FLAG_CWR) >> 16);
 
-#ifdef CONFIG_I40E_VXLAN
+#if defined(CONFIG_VXLAN) || defined(CONFIG_VXLAN_MODULE)
 	vxlan_get_rx_port(netdev);
 #endif
 
@@ -6659,13 +6659,13 @@ static void i40e_handle_mdd_event(struct i40e_pf *pf)
 	i40e_flush(hw);
 }
 
-#ifdef CONFIG_I40E_VXLAN
 /**
  * i40e_sync_vxlan_filters_subtask - Sync the VSI filter list with HW
  * @pf: board private structure
  **/
 static void i40e_sync_vxlan_filters_subtask(struct i40e_pf *pf)
 {
+#if defined(CONFIG_VXLAN) || defined(CONFIG_VXLAN_MODULE)
 	struct i40e_hw *hw = &pf->hw;
 	i40e_status ret;
 	__be16 port;
@@ -6699,9 +6699,9 @@ static void i40e_sync_vxlan_filters_subtask(struct i40e_pf *pf)
 			}
 		}
 	}
+#endif
 }
 
-#endif
 /**
  * i40e_service_task - Run the driver's async subtasks
  * @work: pointer to work_struct containing our data
@@ -6725,9 +6725,7 @@ static void i40e_service_task(struct work_struct *work)
 	i40e_watchdog_subtask(pf);
 	i40e_fdir_reinit_subtask(pf);
 	i40e_sync_filters_subtask(pf);
-#ifdef CONFIG_I40E_VXLAN
 	i40e_sync_vxlan_filters_subtask(pf);
-#endif
 	i40e_clean_adminq_subtask(pf);
 
 	i40e_service_event_complete(pf);
@@ -7944,7 +7942,6 @@ static int i40e_set_features(struct net_device *netdev,
 	return 0;
 }
 
-#ifdef CONFIG_I40E_VXLAN
 /**
  * i40e_get_vxlan_port_idx - Lookup a possibly offloaded for Rx UDP port
  * @pf: board private structure
@@ -8039,7 +8036,6 @@ static void i40e_del_vxlan_port(struct net_device *netdev,
 	}
 }
 
-#endif
 static int i40e_get_phys_port_id(struct net_device *netdev,
 				 struct netdev_phys_item_id *ppid)
 {
@@ -8262,10 +8258,8 @@ static const struct net_device_ops i40e_netdev_ops = {
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

