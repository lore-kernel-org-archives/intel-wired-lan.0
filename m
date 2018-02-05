From: Alice Michael <alice.michael@intel.com>
Date: Mon,  5 Feb 2018 06:11:19 -0500
Subject: [Intel-wired-lan] [next PATCH S86 V3 6/8] i40e: i40e: Change
 ethtool check from MAC to HW flag
In-Reply-To: <20180205111121.59468-1-alice.michael@intel.com>
References: <20180205111121.59468-1-alice.michael@intel.com>
Message-ID: <20180205111121.59468-6-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Dave Ertman <david.m.ertman@intel.com>

The MAC, FW Version and NPAR check used to determine
if shutting off the FW LLDP engine is supported is not
using the usual feature check mechanism.

This patch fixes the problem by moving the feature check
to i40e_sw_init in order to set a flag in pf->hw_features
that ethtool will use for priv_flags disable operation.

Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h         |  1 +
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 12 ++----------
 drivers/net/ethernet/intel/i40e/i40e_main.c    | 10 ++++++++++
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index ebe795a..4cf9929 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -507,6 +507,7 @@ struct i40e_pf {
 #define I40E_HW_STOP_FW_LLDP			BIT(16)
 #define I40E_HW_PORT_ID_VALID			BIT(17)
 #define I40E_HW_RESTART_AUTONEG			BIT(18)
+#define I40E_HW_STOPPABLE_FW_LLDP		BIT(19)
 
 	u64 flags;
 #define I40E_FLAG_RX_CSUM_ENABLED		BIT_ULL(0)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index abc057c..c3e4767 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -4428,17 +4428,9 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 	 * unsupported FW verions.
 	 */
 	if (changed_flags & I40E_FLAG_DISABLE_FW_LLDP) {
-		if (pf->hw.func_caps.npar_enable) {
+		if (!(pf->hw_features & I40E_HW_STOPPABLE_FW_LLDP)) {
 			dev_warn(&pf->pdev->dev,
-				 "Unable to change FW LLDP if NPAR active\n");
-			return -EOPNOTSUPP;
-		}
-
-		if (pf->hw.aq.api_maj_ver < 1 ||
-		    (pf->hw.aq.api_maj_ver == 1 &&
-		     pf->hw.aq.api_min_ver < 7)) {
-			dev_warn(&pf->pdev->dev,
-				 "FW ver does not support changing FW LLDP\n");
+				 "Device does not support changing FW LLDP\n");
 			return -EOPNOTSUPP;
 		}
 	}
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 90ea65b..058d524 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -11159,6 +11159,16 @@ static int i40e_sw_init(struct i40e_pf *pf)
 		/* IWARP needs one extra vector for CQP just like MISC.*/
 		pf->num_iwarp_msix = (int)num_online_cpus() + 1;
 	}
+	/* Stopping the FW LLDP engine is only supported on the
+	 * XL710 with a FW ver >= 1.7.  Also, stopping FW LLDP
+	 * engine is not supported if NPAR is functioning on this
+	 * part
+	 */
+	if (pf->hw.mac.type == I40E_MAC_XL710 &&
+	    !pf->hw.func_caps.npar_enable &&
+	    (pf->hw.aq.api_maj_ver > 1 ||
+	     (pf->hw.aq.api_maj_ver == 1 && pf->hw.aq.api_min_ver > 6)))
+		pf->hw_features |= I40E_HW_STOPPABLE_FW_LLDP;
 
 #ifdef CONFIG_PCI_IOV
 	if (pf->hw.func_caps.num_vfs && pf->hw.partition_id == 1) {
-- 
2.9.5

