From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Fri, 09 Feb 2018 16:10:02 -0800
Subject: [Intel-wired-lan] [PATCH] virtio_pci: Add SR-IOV support
Message-ID: <20180210001001.24685.8117.stgit@mdrustad-mac04.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mark Rustad <mark.d.rustad@intel.com>

Hardware-realized virtio devices can implement SR-IOV, so enable
its use.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/virtio/virtio_pci_common.c |   64 ++++++++++++++++++++++++++++++++++++
 drivers/virtio/virtio_pci_common.h |    3 ++
 2 files changed, 67 insertions(+)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 1c4797e53f68..c46bbad57e67 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -584,6 +584,67 @@ static void virtio_pci_remove(struct pci_dev *pci_dev)
 	put_device(dev);
 }
 
+#ifdef CONFIG_PCI_IOV
+static int _virtio_pci_sriov_disable(struct virtio_pci_device *vp_dev,
+				     struct pci_dev *pci_dev)
+{
+	vp_dev->num_vfs = 0;
+	/* If vfs are assigned we cannot shut down SR-IOV without causing
+	 * issues, so just leave the hardware available.
+	 */
+	if (pci_vfs_assigned(pci_dev)) {
+		dev_warn(&pci_dev->dev,
+			 "Unloading driver while VFs are assigned - VFs will not be deallocated\n");
+		return -EPERM;
+	}
+	pci_disable_sriov(pci_dev);
+	return 0;
+}
+
+static int virtio_pci_sriov_disable(struct pci_dev *pci_dev)
+{
+	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
+
+	if (!vp_dev->num_vfs && !pci_num_vf(pci_dev))
+		return -EINVAL;
+
+	return _virtio_pci_sriov_disable(vp_dev, pci_dev);
+}
+
+static int virtio_pci_sriov_enable(struct pci_dev *pci_dev, int num_vfs)
+{
+	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
+	int pre_existing_vfs = pci_num_vf(pci_dev);
+	int rc = 0;
+
+	if (vp_dev->num_vfs == num_vfs)
+		return -EINVAL;
+
+	if (pre_existing_vfs && pre_existing_vfs != num_vfs)
+		rc = _virtio_pci_sriov_disable(vp_dev, pci_dev);
+	else if (pre_existing_vfs && pre_existing_vfs == num_vfs)
+		return num_vfs;
+	if (rc)
+		return rc;
+
+	rc = pci_enable_sriov(pci_dev, num_vfs);
+	if (rc) {
+		dev_warn(&pci_dev->dev, "Failed to enable PCI sriov: %d\n", rc);
+		return rc;
+	}
+	vp_dev->num_vfs = num_vfs;
+	dev_info(&pci_dev->dev, "SR-IOV enabled with %d VFs\n", num_vfs);
+	return num_vfs;
+}
+
+static int virtio_pci_sriov_configure(struct pci_dev *dev, int num_vfs)
+{
+	if (!num_vfs)
+		return virtio_pci_sriov_disable(dev);
+	return virtio_pci_sriov_enable(dev, num_vfs);
+}
+#endif /* CONFIG_PCI_IOV */
+
 static struct pci_driver virtio_pci_driver = {
 	.name		= "virtio-pci",
 	.id_table	= virtio_pci_id_table,
@@ -592,6 +653,9 @@ static void virtio_pci_remove(struct pci_dev *pci_dev)
 #ifdef CONFIG_PM_SLEEP
 	.driver.pm	= &virtio_pci_pm_ops,
 #endif
+#ifdef CONFIG_PCI_IOV
+	.sriov_configure = virtio_pci_sriov_configure,
+#endif
 };
 
 module_pci_driver(virtio_pci_driver);
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index 135ee3cf7175..7d3910c15e99 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -94,6 +94,9 @@ struct virtio_pci_device {
 	/* Vectors allocated, excluding per-vq vectors if any */
 	unsigned msix_used_vectors;
 
+	/* Number of VFs allocated */
+	int num_vfs;
+
 	/* Whether we have vector per vq */
 	bool per_vq_vectors;
 

