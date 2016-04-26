From: Bynoe, Ronald J <ronald.j.bynoe@intel.com>
Date: Tue, 26 Apr 2016 20:53:41 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Disable DCB and FCoE for
 X550EM_x	and x550em_a
In-Reply-To: <20160426120026.8106.64120.stgit@ukketine.jf.intel.com>
References: <20160426120026.8106.64120.stgit@ukketine.jf.intel.com>
Message-ID: <3108673A8B660F4EA3D50CFD4A0EF235124E50A1@fmsmsx107.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

________________________________________
From: Intel-wired-lan [intel-wired-lan-bounces at lists.osuosl.org] on behalf of Usha Ketineni [usha.k.ketineni at intel.com]
Sent: Tuesday, April 26, 2016 5:00 AM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [PATCH] ixgbe: Disable DCB and FCoE for X550EM_x     and x550em_a

This patch adds IXGBE_FLAG_DCB_CAPABLE flag that is set
for all MACs other than X550EM_x and x550em_a. DCB and
FCoE is disabled for these MACS. DCB initialization
code is moved to a seperate function.

Signed-off-by: Usha Ketineni <usha.k.ketineni@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |    1
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  111 ++++++++++++++++---------
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |    1
 3 files changed, 71 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 781c878..874e968 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -644,6 +644,7 @@ struct ixgbe_adapter {
 #define IXGBE_FLAG_VXLAN_OFFLOAD_CAPABLE       BIT(24)
 #define IXGBE_FLAG_RX_HWTSTAMP_ENABLED         BIT(25)
 #define IXGBE_FLAG_RX_HWTSTAMP_IN_REGISTER     BIT(26)
+#define IXGBE_FLAG_DCB_CAPABLE                 BIT(27)

        u32 flags2;
 #define IXGBE_FLAG2_RSC_CAPABLE                        BIT(0)
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 0ef4a15..6467ec0 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -5558,6 +5558,58 @@ static void ixgbe_tx_timeout(struct net_device *netdev)
        ixgbe_tx_timeout_reset(adapter);
 }

+#ifdef CONFIG_IXGBE_DCB
+static void ixgbe_init_dcb(struct ixgbe_adapter *adapter)
+{
+       struct ixgbe_hw *hw = &adapter->hw;
+       struct tc_configuration *tc;
+       int j;
+
+       switch (hw->mac.type) {
+       case ixgbe_mac_82598EB:
+       case ixgbe_mac_82599EB:
+               adapter->dcb_cfg.num_tcs.pg_tcs = MAX_TRAFFIC_CLASS;
+               adapter->dcb_cfg.num_tcs.pfc_tcs = MAX_TRAFFIC_CLASS;
+               break;
+       case ixgbe_mac_X540:
+       case ixgbe_mac_X550:
+               adapter->dcb_cfg.num_tcs.pg_tcs = X540_TRAFFIC_CLASS;
+               adapter->dcb_cfg.num_tcs.pfc_tcs = X540_TRAFFIC_CLASS;
+               break;
+       case ixgbe_mac_X550EM_x:
+       case ixgbe_mac_x550em_a:
+       default:
+               adapter->dcb_cfg.num_tcs.pg_tcs = DEF_TRAFFIC_CLASS;
+               adapter->dcb_cfg.num_tcs.pfc_tcs = DEF_TRAFFIC_CLASS;
+               break;
+       }
+
+       /* Configure DCB traffic classes */
+       for (j = 0; j < MAX_TRAFFIC_CLASS; j++) {
+               tc = &adapter->dcb_cfg.tc_config[j];
+               tc->path[DCB_TX_CONFIG].bwg_id = 0;
+               tc->path[DCB_TX_CONFIG].bwg_percent = 12 + (j & 1);
+               tc->path[DCB_RX_CONFIG].bwg_id = 0;
+               tc->path[DCB_RX_CONFIG].bwg_percent = 12 + (j & 1);
+               tc->dcb_pfc = pfc_disabled;
+       }
+
+       /* Initialize default user to priority mapping, UPx->TC0 */
+       tc = &adapter->dcb_cfg.tc_config[0];
+       tc->path[DCB_TX_CONFIG].up_to_tc_bitmap = 0xFF;
+       tc->path[DCB_RX_CONFIG].up_to_tc_bitmap = 0xFF;
+
+       adapter->dcb_cfg.bw_percentage[DCB_TX_CONFIG][0] = 100;
+       adapter->dcb_cfg.bw_percentage[DCB_RX_CONFIG][0] = 100;
+       adapter->dcb_cfg.pfc_mode_enable = false;
+       adapter->dcb_set_bitmap = 0x00;
+       if (adapter->flags & IXGBE_FLAG_DCB_CAPABLE)
+               adapter->dcbx_cap = DCB_CAP_DCBX_HOST | DCB_CAP_DCBX_VER_CEE;
+       memcpy(&adapter->temp_dcb_cfg, &adapter->dcb_cfg,
+              sizeof(adapter->temp_dcb_cfg));
+}
+#endif
+
 /**
  * ixgbe_sw_init - Initialize general software structures (struct ixgbe_adapter)
  * @adapter: board private structure to initialize
@@ -5573,10 +5625,6 @@ static int ixgbe_sw_init(struct ixgbe_adapter *adapter)
        unsigned int rss, fdir;
        u32 fwsm;
        u16 device_caps;
-#ifdef CONFIG_IXGBE_DCB
-       int j;
-       struct tc_configuration *tc;
-#endif

        /* PCI config space info */

