From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 15 Oct 2018 12:18:29 -0700
Subject: [Intel-wired-lan] [net-next 3/3] fm10k: add missing device IDs to
 the upstream driver
In-Reply-To: <20181015191829.17115-1-jacob.e.keller@intel.com>
References: <20181015191829.17115-1-jacob.e.keller@intel.com>
Message-ID: <20181015191829.17115-4-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The device IDs for the Ethernet SDI Adapter devices were never added to
the upstream driver. The IDs are already in the pci.ids database, and
are supported by the out-of-tree driver.

Add the device IDs now, so that the upstream driver can recognize and
load these devices.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c  | 2 ++
 drivers/net/ethernet/intel/fm10k/fm10k_type.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index c859ababeed5..8f1345b11aa9 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -23,6 +23,8 @@ static const struct fm10k_info *fm10k_info_tbl[] = {
  */
 static const struct pci_device_id fm10k_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, FM10K_DEV_ID_PF), fm10k_device_pf },
+	{ PCI_VDEVICE(INTEL, FM10K_DEV_ID_SDI_FM10420_QDA2), fm10k_device_pf },
+	{ PCI_VDEVICE(INTEL, FM10K_DEV_ID_SDI_FM10420_DA2), fm10k_device_pf },
 	{ PCI_VDEVICE(INTEL, FM10K_DEV_ID_VF), fm10k_device_vf },
 	/* required last entry */
 	{ 0, }
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_type.h b/drivers/net/ethernet/intel/fm10k/fm10k_type.h
index 3e608e493f9d..9fb9fca375e3 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_type.h
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_type.h
@@ -15,6 +15,8 @@ struct fm10k_hw;
 
 #define FM10K_DEV_ID_PF			0x15A4
 #define FM10K_DEV_ID_VF			0x15A5
+#define FM10K_DEV_ID_SDI_FM10420_QDA2	0x15D0
+#define FM10K_DEV_ID_SDI_FM10420_DA2	0x15D5
 
 #define FM10K_MAX_QUEUES		256
 #define FM10K_MAX_QUEUES_PF		128
-- 
2.18.0.219.gaf81d287a9da

