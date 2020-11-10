From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Mon,  9 Nov 2020 22:10:16 -0800
Subject: [Intel-wired-lan] [PATCH next-queue v2 0/3] igc: Add support for
 PCIe PTM
Message-ID: <20201110061019.519589-1-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

Changes from v1:
  - This now should cross compile better, convert_art_ns_to_tsc() will
    only be used if CONFIG_X86_TSC is enabled;
  - PCIe PTM errors reported by the NIC are logged and PTM cycles are
    restarted in case an error is detected;

Original cover letter:

This adds support for PCIe PTM (Precision Time Measurement) to the igc
driver. PCIe PTM allows the NIC and Host clocks to be compared more
precisely, improving the clock synchronization accuracy.

Patch 1/3 reverts a commit that made pci_enable_ptm() private to the
PCI subsystem, reverting makes it possible for it to be called from
the drivers.

Patch 2/3 calls pci_enable_ptm() from the igc driver.

Patch 3/3 implements the PCIe PTM support. It adds a workqueue that
reads the PTM registers periodically and collects the information so a
subsequent call to getcrosststamp() has all the timestamps needed.

Some questions are raised (also pointed out in the commit message):

1. Using convert_art_ns_to_tsc() is too x86 specific, there should be
   a common way to create a 'system_counterval_t' from a timestamp.

2. convert_art_ns_to_tsc() says that it should only be used when
   X86_FEATURE_TSC_KNOWN_FREQ is true, but during tests it works even
   when it returns false. Should that check be done?

Cheers,


Vinicius Costa Gomes (3):
  Revert "PCI: Make pci_enable_ptm() private"
  igc: Enable PCIe PTM
  igc: Add support for PTP getcrosststamp()

 drivers/net/ethernet/intel/igc/igc.h         |   7 +
 drivers/net/ethernet/intel/igc/igc_defines.h |  27 +++
 drivers/net/ethernet/intel/igc/igc_main.c    |   7 +
 drivers/net/ethernet/intel/igc/igc_ptp.c     | 209 +++++++++++++++++++
 drivers/net/ethernet/intel/igc/igc_regs.h    |  23 ++
 drivers/pci/pci.h                            |   3 -
 include/linux/pci.h                          |   7 +
 7 files changed, 280 insertions(+), 3 deletions(-)

-- 
2.29.0

