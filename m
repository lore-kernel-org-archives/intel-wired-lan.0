From: Alice Michael <alice.michael@intel.com>
Date: Fri, 27 Oct 2017 11:06:49 -0400
Subject: [Intel-wired-lan] [next PATCH S81-V3 2/9] i40evf: don't rely on
	netif_running() outside rtnl_lock()
In-Reply-To: <20171027150656.68250-1-alice.michael@intel.com>
References: <20171027150656.68250-1-alice.michael@intel.com>
Message-ID: <20171027150656.68250-2-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

In i40evf_reset_task we use netif_running() to determine whether or not
the device is currently up. This allows us to properly free queue memory
and shut down things before we request the hardware reset.

It turns out that we cannot be guaranteed of netif_running() returning
false until the device is fully up, as the kernel core code sets
__LINK_STATE_START prior to calling .ndo_open. Since we're not holding
the rtnl_lock(), it's possible that the driver's i40evf_open handler
function is currently being called while we're resetting.

We can't simply hold the rtnl_lock() while checking netif_running() as
this could cause a deadlock with the i40evf_open() function.
Additionally, we can't avoid the deadlock by holding the rtnl_lock()
over the whole reset path, as this essentially serializes all resets,
and can cause massive delays if we have multiple VFs on a system.

Instead, lets just check our own internal state __I40EVF_RUNNING state
field. This allows us to ensure that the state is correct and is only
set after we've finished bringing the device up.

Without this change we might free data structures about device queues
and other memory before they've been fully allocated.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index ca2ebdb..320408f 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1796,7 +1796,11 @@ static void i40evf_disable_vf(struct i40evf_adapter *adapter)
 
 	adapter->flags |= I40EVF_FLAG_PF_COMMS_FAILED;
 
-	if (netif_running(adapter->netdev)) {
+	/* We don't use netif_running() because it may be true prior to
+	 * ndo_open() returning, so we can't assume it means all our open
+	 * tasks have finished, since we're not holding the rtnl_lock here.
+	 */
+	if (adapter->state == __I40EVF_RUNNING) {
 		set_bit(__I40E_VSI_DOWN, adapter->vsi.state);
 		netif_carrier_off(adapter->netdev);
 		netif_tx_disable(adapter->netdev);
@@ -1854,6 +1858,7 @@ static void i40evf_reset_task(struct work_struct *work)
 	struct i40evf_mac_filter *f;
 	u32 reg_val;
 	int i = 0, err;
+	bool running;
 
 	while (test_and_set_bit(__I40EVF_IN_CLIENT_TASK,
 				&adapter->crit_section))
@@ -1913,7 +1918,13 @@ static void i40evf_reset_task(struct work_struct *work)
 	}
 
 continue_reset:
-	if (netif_running(netdev)) {
+	/* We don't use netif_running() because it may be true prior to
+	 * ndo_open() returning, so we can't assume it means all our open
+	 * tasks have finished, since we're not holding the rtnl_lock here.
+	 */
+	running = (adapter->state == __I40EVF_RUNNING);
+
+	if (running) {
 		netif_carrier_off(netdev);
 		netif_tx_stop_all_queues(netdev);
 		adapter->link_up = false;
@@ -1964,7 +1975,10 @@ static void i40evf_reset_task(struct work_struct *work)
 
 	mod_timer(&adapter->watchdog_timer, jiffies + 2);
 
-	if (netif_running(adapter->netdev)) {
+	/* We were running when the reset started, so we need to restore some
+	 * state here.
+	 */
+	if (running) {
 		/* allocate transmit descriptors */
 		err = i40evf_setup_all_tx_resources(adapter);
 		if (err)
-- 
2.9.5

