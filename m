From: Alice Michael <alice.michael@intel.com>
Date: Fri, 27 Oct 2017 11:06:52 -0400
Subject: [Intel-wired-lan] [next PATCH S81-V3 5/9] i40evf: hold the critical
	task bit lock while opening
In-Reply-To: <20171027150656.68250-1-alice.michael@intel.com>
References: <20171027150656.68250-1-alice.michael@intel.com>
Message-ID: <20171027150656.68250-5-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

If i40evf_open() is called quickly at the same time as a reset occurs
(such as via ethtool) it is possible for the device to attempt to open
while a reset is in progress. This occurs because the driver was not
holding the critical task bit lock during i40evf_open, nor was it
holding it around the call to i40evf_up_complete() in
i40evf_reset_task().

We didn't hold the lock previously because calls to i40evf_down() would
take the bit lock directly, and this would have caused a deadlock.

To avoid this, we'll move the bit lock handling out of i40evf_down() and
into the callers of this function. Additionally, we'll now hold the bit
lock over the entire set of steps when going up or down, to ensure that
we remain consistent.

Ultimately this causes us to serialize the transitions between down and
up properly, and avoid changing status while we're resetting.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 40 +++++++++++++++++++------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 9a945ff..45cff72 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1035,6 +1035,8 @@ static void i40evf_configure(struct i40evf_adapter *adapter)
 /**
  * i40evf_up_complete - Finish the last steps of bringing up a connection
  * @adapter: board private structure
+ *
+ * Expects to be called while holding the __I40EVF_IN_CRITICAL_TASK bit lock.
  **/
 static void i40evf_up_complete(struct i40evf_adapter *adapter)
 {
@@ -1052,6 +1054,8 @@ static void i40evf_up_complete(struct i40evf_adapter *adapter)
 /**
  * i40e_down - Shutdown the connection processing
  * @adapter: board private structure
+ *
+ * Expects to be called while holding the __I40EVF_IN_CRITICAL_TASK bit lock.
  **/
 void i40evf_down(struct i40evf_adapter *adapter)
 {
@@ -1061,10 +1065,6 @@ void i40evf_down(struct i40evf_adapter *adapter)
 	if (adapter->state <= __I40EVF_DOWN_PENDING)
 		return;
 
-	while (test_and_set_bit(__I40EVF_IN_CRITICAL_TASK,
-				&adapter->crit_section))
-		usleep_range(500, 1000);
-
 	netif_carrier_off(netdev);
 	netif_tx_disable(netdev);
 	adapter->link_up = false;
@@ -1097,7 +1097,6 @@ void i40evf_down(struct i40evf_adapter *adapter)
 		adapter->aq_required |= I40EVF_FLAG_AQ_DISABLE_QUEUES;
 	}
 
-	clear_bit(__I40EVF_IN_CRITICAL_TASK, &adapter->crit_section);
 	mod_timer_pending(&adapter->watchdog_timer, jiffies + 1);
 }
 
@@ -1960,8 +1959,6 @@ static void i40evf_reset_task(struct work_struct *work)
 
 	adapter->aq_required |= I40EVF_FLAG_AQ_ADD_MAC_FILTER;
 	adapter->aq_required |= I40EVF_FLAG_AQ_ADD_VLAN_FILTER;
-	clear_bit(__I40EVF_IN_CLIENT_TASK, &adapter->crit_section);
-	clear_bit(__I40EVF_IN_CRITICAL_TASK, &adapter->crit_section);
 	i40evf_misc_irq_enable(adapter);
 
 	mod_timer(&adapter->watchdog_timer, jiffies + 2);
@@ -1998,9 +1995,13 @@ static void i40evf_reset_task(struct work_struct *work)
 		adapter->state = __I40EVF_DOWN;
 		wake_up(&adapter->down_waitqueue);
 	}
+	clear_bit(__I40EVF_IN_CLIENT_TASK, &adapter->crit_section);
+	clear_bit(__I40EVF_IN_CRITICAL_TASK, &adapter->crit_section);
 
 	return;
 reset_err:
+	clear_bit(__I40EVF_IN_CLIENT_TASK, &adapter->crit_section);
+	clear_bit(__I40EVF_IN_CRITICAL_TASK, &adapter->crit_section);
 	dev_err(&adapter->pdev->dev, "failed to allocate resources during reinit\n");
 	i40evf_close(netdev);
 }
@@ -2244,8 +2245,14 @@ static int i40evf_open(struct net_device *netdev)
 		return -EIO;
 	}
 
-	if (adapter->state != __I40EVF_DOWN)
-		return -EBUSY;
+	while (test_and_set_bit(__I40EVF_IN_CRITICAL_TASK,
+				&adapter->crit_section))
+		usleep_range(500, 1000);
+
+	if (adapter->state != __I40EVF_DOWN) {
+		err = -EBUSY;
+		goto err_unlock;
+	}
 
 	/* allocate transmit descriptors */
 	err = i40evf_setup_all_tx_resources(adapter);
@@ -2269,6 +2276,8 @@ static int i40evf_open(struct net_device *netdev)
 
 	i40evf_irq_enable(adapter, true);
 
+	clear_bit(__I40EVF_IN_CRITICAL_TASK, &adapter->crit_section);
+
 	return 0;
 
 err_req_irq:
@@ -2278,6 +2287,8 @@ static int i40evf_open(struct net_device *netdev)
 	i40evf_free_all_rx_resources(adapter);
 err_setup_tx:
 	i40evf_free_all_tx_resources(adapter);
+err_unlock:
+	clear_bit(__I40EVF_IN_CRITICAL_TASK, &adapter->crit_section);
 
 	return err;
 }
@@ -2301,6 +2312,9 @@ static int i40evf_close(struct net_device *netdev)
 	if (adapter->state <= __I40EVF_DOWN_PENDING)
 		return 0;
 
+	while (test_and_set_bit(__I40EVF_IN_CRITICAL_TASK,
+				&adapter->crit_section))
+		usleep_range(500, 1000);
 
 	set_bit(__I40E_VSI_DOWN, adapter->vsi.state);
 	if (CLIENT_ENABLED(adapter))
@@ -2310,6 +2324,8 @@ static int i40evf_close(struct net_device *netdev)
 	adapter->state = __I40EVF_DOWN_PENDING;
 	i40evf_free_traffic_irqs(adapter);
 
+	clear_bit(__I40EVF_IN_CRITICAL_TASK, &adapter->crit_section);
+
 	/* We explicitly don't free resources here because the hardware is
 	 * still active and can DMA into memory. Resources are cleared in
 	 * i40evf_virtchnl_completion() after we get confirmation from the PF
@@ -2992,6 +3008,10 @@ static int i40evf_suspend(struct pci_dev *pdev, pm_message_t state)
 
 	netif_device_detach(netdev);
 
+	while (test_and_set_bit(__I40EVF_IN_CRITICAL_TASK,
+				&adapter->crit_section))
+		usleep_range(500, 1000);
+
 	if (netif_running(netdev)) {
 		rtnl_lock();
 		i40evf_down(adapter);
@@ -3000,6 +3020,8 @@ static int i40evf_suspend(struct pci_dev *pdev, pm_message_t state)
 	i40evf_free_misc_irq(adapter);
 	i40evf_reset_interrupt_capability(adapter);
 
+	clear_bit(__I40EVF_IN_CRITICAL_TASK, &adapter->crit_section);
+
 	retval = pci_save_state(pdev);
 	if (retval)
 		return retval;
-- 
2.9.5

