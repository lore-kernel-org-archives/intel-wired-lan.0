From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu, 27 Aug 2015 11:42:40 -0400
Subject: [Intel-wired-lan] [next PATCH S12 12/15] i40e: add switch for link
	polling
In-Reply-To: <1440690163-128213-1-git-send-email-catherine.sullivan@intel.com>
References: <1440690163-128213-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1440690163-128213-13-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

There's been some need for controlling the periodic link polling for
debugging link issues.  This patch enables switching it off and on
through an ethtool private flag.  The link poll remains on by default,
but can be turned off with
	ethtool --set-priv-flags p261p1 LinkPolling off
and later turned back on with
	ethtool --set-priv-flags p261p1 LinkPolling on

To check the current status, use
	ethtool --show-priv-flags p261p1

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Change-ID: I32e4ab654ff3eec90a06cf144899971b82d71c40
---
 drivers/net/ethernet/intel/i40e/i40e.h         |  2 ++
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 26 ++++++++++++++++++++++++--
 drivers/net/ethernet/intel/i40e/i40e_main.c    |  4 +++-
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 672ca75..9c9601c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -101,6 +101,7 @@
 
 /* Ethtool Private Flags */
 #define I40E_PRIV_FLAGS_NPAR_FLAG	BIT(0)
+#define I40E_PRIV_FLAGS_LINKPOLL_FLAG	BIT(1)
 
 #define I40E_NVM_VERSION_LO_SHIFT  0
 #define I40E_NVM_VERSION_LO_MASK   (0xff << I40E_NVM_VERSION_LO_SHIFT)
@@ -329,6 +330,7 @@ struct i40e_pf {
 #define I40E_FLAG_WB_ON_ITR_CAPABLE		BIT_ULL(35)
 #define I40E_FLAG_VEB_STATS_ENABLED		BIT_ULL(37)
 #define I40E_FLAG_MULTIPLE_TCP_UDP_RSS_PCTYPE	BIT_ULL(38)
+#define I40E_FLAG_LINK_POLLING_ENABLED		BIT_ULL(39)
 #define I40E_FLAG_VEB_MODE_ENABLED		BIT_ULL(40)
 #define I40E_FLAG_GENEVE_OFFLOAD_CAPABLE	BIT_ULL(41)
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index f2b4f8b..5a726f2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -230,10 +230,10 @@ static const char i40e_gstrings_test[][ETH_GSTRING_LEN] = {
 
 static const char i40e_priv_flags_strings[][ETH_GSTRING_LEN] = {
 	"NPAR",
+	"LinkPolling",
 };
 
-#define I40E_PRIV_FLAGS_STR_LEN \
-	(sizeof(i40e_priv_flags_strings) / ETH_GSTRING_LEN)
+#define I40E_PRIV_FLAGS_STR_LEN ARRAY_SIZE(i40e_priv_flags_strings)
 
 /**
  * i40e_partition_setting_complaint - generic complaint for MFP restriction
@@ -2636,10 +2636,31 @@ static u32 i40e_get_priv_flags(struct net_device *dev)
 
 	ret_flags |= pf->hw.func_caps.npar_enable ?
 		I40E_PRIV_FLAGS_NPAR_FLAG : 0;
+	ret_flags |= pf->flags & I40E_FLAG_LINK_POLLING_ENABLED ?
+		I40E_PRIV_FLAGS_LINKPOLL_FLAG : 0;
 
 	return ret_flags;
 }
 
+/**
+ * i40e_set_priv_flags - set private flags
+ * @dev: network interface device structure
+ * @flags: bit flags to be set
+ **/
+static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
+{
+	struct i40e_netdev_priv *np = netdev_priv(dev);
+	struct i40e_vsi *vsi = np->vsi;
+	struct i40e_pf *pf = vsi->back;
+
+	if (flags & I40E_PRIV_FLAGS_LINKPOLL_FLAG)
+		pf->flags |= I40E_FLAG_LINK_POLLING_ENABLED;
+	else
+		pf->flags &= ~I40E_FLAG_LINK_POLLING_ENABLED;
+
+	return 0;
+}
+
 static const struct ethtool_ops i40e_ethtool_ops = {
 	.get_settings		= i40e_get_settings,
 	.set_settings		= i40e_set_settings,
@@ -2676,6 +2697,7 @@ static const struct ethtool_ops i40e_ethtool_ops = {
 	.set_channels		= i40e_set_channels,
 	.get_ts_info		= i40e_get_ts_info,
 	.get_priv_flags		= i40e_get_priv_flags,
+	.set_priv_flags		= i40e_set_priv_flags,
 };
 
 void i40e_set_ethtool_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 73c6d37..4830c91 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5745,7 +5745,8 @@ static void i40e_watchdog_subtask(struct i40e_pf *pf)
 	pf->service_timer_previous = jiffies;
 
 	i40e_check_hang_subtask(pf);
-	i40e_link_event(pf);
+	if (pf->flags & I40E_FLAG_LINK_POLLING_ENABLED)
+		i40e_link_event(pf);
 
 	/* Update the stats for active netdevs so the network stack
 	 * can look at updated numbers whenever it cares to
@@ -7756,6 +7757,7 @@ static int i40e_sw_init(struct i40e_pf *pf)
 	/* Set default capability flags */
 	pf->flags = I40E_FLAG_RX_CSUM_ENABLED |
 		    I40E_FLAG_MSI_ENABLED     |
+		    I40E_FLAG_LINK_POLLING_ENABLED |
 		    I40E_FLAG_MSIX_ENABLED;
 
 	if (iommu_present(&pci_bus_type))
-- 
1.9.3

