From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 30 Oct 2018 10:50:47 -0700
Subject: [Intel-wired-lan] [next S97 v2 6/6] i40e: Allow disabling FW LLDP
 on X722 devices
In-Reply-To: <20181030175047.18874-1-jeffrey.t.kirsher@intel.com>
References: <20181030175047.18874-1-jeffrey.t.kirsher@intel.com>
Message-ID: <20181030175047.18874-6-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Patryk Ma?ek <patryk.malek@intel.com>

This patch allows disabling FW LLDP agent on X722 devices.
It also changes a source of information for this feature from
pf->hw_features to pf->hw.flags which are set in i40e_init_adminq.

Signed-off-by: Patryk Ma?ek <patryk.malek@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h         |  1 -
 drivers/net/ethernet/intel/i40e/i40e_common.c  |  3 +++
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 13 +++++++------
 drivers/net/ethernet/intel/i40e/i40e_main.c    | 15 +++++++--------
 4 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index f575b03bc3ed..382b39e326ce 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -496,7 +496,6 @@ struct i40e_pf {
 #define I40E_HW_STOP_FW_LLDP			BIT(16)
 #define I40E_HW_PORT_ID_VALID			BIT(17)
 #define I40E_HW_RESTART_AUTONEG			BIT(18)
-#define I40E_HW_STOPPABLE_FW_LLDP		BIT(19)
 
 	u32 flags;
 #define I40E_FLAG_RX_CSUM_ENABLED		BIT(0)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 85f75b5978fc..97a9b1fb4763 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -3723,6 +3723,9 @@ i40e_aq_set_dcb_parameters(struct i40e_hw *hw, bool dcb_enable,
 		(struct i40e_aqc_set_dcb_parameters *)&desc.params.raw;
 	i40e_status status;
 
+	if (!(hw->flags & I40E_HW_FLAG_FW_LLDP_STOPPABLE))
+		return I40E_ERR_DEVICE_NOT_SUPPORTED;
+
 	i40e_fill_default_direct_cmd_desc(&desc,
 					  i40e_aqc_opc_set_dcb_parameters);
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 2bb116fe1515..213e412eb7d7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -4659,14 +4659,15 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 		return -EOPNOTSUPP;
 
 	/* If the driver detected FW LLDP was disabled on init, this flag could
-	 * be set, however we do not support _changing_ the flag if NPAR is
-	 * enabled or FW API version < 1.7.  There are situations where older
-	 * FW versions/NPAR enabled PFs could disable LLDP, however we _must_
-	 * not allow the user to enable/disable LLDP with this flag on
-	 * unsupported FW versions.
+	 * be set, however we do not support _changing_ the flag:
+	 * - on XL710 if NPAR is enabled or FW API version < 1.7
+	 * - on X722 with FW API version < 1.6
+	 * There are situations where older FW versions/NPAR enabled PFs could
+	 * disable LLDP, however we _must_ not allow the user to enable/disable
+	 * LLDP with this flag on unsupported FW versions.
 	 */
 	if (changed_flags & I40E_FLAG_DISABLE_FW_LLDP) {
-		if (!(pf->hw_features & I40E_HW_STOPPABLE_FW_LLDP)) {
+		if (!(pf->hw.flags & I40E_HW_FLAG_FW_LLDP_STOPPABLE)) {
 			dev_warn(&pf->pdev->dev,
 				 "Device does not support changing FW LLDP\n");
 			return -EOPNOTSUPP;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 61a99a8e9566..7963ec46ab59 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -11431,16 +11431,15 @@ static int i40e_sw_init(struct i40e_pf *pf)
 		/* IWARP needs one extra vector for CQP just like MISC.*/
 		pf->num_iwarp_msix = (int)num_online_cpus() + 1;
 	}
-	/* Stopping the FW LLDP engine is only supported on the
-	 * XL710 with a FW ver >= 1.7.  Also, stopping FW LLDP
-	 * engine is not supported if NPAR is functioning on this
-	 * part
+	/* Stopping FW LLDP engine is supported on XL710 and X722
+	 * starting from FW versions determined in i40e_init_adminq.
+	 * Stopping the FW LLDP engine is not supported on XL710
+	 * if NPAR is functioning so unset this hw flag in this case.
 	 */
 	if (pf->hw.mac.type == I40E_MAC_XL710 &&
-	    !pf->hw.func_caps.npar_enable &&
-	    (pf->hw.aq.api_maj_ver > 1 ||
-	     (pf->hw.aq.api_maj_ver == 1 && pf->hw.aq.api_min_ver > 6)))
-		pf->hw_features |= I40E_HW_STOPPABLE_FW_LLDP;
+	    pf->hw.func_caps.npar_enable &&
+	    (pf->hw.flags & I40E_HW_FLAG_FW_LLDP_STOPPABLE))
+		pf->hw.flags &= ~I40E_HW_FLAG_FW_LLDP_STOPPABLE;
 
 #ifdef CONFIG_PCI_IOV
 	if (pf->hw.func_caps.num_vfs && pf->hw.partition_id == 1) {
-- 
2.17.2

