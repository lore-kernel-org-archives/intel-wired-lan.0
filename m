From: Barry Song <21cnbao@gmail.com>
Date: Wed, 25 Aug 2021 18:26:33 +0800
Subject: [Intel-wired-lan] [PATCH v3 0/3] PCI/MSI: Clarify the IRQ sysfs ABI
 for PCI devices
Message-ID: <20210825102636.52757-1-21cnbao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Barry Song <song.bao.hua@hisilicon.com>


/sys/bus/pci/devices/.../irq has been there for many years but it has never
been documented. This patchset is trying to clarify it.

-v3:
  - Don't attempt to modify the current behaviour of IRQ ABI for MSI-X
  - Make MSI IRQ ABI more explicit(return 1st IRQ of the IRQ vector)
  - Add Marc's patch of removing default_irq from the previous comment to
    the series.
  Note patch 3/3 indirectly changed the code of pci_restore_msi_state(),
  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c is the only driver
  calling this API. I would appreciate testing done from this driver's
  maintainers.

-v2:
  - split into two patches according to Bjorn's comments;
  - Add Greg's Acked-by, thanks for reviewing!
  https://lore.kernel.org/lkml/20210820223744.8439-1-21cnbao at gmail.com/

-v1:
  https://lore.kernel.org/lkml/20210813122650.25764-1-21cnbao at gmail.com/#t

Barry Song (2):
  Documentation: ABI: sysfs-bus-pci: Add description for IRQ entry
  PCI/sysfs: Don't depend on pci_dev.irq for IRQ entry

Marc Zyngier (1):
  PCI/MSI: remove msi_attrib.default_irq in msi_desc

 Documentation/ABI/testing/sysfs-bus-pci | 10 ++++++++++
 drivers/pci/msi.c                       | 12 +++++-------
 drivers/pci/pci-sysfs.c                 | 23 ++++++++++++++++++++++-
 include/linux/msi.h                     |  2 --
 4 files changed, 37 insertions(+), 10 deletions(-)

-- 
1.8.3.1

