From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Date: Mon, 16 Aug 2021 18:07:17 +0200
Subject: [Intel-wired-lan] [RFC net-next 7/7] ice: add sysfs interface to
 configure PHY recovered reference signal
In-Reply-To: <20210816160717.31285-1-arkadiusz.kubalewski@intel.com>
References: <20210816160717.31285-1-arkadiusz.kubalewski@intel.com>
Message-ID: <20210816160717.31285-8-arkadiusz.kubalewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Allow user to enable or disable propagation of PHY recovered clock
signal onto requested output pin with new human friendly device private
sysfs interface.

Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 111 ++++++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_ptp.h |   1 +
 2 files changed, 111 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 23ab85dbbfc8..054346a8fdbd 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -9,6 +9,114 @@
 
 #define UNKNOWN_INCVAL_E822 0x100000000ULL
 
+static ssize_t ice_sysfs_phy_write(struct kobject *kobj,
+				   struct kobj_attribute *attr,
+				   const char *buf, size_t count);
+
+static struct kobj_attribute phy_attribute = __ATTR(synce, 0220,
+	NULL, ice_sysfs_phy_write);
+
+/**
+ * __get_pf_pdev - helper function to get the pdev
+ * @kobj:       kobject passed
+ * @pdev:       PCI device information struct
+ *
+ * Raturns 0 on success, negative on failure
+ */
+static int __get_pf_pdev(struct kobject *kobj, struct pci_dev **pdev)
+{
+	struct device *dev;
+
+	if (!kobj->parent)
+		return -EINVAL;
+
+	/* get pdev */
+	dev = kobj_to_dev(kobj->parent);
+	*pdev = to_pci_dev(dev);
+
+	return 0;
+}
+
+#define ICE_C827_RCLKB_PIN      1 /* SDA pin */
+
+/**
+ * ice_sysfs_phy_write - sysfs interface for setting PHY recovered clock pins
+ * @kobj:  sysfs node
+ * @attr:  sysfs node attributes
+ * @buf:   string representing enable and pin number
+ * @count: length of the 'buf' string
+ *
+ * Return number of bytes written on success or negative value on failure.
+ **/
+static ssize_t
+ice_sysfs_phy_write(struct kobject *kobj, struct kobj_attribute *attr,
+		    const char *buf, size_t count)
+{
+	enum ice_status ret = 0;
+	unsigned int ena, pin;
+	struct pci_dev *pdev;
+	struct ice_pf *pf;
+	u32 freq = 0;
+	int cnt;
+
+	if (__get_pf_pdev(kobj, &pdev))
+		return -EPERM;
+
+	pf = pci_get_drvdata(pdev);
+
+	cnt = sscanf(buf, "%u %u", &ena, &pin);
+	if (cnt != 2 || pin > ICE_C827_RCLKB_PIN)
+		return -EINVAL;
+
+	ret = ice_aq_set_phy_rec_clk_out(&pf->hw, pin, !!ena, &freq);
+	if (ret)
+		return -EIO;
+
+	return count;
+}
+
+/**
+ * ice_phy_sysfs_init - initialize sysfs for DPLL
+ * @pf: pointer to pf structure
+ *
+ * Initialize sysfs for handling DPLL in HW.
+ **/
+static void ice_phy_sysfs_init(struct ice_pf *pf)
+{
+	struct kobject *phy_kobj;
+
+	phy_kobj = kobject_create_and_add("phy", &pf->pdev->dev.kobj);
+	if (!phy_kobj) {
+		dev_info(&pf->pdev->dev, "Failed to create PHY kobject\n");
+		return;
+	}
+
+	if (sysfs_create_file(phy_kobj, &phy_attribute.attr)) {
+		dev_info(&pf->pdev->dev, "Failed to create synce kobject\n");
+		kobject_put(phy_kobj);
+		return;
+	}
+
+	pf->ptp.phy_kobj = phy_kobj;
+}
+
+/**
+ * ice_ptp_sysfs_release - release sysfs resources of ptp and synce features
+ * @pf: pointer to pf structure
+ *
+ * Release sysfs interface resources for handling configuration of
+ * ptp and synce features.
+ */
+static void ice_ptp_sysfs_release(struct ice_pf *pf)
+{
+	if (pf->ptp.phy_kobj) {
+		sysfs_remove_file(pf->ptp.phy_kobj, &phy_attribute.attr);
+		kobject_del(pf->ptp.phy_kobj);
+		kobject_put(pf->ptp.phy_kobj);
+		pf->ptp.phy_kobj = 0;
+	}
+}
+
 /**
  * ice_set_tx_tstamp - Enable or disable Tx timestamping
  * @pf: The PF pointer to search in
@@ -2121,6 +2229,7 @@ void ice_ptp_init(struct ice_pf *pf)
 			return;
 	}
 
+	ice_phy_sysfs_init(pf);
 	/* Disable timestamping for both Tx and Rx */
 	ice_ptp_cfg_timestamp(pf, false);
 
@@ -2180,7 +2289,7 @@ void ice_ptp_release(struct ice_pf *pf)
 {
 	/* Disable timestamping for both Tx and Rx */
 	ice_ptp_cfg_timestamp(pf, false);
-
+	ice_ptp_sysfs_release(pf);
 	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
 
 	clear_bit(ICE_FLAG_PTP, pf->flags);
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index 75656eb3084a..9b526782a977 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -143,6 +143,7 @@ struct ice_ptp {
 	struct ptp_clock_info info;
 	struct ptp_clock *clock;
 	struct hwtstamp_config tstamp_config;
+	struct kobject *phy_kobj;
 };
 
 #define __ptp_port_to_ptp(p) \
-- 
2.24.0

