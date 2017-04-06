From: Sasha Neftin <sasha.neftin@intel.com>
Date: Thu,  6 Apr 2017 10:26:32 +0300
Subject: [Intel-wired-lan] [PATCH 1/3] e1000e: Initial Support for CannonLake
Message-ID: <20170406072632.10703-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Description: i219 (6) and i219 (7) are the next LOM
generations that will be available on the next
Intel Client platform (CannonLake)
This patch provides the initial support for these devices

Reviewed-by: Raanan Avargil <raanan.avargil@intel.com>
Reviewed-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/e1000e/e1000.h   |  4 +++-
 drivers/net/ethernet/intel/e1000e/hw.h      |  5 +++++
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 20 ++++++++++++++++++++
 drivers/net/ethernet/intel/e1000e/netdev.c  |  5 +++++
 4 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/ethernet/intel/e1000e/e1000.h
index a29b12e80855..f16d9826c66d 100644
--- a/drivers/net/ethernet/intel/e1000e/e1000.h
+++ b/drivers/net/ethernet/intel/e1000e/e1000.h
@@ -135,7 +135,8 @@ enum e1000_boards {
 	board_pchlan,
 	board_pch2lan,
 	board_pch_lpt,
-	board_pch_spt
+	board_pch_spt,
+	board_pch_cnp
 };
 
 struct e1000_ps_page {
@@ -515,6 +516,7 @@ extern const struct e1000_info e1000_pch_info;
 extern const struct e1000_info e1000_pch2_info;
 extern const struct e1000_info e1000_pch_lpt_info;
 extern const struct e1000_info e1000_pch_spt_info;
+extern const struct e1000_info e1000_pch_cnp_info;
 extern const struct e1000_info e1000_es2_info;
 
 void e1000e_ptp_init(struct e1000_adapter *adapter);
diff --git a/drivers/net/ethernet/intel/e1000e/hw.h b/drivers/net/ethernet/intel/e1000e/hw.h
index 4e733bf1a38e..66bd5060a65b 100644
--- a/drivers/net/ethernet/intel/e1000e/hw.h
+++ b/drivers/net/ethernet/intel/e1000e/hw.h
@@ -96,6 +96,10 @@ struct e1000_hw;
 #define E1000_DEV_ID_PCH_SPT_I219_V4		0x15D8
 #define E1000_DEV_ID_PCH_SPT_I219_LM5		0x15E3
 #define E1000_DEV_ID_PCH_SPT_I219_V5		0x15D6
+#define E1000_DEV_ID_PCH_CNP_I219_LM6		0x15BD
+#define E1000_DEV_ID_PCH_CNP_I219_V6		0x15BE
+#define E1000_DEV_ID_PCH_CNP_I219_LM7		0x15BB
+#define E1000_DEV_ID_PCH_CNP_I219_V7		0x15BC
 
 #define E1000_REVISION_4	4
 
@@ -118,6 +122,7 @@ enum e1000_mac_type {
 	e1000_pch2lan,
 	e1000_pch_lpt,
 	e1000_pch_spt,
+	e1000_pch_cnp,
 };
 
 enum e1000_media_type {
diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index f3aaca743ea3..bf55e30f147d 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -5914,3 +5914,23 @@ const struct e1000_info e1000_pch_spt_info = {
 	.phy_ops		= &ich8_phy_ops,
 	.nvm_ops		= &spt_nvm_ops,
 };
+
+const struct e1000_info e1000_pch_cnp_info = {
+	.mac			= e1000_pch_cnp,
+	.flags			= FLAG_IS_ICH
+				  | FLAG_HAS_WOL
+				  | FLAG_HAS_HW_TIMESTAMP
+				  | FLAG_HAS_CTRLEXT_ON_LOAD
+				  | FLAG_HAS_AMT
+				  | FLAG_HAS_FLASH
+				  | FLAG_HAS_JUMBO_FRAMES
+				  | FLAG_APME_IN_WUC,
+	.flags2			= FLAG2_HAS_PHY_STATS
+				  | FLAG2_HAS_EEE,
+	.pba			= 26,
+	.max_hw_frame_size	= 9022,
+	.get_variants		= e1000_get_variants_ich8lan,
+	.mac_ops		= &ich8_mac_ops,
+	.phy_ops		= &ich8_phy_ops,
+	.nvm_ops		= &spt_nvm_ops,
+};
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 2175cced402f..4bda1cb97b27 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -71,6 +71,7 @@ static const struct e1000_info *e1000_info_tbl[] = {
 	[board_pch2lan]		= &e1000_pch2_info,
 	[board_pch_lpt]		= &e1000_pch_lpt_info,
 	[board_pch_spt]		= &e1000_pch_spt_info,
+	[board_pch_cnp]		= &e1000_pch_cnp_info,
 };
 
 struct e1000_reg_info {
@@ -7508,6 +7509,10 @@ static const struct pci_device_id e1000_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_SPT_I219_V4), board_pch_spt },
 	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_SPT_I219_LM5), board_pch_spt },
 	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_SPT_I219_V5), board_pch_spt },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_CNP_I219_LM6), board_pch_cnp },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_CNP_I219_V6), board_pch_cnp },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_CNP_I219_LM7), board_pch_cnp },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_CNP_I219_V7), board_pch_cnp },
 
 	{ 0, 0, 0, 0, 0, 0, 0 }	/* terminate list */
 };
-- 
2.11.0

