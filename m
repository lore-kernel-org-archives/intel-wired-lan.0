From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Wed, 28 Jul 2021 12:39:10 -0700
Subject: [Intel-wired-lan] [PATCH net] ice: Prevent probing virtual functions
Message-ID: <20210728193910.644656-1-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The userspace utility "driverctl" can be used to change/override the
system's default driver choices. This is useful in some situations
(buggy driver, old driver missing a device ID, trying a workaround,
etc.) where the user needs to load a different driver.

However, this is also prone to user error, where a driver is mapped
to a device it's not designed to drive. For example, if the ice driver
is mapped to driver iavf devices, the ice driver crashes.

Add a check to return an error if the ice driver is being used to
probe a virtual function.

Fixes: 837f08fdecbe ("ice: Add basic driver framework for Intel(R) E800 Series")
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 4f5ce08..43b8e84 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4260,6 +4260,11 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 	struct ice_hw *hw;
 	int i, err;
 
+	if (pdev->is_virtfn) {
+		dev_err(dev, "can't probe a virtual function\n");
+		return -EINVAL;
+	}
+
 	/* this driver uses devres, see
 	 * Documentation/driver-api/driver-model/devres.rst
 	 */
-- 
2.31.1

