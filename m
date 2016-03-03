From: Bruce Allan <bruce.w.allan@intel.com>
Date: Thu, 03 Mar 2016 12:57:37 -0800
Subject: [Intel-wired-lan] [next-queue PATCH] fm10k: enable Intel Ethernet
 SDI Adapter FM10420 device ids
Message-ID: <20160303205737.6701.97855.stgit@bwallan-cwp1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c  |    2 ++
 drivers/net/ethernet/intel/fm10k/fm10k_type.h |    2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 5b74eac..c3b9945 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -39,6 +39,8 @@ static const struct fm10k_info *fm10k_info_tbl[] = {
  */
 static const struct pci_device_id fm10k_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, FM10K_DEV_ID_PF), fm10k_device_pf },
+	{ PCI_VDEVICE(INTEL, FM10K_DEV_ID_SDI_FM10420_QDA2), fm10k_device_pf },
+	{ PCI_VDEVICE(INTEL, FM10K_DEV_ID_SDI_FM10420_DA2), fm10k_device_pf },
 	{ PCI_VDEVICE(INTEL, FM10K_DEV_ID_VF), fm10k_device_vf },
 	/* required last entry */
 	{ 0, }
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_type.h b/drivers/net/ethernet/intel/fm10k/fm10k_type.h
index 5c05330..e24515f 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_type.h
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_type.h
@@ -32,6 +32,8 @@ struct fm10k_hw;
 
 #define FM10K_DEV_ID_PF			0x15A4
 #define FM10K_DEV_ID_VF			0x15A5
+#define FM10K_DEV_ID_SDI_FM10420_QDA2	0x15D0
+#define FM10K_DEV_ID_SDI_FM10420_DA2	0x15D5
 
 #define FM10K_MAX_QUEUES		256
 #define FM10K_MAX_QUEUES_PF		128

