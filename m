From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Mon, 26 Jul 2021 20:36:53 -0700
Subject: [Intel-wired-lan] [PATCH next-queue v6 0/4] igc: Add support for
 PCIe PTM
Message-ID: <20210727033657.39885-1-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

Changes from v5:
  - Improved commit messages (Paul Menzel);
  - Clearer loop for PCIe PTM timestamps retrieval (Paul Menzel);

Changes from v4:
  - Improved commit messages (Bjorn Helgaas);

Changes from v3:
  - More descriptive commit messages and comments (Bjorn Helgaas);
  - Added a pcie_ptm_enabled() helper (Bjorn Helgaas);

Changes from v2:
  - Now the PTM timestamps are retrieved synchronously with the
    ioctl();
  - Fixed some typos in constants;
  - The IGC_PTM_STAT register is write-1-to-clear, document this more
    clearly;

Changes from v1:
  - This now should cross compile better, convert_art_ns_to_tsc() will
    only be used if CONFIG_X86_TSC is enabled;
  - PCIe PTM errors reported by the NIC are logged and PTM cycles are
    restarted in case an error is detected;

Original cover letter (lightly edited):

This adds support for PCIe PTM (Precision Time Measurement) to the igc
driver. PCIe PTM allows the NIC and Host clocks to be compared more
precisely, improving the clock synchronization accuracy.

Patch 1/4 reverts a commit that made pci_enable_ptm() private to the
PCI subsystem, reverting makes it possible for it to be called from
the drivers.

Patch 2/4 adds the pcie_ptm_enabled() helper.

Patch 3/4 calls pci_enable_ptm() from the igc driver.

Patch 4/4 implements the PCIe PTM support. Exposing it via the
.getcrosststamp() API implies that the time measurements are made
synchronously with the ioctl(). The hardware was implemented so the
most convenient way to retrieve that information would be
asynchronously. So, to follow the expectations of the ioctl() we have
to use less convenient ways, triggering an PCIe PTM dialog every time
a ioctl() is received.

Some questions are raised (also pointed out in the commit message):

1. Using convert_art_ns_to_tsc() is too x86 specific, there should be
   a common way to create a 'system_counterval_t' from a timestamp.

2. convert_art_ns_to_tsc() says that it should only be used when
   X86_FEATURE_TSC_KNOWN_FREQ is true, but during tests it works even
   when it returns false. Should that check be done?

Cheers,


Vinicius Costa Gomes (4):
  Revert "PCI: Make pci_enable_ptm() private"
  PCI: Add pcie_ptm_enabled()
  igc: Enable PCIe PTM
  igc: Add support for PTP getcrosststamp()

 drivers/net/ethernet/intel/igc/igc.h         |   1 +
 drivers/net/ethernet/intel/igc/igc_defines.h |  31 ++++
 drivers/net/ethernet/intel/igc/igc_main.c    |   6 +
 drivers/net/ethernet/intel/igc/igc_ptp.c     | 179 +++++++++++++++++++
 drivers/net/ethernet/intel/igc/igc_regs.h    |  23 +++
 drivers/pci/pci.h                            |   3 -
 drivers/pci/pcie/ptm.c                       |   9 +
 include/linux/pci.h                          |  10 ++
 8 files changed, 259 insertions(+), 3 deletions(-)

-- 
2.32.0