@@ -5598,6 +5646,10 @@ static int ixgbe_sw_init(struct ixgbe_adapter *adapter)
 #ifdef CONFIG_IXGBE_DCA
        adapter->flags |= IXGBE_FLAG_DCA_CAPABLE;
 #endif
+#ifdef CONFIG_IXGBE_DCB
+       adapter->flags |= IXGBE_FLAG_DCB_CAPABLE;
+       adapter->flags &= ~IXGBE_FLAG_DCB_ENABLED;
+#endif
 #ifdef IXGBE_FCOE
        adapter->flags |= IXGBE_FLAG_FCOE_CAPABLE;
        adapter->flags &= ~IXGBE_FLAG_FCOE_ENABLED;
@@ -5647,6 +5699,16 @@ static int ixgbe_sw_init(struct ixgbe_adapter *adapter)
                break;
        case ixgbe_mac_X550EM_x:
        case ixgbe_mac_x550em_a:
+#ifdef CONFIG_IXGBE_DCB
+               adapter->flags &= ~IXGBE_FLAG_DCB_CAPABLE;
+#endif
+#ifdef IXGBE_FCOE
+               adapter->flags &= ~IXGBE_FLAG_FCOE_CAPABLE;
+#ifdef CONFIG_IXGBE_DCB
+               adapter->fcoe.up = 0;
+#endif /* IXGBE_DCB */
+#endif /* IXGBE_FCOE */
+       /* Fall Through */
        case ixgbe_mac_X550:
 #ifdef CONFIG_IXGBE_DCA
                adapter->flags &= ~IXGBE_FLAG_DCA_CAPABLE;
@@ -5668,43 +5730,7 @@ static int ixgbe_sw_init(struct ixgbe_adapter *adapter)
        spin_lock_init(&adapter->fdir_perfect_lock);

 #ifdef CONFIG_IXGBE_DCB
-       switch (hw->mac.type) {
-       case ixgbe_mac_X540:
-       case ixgbe_mac_X550:
-       case ixgbe_mac_X550EM_x:
-       case ixgbe_mac_x550em_a:
-               adapter->dcb_cfg.num_tcs.pg_tcs = X540_TRAFFIC_CLASS;
-               adapter->dcb_cfg.num_tcs.pfc_tcs = X540_TRAFFIC_CLASS;
-               break;
-       default:
-               adapter->dcb_cfg.num_tcs.pg_tcs = MAX_TRAFFIC_CLASS;
-               adapter->dcb_cfg.num_tcs.pfc_tcs = MAX_TRAFFIC_CLASS;
-               break;
-       }
-
-       /* Configure DCB traffic classes */
-       for (j = 0; j < MAX_TRAFFIC_CLASS; j++) {
-               tc = &adapter->dcb_cfg.tc_config[j];
-               tc->path[DCB_TX_CONFIG].bwg_id = 0;
-               tc->path[DCB_TX_CONFIG].bwg_percent = 12 + (j & 1);
-               tc->path[DCB_RX_CONFIG].bwg_id = 0;
-               tc->path[DCB_RX_CONFIG].bwg_percent = 12 + (j & 1);
-               tc->dcb_pfc = pfc_disabled;
-       }
-
-       /* Initialize default user to priority mapping, UPx->TC0 */
-       tc = &adapter->dcb_cfg.tc_config[0];
-       tc->path[DCB_TX_CONFIG].up_to_tc_bitmap = 0xFF;
-       tc->path[DCB_RX_CONFIG].up_to_tc_bitmap = 0xFF;
-
-       adapter->dcb_cfg.bw_percentage[DCB_TX_CONFIG][0] = 100;
-       adapter->dcb_cfg.bw_percentage[DCB_RX_CONFIG][0] = 100;
-       adapter->dcb_cfg.pfc_mode_enable = false;
-       adapter->dcb_set_bitmap = 0x00;
-       adapter->dcbx_cap = DCB_CAP_DCBX_HOST | DCB_CAP_DCBX_VER_CEE;
-       memcpy(&adapter->temp_dcb_cfg, &adapter->dcb_cfg,
-              sizeof(adapter->temp_dcb_cfg));
-
+       ixgbe_init_dcb(adapter);
 #endif

        /* default flow control settings */
@@ -9352,7 +9378,8 @@ skip_sriov:
        netdev->priv_flags |= IFF_SUPP_NOFCS;

 #ifdef CONFIG_IXGBE_DCB
-       netdev->dcbnl_ops = &dcbnl_ops;
+       if (adapter->flags & IXGBE_FLAG_DCB_CAPABLE)
+               netdev->dcbnl_ops = &dcbnl_ops;
 #endif

 #ifdef IXGBE_FCOE
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 7af4514..44b256a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -548,6 +548,7 @@ struct ixgbe_thermal_sensor_data {
 /* DCB registers */
 #define MAX_TRAFFIC_CLASS        8
 #define X540_TRAFFIC_CLASS       4
+#define DEF_TRAFFIC_CLASS        1
 #define IXGBE_RMCS      0x03D00
 #define IXGBE_DPMCS     0x07F40
 #define IXGBE_PDPMCS    0x0CD00

Our validation found nothing wrong with this patch, works as expected, thanks Usha!
Tested-by: Ronald Bynoe <ronald.j.bynoe@intel.com>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at lists.osuosl.org
http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
