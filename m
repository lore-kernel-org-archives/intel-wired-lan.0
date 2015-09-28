From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 28 Sep 2015 14:12:37 -0400
Subject: [Intel-wired-lan] [next PATCH S16 08/15] i40e/i40evf: moderate
	interrupts differently
In-Reply-To: <1443463964-148204-1-git-send-email-catherine.sullivan@intel.com>
References: <1443463964-148204-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1443463964-148204-9-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

The XL710 hardware has a different interrupt moderation design
that can support a limit of total interrupts per second per
vector, in addition to the "number of interrupts per second"
controls already established in the driver.  This combination
of hardware features allows us to set very low default latency
settings but minimize the total CPU utilization by not
making too many interrupts, should the user desire.

The current driver implementation is still enabling the dynamic
moderation in the driver, and only using the rx/tx-usecs
limit in ethtool to limit the interrupt rate per second, by default.

The new code implemented in this patch
2) adds init/use of the new "Interrupt Limit" register
3) adds ethtool knob to control/report the limits above

Usage is ethtool -C ethx rx-usecs-high <value> Where <value> is number
of microseconds to create a rate of 1/N interrupts per second,
regardless of rx-usecs or tx-usecs values. Since there is a credit based
scheme in the hardware, the rx-usecs and tx-usecs can be configured for
very low latency for short bursts, but once the credit runs out the
refill rate on the credits is limited by rx-usecs-high.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Change-ID: I3a1075d3296123b0f4f50623c779b027af5b188d
---
 drivers/net/ethernet/intel/i40e/i40e.h         |  1 +
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 24 ++++++++++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_main.c    | 10 +++++++---
 drivers/net/ethernet/intel/i40e/i40e_txrx.h    | 10 ++++++++++
 drivers/net/ethernet/intel/i40evf/i40e_txrx.h  | 10 ++++++++++
 5 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 446d6a8..c714822 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -500,6 +500,7 @@ struct i40e_vsi {
 	 */
 	u16 rx_itr_setting;
 	u16 tx_itr_setting;
+	u16 int_rate_limit;  /* value in usecs */
 
 	u16 rss_table_size;
 	u16 rss_size;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 21612d9..baec2f8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1846,6 +1846,14 @@ static int i40e_get_coalesce(struct net_device *netdev,
 
 	ec->rx_coalesce_usecs = vsi->rx_itr_setting & ~I40E_ITR_DYNAMIC;
 	ec->tx_coalesce_usecs = vsi->tx_itr_setting & ~I40E_ITR_DYNAMIC;
+	/* we use the _usecs_high to store/set the interrupt rate limit
+	 * that the hardware supports, that almost but not quite
+	 * fits the original intent of the ethtool variable,
+	 * the rx_coalesce_usecs_high limits total interrupts
+	 * per second from both tx/rx sources.
+	 */
+	ec->rx_coalesce_usecs_high = vsi->int_rate_limit;
+	ec->tx_coalesce_usecs_high = vsi->int_rate_limit;
 
 	return 0;
 }
@@ -1864,6 +1872,17 @@ static int i40e_set_coalesce(struct net_device *netdev,
 	if (ec->tx_max_coalesced_frames_irq || ec->rx_max_coalesced_frames_irq)
 		vsi->work_limit = ec->tx_max_coalesced_frames_irq;
 
+	/* tx_coalesce_usecs_high is ignored, use rx-usecs-high instead */
+	if (ec->tx_coalesce_usecs_high != vsi->int_rate_limit) {
+		netif_info(pf, drv, netdev, "tx-usecs-high is not used, please program rx-usecs-high\n");
+		return -EINVAL;
+	}
+
+	if (ec->rx_coalesce_usecs_high >= INTRL_REG_TO_USEC(I40E_MAX_INTRL)) {
+		netif_info(pf, drv, netdev, "Invalid value, rx-usecs-high range is 0-235\n");
+		return -EINVAL;
+	}
+
 	vector = vsi->base_vector;
 	if ((ec->rx_coalesce_usecs >= (I40E_MIN_ITR << 1)) &&
 	    (ec->rx_coalesce_usecs <= (I40E_MAX_ITR << 1))) {
@@ -1877,6 +1896,8 @@ static int i40e_set_coalesce(struct net_device *netdev,
 		return -EINVAL;
 	}
 
+	vsi->int_rate_limit = ec->rx_coalesce_usecs_high;
+
 	if ((ec->tx_coalesce_usecs >= (I40E_MIN_ITR << 1)) &&
 	    (ec->tx_coalesce_usecs <= (I40E_MAX_ITR << 1))) {
 		vsi->tx_itr_setting = ec->tx_coalesce_usecs;
@@ -1901,11 +1922,14 @@ static int i40e_set_coalesce(struct net_device *netdev,
 		vsi->tx_itr_setting &= ~I40E_ITR_DYNAMIC;
 
 	for (i = 0; i < vsi->num_q_vectors; i++, vector++) {
+		u16 intrl = INTRL_USEC_TO_REG(vsi->int_rate_limit);
+
 		q_vector = vsi->q_vectors[i];
 		q_vector->rx.itr = ITR_TO_REG(vsi->rx_itr_setting);
 		wr32(hw, I40E_PFINT_ITRN(0, vector - 1), q_vector->rx.itr);
 		q_vector->tx.itr = ITR_TO_REG(vsi->tx_itr_setting);
 		wr32(hw, I40E_PFINT_ITRN(1, vector - 1), q_vector->tx.itr);
+		wr32(hw, I40E_PFINT_RATEN(vector - 1), intrl);
 		i40e_flush(hw);
 	}
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index d656182..7989c2e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3087,11 +3087,9 @@ static int i40e_vsi_configure(struct i40e_vsi *vsi)
 static void i40e_vsi_configure_msix(struct i40e_vsi *vsi)
 {
 	struct i40e_pf *pf = vsi->back;
-	struct i40e_q_vector *q_vector;
 	struct i40e_hw *hw = &pf->hw;
 	u16 vector;
 	int i, q;
-	u32 val;
 	u32 qp;
 
 	/* The interrupt indexing is offset by 1 in the PFINT_ITRn
@@ -3101,7 +3099,8 @@ static void i40e_vsi_configure_msix(struct i40e_vsi *vsi)
 	qp = vsi->base_queue;
 	vector = vsi->base_vector;
 	for (i = 0; i < vsi->num_q_vectors; i++, vector++) {
-		q_vector = vsi->q_vectors[i];
+		struct i40e_q_vector *q_vector = vsi->q_vectors[i];
+
 		q_vector->rx.itr = ITR_TO_REG(vsi->rx_itr_setting);
 		q_vector->rx.latency_range = I40E_LOW_LATENCY;
 		wr32(hw, I40E_PFINT_ITRN(I40E_RX_ITR, vector - 1),
@@ -3110,10 +3109,14 @@ static void i40e_vsi_configure_msix(struct i40e_vsi *vsi)
 		q_vector->tx.latency_range = I40E_LOW_LATENCY;
 		wr32(hw, I40E_PFINT_ITRN(I40E_TX_ITR, vector - 1),
 		     q_vector->tx.itr);
+		wr32(hw, I40E_PFINT_RATEN(vector - 1),
+		     INTRL_USEC_TO_REG(vsi->int_rate_limit));
 
 		/* Linked list for the queuepairs assigned to this vector */
 		wr32(hw, I40E_PFINT_LNKLSTN(vector - 1), qp);
 		for (q = 0; q < q_vector->num_ringpairs; q++) {
+			u32 val;
+
 			val = I40E_QINT_RQCTL_CAUSE_ENA_MASK |
 			      (I40E_RX_ITR << I40E_QINT_RQCTL_ITR_INDX_SHIFT)  |
 			      (vector      << I40E_QINT_RQCTL_MSIX_INDX_SHIFT) |
@@ -7226,6 +7229,7 @@ static int i40e_vsi_mem_alloc(struct i40e_pf *pf, enum i40e_vsi_type type)
 	vsi->idx = vsi_idx;
 	vsi->rx_itr_setting = pf->rx_itr_default;
 	vsi->tx_itr_setting = pf->tx_itr_default;
+	vsi->int_rate_limit = 0;
 	vsi->rss_table_size = (vsi->type == I40E_VSI_MAIN) ?
 				pf->rss_table_size : 64;
 	vsi->netdev_registered = false;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index 75cecfa..7c0ed84 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -35,6 +35,7 @@
 #define I40E_ITR_20K               0x0019
 #define I40E_ITR_8K                0x003E
 #define I40E_ITR_4K                0x007A
+#define I40E_MAX_INTRL             0x3B    /* reg uses 4 usec resolution */
 #define I40E_ITR_RX_DEF            I40E_ITR_8K
 #define I40E_ITR_TX_DEF            I40E_ITR_4K
 #define I40E_ITR_DYNAMIC           0x8000  /* use top bit as a flag */
@@ -44,6 +45,15 @@
 #define ITR_TO_REG(setting) ((setting & ~I40E_ITR_DYNAMIC) >> 1)
 #define ITR_IS_DYNAMIC(setting) (!!(setting & I40E_ITR_DYNAMIC))
 #define ITR_REG_TO_USEC(itr_reg) (itr_reg << 1)
+/* 0x40 is the enable bit for interrupt rate limiting, and must be set if
+ * the value of the rate limit is non-zero
+ */
+#define INTRL_ENA                  BIT(6)
+#define INTRL_REG_TO_USEC(intrl) ((intrl & ~INTRL_ENA) << 2)
+#define INTRL_USEC_TO_REG(set) ((set) ? ((set) >> 2) | INTRL_ENA : 0)
+#define I40E_INTRL_8K              125     /* 8000 ints/sec */
+#define I40E_INTRL_62K             16      /* 62500 ints/sec */
+#define I40E_INTRL_83K             12      /* 83333 ints/sec */
 
 #define I40E_QUEUE_END_OF_LIST 0x7FF
 
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.h b/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
index 0c13ece..c4f5a4e 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
@@ -35,6 +35,7 @@
 #define I40E_ITR_20K               0x0019
 #define I40E_ITR_8K                0x003E
 #define I40E_ITR_4K                0x007A
+#define I40E_MAX_INTRL             0x3B    /* reg uses 4 usec resolution */
 #define I40E_ITR_RX_DEF            I40E_ITR_8K
 #define I40E_ITR_TX_DEF            I40E_ITR_4K
 #define I40E_ITR_DYNAMIC           0x8000  /* use top bit as a flag */
@@ -44,6 +45,15 @@
 #define ITR_TO_REG(setting) ((setting & ~I40E_ITR_DYNAMIC) >> 1)
 #define ITR_IS_DYNAMIC(setting) (!!(setting & I40E_ITR_DYNAMIC))
 #define ITR_REG_TO_USEC(itr_reg) (itr_reg << 1)
+/* 0x40 is the enable bit for interrupt rate limiting, and must be set if
+ * the value of the rate limit is non-zero
+ */
+#define INTRL_ENA                  BIT(6)
+#define INTRL_REG_TO_USEC(intrl) ((intrl & ~INTRL_ENA) << 2)
+#define INTRL_USEC_TO_REG(set) ((set) ? ((set) >> 2) | INTRL_ENA : 0)
+#define I40E_INTRL_8K              125     /* 8000 ints/sec */
+#define I40E_INTRL_62K             16      /* 62500 ints/sec */
+#define I40E_INTRL_83K             12      /* 83333 ints/sec */
 
 #define I40E_QUEUE_END_OF_LIST 0x7FF
 
-- 
1.9.3

