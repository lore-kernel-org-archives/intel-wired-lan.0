From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Thu, 21 Apr 2016 11:37:06 -0700
Subject: [Intel-wired-lan] [PATCH 1/2] ixgbe: add WOL support for some 82599
	subdevice IDs
Message-ID: <20160421183706.21311.93388.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We had some 82599 subdevice IDs missing from the list of parts that
support WOL.

Reported-by: Neil Horman <nhorman@redhat.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    8 ++++++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |    6 +++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index d52a2a8..5f621ab 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -9202,8 +9202,10 @@ int ixgbe_wol_supported(struct ixgbe_adapter *adapter, u16 device_id,
 	case IXGBE_DEV_ID_82599_SFP:
 		/* Only these subdevices could supports WOL */
 		switch (subdevice_id) {
-		case IXGBE_SUBDEV_ID_82599_SFP_WOL0:
 		case IXGBE_SUBDEV_ID_82599_560FLR:
+		case IXGBE_SUBDEV_ID_82599_LOM_SNAP6:
+		case IXGBE_SUBDEV_ID_82599_SFP_WOL0:
+		case IXGBE_SUBDEV_ID_82599_SFP_2OCP:
 			/* only support first port */
 			if (hw->bus.func != 0)
 				break;
@@ -9211,7 +9213,9 @@ int ixgbe_wol_supported(struct ixgbe_adapter *adapter, u16 device_id,
 		case IXGBE_SUBDEV_ID_82599_SFP:
 		case IXGBE_SUBDEV_ID_82599_RNDC:
 		case IXGBE_SUBDEV_ID_82599_ECNA_DP:
-		case IXGBE_SUBDEV_ID_82599_LOM_SFP:
+		case IXGBE_SUBDEV_ID_82599_SFP_1OCP:
+		case IXGBE_SUBDEV_ID_82599_SFP_LOM_OEM1:
+		case IXGBE_SUBDEV_ID_82599_SFP_LOM_OEM2:
 			is_wol_supported = 1;
 			break;
 		}
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 7af4514..71082be 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -59,8 +59,12 @@
 #define IXGBE_SUBDEV_ID_82599_RNDC       0x1F72
 #define IXGBE_SUBDEV_ID_82599_560FLR     0x17D0
 #define IXGBE_SUBDEV_ID_82599_SP_560FLR  0x211B
+#define IXGBE_SUBDEV_ID_82599_LOM_SNAP6		0x2159
+#define IXGBE_SUBDEV_ID_82599_SFP_1OCP		0x000D
+#define IXGBE_SUBDEV_ID_82599_SFP_2OCP		0x0008
+#define IXGBE_SUBDEV_ID_82599_SFP_LOM_OEM1	0x8976
+#define IXGBE_SUBDEV_ID_82599_SFP_LOM_OEM2	0x06EE
 #define IXGBE_SUBDEV_ID_82599_ECNA_DP    0x0470
-#define IXGBE_SUBDEV_ID_82599_LOM_SFP    0x8976
 #define IXGBE_DEV_ID_82599_SFP_EM        0x1507
 #define IXGBE_DEV_ID_82599_SFP_SF2       0x154D
 #define IXGBE_DEV_ID_82599EN_SFP         0x1557

