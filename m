From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 11 Nov 2020 10:59:15 -0800
Subject: [Intel-wired-lan] [net-next PATCH] ice: report timeout length for
 erasing during devlink flash
Message-ID: <20201111185915.813332-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When erasing, notify userspace of how long we will potentially take to
erase a module. Doing so allows userspace to report the timeout, giving
a clear indication of the upper time bound of the operation.

Since we're re-using the erase timeout value, make it a macro rather
than a magic number.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_fw_update.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_fw_update.c b/drivers/net/ethernet/intel/ice/ice_fw_update.c
index 8f81b95e679c..dcec0360ce55 100644
--- a/drivers/net/ethernet/intel/ice/ice_fw_update.c
+++ b/drivers/net/ethernet/intel/ice/ice_fw_update.c
@@ -417,6 +417,11 @@ ice_write_nvm_module(struct ice_pf *pf, u16 module, const char *component,
 	return err;
 }
 
+/* Length in seconds to wait before timing out when erasing a flash module.
+ * Yes, erasing really can take minutes to complete.
+ */
+#define ICE_FW_ERASE_TIMEOUT 300
+
 /**
  * ice_erase_nvm_module - Erase an NVM module and await firmware completion
  * @pf: the PF data structure
@@ -449,7 +454,7 @@ ice_erase_nvm_module(struct ice_pf *pf, u16 module, const char *component,
 
 	devlink = priv_to_devlink(pf);
 
-	devlink_flash_update_status_notify(devlink, "Erasing", component, 0, 0);
+	devlink_flash_update_timeout_notify(devlink, "Erasing", component, ICE_FW_ERASE_TIMEOUT);
 
 	status = ice_aq_erase_nvm(hw, module, NULL);
 	if (status) {
@@ -461,8 +466,7 @@ ice_erase_nvm_module(struct ice_pf *pf, u16 module, const char *component,
 		goto out_notify_devlink;
 	}
 
-	/* Yes, this really can take minutes to complete */
-	err = ice_aq_wait_for_event(pf, ice_aqc_opc_nvm_erase, 300 * HZ, &event);
+	err = ice_aq_wait_for_event(pf, ice_aqc_opc_nvm_erase, ICE_FW_ERASE_TIMEOUT * HZ, &event);
 	if (err) {
 		dev_err(dev, "Timed out waiting for firmware to respond with erase completion for %s (module 0x%02x), err %d\n",
 			component, module, err);

base-commit: 6a4868314a36d2580a87ade92e2d3f302eec3f03
-- 
2.29.0

