From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon, 12 Jun 2017 14:51:18 -0700
Subject: [Intel-wired-lan] i40e: fix handling of HW ATR eviction
Message-ID: <20170612215118.17642-1-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

A recent commit to refactor the driver and remove the hw_disabled_flags
field accidentally introduced two regressions. First, we overwrote
pf->flags which removed various key flags including the MSI-X settings.

Additionally, it was intended that we have now two flags,
HW_ATR_EVICT_CAPABLe and HW_ATR_EVICT_ENABLED, but this was not done,
and we accidentally were mis-using HW_ATR_EVICT_CAPABLE everywhere.

This patch adds the missing piece, HW_ATR_EVICT_ENABLED, and safely
updates pf->flags instead of overwriting it.

Without this patch we will have many problems including disabling MSI-X
support, and we'll attempt to use HW ATR eviction on devices which do
not support it.

Fixes: 47994c119a36 ("i40e: remove hw_disabled_flags in favor of using separate flag bits", 2017-04-19)
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h         |    1 +
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c |    4 ++--
 drivers/net/ethernet/intel/i40e/i40e_main.c    |    7 ++++---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c    |    4 ++--
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 60dc9b2c19ff..395ca94faf80 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -399,6 +399,7 @@ struct i40e_pf {
 #define I40E_FLAG_RX_CSUM_ENABLED		BIT_ULL(1)
 #define I40E_FLAG_MSI_ENABLED			BIT_ULL(2)
 #define I40E_FLAG_MSIX_ENABLED			BIT_ULL(3)
+#define I40E_FLAG_HW_ATR_EVICT_ENABLED		BIT_ULL(4)
 #define I40E_FLAG_RSS_ENABLED			BIT_ULL(6)
 #define I40E_FLAG_VMDQ_ENABLED			BIT_ULL(7)
 #define I40E_FLAG_IWARP_ENABLED			BIT_ULL(10)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 35a246f05520..3d58762efbc0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -225,7 +225,7 @@ static const struct i40e_priv_flags i40e_gstrings_priv_flags[] = {
 	I40E_PRIV_FLAG("LinkPolling", I40E_FLAG_LINK_POLLING_ENABLED, 0),
 	I40E_PRIV_FLAG("flow-director-atr", I40E_FLAG_FD_ATR_ENABLED, 0),
 	I40E_PRIV_FLAG("veb-stats", I40E_FLAG_VEB_STATS_ENABLED, 0),
-	I40E_PRIV_FLAG("hw-atr-eviction", I40E_FLAG_HW_ATR_EVICT_CAPABLE, 0),
+	I40E_PRIV_FLAG("hw-atr-eviction", I40E_FLAG_HW_ATR_EVICT_ENABLED, 0),
 	I40E_PRIV_FLAG("legacy-rx", I40E_FLAG_LEGACY_RX, 0),
 };
 
@@ -4093,7 +4093,7 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 
 	/* Only allow ATR evict on hardware that is capable of handling it */
 	if (pf->flags & I40E_FLAG_HW_ATR_EVICT_CAPABLE)
-		pf->flags &= ~I40E_FLAG_HW_ATR_EVICT_CAPABLE;
+		pf->flags &= ~I40E_FLAG_HW_ATR_EVICT_ENABLED;
 
 	if (changed_flags & I40E_FLAG_TRUE_PROMISC_SUPPORT) {
 		u16 sw_flags = 0, valid_flags = 0;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index abab7fb7a3fc..98fb644a580e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8823,11 +8823,12 @@ static int i40e_sw_init(struct i40e_pf *pf)
 		    (pf->hw.aq.api_min_ver > 4))) {
 		/* Supported in FW API version higher than 1.4 */
 		pf->flags |= I40E_FLAG_GENEVE_OFFLOAD_CAPABLE;
-		pf->flags = I40E_FLAG_HW_ATR_EVICT_CAPABLE;
-	} else {
-		pf->flags = I40E_FLAG_HW_ATR_EVICT_CAPABLE;
 	}
 
+	/* Enable HW ATR eviction if possible */
+	if (pf->flags & I40E_FLAG_HW_ATR_EVICT_CAPABLE)
+		pf->flags |= I40E_FLAG_HW_ATR_EVICT_ENABLED;
+
 	pf->eeprom_version = 0xDEAD;
 	pf->lan_veb = I40E_NO_VEB;
 	pf->lan_vsi = I40E_NO_VSI;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index ddf885084c77..af554f3cda19 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2341,7 +2341,7 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
 	/* Due to lack of space, no more new filters can be programmed */
 	if (th->syn && (pf->flags & I40E_FLAG_FD_ATR_AUTO_DISABLED))
 		return;
-	if (pf->flags & I40E_FLAG_HW_ATR_EVICT_CAPABLE) {
+	if (pf->flags & I40E_FLAG_HW_ATR_EVICT_ENABLED) {
 		/* HW ATR eviction will take care of removing filters on FIN
 		 * and RST packets.
 		 */
@@ -2403,7 +2403,7 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
 			I40E_TXD_FLTR_QW1_CNTINDEX_SHIFT) &
 			I40E_TXD_FLTR_QW1_CNTINDEX_MASK;
 
-	if (pf->flags & I40E_FLAG_HW_ATR_EVICT_CAPABLE)
+	if (pf->flags & I40E_FLAG_HW_ATR_EVICT_ENABLED)
 		dtype_cmd |= I40E_TXD_FLTR_QW1_ATR_MASK;
 
 	fdir_desc->qindex_flex_ptype_vsi = cpu_to_le32(flex_ptype);
