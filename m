From: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
Date: Tue,  6 Mar 2018 17:12:28 -0800
Subject: [Intel-wired-lan] [RFC v3 net-next 16/18] igb: Only change Tx
 arbitration when CBS is on
In-Reply-To: <20180307011230.24001-1-jesus.sanchez-palencia@intel.com>
References: <20180307011230.24001-1-jesus.sanchez-palencia@intel.com>
Message-ID: <20180307011230.24001-17-jesus.sanchez-palencia@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Currently the data transmission arbitration algorithm - DataTranARB
field on TQAVCTRL reg - is always set to CBS when the Tx mode is
changed from legacy to 'Qav' mode.

Make that configuration a bit more granular in preparation for the
upcoming Launchtime enabling patches, since CBS and Launchtime can be
enabled separately. That is achieved by moving the DataTranARB setup
to igb_config_tx_modes() instead.

Similarly, when disabling CBS we must check if it has been disabled
for all queues, and clear the DataTranARB accordingly.

Signed-off-by: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 49 +++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 49cfbe4fd2b1..9c33f2d18d8c 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -1672,6 +1672,18 @@ static void set_queue_mode(struct e1000_hw *hw, int queue, enum queue_mode mode)
 	wr32(E1000_I210_TQAVCC(queue), val);
 }
 
+static bool is_any_cbs_enabled(struct igb_adapter *adapter)
+{
+	int i;
+
+	for (i = 0; i < adapter->num_tx_queues; i++) {
+		if (adapter->tx_ring[i]->cbs_enable)
+			return true;
+	}
+
+	return false;
+}
+
 /**
  *  igb_config_tx_modes - Configure "Qav Tx mode" features on igb
  *  @adapter: pointer to adapter struct
@@ -1686,7 +1698,7 @@ static void igb_config_tx_modes(struct igb_adapter *adapter, int queue)
 	struct igb_ring *ring = adapter->tx_ring[queue];
 	struct net_device *netdev = adapter->netdev;
 	struct e1000_hw *hw = &adapter->hw;
-	u32 tqavcc;
+	u32 tqavcc, tqavctrl;
 	u16 value;
 
 	WARN_ON(hw->mac.type != e1000_i210);
@@ -1696,6 +1708,14 @@ static void igb_config_tx_modes(struct igb_adapter *adapter, int queue)
 		set_tx_desc_fetch_prio(hw, queue, TX_QUEUE_PRIO_HIGH);
 		set_queue_mode(hw, queue, QUEUE_MODE_STREAM_RESERVATION);
 
+		/* Always set data transfer arbitration to credit-based
+		 * shaper algorithm on TQAVCTRL if CBS is enabled for any of
+		 * the queues.
+		 */
+		tqavctrl = rd32(E1000_I210_TQAVCTRL);
+		tqavctrl |= E1000_TQAVCTRL_DATATRANARB;
+		wr32(E1000_I210_TQAVCTRL, tqavctrl);
+
 		/* According to i210 datasheet section 7.2.7.7, we should set
 		 * the 'idleSlope' field from TQAVCC register following the
 		 * equation:
@@ -1773,6 +1793,16 @@ static void igb_config_tx_modes(struct igb_adapter *adapter, int queue)
 
 		/* Set hiCredit to zero. */
 		wr32(E1000_I210_TQAVHC(queue), 0);
+
+		/* If CBS is not enabled for any queues anymore, then return to
+		 * the default state of Data Transmission Arbitration on
+		 * TQAVCTRL.
+		 */
+		if (!is_any_cbs_enabled(adapter)) {
+			tqavctrl = rd32(E1000_I210_TQAVCTRL);
+			tqavctrl &= ~E1000_TQAVCTRL_DATATRANARB;
+			wr32(E1000_I210_TQAVCTRL, tqavctrl);
+		}
 	}
 
 	/* XXX: In i210 controller the sendSlope and loCredit parameters from
@@ -1806,18 +1836,6 @@ static int igb_save_cbs_params(struct igb_adapter *adapter, int queue,
 	return 0;
 }
 
-static bool is_any_cbs_enabled(struct igb_adapter *adapter)
-{
-	int i;
-
-	for (i = 0; i < adapter->num_tx_queues; i++) {
-		if (adapter->tx_ring[i]->cbs_enable)
-			return true;
-	}
-
-	return false;
-}
-
 /**
  *  igb_setup_tx_mode - Switch to/from Qav Tx mode when applicable
  *  @adapter: pointer to adapter struct
@@ -1841,11 +1859,10 @@ static void igb_setup_tx_mode(struct igb_adapter *adapter)
 		int i, max_queue;
 
 		/* Configure TQAVCTRL register: set transmit mode to 'Qav',
-		 * set data fetch arbitration to 'round robin' and set data
-		 * transfer arbitration to 'credit shaper algorithm.
+		 * set data fetch arbitration to 'round robin'.
 		 */
 		val = rd32(E1000_I210_TQAVCTRL);
-		val |= E1000_TQAVCTRL_XMIT_MODE | E1000_TQAVCTRL_DATATRANARB;
+		val |= E1000_TQAVCTRL_XMIT_MODE;
 		val &= ~E1000_TQAVCTRL_DATAFETCHARB;
 		wr32(E1000_I210_TQAVCTRL, val);
 
-- 
2.16.2

