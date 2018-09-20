From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Wed, 19 Sep 2018 17:23:06 -0700
Subject: [Intel-wired-lan] [PATCH 3/8] ice: update branding strings and
 supported device ids
In-Reply-To: <20180920002311.10891-1-anirudh.venkataramanan@intel.com>
References: <20180920002311.10891-1-anirudh.venkataramanan@intel.com>
Message-ID: <20180920002311.10891-4-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

Update branding strings and remove device ids 0x1594 and 0x1595.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned up commit message]
---
 drivers/net/ethernet/intel/ice/ice_devids.h | 10 +++-------
 drivers/net/ethernet/intel/ice/ice_main.c   |  2 --
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_devids.h b/drivers/net/ethernet/intel/ice/ice_devids.h
index 0e14d7215a6e..a6f0a5c0c305 100644
--- a/drivers/net/ethernet/intel/ice/ice_devids.h
+++ b/drivers/net/ethernet/intel/ice/ice_devids.h
@@ -5,15 +5,11 @@
 #define _ICE_DEVIDS_H_
 
 /* Device IDs */
-/* Intel(R) Ethernet Controller C810 for backplane */
+/* Intel(R) Ethernet Controller E810-C for backplane */
 #define ICE_DEV_ID_C810_BACKPLANE	0x1591
-/* Intel(R) Ethernet Controller C810 for QSFP */
+/* Intel(R) Ethernet Controller E810-C for QSFP */
 #define ICE_DEV_ID_C810_QSFP		0x1592
-/* Intel(R) Ethernet Controller C810 for SFP */
+/* Intel(R) Ethernet Controller E810-C for SFP */
 #define ICE_DEV_ID_C810_SFP		0x1593
-/* Intel(R) Ethernet Controller C810/X557-AT 10GBASE-T */
-#define ICE_DEV_ID_C810_10G_BASE_T	0x1594
-/* Intel(R) Ethernet Controller C810 1GbE */
-#define ICE_DEV_ID_C810_SGMII		0x1595
 
 #endif /* _ICE_DEVIDS_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d54e63785ff0..c0599d0b5c0a 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3777,8 +3777,6 @@ static const struct pci_device_id ice_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_C810_BACKPLANE), 0 },
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_C810_QSFP), 0 },
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_C810_SFP), 0 },
-	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_C810_10G_BASE_T), 0 },
-	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_C810_SGMII), 0 },
 	/* required last entry */
 	{ 0, }
 };
-- 
2.14.3

