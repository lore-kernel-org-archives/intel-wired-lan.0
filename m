From: Bjorn Helgaas <helgaas@kernel.org>
Date: Wed, 25 Jul 2018 14:52:08 -0500
Subject: [Intel-wired-lan] [PATCH v1 0/4] PCI: Remove unnecessary includes
 of <linux/pci-aspm.h>
Message-ID: <153254813164.92573.10755585465477668768.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Remove includes of <linux/pci-aspm.h> from files that don't need
it.  I'll apply all these via the PCI tree unless there's objection.

---

Bjorn Helgaas (4):
      igb: Remove unnecessary include of <linux/pci-aspm.h>
      ath9k: Remove unnecessary include of <linux/pci-aspm.h>
      iwlwifi: Remove unnecessary include of <linux/pci-aspm.h>
      PCI: Remove unnecessary include of <linux/pci-aspm.h>


 drivers/net/ethernet/intel/igb/igb_main.c     |    1 -
 drivers/net/wireless/ath/ath9k/pci.c          |    1 -
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |    1 -
 drivers/pci/pci-sysfs.c                       |    1 -
 drivers/pci/pci.c                             |    1 -
 drivers/pci/probe.c                           |    1 -
 drivers/pci/remove.c                          |    1 -
 7 files changed, 7 deletions(-)
