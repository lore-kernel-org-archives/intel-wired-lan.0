From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 31 Aug 2015 19:54:49 -0400
Subject: [Intel-wired-lan] [next PATCH S14 09/15] i40e: update fw version
	text string per previous product formats
In-Reply-To: <1441065295-234333-1-git-send-email-catherine.sullivan@intel.com>
References: <1441065295-234333-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1441065295-234333-10-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Carolyn Wyborny <carolyn.wyborny@intel.com>

This patch moves the internal fw version and fw api version info to be
output in probe.  The nvm version, etrack and oem version info are now
configured for output via ethtool -i.

Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
Change-ID: I05d490093a7137dbefcdef263d014d1e5c9e83d0
---
 drivers/net/ethernet/intel/i40e/i40e.h      | 10 ++++++----
 drivers/net/ethernet/intel/i40e/i40e_main.c |  7 +++++++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 9c9601c..031a93a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -107,6 +107,8 @@
 #define I40E_NVM_VERSION_LO_MASK   (0xff << I40E_NVM_VERSION_LO_SHIFT)
 #define I40E_NVM_VERSION_HI_SHIFT  12
 #define I40E_NVM_VERSION_HI_MASK   (0xf << I40E_NVM_VERSION_HI_SHIFT)
+#define I40E_OEM_VER_BUILD_MASK    0xff00
+#define I40E_OEM_VER_PATCH_MASK    0xff
 
 /* The values in here are decimal coded as hex as is the case in the NVM map*/
 #define I40E_CURRENT_NVM_VERSION_HI 0x2
@@ -589,14 +591,14 @@ static inline char *i40e_fw_version_str(struct i40e_hw *hw)
 	static char buf[32];
 
 	snprintf(buf, sizeof(buf),
-		 "f%d.%d.%05d a%d.%d n%x.%02x e%x",
-		 hw->aq.fw_maj_ver, hw->aq.fw_min_ver, hw->aq.fw_build,
-		 hw->aq.api_maj_ver, hw->aq.api_min_ver,
+		 "%x.%02x 0x%x %d.%d.%d",
 		 (hw->nvm.version & I40E_NVM_VERSION_HI_MASK) >>
 			I40E_NVM_VERSION_HI_SHIFT,
 		 (hw->nvm.version & I40E_NVM_VERSION_LO_MASK) >>
 			I40E_NVM_VERSION_LO_SHIFT,
-		 (hw->nvm.eetrack & 0xffffff));
+		 hw->nvm.eetrack, (hw->nvm.oem_ver >> 24),
+		 (hw->nvm.oem_ver & I40E_OEM_VER_BUILD_MASK) >> 8,
+		 hw->nvm.oem_ver & I40E_OEM_VER_PATCH_MASK);
 
 	return buf;
 }
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 7dfe0db..ae2d630 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -10100,6 +10100,13 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	err = i40e_init_adminq(hw);
 	dev_info(&pdev->dev, "%s\n", i40e_fw_version_str(hw));
+
+	/* provide additional fw info, like api and ver */
+	dev_info(&pdev->dev, "fw_version:%d.%d.%05d\n",
+		 hw->aq.fw_maj_ver, hw->aq.fw_min_ver, hw->aq.fw_build);
+	dev_info(&pdev->dev, "fw api version:%d.%d\n",
+		 hw->aq.api_maj_ver, hw->aq.api_min_ver);
+
 	if (err) {
 		dev_info(&pdev->dev,
 			 "The driver for the device stopped because the NVM image is newer than expected. You must install the most recent version of the network driver.\n");
-- 
1.9.3

