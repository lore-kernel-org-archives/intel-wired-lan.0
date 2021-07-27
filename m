From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Mon, 26 Jul 2021 20:36:56 -0700
Subject: [Intel-wired-lan] [PATCH next-queue v6 3/4] igc: Enable PCIe PTM
In-Reply-To: <20210727033657.39885-1-vinicius.gomes@intel.com>
References: <20210727033657.39885-1-vinicius.gomes@intel.com>
Message-ID: <20210727033657.39885-4-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Enables PCIe PTM (Precision Time Measurement) support in the igc
driver. Notifies the PCI devices that PCIe PTM should be enabled.

PCIe PTM is similar protocol to PTP (Precision Time Protocol) running
in the PCIe fabric, it allows devices to report time measurements from
their internal clocks and the correlation with the PCIe root clock.

The i225 NIC exposes some registers that expose those time
measurements, those registers will be used, in later patches, to
implement the PTP_SYS_OFFSET_PRECISE ioctl().

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 4dc7c4d70929..0600c11c2d64 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -12,6 +12,8 @@
 #include <net/pkt_sched.h>
 #include <linux/bpf_trace.h>
 #include <net/xdp_sock_drv.h>
+#include <linux/pci.h>
+
 #include <net/ipv6.h>
 
 #include "igc.h"
@@ -6183,6 +6185,10 @@ static int igc_probe(struct pci_dev *pdev,
 
 	pci_enable_pcie_error_reporting(pdev);
 
+	err = pci_enable_ptm(pdev, NULL);
+	if (err < 0)
+		dev_info(&pdev->dev, "PCIe PTM not supported by PCIe bus/controller\n");
+
 	pci_set_master(pdev);
 
 	err = -ENOMEM;
-- 
2.32.0

