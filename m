From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Fri, 25 Mar 2016 10:20:49 -0700
Subject: [Intel-wired-lan] [PATCH V2 10/11] ixgbe: Add KR backplane support
	for x550em_a
In-Reply-To: <20160325171845.43003.2969.stgit@mdrustad-wks.jf.intel.com>
References: <20160325171845.43003.2969.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <20160325172049.43003.70982.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add support for x550em_a-based KR backplane devices.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    2 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |    2 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |   13 +++++++++++--
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 41bc816bbe87..0d5893a60e08 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -130,6 +130,8 @@ static const struct pci_device_id ixgbe_pci_tbl[] = {
 	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_X_KR), board_X550EM_x},
 	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_X_10G_T), board_X550EM_x},
 	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_X_SFP), board_X550EM_x},
+	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_A_KR), board_x550em_a },
+	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_A_KR_L), board_x550em_a },
 	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_A_SFP_N), board_x550em_a },
 	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_A_SGMII), board_x550em_a },
 	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_A_SGMII_L), board_x550em_a },
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index eada335c03f8..216a29dcc718 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -80,6 +80,8 @@
 #define IXGBE_DEV_ID_X550EM_X_SFP	0x15AC
 #define IXGBE_DEV_ID_X550EM_X_10G_T	0x15AD
 #define IXGBE_DEV_ID_X550EM_X_1G_T	0x15AE
+#define IXGBE_DEV_ID_X550EM_A_KR	0x15C2
+#define IXGBE_DEV_ID_X550EM_A_KR_L	0x15C3
 #define IXGBE_DEV_ID_X550EM_A_SFP_N	0x15C4
 #define IXGBE_DEV_ID_X550EM_A_SGMII	0x15C6
 #define IXGBE_DEV_ID_X550EM_A_SGMII_L	0x15C7
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 1fd4f134ce49..aecc831496c5 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -291,6 +291,8 @@ static s32 ixgbe_identify_phy_x550em(struct ixgbe_hw *hw)
 		hw->phy.type = ixgbe_phy_x550em_kx4;
 		break;
 	case IXGBE_DEV_ID_X550EM_X_KR:
+	case IXGBE_DEV_ID_X550EM_A_KR:
+	case IXGBE_DEV_ID_X550EM_A_KR_L:
 		hw->phy.type = ixgbe_phy_x550em_kr;
 		break;
 	case IXGBE_DEV_ID_X550EM_X_1G_T:
@@ -2196,7 +2198,9 @@ static s32 ixgbe_setup_fc_x550em(struct ixgbe_hw *hw)
 		return IXGBE_ERR_CONFIG;
 	}
 
-	if (hw->device_id != IXGBE_DEV_ID_X550EM_X_KR)
+	if (hw->device_id != IXGBE_DEV_ID_X550EM_X_KR &&
+	    hw->device_id != IXGBE_DEV_ID_X550EM_A_KR &&
+	    hw->device_id != IXGBE_DEV_ID_X550EM_A_KR_L)
 		return 0;
 
 	rc = hw->mac.ops.read_iosf_sb_reg(hw,
@@ -2387,7 +2391,10 @@ static s32 ixgbe_init_phy_ops_X550em(struct ixgbe_hw *hw)
 		phy->ops.write_reg = ixgbe_write_phy_reg_x550em;
 		break;
 	case ixgbe_phy_x550em_kr:
-		phy->ops.setup_link = ixgbe_setup_kr_x550em;
+		if (hw->mac.type == ixgbe_mac_X550EM_x)
+			phy->ops.setup_link = ixgbe_setup_kr_x550em;
+		else
+			phy->ops.setup_link = NULL;
 		phy->ops.read_reg = ixgbe_read_phy_reg_x550em;
 		phy->ops.write_reg = ixgbe_write_phy_reg_x550em;
 		break;
@@ -2437,6 +2444,8 @@ static enum ixgbe_media_type ixgbe_get_media_type_X550em(struct ixgbe_hw *hw)
 		/* Fallthrough */
 	case IXGBE_DEV_ID_X550EM_X_KR:
 	case IXGBE_DEV_ID_X550EM_X_KX4:
+	case IXGBE_DEV_ID_X550EM_A_KR:
+	case IXGBE_DEV_ID_X550EM_A_KR_L:
 		media_type = ixgbe_media_type_backplane;
 		break;
 	case IXGBE_DEV_ID_X550EM_X_SFP:

