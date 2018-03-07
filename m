From: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
Date: Tue,  6 Mar 2018 17:12:27 -0800
Subject: [Intel-wired-lan] [RFC v3 net-next 15/18] igb: Refactor
 igb_configure_cbs()
In-Reply-To: <20180307011230.24001-1-jesus.sanchez-palencia@intel.com>
References: <20180307011230.24001-1-jesus.sanchez-palencia@intel.com>
Message-ID: <20180307011230.24001-16-jesus.sanchez-palencia@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Make this function retrieve what it needs from the Tx ring being
addressed since it already relies on what had been saved on it before.
Also, since this function will be used by the upcoming Launchtime
patches rename it to better reflect its intention. Note that
Launchtime is not part of what 802.1Qav specifies, but the i210
datasheet refers to this set of functionality as "Qav Transmission
Mode".

Here we also perform a tiny refactor at is_any_cbs_enabled(), and add
further documentation to igb_setup_tx_mode().

Signed-off-by: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 54 ++++++++++++++-----------------
 1 file changed, 25 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index b88fae785369..49cfbe4fd2b1 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -1673,23 +1673,17 @@ static void set_queue_mode(struct e1000_hw *hw, int queue, enum queue_mode mode)
 }
 
 /**
- *  igb_configure_cbs - Configure Credit-Based Shaper (CBS)
+ *  igb_config_tx_modes - Configure "Qav Tx mode" features on igb
  *  @adapter: pointer to adapter struct
  *  @queue: queue number
- *  @enable: true = enable CBS, false = disable CBS
- *  @idleslope: idleSlope in kbps
- *  @sendslope: sendSlope in kbps
- *  @hicredit: hiCredit in bytes
- *  @locredit: loCredit in bytes
  *
- *  Configure CBS for a given hardware queue. When disabling, idleslope,
- *  sendslope, hicredit, locredit arguments are ignored. Returns 0 if
- *  success. Negative otherwise.
+ *  Configure CBS for a given hardware queue. Parameters are retrieved
+ *  from the correct Tx ring, so igb_save_cbs_params() should be used
+ *  for setting those correctly prior to this function being called.
  **/
-static void igb_configure_cbs(struct igb_adapter *adapter, int queue,
-			      bool enable, int idleslope, int sendslope,
-			      int hicredit, int locredit)
+static void igb_config_tx_modes(struct igb_adapter *adapter, int queue)
 {
+	struct igb_ring *ring = adapter->tx_ring[queue];
 	struct net_device *netdev = adapter->netdev;
 	struct e1000_hw *hw = &adapter->hw;
 	u32 tqavcc;
@@ -1698,7 +1692,7 @@ static void igb_configure_cbs(struct igb_adapter *adapter, int queue,
 	WARN_ON(hw->mac.type != e1000_i210);
 	WARN_ON(queue < 0 || queue > 1);
 
-	if (enable) {
+	if (ring->cbs_enable) {
 		set_tx_desc_fetch_prio(hw, queue, TX_QUEUE_PRIO_HIGH);
 		set_queue_mode(hw, queue, QUEUE_MODE_STREAM_RESERVATION);
 
@@ -1759,14 +1753,15 @@ static void igb_configure_cbs(struct igb_adapter *adapter, int queue,
 		 *       calculated value, so the resulting bandwidth might
 		 *       be slightly higher for some configurations.
 		 */
-		value = DIV_ROUND_UP_ULL(idleslope * 61034ULL, 1000000);
+		value = DIV_ROUND_UP_ULL(ring->idleslope * 61034ULL, 1000000);
 
 		tqavcc = rd32(E1000_I210_TQAVCC(queue));
 		tqavcc &= ~E1000_TQAVCC_IDLESLOPE_MASK;
 		tqavcc |= value;
 		wr32(E1000_I210_TQAVCC(queue), tqavcc);
 
-		wr32(E1000_I210_TQAVHC(queue), 0x80000000 + hicredit * 0x7735);
+		wr32(E1000_I210_TQAVHC(queue),
+		     0x80000000 + ring->hicredit * 0x7735);
 	} else {
 		set_tx_desc_fetch_prio(hw, queue, TX_QUEUE_PRIO_LOW);
 		set_queue_mode(hw, queue, QUEUE_MODE_STRICT_PRIORITY);
@@ -1786,8 +1781,9 @@ static void igb_configure_cbs(struct igb_adapter *adapter, int queue,
 	 */
 
 	netdev_dbg(netdev, "CBS %s: queue %d idleslope %d sendslope %d hiCredit %d locredit %d\n",
-		   (enable) ? "enabled" : "disabled", queue,
-		   idleslope, sendslope, hicredit, locredit);
+		   (ring->cbs_enable) ? "enabled" : "disabled", queue,
+		   ring->idleslope, ring->sendslope, ring->hicredit,
+		   ring->locredit);
 }
 
 static int igb_save_cbs_params(struct igb_adapter *adapter, int queue,
@@ -1812,19 +1808,25 @@ static int igb_save_cbs_params(struct igb_adapter *adapter, int queue,
 
 static bool is_any_cbs_enabled(struct igb_adapter *adapter)
 {
-	struct igb_ring *ring;
 	int i;
 
 	for (i = 0; i < adapter->num_tx_queues; i++) {
-		ring = adapter->tx_ring[i];
-
-		if (ring->cbs_enable)
+		if (adapter->tx_ring[i]->cbs_enable)
 			return true;
 	}
 
 	return false;
 }
 
+/**
+ *  igb_setup_tx_mode - Switch to/from Qav Tx mode when applicable
+ *  @adapter: pointer to adapter struct
+ *
+ *  Configure TQAVCTRL register switching the controller's Tx mode
+ *  if FQTSS mode is enabled or disabled. Additionally, will issue
+ *  a call to igb_config_tx_modes() per queue so any previously saved
+ *  Tx parameters are applied.
+ **/
 static void igb_setup_tx_mode(struct igb_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
@@ -1884,11 +1886,7 @@ static void igb_setup_tx_mode(struct igb_adapter *adapter)
 			    adapter->num_tx_queues : I210_SR_QUEUES_NUM;
 
 		for (i = 0; i < max_queue; i++) {
-			struct igb_ring *ring = adapter->tx_ring[i];
-
-			igb_configure_cbs(adapter, i, ring->cbs_enable,
-					  ring->idleslope, ring->sendslope,
-					  ring->hicredit, ring->locredit);
+			igb_config_tx_modes(adapter, i);
 		}
 	} else {
 		wr32(E1000_RXPBS, I210_RXPBSIZE_DEFAULT);
@@ -2482,9 +2480,7 @@ static int igb_offload_cbs(struct igb_adapter *adapter,
 		return err;
 
 	if (is_fqtss_enabled(adapter)) {
-		igb_configure_cbs(adapter, qopt->queue, qopt->enable,
-				  qopt->idleslope, qopt->sendslope,
-				  qopt->hicredit, qopt->locredit);
+		igb_config_tx_modes(adapter, qopt->queue);
 
 		if (!is_any_cbs_enabled(adapter))
 			enable_fqtss(adapter, false);
-- 
2.16.2

