From: Alice Michael <alice.michael@intel.com>
Date: Wed, 27 Dec 2017 07:32:35 -0500
Subject: [Intel-wired-lan] [next PATCH S84-V2 06/13] i40e: change flags to
 use 64 bits
In-Reply-To: <20171227123242.22356-1-alice.michael@intel.com>
References: <20171227123242.22356-1-alice.michael@intel.com>
Message-ID: <20171227123242.22356-6-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

As we have added more flags, we need to now use more
bits and have overflooded the 32 bit size.  So
make it 64.

also change all the existing bits to unsigned long long
bits.

Signed-off-by: Alice Michael <alice.michael@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h         | 67 +++++++++++++-------------
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  4 +-
 2 files changed, 36 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index e019baa..46e9f4e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -508,39 +508,40 @@ struct i40e_pf {
 #define I40E_HW_PORT_ID_VALID			BIT(17)
 #define I40E_HW_RESTART_AUTONEG			BIT(18)
 
-	u32 flags;
-#define I40E_FLAG_RX_CSUM_ENABLED		BIT(0)
-#define I40E_FLAG_MSI_ENABLED			BIT(1)
-#define I40E_FLAG_MSIX_ENABLED			BIT(2)
-#define I40E_FLAG_RSS_ENABLED			BIT(3)
-#define I40E_FLAG_VMDQ_ENABLED			BIT(4)
-#define I40E_FLAG_FILTER_SYNC			BIT(5)
-#define I40E_FLAG_SRIOV_ENABLED			BIT(6)
-#define I40E_FLAG_DCB_CAPABLE			BIT(7)
-#define I40E_FLAG_DCB_ENABLED			BIT(8)
-#define I40E_FLAG_FD_SB_ENABLED			BIT(9)
-#define I40E_FLAG_FD_ATR_ENABLED		BIT(10)
-#define I40E_FLAG_FD_SB_AUTO_DISABLED		BIT(11)
-#define I40E_FLAG_FD_ATR_AUTO_DISABLED		BIT(12)
-#define I40E_FLAG_MFP_ENABLED			BIT(13)
-#define I40E_FLAG_UDP_FILTER_SYNC		BIT(14)
-#define I40E_FLAG_HW_ATR_EVICT_ENABLED		BIT(15)
-#define I40E_FLAG_VEB_MODE_ENABLED		BIT(16)
-#define I40E_FLAG_VEB_STATS_ENABLED		BIT(17)
-#define I40E_FLAG_LINK_POLLING_ENABLED		BIT(18)
-#define I40E_FLAG_TRUE_PROMISC_SUPPORT		BIT(19)
-#define I40E_FLAG_TEMP_LINK_POLLING		BIT(20)
-#define I40E_FLAG_LEGACY_RX			BIT(21)
-#define I40E_FLAG_PTP				BIT(22)
-#define I40E_FLAG_IWARP_ENABLED			BIT(23)
-#define I40E_FLAG_SERVICE_CLIENT_REQUESTED	BIT(24)
-#define I40E_FLAG_CLIENT_L2_CHANGE		BIT(25)
-#define I40E_FLAG_CLIENT_RESET			BIT(26)
-#define I40E_FLAG_LINK_DOWN_ON_CLOSE_ENABLED	BIT(27)
-#define I40E_FLAG_SOURCE_PRUNING_DISABLED	BIT(28)
-#define I40E_FLAG_TC_MQPRIO			BIT(29)
-#define I40E_FLAG_FD_SB_INACTIVE		BIT(30)
-#define I40E_FLAG_FD_SB_TO_CLOUD_FILTER		BIT(31)
+	u64 flags;
+#define I40E_FLAG_RX_CSUM_ENABLED		BIT_ULL(0)
+#define I40E_FLAG_MSI_ENABLED			BIT_ULL(1)
+#define I40E_FLAG_MSIX_ENABLED			BIT_ULL(2)
+#define I40E_FLAG_RSS_ENABLED			BIT_ULL(3)
+#define I40E_FLAG_VMDQ_ENABLED			BIT_ULL(4)
+#define I40E_FLAG_FILTER_SYNC			BIT_ULL(5)
+#define I40E_FLAG_SRIOV_ENABLED			BIT_ULL(6)
+#define I40E_FLAG_DCB_CAPABLE			BIT_ULL(7)
+#define I40E_FLAG_DCB_ENABLED			BIT_ULL(8)
+#define I40E_FLAG_FD_SB_ENABLED			BIT_ULL(9)
+#define I40E_FLAG_FD_ATR_ENABLED		BIT_ULL(10)
+#define I40E_FLAG_FD_SB_AUTO_DISABLED		BIT_ULL(11)
+#define I40E_FLAG_FD_ATR_AUTO_DISABLED		BIT_ULL(12)
+#define I40E_FLAG_MFP_ENABLED			BIT_ULL(13)
+#define I40E_FLAG_UDP_FILTER_SYNC		BIT_ULL(14)
+#define I40E_FLAG_HW_ATR_EVICT_ENABLED		BIT_ULL(15)
+#define I40E_FLAG_VEB_MODE_ENABLED		BIT_ULL(16)
+#define I40E_FLAG_VEB_STATS_ENABLED		BIT_ULL(17)
+#define I40E_FLAG_LINK_POLLING_ENABLED		BIT_ULL(18)
+#define I40E_FLAG_TRUE_PROMISC_SUPPORT		BIT_ULL(19)
+#define I40E_FLAG_TEMP_LINK_POLLING		BIT_ULL(20)
+#define I40E_FLAG_LEGACY_RX			BIT_ULL(21)
+#define I40E_FLAG_PTP				BIT_ULL(22)
+#define I40E_FLAG_IWARP_ENABLED			BIT_ULL(23)
+#define I40E_FLAG_SERVICE_CLIENT_REQUESTED	BIT_ULL(24)
+#define I40E_FLAG_CLIENT_L2_CHANGE		BIT_ULL(25)
+#define I40E_FLAG_CLIENT_RESET			BIT_ULL(26)
+#define I40E_FLAG_LINK_DOWN_ON_CLOSE_ENABLED	BIT_ULL(27)
+#define I40E_FLAG_SOURCE_PRUNING_DISABLED	BIT_ULL(28)
+#define I40E_FLAG_TC_MQPRIO			BIT_ULL(29)
+#define I40E_FLAG_FD_SB_INACTIVE		BIT_ULL(30)
+#define I40E_FLAG_FD_SB_TO_CLOUD_FILTER		BIT_ULL(31)
+#define I40E_FLAG_DISABLE_FW_LLDP		BIT_ULL(32)
 
 	struct i40e_client_instance *cinst;
 	bool stat_offsets_loaded;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 79c752a..e42b1c2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -4266,7 +4266,7 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 	struct i40e_netdev_priv *np = netdev_priv(dev);
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_pf *pf = vsi->back;
-	u32 orig_flags, new_flags, changed_flags;
+	u64 orig_flags, new_flags, changed_flags;
 	u32 i, j;
 
 	orig_flags = READ_ONCE(pf->flags);
@@ -4323,7 +4323,7 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 	 * originally. We'll just punt with an error and log something in the
 	 * message buffer.
 	 */
-	if (cmpxchg(&pf->flags, orig_flags, new_flags) != orig_flags) {
+	if (cmpxchg64(&pf->flags, orig_flags, new_flags) != orig_flags) {
 		dev_warn(&pf->pdev->dev,
 			 "Unable to update pf->flags as it was modified by another thread...\n");
 		return -EAGAIN;
-- 
2.9.5

