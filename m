From: Anjali Singhai Jain <anjali.singhai@intel.com>
Date: Sun, 15 Nov 2015 16:02:49 -0800
Subject: [Intel-wired-lan] [PATCH v5 1/7] Revert "i40e: remove
	CONFIG_I40E_VXLAN"
Message-ID: <1447632175-9477-1-git-send-email-anjali.singhai@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch breaks compile when I40E is compiled in the kernel
and VXLAN is a module.

This reverts commit f59b488df98da2db2d05385fe1ff948d36acce67.
---
 drivers/net/ethernet/intel/Kconfig          | 11 +++++++++++
 drivers/net/ethernet/intel/i40e/i40e.h      |  4 +++-
 drivers/net/ethernet/intel/i40e/i40e_main.c | 12 ++++++------
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index 061e4e0..4163b16 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -269,6 +269,17 @@ config I40E
 	  To compile this driver as a module, choose M here. The module
 	  will be called i40e.
 
+config I40E_VXLAN
+	bool "Virtual eXtensible Local Area Network Support"
+	default n
+	depends on I40E && VXLAN && !(I40E=y && VXLAN=m)
+	---help---
+	  This allows one to create VXLAN virtual interfaces that provide
+	  Layer 2 Networks over Layer 3 Networks. VXLAN is often used
+	  to tunnel virtual network infrastructure in virtualized environments.
+	  Say Y here if you want to use Virtual eXtensible Local Area Network
+	  (VXLAN) in the driver.
+
 config I40E_DCB
 	bool "Data Center Bridging (DCB) Support"
 	default n
diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 8ed759e..4ca85d5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -282,7 +282,7 @@ struct i40e_pf {
 	u32 fd_atr_cnt;
 	u32 fd_tcp_rule;
 
-#if IS_ENABLED(CONFIG_VXLAN)
+#ifdef CONFIG_I40E_VXLAN
 	__be16  vxlan_ports[I40E_MAX_PF_UDP_OFFLOAD_PORTS];
 	u16 pending_vxlan_bitmap;
 
@@ -323,7 +323,9 @@ struct i40e_pf {
 #define I40E_FLAG_FD_ATR_ENABLED		BIT_ULL(22)
 #define I40E_FLAG_PTP				BIT_ULL(25)
 #define I40E_FLAG_MFP_ENABLED			BIT_ULL(26)
+#ifdef CONFIG_I40E_VXLAN
 #define I40E_FLAG_VXLAN_FILTER_SYNC		BIT_ULL(27)
+#endif
 #define I40E_FLAG_PORT_ID_VALID			BIT_ULL(28)
 #define I40E_FLAG_DCB_CAPABLE			BIT_ULL(29)
 #define I40E_FLAG_RSS_AQ_CAPABLE		BIT_ULL(31)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index b447af6..36645828 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -27,7 +27,7 @@
 /* Local includes */
 #include "i40e.h"
 #include "i40e_diag.h"
-#if IS_ENABLED(CONFIG_VXLAN)
+#ifdef CONFIG_I40E_VXLAN
 #include <net/vxlan.h>
 #endif
 
@@ -5294,7 +5294,7 @@ int i40e_open(struct net_device *netdev)
 						       TCP_FLAG_CWR) >> 16);
 	wr32(&pf->hw, I40E_GLLAN_TSOMSK_L, be32_to_cpu(TCP_FLAG_CWR) >> 16);
 
-#if IS_ENABLED(CONFIG_VXLAN)
+#ifdef CONFIG_I40E_VXLAN
 	vxlan_get_rx_port(netdev);
 #endif
 
@@ -6990,7 +6990,7 @@ static void i40e_handle_mdd_event(struct i40e_pf *pf)
 	i40e_flush(hw);
 }
 
-#if IS_ENABLED(CONFIG_VXLAN)
+#ifdef CONFIG_I40E_VXLAN
 /**
  * i40e_sync_vxlan_filters_subtask - Sync the VSI filter list with HW
  * @pf: board private structure
@@ -7057,7 +7057,7 @@ static void i40e_service_task(struct work_struct *work)
 	i40e_watchdog_subtask(pf);
 	i40e_fdir_reinit_subtask(pf);
 	i40e_sync_filters_subtask(pf);
-#if IS_ENABLED(CONFIG_VXLAN)
+#ifdef CONFIG_I40E_VXLAN
 	i40e_sync_vxlan_filters_subtask(pf);
 #endif
 	i40e_clean_adminq_subtask(pf);
@@ -8433,7 +8433,7 @@ static int i40e_set_features(struct net_device *netdev,
 	return 0;
 }
 
-#if IS_ENABLED(CONFIG_VXLAN)
+#ifdef CONFIG_I40E_VXLAN
 /**
  * i40e_get_vxlan_port_idx - Lookup a possibly offloaded for Rx UDP port
  * @pf: board private structure
@@ -8753,7 +8753,7 @@ static const struct net_device_ops i40e_netdev_ops = {
 	.ndo_get_vf_config	= i40e_ndo_get_vf_config,
 	.ndo_set_vf_link_state	= i40e_ndo_set_vf_link_state,
 	.ndo_set_vf_spoofchk	= i40e_ndo_set_vf_spoofchk,
-#if IS_ENABLED(CONFIG_VXLAN)
+#ifdef CONFIG_I40E_VXLAN
 	.ndo_add_vxlan_port	= i40e_add_vxlan_port,
 	.ndo_del_vxlan_port	= i40e_del_vxlan_port,
 #endif
-- 
1.8.1.4

