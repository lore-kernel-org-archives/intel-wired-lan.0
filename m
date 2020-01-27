From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon, 27 Jan 2020 00:59:27 -0800
Subject: [Intel-wired-lan] [PATCH S39 15/15] ice: fix define for E822
 backplane device
In-Reply-To: <20200127085927.13999-1-anthony.l.nguyen@intel.com>
References: <20200127085927.13999-1-anthony.l.nguyen@intel.com>
Message-ID: <20200127085927.13999-15-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

This product's name has changed; update the macro identifier accordingly.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_devids.h | 4 ++--
 drivers/net/ethernet/intel/ice/ice_main.c   | 2 +-
 drivers/net/ethernet/intel/ice/ice_nvm.c    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_devids.h b/drivers/net/ethernet/intel/ice/ice_devids.h
index 6fccb66ff43c..9d8194671f6a 100644
--- a/drivers/net/ethernet/intel/ice/ice_devids.h
+++ b/drivers/net/ethernet/intel/ice/ice_devids.h
@@ -43,8 +43,8 @@
 #define ICE_DEV_ID_E822C_10G_BASE_T	0x1893
 /* Intel(R) Ethernet Connection E822-C 1GbE */
 #define ICE_DEV_ID_E822C_SGMII		0x1894
-/* Intel(R) Ethernet Connection E822-X for backplane */
-#define ICE_DEV_ID_E822X_BACKPLANE	0x1897
+/* Intel(R) Ethernet Connection E822-L for backplane */
+#define ICE_DEV_ID_E822L_BACKPLANE	0x1897
 /* Intel(R) Ethernet Connection E822-L for SFP */
 #define ICE_DEV_ID_E822L_SFP		0x1898
 /* Intel(R) Ethernet Connection E822-L/X557-AT 10GBASE-T */
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 5f23806669e2..b25ac179c8b8 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3626,7 +3626,7 @@ static const struct pci_device_id ice_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E822C_SFP), 0 },
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E822C_10G_BASE_T), 0 },
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E822C_SGMII), 0 },
-	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E822X_BACKPLANE), 0 },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E822L_BACKPLANE), 0 },
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E822L_SFP), 0 },
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E822L_10G_BASE_T), 0 },
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E822L_SGMII), 0 },
diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.c b/drivers/net/ethernet/intel/ice/ice_nvm.c
index 75cd4cbb473b..f6e25db22c23 100644
--- a/drivers/net/ethernet/intel/ice/ice_nvm.c
+++ b/drivers/net/ethernet/intel/ice/ice_nvm.c
@@ -301,7 +301,7 @@ enum ice_status ice_init_nvm(struct ice_hw *hw)
 	case ICE_DEV_ID_E822C_10G_BASE_T:
 	case ICE_DEV_ID_E822C_SGMII:
 	case ICE_DEV_ID_E822C_SFP:
-	case ICE_DEV_ID_E822X_BACKPLANE:
+	case ICE_DEV_ID_E822L_BACKPLANE:
 	case ICE_DEV_ID_E822L_SFP:
 	case ICE_DEV_ID_E822L_10G_BASE_T:
 	case ICE_DEV_ID_E822L_SGMII:
-- 
2.20.1

