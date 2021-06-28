From: Mateusz Palczewski <mateusz.palczewski@intel.com>
Date: Mon, 28 Jun 2021 15:15:58 +0000
Subject: [Intel-wired-lan] [PATCH net-next v5 2/3] iavf: Add
 __IAVF_INIT_FAILED state
Message-ID: <20210628151558.28897-1-mateusz.palczewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This commit adds a new state, __IAVF_INIT_FAILED
to the state machine. From now on initialization functions report errors not
by returning an error value, but by changing the state to indicate that
something went wrong.

Signed-off-by: Jakub Pawlak <jakub.pawlak@intel.com>
Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
---
v5: Fixed the patch so that it applies on net-next tree
v4: Removed unnecessary line
v3: Added new file to patch series
v2: Splitted the patch into 2 to make them smaller
---
 drivers/net/ethernet/intel/iavf/iavf.h      |  1 +
 drivers/net/ethernet/intel/iavf/iavf_main.c | 35 ++++++++++++---------
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 89bcc4e..09d3b90 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -176,6 +176,7 @@ enum iavf_state_t {
 	__IAVF_INIT_VERSION_CHECK,	/* aq msg sent, awaiting reply */
 	__IAVF_INIT_GET_RESOURCES,	/* aq msg sent, awaiting reply */
 	__IAVF_INIT_SW,		/* got resources, setting up structs */
+	__IAVF_INIT_FAILED,	/* init failed, restarting procedure */
 	__IAVF_RESETTING,		/* in reset */
 	__IAVF_COMM_FAILED,		/* communication with PF failed */
 	/* Below here, watchdog is running */
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 2df72f9..932f44c 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -14,7 +14,7 @@
 static int iavf_setup_all_tx_resources(struct iavf_adapter *adapter);
 static int iavf_setup_all_rx_resources(struct iavf_adapter *adapter);
 static int iavf_close(struct net_device *netdev);
-static int iavf_init_get_resources(struct iavf_adapter *adapter);
+static void iavf_init_get_resources(struct iavf_adapter *adapter);
 static int iavf_check_reset_complete(struct iavf_hw *hw);
 
 char iavf_driver_name[] = "iavf";
@@ -1671,9 +1671,9 @@ static int iavf_process_aq_command(struct iavf_adapter *adapter)
  *
  * Function process __IAVF_STARTUP driver state.
  * When success the state is changed to __IAVF_INIT_VERSION_CHECK
- * when fails it returns -EAGAIN
+ * when fails the state is changed to __IAVF_INIT_FAILED
  **/
-static int iavf_startup(struct iavf_adapter *adapter)
+static void iavf_startup(struct iavf_adapter *adapter)
 {
 	struct pci_dev *pdev = adapter->pdev;
 	struct iavf_hw *hw = &adapter->hw;
@@ -1713,8 +1713,9 @@ static int iavf_startup(struct iavf_adapter *adapter)
 		goto err;
 	}
 	iavf_change_state(adapter, __IAVF_INIT_VERSION_CHECK);
+	return;
 err:
-	return err;
+	iavf_change_state(adapter, __IAVF_INIT_FAILED);
 }
 
 /**
@@ -1723,9 +1724,9 @@ static int iavf_startup(struct iavf_adapter *adapter)
  *
  * Function process __IAVF_INIT_VERSION_CHECK driver state.
  * When success the state is changed to __IAVF_INIT_GET_RESOURCES
- * when fails it returns -EAGAIN
+ * when fails the state is changed to __IAVF_INIT_FAILED
  **/
-static int iavf_init_version_check(struct iavf_adapter *adapter)
+static void iavf_init_version_check(struct iavf_adapter *adapter)
 {
 	struct pci_dev *pdev = adapter->pdev;
 	struct iavf_hw *hw = &adapter->hw;
@@ -1760,8 +1761,9 @@ static int iavf_init_version_check(struct iavf_adapter *adapter)
 		goto err;
 	}
 	iavf_change_state(adapter, __IAVF_INIT_GET_RESOURCES);
+	return;
 err:
-	return err;
+	iavf_change_state(adapter, __IAVF_INIT_FAILED);
 }
 
 /**
@@ -1771,9 +1773,9 @@ static int iavf_init_version_check(struct iavf_adapter *adapter)
  * Function process __IAVF_INIT_GET_RESOURCES driver state and
  * finishes driver initialization procedure.
  * When success the state is changed to __IAVF_DOWN
- * when fails it returns -EAGAIN
+ * when fails the state is changed to __IAVF_INIT_FAILED
  **/
-static int iavf_init_get_resources(struct iavf_adapter *adapter)
+static void iavf_init_get_resources(struct iavf_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
 	struct pci_dev *pdev = adapter->pdev;
@@ -1801,7 +1803,7 @@ static int iavf_init_get_resources(struct iavf_adapter *adapter)
 		 */
 		iavf_shutdown_adminq(hw);
 		dev_err(&pdev->dev, "Unable to get VF config due to PF error condition, not retrying\n");
-		return 0;
+		return;
 	}
 	if (err) {
 		dev_err(&pdev->dev, "Unable to get VF config (%d)\n", err);
@@ -1893,7 +1895,7 @@ static int iavf_init_get_resources(struct iavf_adapter *adapter)
 	else
 		iavf_init_rss(adapter);
 
-	return err;
+	return;
 err_mem:
 	iavf_free_rss(adapter);
 err_register:
@@ -1904,7 +1906,7 @@ static int iavf_init_get_resources(struct iavf_adapter *adapter)
 	kfree(adapter->vf_res);
 	adapter->vf_res = NULL;
 err:
-	return err;
+	iavf_change_state(adapter, __IAVF_INIT_FAILED);
 }
 
 /**
@@ -3629,15 +3631,18 @@ static void iavf_init_task(struct work_struct *work)
 
 	switch (adapter->state) {
 	case __IAVF_STARTUP:
-		if (iavf_startup(adapter) < 0)
+		iavf_startup(adapter);
+		if (adapter->state == __IAVF_INIT_FAILED)
 			goto init_failed;
 		break;
 	case __IAVF_INIT_VERSION_CHECK:
-		if (iavf_init_version_check(adapter) < 0)
+		iavf_init_version_check(adapter);
+		if (adapter->state == __IAVF_INIT_FAILED)
 			goto init_failed;
 		break;
 	case __IAVF_INIT_GET_RESOURCES:
-		if (iavf_init_get_resources(adapter) < 0)
+		iavf_init_get_resources(adapter);
+		if (adapter->state == __IAVF_INIT_FAILED)
 			goto init_failed;
 		return;
 	default:
-- 
2.17.1

