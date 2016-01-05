From: Deepthi Kavalur <deepthi.kavalur@intel.com>
Date: Mon,  4 Jan 2016 18:03:13 -0800
Subject: [Intel-wired-lan] [next PATCH] i40e: add priv flag for automatic
	rule eviction
Message-ID: <1451959393-4771-1-git-send-email-deepthi.kavalur@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anjali Singhai Jain <anjali.singhai@intel.com>

The X722 can support automatic rule eviction for automatically added
flow director rules.  Feature is (should be) disabled by default.

Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h         | 1 +
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 9 +++++++++
 drivers/net/ethernet/intel/i40e/i40e_main.c    | 2 ++
 drivers/net/ethernet/intel/i40e/i40e_txrx.c    | 6 ++++--
 drivers/net/ethernet/intel/i40e/i40e_type.h    | 4 ++++
 5 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 5dfe33b..7ec304c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -104,6 +104,7 @@
 #define I40E_PRIV_FLAGS_FD_ATR		BIT(2)
 #define I40E_PRIV_FLAGS_VEB_STATS	BIT(3)
 #define I40E_PRIV_FLAGS_PS		BIT(4)
+#define I40E_PRIV_FLAGS_HW_ATR_EVICT    BIT(5)
 
 #define I40E_NVM_VERSION_LO_SHIFT  0
 #define I40E_NVM_VERSION_LO_MASK   (0xff << I40E_NVM_VERSION_LO_SHIFT)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 252a9dd..80c3f20 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -232,6 +232,7 @@ static const char i40e_priv_flags_strings[][ETH_GSTRING_LEN] = {
 	"flow-director-atr",
 	"veb-stats",
 	"packet-split",
+	"hw-atr-eviction",
 };
 
 #define I40E_PRIV_FLAGS_STR_LEN ARRAY_SIZE(i40e_priv_flags_strings)
@@ -2706,6 +2707,8 @@ static u32 i40e_get_priv_flags(struct net_device *dev)
 		I40E_PRIV_FLAGS_VEB_STATS : 0;
 	ret_flags |= pf->flags & I40E_FLAG_RX_PS_ENABLED ?
 		I40E_PRIV_FLAGS_PS : 0;
+	ret_flags |= pf->auto_disable_flags & I40E_FLAG_HW_ATR_EVICT_CAPABLE ?
+		0 : I40E_PRIV_FLAGS_HW_ATR_EVICT;
 
 	return ret_flags;
 }
@@ -2762,6 +2765,12 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 	else
 		pf->flags &= ~I40E_FLAG_VEB_STATS_ENABLED;
 
+	if ((flags & I40E_PRIV_FLAGS_HW_ATR_EVICT) &&
+				   (pf->flags & I40E_FLAG_HW_ATR_EVICT_CAPABLE))
+		pf->auto_disable_flags &= ~I40E_FLAG_HW_ATR_EVICT_CAPABLE;
+	else
+		pf->auto_disable_flags |= I40E_FLAG_HW_ATR_EVICT_CAPABLE;
+
 	/* if needed, issue reset to cause things to take effect */
 	if (reset_required)
 		i40e_do_reset(pf, BIT(__I40E_PF_RESET_REQUESTED));
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index c9393d2..58da2f1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8396,6 +8396,8 @@ static int i40e_sw_init(struct i40e_pf *pf)
 			     I40E_FLAG_OUTER_UDP_CSUM_CAPABLE |
 			     I40E_FLAG_WB_ON_ITR_CAPABLE |
 			     I40E_FLAG_MULTIPLE_TCP_UDP_RSS_PCTYPE;
+	} else {
+		pf->auto_disable_flags = I40E_FLAG_HW_ATR_EVICT_CAPABLE;
 	}
 	pf->eeprom_version = 0xDEAD;
 	pf->lan_veb = I40E_NO_VEB;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index ba79f67..94dbeb3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2039,7 +2039,8 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
 	/* Due to lack of space, no more new filters can be programmed */
 	if (th->syn && (pf->auto_disable_flags & I40E_FLAG_FD_ATR_ENABLED))
 		return;
-	if (pf->flags & I40E_FLAG_HW_ATR_EVICT_CAPABLE) {
+	if ((pf->flags & I40E_FLAG_HW_ATR_EVICT_CAPABLE) &&
+	    (!(pf->auto_disable_flags & I40E_FLAG_HW_ATR_EVICT_CAPABLE))) {
 		/* HW ATR eviction will take care of removing filters on FIN
 		 * and RST packets.
 		 */
@@ -2101,7 +2102,8 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
 			I40E_TXD_FLTR_QW1_CNTINDEX_SHIFT) &
 			I40E_TXD_FLTR_QW1_CNTINDEX_MASK;
 
-	if (pf->flags & I40E_FLAG_HW_ATR_EVICT_CAPABLE)
+	if ((pf->flags & I40E_FLAG_HW_ATR_EVICT_CAPABLE) &&
+	    (!(pf->auto_disable_flags & I40E_FLAG_HW_ATR_EVICT_CAPABLE)))
 		dtype_cmd |= I40E_TXD_FLTR_QW1_ATR_MASK;
 
 	fdir_desc->qindex_flex_ptype_vsi = cpu_to_le32(flex_ptype);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index dd2da35..b59a021 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -1098,6 +1098,10 @@ enum i40e_filter_program_desc_pcmd {
 					 I40E_TXD_FLTR_QW1_CMD_SHIFT)
 #define I40E_TXD_FLTR_QW1_ATR_MASK	BIT_ULL(I40E_TXD_FLTR_QW1_ATR_SHIFT)
 
+#define I40E_TXD_FLTR_QW1_ATR_SHIFT	(0xEULL + \
+					 I40E_TXD_FLTR_QW1_CMD_SHIFT)
+#define I40E_TXD_FLTR_QW1_ATR_MASK	BIT_ULL(I40E_TXD_FLTR_QW1_ATR_SHIFT)
+
 #define I40E_TXD_FLTR_QW1_CNTINDEX_SHIFT 20
 #define I40E_TXD_FLTR_QW1_CNTINDEX_MASK	(0x1FFUL << \
 					 I40E_TXD_FLTR_QW1_CNTINDEX_SHIFT)
-- 
2.1.0

