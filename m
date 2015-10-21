From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Wed, 21 Oct 2015 19:47:08 -0400
Subject: [Intel-wired-lan] [next PATCH S19 07/15] i40e/i40evf: Add a stat to
	track how many times we have to do a force WB
In-Reply-To: <1445471236-35918-1-git-send-email-catherine.sullivan@intel.com>
References: <1445471236-35918-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1445471236-35918-8-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anjali Singhai Jain <anjali.singhai@intel.com>

When in NAPI with interrupts disabled, the HW needs to be forced to do a
write back on TX if the number of descriptors pending are less than a
cache line.

This stat helps keep track of how many times we get into this situation.

Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
Change-ID: I76c1bcc7ebccd6bffcc5aa33bfe05f2fa1c9a984

---
Testing-hints: We are forcing WB only once a second with the changes to
move force WB in the timer task. You should not see this ethtool stat
"tx_force_wb" go up more often than that on X[L]710. On TLVF you will
see this stat more ofetn since we have a different strategy for force WB
since the HW provides a less expensive way of doing a force WB.
 drivers/net/ethernet/intel/i40e/i40e.h         | 1 +
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c    | 5 ++++-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c    | 4 +++-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h    | 1 +
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c  | 4 +++-
 drivers/net/ethernet/intel/i40evf/i40e_txrx.h  | 1 +
 7 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 4dd3e26..ca07a7b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -487,6 +487,7 @@ struct i40e_vsi {
 	u32 tx_restart;
 	u32 tx_busy;
 	u64 tx_linearize;
+	u64 tx_force_wb;
 	u32 rx_buf_failed;
 	u32 rx_page_failed;
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index f956cd0..1a39d4d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -88,6 +88,7 @@ static const struct i40e_stats i40e_gstrings_misc_stats[] = {
 	I40E_VSI_STAT("tx_broadcast", eth_stats.tx_broadcast),
 	I40E_VSI_STAT("rx_unknown_protocol", eth_stats.rx_unknown_protocol),
 	I40E_VSI_STAT("tx_linearize", tx_linearize),
+	I40E_VSI_STAT("tx_force_wb", tx_force_wb),
 };
 
 /* These PF_STATs might look like duplicates of some NETDEV_STATs,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index c8727b8..ae63539 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -881,6 +881,7 @@ static void i40e_update_vsi_stats(struct i40e_vsi *vsi)
 	u64 bytes, packets;
 	unsigned int start;
 	u64 tx_linearize;
+	u64 tx_force_wb;
 	u64 rx_p, rx_b;
 	u64 tx_p, tx_b;
 	u16 q;
@@ -899,7 +900,7 @@ static void i40e_update_vsi_stats(struct i40e_vsi *vsi)
 	 */
 	rx_b = rx_p = 0;
 	tx_b = tx_p = 0;
-	tx_restart = tx_busy = tx_linearize = 0;
+	tx_restart = tx_busy = tx_linearize = tx_force_wb = 0;
 	rx_page = 0;
 	rx_buf = 0;
 	rcu_read_lock();
@@ -917,6 +918,7 @@ static void i40e_update_vsi_stats(struct i40e_vsi *vsi)
 		tx_restart += p->tx_stats.restart_queue;
 		tx_busy += p->tx_stats.tx_busy;
 		tx_linearize += p->tx_stats.tx_linearize;
+		tx_force_wb += p->tx_stats.tx_force_wb;
 
 		/* Rx queue is part of the same block as Tx queue */
 		p = &p[1];
@@ -934,6 +936,7 @@ static void i40e_update_vsi_stats(struct i40e_vsi *vsi)
 	vsi->tx_restart = tx_restart;
 	vsi->tx_busy = tx_busy;
 	vsi->tx_linearize = tx_linearize;
+	vsi->tx_force_wb = tx_force_wb;
 	vsi->rx_page_failed = rx_page;
 	vsi->rx_buf_failed = rx_buf;
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 626c567..718c0f0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1926,8 +1926,10 @@ int i40e_napi_poll(struct napi_struct *napi, int budget)
 	/* If work not completed, return budget and polling will return */
 	if (!clean_complete) {
 tx_only:
-		if (arm_wb)
+		if (arm_wb) {
+			q_vector->tx.ring[0].tx_stats.tx_force_wb++;
 			i40e_force_wb(vsi, q_vector);
+		}
 		return budget;
 	}
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index 6779fb7..dccc1eb 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -202,6 +202,7 @@ struct i40e_tx_queue_stats {
 	u64 tx_busy;
 	u64 tx_done_old;
 	u64 tx_linearize;
+	u64 tx_force_wb;
 };
 
 struct i40e_rx_queue_stats {
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index 521803e..e4f97f8 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -1364,8 +1364,10 @@ int i40evf_napi_poll(struct napi_struct *napi, int budget)
 	/* If work not completed, return budget and polling will return */
 	if (!clean_complete) {
 tx_only:
-		if (arm_wb)
+		if (arm_wb) {
+			q_vector->tx.ring[0].tx_stats.tx_force_wb++;
 			i40evf_force_wb(vsi, q_vector);
+		}
 		return budget;
 	}
 
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.h b/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
index ebc1bf7..997b374 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
@@ -201,6 +201,7 @@ struct i40e_tx_queue_stats {
 	u64 tx_busy;
 	u64 tx_done_old;
 	u64 tx_linearize;
+	u64 tx_force_wb;
 };
 
 struct i40e_rx_queue_stats {
-- 
1.9.3

