From: Raanan Avargil <raanan.avargil@intel.com>
Date: Tue, 22 Dec 2015 15:35:05 +0200
Subject: [Intel-wired-lan] [PATCH 5/5] e1000e: Initial support for KabeLake
In-Reply-To: <1450791305-11285-1-git-send-email-raanan.avargil@intel.com>
References: <1450791305-11285-1-git-send-email-raanan.avargil@intel.com>
Message-ID: <1450791305-11285-5-git-send-email-raanan.avargil@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

i219 (4) and i219 (5) are the next LOM generations that will be
available on the next Intel platform (KabeLake).
This patch provides the initial support for the devices.

Signed-off-by: Raanan Avargil <raanan.avargil@intel.com>
---
 drivers/net/ethernet/intel/e1000e/hw.h     | 4 ++++
 drivers/net/ethernet/intel/e1000e/netdev.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/hw.h b/drivers/net/ethernet/intel/e1000e/hw.h
index b3949d5..4e733bf 100644
--- a/drivers/net/ethernet/intel/e1000e/hw.h
+++ b/drivers/net/ethernet/intel/e1000e/hw.h
@@ -92,6 +92,10 @@ struct e1000_hw;
 #define E1000_DEV_ID_PCH_SPT_I219_LM2		0x15B7	/* SPT-H PCH */
 #define E1000_DEV_ID_PCH_SPT_I219_V2		0x15B8	/* SPT-H PCH */
 #define E1000_DEV_ID_PCH_LBG_I219_LM3		0x15B9	/* LBG PCH */
+#define E1000_DEV_ID_PCH_SPT_I219_LM4		0x15D7
+#define E1000_DEV_ID_PCH_SPT_I219_V4		0x15D8
+#define E1000_DEV_ID_PCH_SPT_I219_LM5		0x15E3
+#define E1000_DEV_ID_PCH_SPT_I219_V5		0x15D6
 
 #define E1000_REVISION_4	4
 
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index c71ba1b..9b4ec13 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -7452,6 +7452,10 @@ static const struct pci_device_id e1000_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_SPT_I219_LM2), board_pch_spt },
 	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_SPT_I219_V2), board_pch_spt },
 	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_LBG_I219_LM3), board_pch_spt },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_SPT_I219_LM4), board_pch_spt },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_SPT_I219_V4), board_pch_spt },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_SPT_I219_LM5), board_pch_spt },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_SPT_I219_V5), board_pch_spt },
 
 	{ 0, 0, 0, 0, 0, 0, 0 }	/* terminate list */
 };
-- 
2.1.0

---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

