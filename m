From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri,  4 Jun 2021 09:53:21 -0700
Subject: [Intel-wired-lan] [PATCH net-next 01/15] iavf: correctly track
 whether the interface is running during resets
Message-ID: <20210604165335.33329-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Nicholas Nunley <nicholas.d.nunley@intel.com>

During a hardware reset the driver needs to know if the interface is
running so it can appropriately shut down and restore itself to the
previous state. However, as described in commit 44b034b40621 ("i40evf:
don't rely on netif_running() outside rtnl_lock()") the driver can't simply
grab rtnl_lock() in the reset path when it needs to check netif_running().

The previous fix for this was to have the driver use the __IAVF_RUNNING
state to stand in for netif_running(). This turns out to be incorrect,
since although __IAVF_RUNNING does tell is if the interface is running,
there are other states the driver could be in, and they don't accurately
indicate whether the interface is actually running or not.

Although adapter->state can't be used to reliably determine if the
interface is running, adapter->vsi.state can, so use this instead.

This patch also replaces the use of netif_running() in
iavf_reinit_interrupt_scheme() which was presumably overlooked earlier.

Signed-off-by: Nicholas Nunley <nicholas.d.nunley@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 1323778f461d..bf96a9dab962 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1486,7 +1486,7 @@ static int iavf_reinit_interrupt_scheme(struct iavf_adapter *adapter)
 	struct net_device *netdev = adapter->netdev;
 	int err;
 
-	if (netif_running(netdev))
+	if (!test_bit(__IAVF_VSI_DOWN, adapter->vsi.state))
 		iavf_free_traffic_irqs(adapter);
 	iavf_free_misc_irq(adapter);
 	iavf_reset_interrupt_capability(adapter);
@@ -2029,7 +2029,7 @@ static void iavf_disable_vf(struct iavf_adapter *adapter)
 	 * ndo_open() returning, so we can't assume it means all our open
 	 * tasks have finished, since we're not holding the rtnl_lock here.
 	 */
-	if (adapter->state == __IAVF_RUNNING) {
+	if (!test_bit(__IAVF_VSI_DOWN, adapter->vsi.state)) {
 		set_bit(__IAVF_VSI_DOWN, adapter->vsi.state);
 		netif_carrier_off(adapter->netdev);
 		netif_tx_disable(adapter->netdev);
@@ -2169,9 +2169,7 @@ static void iavf_reset_task(struct work_struct *work)
 	 * ndo_open() returning, so we can't assume it means all our open
 	 * tasks have finished, since we're not holding the rtnl_lock here.
 	 */
-	running = ((adapter->state == __IAVF_RUNNING) ||
-		   (adapter->state == __IAVF_RESETTING));
-
+	running = !test_bit(__IAVF_VSI_DOWN, adapter->vsi.state);
 	if (running) {
 		netif_carrier_off(netdev);
 		netif_tx_stop_all_queues(netdev);
-- 
2.20.1

