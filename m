From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed,  8 Sep 2021 16:49:21 -0700
Subject: [Intel-wired-lan] [net-next 1/4] ice: devlink: add shadow-ram
 region to snapshot Shadow RAM
In-Reply-To: <20210908234924.3416592-1-jacob.e.keller@intel.com>
References: <20210908234924.3416592-1-jacob.e.keller@intel.com>
Message-ID: <20210908234924.3416592-2-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We have a region for reading the contents of the NVM flash as
a snapshot. This region does not allow reading the Shadow RAM, as it
always passes the FLASH_ONLY bit to the low level firmware interface.

Add a separate shadow-ram region which will allow snapshot of the
current contents of the Shadow RAM. This data is built from the NVM
contents but is distinct as the device builds up the Shadow RAM during
initialization, so being able to snapshot its contents can be useful
when attempting to debug flash related issues.

Fix the comment description of the nvm-flash region which incorrectly
stated that it filled the shadow-ram region, and add a comment
explaining that the nvm-flash region does not actually read the Shadow
RAM.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h         |  1 +
 drivers/net/ethernet/intel/ice/ice_devlink.c | 93 ++++++++++++++++++--
 2 files changed, 89 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 62d00c82cf2d..4be0828b4972 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -436,6 +436,7 @@ struct ice_pf {
 	struct pci_dev *pdev;
 
 	struct devlink_region *nvm_region;
+	struct devlink_region *sram_region;
 	struct devlink_region *devcaps_region;
 
 	/* devlink port data */
diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
index ee018f249432..66a11ec941a3 100644
--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
@@ -715,16 +715,20 @@ void ice_devlink_destroy_vf_port(struct ice_vf *vf)
 }
 
 /**
- * ice_devlink_nvm_snapshot - Capture a snapshot of the Shadow RAM contents
+ * ice_devlink_nvm_snapshot - Capture a snapshot of the NVM flash contents
  * @devlink: the devlink instance
  * @ops: the devlink region being snapshotted
  * @extack: extended ACK response structure
  * @data: on exit points to snapshot data buffer
  *
  * This function is called in response to the DEVLINK_CMD_REGION_TRIGGER for
- * the shadow-ram devlink region. It captures a snapshot of the shadow ram
- * contents. This snapshot can later be viewed via the devlink-region
- * interface.
+ * the nvm-flash devlink region. It captures a snapshot of the full NVM flash
+ * contents, including both banks of flash. This snapshot can later be viewed
+ * via the devlink-region interface.
+ *
+ * It captures the flash using the FLASH_ONLY bit set when reading via
+ * firmware, so it does not read the current Shadow RAM contents. For that,
+ * use the shadow-ram region.
  *
  * @returns zero on success, and updates the data pointer. Returns a non-zero
  * error code on failure.
@@ -771,6 +775,66 @@ static int ice_devlink_nvm_snapshot(struct devlink *devlink,
 	return 0;
 }
 
+/**
+ * ice_devlink_sram_snapshot - Capture a snapshot of the Shadow RAM contents
+ * @devlink: the devlink instance
+ * @ops: the devlink region being snapshotted
+ * @extack: extended ACK response structure
+ * @data: on exit points to snapshot data buffer
+ *
+ * This function is called in response to the DEVLINK_CMD_REGION_TRIGGER for
+ * the shadow-ram devlink region. It captures a snapshot of the shadow ram
+ * contents. This snapshot can later be viewed via the devlink-region
+ * interface.
+ *
+ * @returns zero on success, and updates the data pointer. Returns a non-zero
+ * error code on failure.
+ */
+static int
+ice_devlink_sram_snapshot(struct devlink *devlink,
+			  const struct devlink_region_ops __always_unused *ops,
+			  struct netlink_ext_ack *extack, u8 **data)
+{
+	struct ice_pf *pf = devlink_priv(devlink);
+	struct device *dev = ice_pf_to_dev(pf);
+	struct ice_hw *hw = &pf->hw;
+	enum ice_status status;
+	u8 *sram_data;
+	u32 sram_size;
+
+	sram_size = hw->flash.sr_words * 2u;
+	sram_data = vzalloc(sram_size);
+	if (!sram_data)
+		return -ENOMEM;
+
+	status = ice_acquire_nvm(hw, ICE_RES_READ);
+	if (status) {
+		dev_dbg(dev, "ice_acquire_nvm failed, err %d aq_err %d\n",
+			status, hw->adminq.sq_last_status);
+		NL_SET_ERR_MSG_MOD(extack, "Failed to acquire NVM semaphore");
+		vfree(sram_data);
+		return -EIO;
+	}
+
+	/* Read from the Shadow RAM, rather than directly from NVM */
+	status = ice_read_flat_nvm(hw, 0, &sram_size, sram_data, true);
+	if (status) {
+		dev_dbg(dev, "ice_read_flat_nvm failed after reading %u bytes, err %d aq_err %d\n",
+			sram_size, status, hw->adminq.sq_last_status);
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Failed to read Shadow RAM contents");
+		ice_release_nvm(hw);
+		vfree(sram_data);
+		return -EIO;
+	}
+
+	ice_release_nvm(hw);
+
+	*data = sram_data;
+
+	return 0;
+}
+
 /**
  * ice_devlink_devcaps_snapshot - Capture snapshot of device capabilities
  * @devlink: the devlink instance
@@ -821,6 +885,12 @@ static const struct devlink_region_ops ice_nvm_region_ops = {
 	.snapshot = ice_devlink_nvm_snapshot,
 };
 
+static const struct devlink_region_ops ice_sram_region_ops = {
+	.name = "shadow-ram",
+	.destructor = vfree,
+	.snapshot = ice_devlink_sram_snapshot,
+};
+
 static const struct devlink_region_ops ice_devcaps_region_ops = {
 	.name = "device-caps",
 	.destructor = vfree,
@@ -838,7 +908,7 @@ void ice_devlink_init_regions(struct ice_pf *pf)
 {
 	struct devlink *devlink = priv_to_devlink(pf);
 	struct device *dev = ice_pf_to_dev(pf);
-	u64 nvm_size;
+	u64 nvm_size, sram_size;
 
 	nvm_size = pf->hw.flash.flash_size;
 	pf->nvm_region = devlink_region_create(devlink, &ice_nvm_region_ops, 1,
@@ -849,6 +919,15 @@ void ice_devlink_init_regions(struct ice_pf *pf)
 		pf->nvm_region = NULL;
 	}
 
+	sram_size = pf->hw.flash.sr_words * 2u;
+	pf->sram_region = devlink_region_create(devlink, &ice_sram_region_ops,
+						1, sram_size);
+	if (IS_ERR(pf->sram_region)) {
+		dev_err(dev, "failed to create shadow-ram devlink region, err %ld\n",
+			PTR_ERR(pf->sram_region));
+		pf->sram_region = NULL;
+	}
+
 	pf->devcaps_region = devlink_region_create(devlink,
 						   &ice_devcaps_region_ops, 10,
 						   ICE_AQ_MAX_BUF_LEN);
@@ -869,6 +948,10 @@ void ice_devlink_destroy_regions(struct ice_pf *pf)
 {
 	if (pf->nvm_region)
 		devlink_region_destroy(pf->nvm_region);
+
+	if (pf->sram_region)
+		devlink_region_destroy(pf->sram_region);
+
 	if (pf->devcaps_region)
 		devlink_region_destroy(pf->devcaps_region);
 }
-- 
2.31.1.331.gb0c09ab8796f

