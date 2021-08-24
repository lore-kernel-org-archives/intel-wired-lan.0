From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon, 23 Aug 2021 17:01:45 -0700
Subject: [Intel-wired-lan] [next-queue v4 00/13] implement support for PTP
 on E822 hardware
Message-ID: <20210824000158.1928482-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Extend the ice driver implementation to support PTP for the E822 based
devices.

This includes a few cleanup patches, that fix some minor issues spotted
while preparing them. In addition, there are some slight refactors to ease
the addition of E822 support, followed by adding the new hardware
implementation ice_ptp_hw.c.

There are a few major differences with E822 support compared to E810
support:

*) The E822 device has a Clock Generation Unit which must be initialized in
order to generate proper clock frequencies on the output that drives the PTP
hardware clock registers

*) The E822 PHY is a bit different and requires a more complex
initialization procedure which must be rerun any time the link configuration
changes.

*) The E822 devices support enhanced timestamp calibration by making use of
a process called Vernier offset measurement. This allows the hardware to
measure phase offset related to the PHY clocks for Serdes and FEC, reducing
the inaccuracy of the timestamp relative to the actual packet transmission
and receipt. Making use of this requires data gathered from the first
transmitted and received packets, and waiting for the PHY to complete the
calibration measurements. This is done as part of a new kthread, ov_work.
Note that to avoid delay in enabling timestamps, we start the PHY in
'bypass' mode which allows timestamps to be captured without the Vernier
calibration measurement. Once the first packets have been sent and received,
we then complete the calibration setup and exit bypass mode and begin using
the more precise timestamps. According to the datasheet, timestamps without
calibration data can be incorrect relative to actual receipt or transmission
by up to 1 clock cycle (~1.25 nanoseconds), while calibrated timestamps
should be correct to within 1/8th of a clock cycle (~0.15 nanoseconds).

*) E822 devices support crosstimestamping via PCIe PTM, which we enable when
available on the platform.

There is a fair amount of logic required to perform PHY and CGU
initialization, which is the vast majority of the new code, but it is fairly
self contained within ice_ptp_hw.c, with the exception of monitoring for
offset validity being handled by a kthread.

Changes since v3:
* Fix quad calculation in ice_ptp_init_tx_e822. Change '%' to '/'

Changes since v2:
* introduced helper functions to enable and disable clock outputs

Changes since v1:
* Rebased on top of IWL to resolve conflict
* Fixed build against non-X86 arch for the PCIe PTM support

Jacob Keller (13):
  ice: fix Tx queue iteration for Tx timestamp enablement
  ice: remove dead code for allocating pin_config
  ice: add lock around Tx timestamp tracker flush
  ice: restart periodic outputs around time changes
  ice: introduce ice_base_incval function
  ice: PTP: move setting of tstamp_config
  ice: use 'int err' instead of 'int status'
  ice: introduce ice_ptp_init_phc function
  ice: convert clk_freq capability into time_ref
  ice: implement basic E822 PTP support
  ice: ensure the hardware Clock Generation Unit is configured
  ice: exit bypass mode once hardware finishes timestamp calibration
  ice: support crosstimestamping on E822 devices if supported

 drivers/net/ethernet/intel/Kconfig            |   10 +
 drivers/net/ethernet/intel/ice/ice_cgu_regs.h |  116 +
 drivers/net/ethernet/intel/ice/ice_common.c   |   12 +
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |    9 +
 drivers/net/ethernet/intel/ice/ice_main.c     |    7 +
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  717 ++++-
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   30 +-
 .../net/ethernet/intel/ice/ice_ptp_consts.h   |  374 +++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 2812 ++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  345 ++
 drivers/net/ethernet/intel/ice/ice_type.h     |   23 +-
 11 files changed, 4235 insertions(+), 220 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_cgu_regs.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_ptp_consts.h

-- 
2.26.2

