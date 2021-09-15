From: Karen Sornek <karen.sornek@intel.com>
Date: Wed, 15 Sep 2021 08:41:23 +0200
Subject: [Intel-wired-lan] [PATCH net-next v1] iavf: Add helper function to
 go from pci_dev to adapter
Message-ID: <20210915064123.69945-1-karen.sornek@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add helper function to go from pci_dev to adapter to make work simple -
to go from a pci_dev to the adapter structure and make netdev assigment
instead of having to go to the net_device then the adapter.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Karen Sornek <karen.sornek@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 24 +++++++++++++++------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 80437ef26..39620fe6c 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -51,6 +51,15 @@ MODULE_LICENSE("GPL v2");
 static const struct net_device_ops iavf_netdev_ops;
 struct workqueue_struct *iavf_wq;
 
+/**
+ * iavf_pdev_to_adapter - go from pci_dev to adapter
+ * @pdev: pci_dev pointer
+ */
+static struct iavf_adapter *iavf_pdev_to_adapter(struct pci_dev *pdev)
+{
+	return netdev_priv(pci_get_drvdata(pdev));
+}
+
 /**
  * iavf_allocate_dma_mem_d - OS specific memory alloc for shared code
  * @hw:   pointer to the HW structure
@@ -3725,8 +3734,8 @@ out:
  **/
 static void iavf_shutdown(struct pci_dev *pdev)
 {
-	struct net_device *netdev = pci_get_drvdata(pdev);
-	struct iavf_adapter *adapter = netdev_priv(netdev);
+	struct iavf_adapter *adapter = iavf_pdev_to_adapter(pdev);
+	struct net_device *netdev = adapter->netdev;
 
 	netif_device_detach(netdev);
 
@@ -3911,10 +3920,11 @@ static int __maybe_unused iavf_suspend(struct device *dev_d)
 static int __maybe_unused iavf_resume(struct device *dev_d)
 {
 	struct pci_dev *pdev = to_pci_dev(dev_d);
-	struct net_device *netdev = pci_get_drvdata(pdev);
-	struct iavf_adapter *adapter = netdev_priv(netdev);
+	struct iavf_adapter *adapter;
 	u32 err;
 
+	adapter = iavf_pdev_to_adapter(pdev);
+
 	pci_set_master(pdev);
 
 	rtnl_lock();
@@ -3933,7 +3943,7 @@ static int __maybe_unused iavf_resume(struct device *dev_d)
 
 	queue_work(iavf_wq, &adapter->reset_task);
 
-	netif_device_attach(netdev);
+	netif_device_attach(adapter->netdev);
 
 	return err;
 }
@@ -3949,8 +3959,8 @@ static int __maybe_unused iavf_resume(struct device *dev_d)
  **/
 static void iavf_remove(struct pci_dev *pdev)
 {
-	struct net_device *netdev = pci_get_drvdata(pdev);
-	struct iavf_adapter *adapter = netdev_priv(netdev);
+	struct iavf_adapter *adapter = iavf_pdev_to_adapter(pdev);
+	struct net_device *netdev = adapter->netdev;
 	struct iavf_fdir_fltr *fdir, *fdirtmp;
 	struct iavf_vlan_filter *vlf, *vlftmp;
 	struct iavf_adv_rss *rss, *rsstmp;
-- 
2.27.0

