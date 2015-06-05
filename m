From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Fri,  5 Jun 2015 12:20:33 -0400
Subject: [Intel-wired-lan] [intel-wired-lan][net-next PATCH S07 09/10]
	i40e/i40evf: Add ATR HW eviction support for X722
In-Reply-To: <1433521234-33355-1-git-send-email-catherine.sullivan@intel.com>
References: <1433521234-33355-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1433521234-33355-10-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anjali Singhai Jain <anjali.singhai@intel.com>

X722 supports evicting ATR filters in the HW. With this patch, we enable
the feature in the driver and avoid filter deletion by the driver.

Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 10 ++++++++++
 drivers/net/ethernet/intel/i40e/i40e_type.h |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 4d48229..ee7f1bc 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2040,6 +2040,13 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
 	/* Due to lack of space, no more new filters can be programmed */
 	if (th->syn && (pf->auto_disable_flags & I40E_FLAG_FD_ATR_ENABLED))
 		return;
+	if (pf->flags & I40E_FLAG_HW_ATR_EVICT_CAPABLE) {
+		/* HW ATR eviction will take care of removing filters on FIN
+		 * and RST packets.
+		 */
+		if (th->fin || th->rst)
+			return;
+	}
 
 	tx_ring->atr_count++;
 
@@ -2095,6 +2102,9 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
 			I40E_TXD_FLTR_QW1_CNTINDEX_SHIFT) &
 			I40E_TXD_FLTR_QW1_CNTINDEX_MASK;
 
+	if (pf->flags & I40E_FLAG_HW_ATR_EVICT_CAPABLE)
+		dtype_cmd |= I40E_TXD_FLTR_QW1_ATR_MASK;
+
 	fdir_desc->qindex_flex_ptype_vsi = cpu_to_le32(flex_ptype);
 	fdir_desc->rsvd = cpu_to_le32(0);
 	fdir_desc->dtype_cmd_cntindex = cpu_to_le32(dtype_cmd);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index b93357d..61b6b11 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -1049,6 +1049,10 @@ enum i40e_filter_program_desc_pcmd {
 #define I40E_TXD_FLTR_QW1_FD_STATUS_MASK (0x3ULL << \
 					  I40E_TXD_FLTR_QW1_FD_STATUS_SHIFT)
 
+#define I40E_TXD_FLTR_QW1_ATR_SHIFT	(0xEULL + \
+					 I40E_TXD_FLTR_QW1_CMD_SHIFT)
+#define I40E_TXD_FLTR_QW1_ATR_MASK	BIT_ULL(I40E_TXD_FLTR_QW1_ATR_SHIFT)
+
 #define I40E_TXD_FLTR_QW1_CNTINDEX_SHIFT 20
 #define I40E_TXD_FLTR_QW1_CNTINDEX_MASK	(0x1FFUL << \
 					 I40E_TXD_FLTR_QW1_CNTINDEX_SHIFT)
-- 
1.9.3

