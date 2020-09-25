From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Fri, 25 Sep 2020 16:28:33 -0700
Subject: [Intel-wired-lan] [PATCH next-queue v1 2/3] igc: Enable PCIe PTM
In-Reply-To: <20200925232834.2704711-1-vinicius.gomes@intel.com>
References: <20200925232834.2704711-1-vinicius.gomes@intel.com>
Message-ID: <20200925232834.2704711-3-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In practice, enabling PTM also sets the enabled_ptm flag in the PCI
device, the flag will be used for detecting if PTM is enabled before
adding support for the SYSOFFSET_PRECISE ioctl() (which is added by
implementing the getcrosststamp() PTP function).

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 897e2d5514a1..56670ce14da8 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -10,6 +10,7 @@
 #include <linux/ip.h>
 #include <linux/pm_runtime.h>
 #include <net/pkt_sched.h>
+#include <linux/pci.h>
 
 #include <net/ipv6.h>
 
@@ -5021,6 +5022,10 @@ static int igc_probe(struct pci_dev *pdev,
 
 	pci_enable_pcie_error_reporting(pdev);
 
+	err = pci_enable_ptm(pdev, NULL);
+	if (err < 0)
+		dev_err(&pdev->dev, "PTM not supported\n");
+
 	pci_set_master(pdev);
 
 	err = -ENOMEM;
-- 
2.28.0

