From: Megha Dey <megha.dey@linux.intel.com>
Date: Fri,  1 Feb 2019 11:14:07 -0800
Subject: [Intel-wired-lan] [RFC v4 0/6] Introduce dynamic allocation/freeing
 of MSI-X vectors
Message-ID: <1549048453-3584-1-git-send-email-megha.dey@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Currently, MSI-X vector enabling and allocation for a PCIe device is static
i.e. a device driver gets only one chance to enable a specific number of
MSI-X vectors, usually during device probe. Also, in many cases, drivers
usually reserve more than required number of vectors anticipating their
use, which unnecessarily blocks resources that could have been made available
to other devices. Lastly, there is no way for drivers to reserve more vectors,
if the MSI-x has already been enabled for that device.

Hence, a dynamic MSI-X kernel infrastructure can benefit drivers by deferring
MSI-X allocation to post probe phase, where actual demand information is
available.

This patchset enables the dynamic allocation/de-allocation of MSI-X vectors
by introducing 2 new APIs: pci_alloc_irq_vectors_dyn() and
pci_free_irq_vectors_grp().

Changes V3->V4
1. Initialised first_desc for MSI as well.

Changes V2->V3
1. Added a separate patch to include documentation
2. Added a lookup function pci_irq_vector_group based on group id
3. Added a 'one_shot' field to struct device
4. Ensure msix table base gets mapped only once
5. Removed redundant checks
6. Use pointer for msi related data to reduce memory footprint of struct device
7. Initialization of idrs used internally by MSI code done by the core code
   instead of drivers/callers..

Changes V1->V2
1. Added relavant documentation
2. Avoid code duplication by ensuring pci_alloc_irq_vectors_affinity calls
   pci_alloc_irq_vectors_affinity_dyn function
3. Add the pci_free_irq_vectors_grp API

Megha Dey (6):
  PCI/MSI: New structures/macros for dynamic MSI-X allocation
  PCI/MSI: Dynamic allocation of MSI-X vectors by group
  x86: Introduce the dynamic teardown function
  PCI/MSI: Introduce new structure to manage MSI-x entries
  PCI/MSI: Free MSI-X resources by group
  Documentation: PCI/MSI: Document dynamic MSI-X infrastructure

 Documentation/PCI/MSI-HOWTO.txt |  36 +++++
 arch/x86/include/asm/x86_init.h |   1 +
 arch/x86/kernel/x86_init.c      |   6 +
 drivers/pci/msi.c               | 350 +++++++++++++++++++++++++++++++++++++---
 drivers/pci/probe.c             |  20 +++
 include/linux/device.h          |  14 ++
 include/linux/msi.h             |  11 ++
 include/linux/pci.h             |  56 +++++++
 kernel/irq/msi.c                |  37 ++++-
 9 files changed, 503 insertions(+), 28 deletions(-)

-- 
2.7.4

