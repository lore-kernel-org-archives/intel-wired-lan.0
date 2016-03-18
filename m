From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Fri, 18 Mar 2016 14:07:10 -0700
Subject: [Intel-wired-lan] [PATCH 1/6] ixgbe: Add KR backplane support for
	X550EM_A
In-Reply-To: <20160318210612.41255.22539.stgit@mdrustad-wks.jf.intel.com>
References: <20160318210612.41255.22539.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <20160318210710.41255.63410.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add device IDs for X550EM_A-based KR backplane devices.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    2 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |    2 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |    8 +++++++-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index ec57c2728b24..ca507d4e46bf 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -131,6 +131,8 @@ static const struct pci_device_id ixgbe_pci_tbl[] = {
 	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_X_10G_T), board_X550EM_x},
 	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_X_SFP), board_X550EM_x},
 	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_A_SFP_N), board_x550em_a },
+	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_A_KR), board_x550em_a },
+	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_A_KR_L), board_x550em_a },
 	/* required last entry */
 	{0, }
 };
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index de02702e44c6..7de93388f050 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -80,6 +80,8 @@
 #define IXGBE_DEV_ID_X550EM_X_SFP	0x15AC
 #define IXGBE_DEV_ID_X550EM_X_10G_T	0x15AD
 #define IXGBE_DEV_ID_X550EM_X_1G_T	0x15AE
+#define IXGBE_DEV_ID_X550EM_A_KR	0x15C2
+#define IXGBE_DEV_ID_X550EM_A_KR_L	0x15C3
 #define IXGBE_DEV_ID_X550EM_A_SFP_N	0x15C4
 
 /* VF Device IDs */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 0dadf2b95c0d..2c9480442157 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -285,6 +285,8 @@ static s32 ixgbe_identify_phy_x550em(struct ixgbe_hw *hw)
 		hw->phy.type = ixgbe_phy_x550em_kx4;
 		break;
 	case IXGBE_DEV_ID_X550EM_X_KR:
+	case IXGBE_DEV_ID_X550EM_A_KR:
+	case IXGBE_DEV_ID_X550EM_A_KR_L:
 		hw->phy.type = ixgbe_phy_x550em_kr;
 		break;
 	case IXGBE_DEV_ID_X550EM_X_1G_T:
@@ -2016,7 +2018,9 @@ static s32 ixgbe_setup_fc_x550em(struct ixgbe_hw *hw)
 		return IXGBE_ERR_CONFIG;
 	}
 
-	if (hw->device_id != IXGBE_DEV_ID_X550EM_X_KR)
+	if (hw->device_id != IXGBE_DEV_ID_X550EM_X_KR &&
+	    hw->device_id != IXGBE_DEV_ID_X550EM_A_KR &&
+	    hw->device_id != IXGBE_DEV_ID_X550EM_A_KR_L)
 		return 0;
 
 	rc = hw->mac.ops.read_iosf_sb_reg(hw,
@@ -2226,6 +2230,8 @@ static enum ixgbe_media_type ixgbe_get_media_type_X550em(struct ixgbe_hw *hw)
 	switch (hw->device_id) {
 	case IXGBE_DEV_ID_X550EM_X_KR:
 	case IXGBE_DEV_ID_X550EM_X_KX4:
+	case IXGBE_DEV_ID_X550EM_A_KR:
+	case IXGBE_DEV_ID_X550EM_A_KR_L:
 		media_type = ixgbe_media_type_backplane;
 		break;
 	case IXGBE_DEV_ID_X550EM_X_SFP:

