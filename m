From: Thomas Gleixner <tglx@linutronix.de>
Date: Sun, 27 Sep 2020 21:48:56 +0200
Subject: [Intel-wired-lan] [patch 10/35] net: intel: Remove in_interrupt()
 warnings
References: <20200927194846.045411263@linutronix.de>
Message-ID: <20200927194920.824108021@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

in_interrupt() is ill defined and does not provide what the name
suggests. The usage especially in driver code is deprecated and a tree wide
effort to clean up and consolidate the (ab)usage of in_interrupt() and
related checks is happening.

In this case the checks cover only parts of the contexts in which these
functions cannot be called. They fail to detect preemption or interrupt
disabled invocations.

As the functions which are invoked from the various places contain already
a broad variety of checks (always enabled or debug option dependent) cover
all invalid conditions already, there is no point in having inconsistent
warnings in those drivers.

Just remove them.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: netdev at vger.kernel.org

---
 drivers/net/ethernet/intel/e1000/e1000_main.c     |    1 -
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c      |    2 --
 drivers/net/ethernet/intel/i40e/i40e_main.c       |    4 ----
 drivers/net/ethernet/intel/ice/ice_main.c         |    1 -
 drivers/net/ethernet/intel/igb/igb_main.c         |    1 -
 drivers/net/ethernet/intel/igc/igc_main.c         |    1 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     |    1 -
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |    2 --
 8 files changed, 13 deletions(-)

--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -534,7 +534,6 @@ void e1000_down(struct e1000_adapter *ad
 
 void e1000_reinit_locked(struct e1000_adapter *adapter)
 {
-	WARN_ON(in_interrupt());
 	while (test_and_set_bit(__E1000_RESETTING, &adapter->flags))
 		msleep(1);
 
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -221,8 +221,6 @@ static bool fm10k_prepare_for_reset(stru
 {
 	struct net_device *netdev = interface->netdev;
 
-	WARN_ON(in_interrupt());
-
 	/* put off any impending NetWatchDogTimeout */
 	netif_trans_update(netdev);
 
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -6689,7 +6689,6 @@ static void i40e_vsi_reinit_locked(struc
 {
 	struct i40e_pf *pf = vsi->back;
 
-	WARN_ON(in_interrupt());
 	while (test_and_set_bit(__I40E_CONFIG_BUSY, pf->state))
 		usleep_range(1000, 2000);
 	i40e_down(vsi);
@@ -8462,9 +8461,6 @@ void i40e_do_reset(struct i40e_pf *pf, u
 {
 	u32 val;
 
-	WARN_ON(in_interrupt());
-
-
 	/* do the biggest reset indicated */
 	if (reset_flags & BIT_ULL(__I40E_GLOBAL_RESET_REQUESTED)) {
 
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -486,7 +486,6 @@ static void ice_do_reset(struct ice_pf *
 	struct ice_hw *hw = &pf->hw;
 
 	dev_dbg(dev, "reset_type 0x%x requested\n", reset_type);
-	WARN_ON(in_interrupt());
 
 	ice_prepare_for_reset(pf);
 
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2220,7 +2220,6 @@ void igb_down(struct igb_adapter *adapte
 
 void igb_reinit_locked(struct igb_adapter *adapter)
 {
-	WARN_ON(in_interrupt());
 	while (test_and_set_bit(__IGB_RESETTING, &adapter->state))
 		usleep_range(1000, 2000);
 	igb_down(adapter);
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -3831,7 +3831,6 @@ void igc_down(struct igc_adapter *adapte
 
 void igc_reinit_locked(struct igc_adapter *adapter)
 {
-	WARN_ON(in_interrupt());
 	while (test_and_set_bit(__IGC_RESETTING, &adapter->state))
 		usleep_range(1000, 2000);
 	igc_down(adapter);
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -5677,7 +5677,6 @@ static void ixgbe_up_complete(struct ixg
 
 void ixgbe_reinit_locked(struct ixgbe_adapter *adapter)
 {
-	WARN_ON(in_interrupt());
 	/* put off any impending NetWatchDogTimeout */
 	netif_trans_update(adapter->netdev);
 
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -2526,8 +2526,6 @@ void ixgbevf_down(struct ixgbevf_adapter
 
 void ixgbevf_reinit_locked(struct ixgbevf_adapter *adapter)
 {
-	WARN_ON(in_interrupt());
-
 	while (test_and_set_bit(__IXGBEVF_RESETTING, &adapter->state))
 		msleep(1);
 

