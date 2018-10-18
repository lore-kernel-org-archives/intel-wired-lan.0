From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Thu, 18 Oct 2018 08:37:04 -0700
Subject: [Intel-wired-lan] [PATCH 2/7] ice: Change device ID define names to
 align with branding string
In-Reply-To: <20181018153709.32664-1-anirudh.venkataramanan@intel.com>
References: <20181018153709.32664-1-anirudh.venkataramanan@intel.com>
Message-ID: <20181018153709.32664-3-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Basically remove references to C810 and use E810C (from the branding
string) instead.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_devids.h | 6 +++---
 drivers/net/ethernet/intel/ice/ice_main.c   | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_devids.h b/drivers/net/ethernet/intel/ice/ice_devids.h
index a6f0a5c0c305..f8d5c661d0ba 100644
--- a/drivers/net/ethernet/intel/ice/ice_devids.h
+++ b/drivers/net/ethernet/intel/ice/ice_devids.h
@@ -6,10 +6,10 @@
 
 /* Device IDs */
 /* Intel(R) Ethernet Controller E810-C for backplane */
-#define ICE_DEV_ID_C810_BACKPLANE	0x1591
+#define ICE_DEV_ID_E810C_BACKPLANE	0x1591
 /* Intel(R) Ethernet Controller E810-C for QSFP */
-#define ICE_DEV_ID_C810_QSFP		0x1592
+#define ICE_DEV_ID_E810C_QSFP		0x1592
 /* Intel(R) Ethernet Controller E810-C for SFP */
-#define ICE_DEV_ID_C810_SFP		0x1593
+#define ICE_DEV_ID_E810C_SFP		0x1593
 
 #endif /* _ICE_DEVIDS_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 8f61b375e768..0084b7290b2b 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2271,9 +2271,9 @@ static void ice_remove(struct pci_dev *pdev)
  *   Class, Class Mask, private data (not used) }
  */
 static const struct pci_device_id ice_pci_tbl[] = {
-	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_C810_BACKPLANE), 0 },
-	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_C810_QSFP), 0 },
-	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_C810_SFP), 0 },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E810C_BACKPLANE), 0 },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E810C_QSFP), 0 },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E810C_SFP), 0 },
 	/* required last entry */
 	{ 0, }
 };
-- 
2.14.3

