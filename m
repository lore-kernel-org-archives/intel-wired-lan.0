From: Sagar Arun Kamble <sagar.a.kamble@intel.com>
Date: Fri, 15 Dec 2017 13:08:25 +0530
Subject: [Intel-wired-lan] [PATCH 10/27] ixgbe: Use timecounter_initialize
 interface
In-Reply-To: <1513323522-15021-1-git-send-email-sagar.a.kamble@intel.com>
References: <1513323522-15021-1-git-send-email-sagar.a.kamble@intel.com>
Message-ID: <1513323522-15021-11-git-send-email-sagar.a.kamble@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

With new interface timecounter_initialize we can initialize timecounter
fields and underlying cyclecounter together. Update ixgbe ptp timecounter
init with this new function.

Signed-off-by: Sagar Arun Kamble <sagar.a.kamble@intel.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: intel-wired-lan at lists.osuosl.org
Cc: netdev at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  6 +++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  4 +--
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c  | 45 +++++++++++++++------------
 3 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 5c391a0..67e8b5c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -739,6 +739,10 @@ struct ixgbe_adapter {
 	unsigned long last_rx_timestamp;
 	spinlock_t tmreg_lock;
 	struct timecounter hw_tc;
+	u64 (*cc_read)(const struct cyclecounter *cc);
+	u64 cc_mask;
+	u32 cc_mult;
+	u32 cc_shift;
 	u32 base_incval;
 	u32 tx_hwtstamp_timeouts;
 	u32 tx_hwtstamp_skipped;
@@ -994,7 +998,7 @@ static inline void ixgbe_ptp_rx_hwtstamp(struct ixgbe_ring *rx_ring,
 
 int ixgbe_ptp_set_ts_config(struct ixgbe_adapter *adapter, struct ifreq *ifr);
 int ixgbe_ptp_get_ts_config(struct ixgbe_adapter *adapter, struct ifreq *ifr);
-void ixgbe_ptp_start_cyclecounter(struct ixgbe_adapter *adapter);
+void ixgbe_ptp_start_timecounter(struct ixgbe_adapter *adapter);
 void ixgbe_ptp_reset(struct ixgbe_adapter *adapter);
 void ixgbe_ptp_check_pps_event(struct ixgbe_adapter *adapter);
 #ifdef CONFIG_PCI_IOV
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 62a1891..86a337b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -7332,7 +7332,7 @@ static void ixgbe_watchdog_link_is_up(struct ixgbe_adapter *adapter)
 	adapter->last_rx_ptp_check = jiffies;
 
 	if (test_bit(__IXGBE_PTP_RUNNING, &adapter->state))
-		ixgbe_ptp_start_cyclecounter(adapter);
+		ixgbe_ptp_start_timecounter(adapter);
 
 	switch (link_speed) {
 	case IXGBE_LINK_SPEED_10GB_FULL:
@@ -7400,7 +7400,7 @@ static void ixgbe_watchdog_link_is_down(struct ixgbe_adapter *adapter)
 		adapter->flags2 |= IXGBE_FLAG2_SEARCH_FOR_SFP;
 
 	if (test_bit(__IXGBE_PTP_RUNNING, &adapter->state))
-		ixgbe_ptp_start_cyclecounter(adapter);
+		ixgbe_ptp_start_timecounter(adapter);
 
 	e_info(drv, "NIC Link is Down\n");
 	netif_carrier_off(netdev);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
index 6e9f2c0..073c1ef 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
@@ -1075,7 +1075,8 @@ static void ixgbe_ptp_link_speed_adjust(struct ixgbe_adapter *adapter,
 }
 
 /**
- * ixgbe_ptp_start_cyclecounter - create the cycle counter from hw
+ * ixgbe_ptp_start_timecounter - create the cycle counter from hw and
+ *				 initialize corresponding timecounter.
  * @adapter: pointer to the adapter structure
  *
  * This function should be called to set the proper values for the TIMINCA
@@ -1084,10 +1085,9 @@ static void ixgbe_ptp_link_speed_adjust(struct ixgbe_adapter *adapter,
  * structure. It should be called whenever a new TIMINCA value is necessary,
  * such as during initialization or when the link speed changes.
  */
-void ixgbe_ptp_start_cyclecounter(struct ixgbe_adapter *adapter)
+void ixgbe_ptp_start_timecounter(struct ixgbe_adapter *adapter)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
-	struct cyclecounter cc;
 	unsigned long flags;
 	u32 incval = 0;
 	u32 tsauxc = 0;
@@ -1104,9 +1104,9 @@ void ixgbe_ptp_start_cyclecounter(struct ixgbe_adapter *adapter)
 	 * proper fix to this problem would require modification of the
 	 * timecounter delta calculations.
 	 */
-	cc.mask = CLOCKSOURCE_MASK(64);
-	cc.mult = 1;
-	cc.shift = 0;
+	adapter->cc_mask = CLOCKSOURCE_MASK(64);
+	adapter->cc_mult = 1;
+	adapter->cc_shift = 0;
 
 	switch (hw->mac.type) {
 	case ixgbe_mac_X550EM_x:
@@ -1118,13 +1118,13 @@ void ixgbe_ptp_start_cyclecounter(struct ixgbe_adapter *adapter)
 		 */
 		fuse0 = IXGBE_READ_REG(hw, IXGBE_FUSES0_GROUP(0));
 		if (!(fuse0 & IXGBE_FUSES0_300MHZ)) {
-			cc.mult = 3;
-			cc.shift = 2;
+			adapter->cc_mult = 3;
+			adapter->cc_shift = 2;
 		}
 		/* fallthrough */
 	case ixgbe_mac_x550em_a:
 	case ixgbe_mac_X550:
-		cc.read = ixgbe_ptp_read_X550;
+		adapter->cc_read = ixgbe_ptp_read_X550;
 
 		/* enable SYSTIME counter */
 		IXGBE_WRITE_REG(hw, IXGBE_SYSTIMR, 0);
@@ -1139,17 +1139,21 @@ void ixgbe_ptp_start_cyclecounter(struct ixgbe_adapter *adapter)
 		IXGBE_WRITE_FLUSH(hw);
 		break;
 	case ixgbe_mac_X540:
-		cc.read = ixgbe_ptp_read_82599;
+		adapter->cc_read = ixgbe_ptp_read_82599;
 
-		ixgbe_ptp_link_speed_adjust(adapter, &cc.shift, &incval);
+		ixgbe_ptp_link_speed_adjust(adapter,
+					    &adapter->cc_shift,
+					    &incval);
 		IXGBE_WRITE_REG(hw, IXGBE_TIMINCA, incval);
 		break;
 	case ixgbe_mac_82599EB:
-		cc.read = ixgbe_ptp_read_82599;
+		adapter->cc_read = ixgbe_ptp_read_82599;
 
-		ixgbe_ptp_link_speed_adjust(adapter, &cc.shift, &incval);
+		ixgbe_ptp_link_speed_adjust(adapter,
+					    &adapter->cc_shift,
+					    &incval);
 		incval >>= IXGBE_INCVAL_SHIFT_82599;
-		cc.shift -= IXGBE_INCVAL_SHIFT_82599;
+		adapter->cc_shift -= IXGBE_INCVAL_SHIFT_82599;
 		IXGBE_WRITE_REG(hw, IXGBE_TIMINCA,
 				BIT(IXGBE_INCPER_SHIFT_82599) | incval);
 		break;
@@ -1164,7 +1168,12 @@ void ixgbe_ptp_start_cyclecounter(struct ixgbe_adapter *adapter)
 
 	/* need lock to prevent incorrect read while modifying cyclecounter */
 	spin_lock_irqsave(&adapter->tmreg_lock, flags);
-	memcpy(&adapter->hw_tc.cc, &cc, sizeof(adapter->hw_tc.cc));
+	timecounter_initialize(&adapter->tc,
+			       adapter->cc_read,
+			       adapter->cc_mask,
+			       adapter->cc_mult,
+			       adapter->cc_shift,
+			       ktime_to_ns(ktime_get_real()));
 	spin_unlock_irqrestore(&adapter->tmreg_lock, flags);
 }
 
@@ -1192,11 +1201,7 @@ void ixgbe_ptp_reset(struct ixgbe_adapter *adapter)
 	if (hw->mac.type == ixgbe_mac_82598EB)
 		return;
 
-	ixgbe_ptp_start_cyclecounter(adapter);
-
-	spin_lock_irqsave(&adapter->tmreg_lock, flags);
-	timecounter_init(&adapter->hw_tc, ktime_to_ns(ktime_get_real()));
-	spin_unlock_irqrestore(&adapter->tmreg_lock, flags);
+	ixgbe_ptp_start_timecounter(adapter);
 
 	adapter->last_overflow_check = jiffies;
 
-- 
1.9.1

