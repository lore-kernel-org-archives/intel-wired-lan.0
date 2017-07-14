From: Alice Michael <alice.michael@intel.com>
Date: Fri, 14 Jul 2017 09:27:09 -0400
Subject: [Intel-wired-lan] [next PATCH S77-V3 10/10] i40e: refactor FW
	version checking
In-Reply-To: <20170714132709.52657-1-alice.michael@intel.com>
References: <20170714132709.52657-1-alice.michael@intel.com>
Message-ID: <20170714132709.52657-10-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

The i40e driver now supports two different devices with two different
firmware versions. So be smart about how we handle these. Move the FW
version macros to the appropriate header file, and add a convenience
macro that checks the version based on the device. Then use this macro
to check whether or not the driver can use the new link info API.

Testing Hints (required if no HSD): Compile, load on both X710 and X722
and make sure it doesn't complain about API version on latest FW.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h   | 10 +++++++++-
 drivers/net/ethernet/intel/i40e/i40e_common.c       |  6 ++++--
 drivers/net/ethernet/intel/i40e/i40e_main.c         |  2 +-
 drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h | 10 +++++++++-
 4 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
index 5d5f422..e2a9ec8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
@@ -34,7 +34,15 @@
  */
 
 #define I40E_FW_API_VERSION_MAJOR	0x0001
-#define I40E_FW_API_VERSION_MINOR	0x0005
+#define I40E_FW_API_VERSION_MINOR_X722	0x0005
+#define I40E_FW_API_VERSION_MINOR_X710	0x0007
+
+#define I40E_FW_MINOR_VERSION(_h) ((_h)->mac.type == I40E_MAC_XL710 ? \
+					I40E_FW_API_VERSION_MINOR_X710 : \
+					I40E_FW_API_VERSION_MINOR_X722)
+
+/* API version 1.7 implements additional link and PHY-specific APIs  */
+#define I40E_MINOR_VER_GET_LINK_INFO_XL710 0x0007
 
 struct i40e_aq_desc {
 	__le16 flags;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 111426b..f01a54a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1593,8 +1593,10 @@ i40e_status i40e_aq_get_phy_capabilities(struct i40e_hw *hw,
 		status = I40E_ERR_UNKNOWN_PHY;
 
 	if (report_init) {
-		hw->phy.phy_types = le32_to_cpu(abilities->phy_type);
-		hw->phy.phy_types |= ((u64)abilities->phy_type_ext << 32);
+		if (hw->mac.type ==  I40E_MAC_XL710 &&
+		    hw->aq.api_maj_ver == I40E_FW_API_VERSION_MAJOR &&
+		    hw->aq.api_min_ver >= I40E_MINOR_VER_GET_LINK_INFO_XL710) {
+			status = i40e_aq_get_link_info(hw, true, NULL, NULL);
 	}
 
 	return status;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 1ad014d..fb0c8c6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -11420,7 +11420,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		 i40e_nvm_version_str(hw));
 
 	if (hw->aq.api_maj_ver == I40E_FW_API_VERSION_MAJOR &&
-	    hw->aq.api_min_ver > I40E_FW_API_VERSION_MINOR)
+	    hw->aq.api_min_ver > I40E_FW_MINOR_VERSION(hw))
 		dev_info(&pdev->dev,
 			 "The driver for the device detected a newer version of the NVM image than expected. Please install the most recent version of the network driver.\n");
 	else if (hw->aq.api_maj_ver == 1 && hw->aq.api_min_ver < 4)
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
index 83e63e5..f9f48d1 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
@@ -34,7 +34,15 @@
  */
 
 #define I40E_FW_API_VERSION_MAJOR	0x0001
-#define I40E_FW_API_VERSION_MINOR	0x0005
+#define I40E_FW_API_VERSION_MINOR_X722	0x0005
+#define I40E_FW_API_VERSION_MINOR_X710	0x0007
+
+#define I40E_FW_MINOR_VERSION(_h) ((_h)->mac.type == I40E_MAC_XL710 ? \
+					I40E_FW_API_VERSION_MINOR_X710 : \
+					I40E_FW_API_VERSION_MINOR_X722)
+
+/* API version 1.7 implements additional link and PHY-specific APIs  */
+#define I40E_MINOR_VER_GET_LINK_INFO_XL710 0x0007
 
 struct i40e_aq_desc {
 	__le16 flags;
-- 
2.9.3

