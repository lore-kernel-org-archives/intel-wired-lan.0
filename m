From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed,  9 Jun 2021 09:39:45 -0700
Subject: [Intel-wired-lan] [PATCH v2 0/8] ice: implement PTP clock for E810
 devices
Message-ID: <20210609163953.52440-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Extend the ice driver to support basic PTP clock functionality for E810
devices.

This includes some tangential work required to setup the sideband queue and
driver shared parameters as well.

This series only supports E810-based devices. This is because other devices
based on the E822 MAC use a different and more complex PHY.

The low level device functionality is kept within ice_ptp_hw.c and is
designed to be extensible for supporting E822 devices in a future series.

This series also only supports very basic functionality including the
ptp_clock device and timestamping. Support for configuring periodic outputs
and external input timestamps will be implemented in a future series.

There are a couple of potential "what? why?" bits in this series I want to
point out:

1) the PTP hardware functionality is shared between multiple functions. This
means that the same clock registers are shared across multiple PFs. In order
to avoid contention or clashing between PFs, firmware assigns "ownership" to
one PF, while other PFs are merely "associated" with the timer. Because we
share the hardware resource, only the clock owner will allocate and register
a PTP clock device. Other PFs determine the appropriate PTP clock index to
report by using a firmware interface to read a shared parameter that is set
by the owning PF.

2) the ice driver uses its own kthread instead of using do_aux_work. This is
because the periodic and asynchronous tasks are necessary for all PFs, but
only one PF will allocate the clock.

The series is broken up into functional pieces to allow easy review.
---
v2:
- Reduce usage of ice_status
- Squash in fix up patches [1] [2]

[1]https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20210526202313.3354027-1-jacob.e.keller at intel.com/
[2]https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20210602173134.4167891-1-jacob.e.keller at intel.com/

Jacob Keller (8):
  ice: add support for sideband messages
  ice: process 1588 PTP capabilities during initialization
  ice: add support for set/get of driver-stored firmware parameters
  ice: add low level PTP clock access functions
  ice: register 1588 PTP clock device object for E810 devices
  ice: report the PTP clock index in ethtool .get_ts_info
  ice: enable receive hardware timestamping
  ice: enable transmit timestamps for E810 devices

 drivers/net/ethernet/intel/Kconfig            |    1 +
 drivers/net/ethernet/intel/ice/Makefile       |    1 +
 drivers/net/ethernet/intel/ice/ice.h          |    8 +-
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   41 +
 drivers/net/ethernet/intel/ice/ice_base.c     |   14 +-
 drivers/net/ethernet/intel/ice/ice_common.c   |  244 ++++
 drivers/net/ethernet/intel/ice/ice_common.h   |   10 +
 drivers/net/ethernet/intel/ice/ice_controlq.c |   62 +
 drivers/net/ethernet/intel/ice/ice_controlq.h |    2 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |   27 +-
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |   69 +
 drivers/net/ethernet/intel/ice/ice_lib.c      |   20 +-
 drivers/net/ethernet/intel/ice/ice_lib.h      |    3 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |   95 ++
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 1270 +++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ptp.h      |  160 +++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  655 +++++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |   79 +
 drivers/net/ethernet/intel/ice/ice_sbq_cmd.h  |   92 ++
 drivers/net/ethernet/intel/ice/ice_txrx.c     |   37 +
 drivers/net/ethernet/intel/ice/ice_txrx.h     |    5 +
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c |    3 +
 drivers/net/ethernet/intel/ice/ice_type.h     |   62 +
 include/linux/kernel.h                        |   12 +
 24 files changed, 2965 insertions(+), 7 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_ptp.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_ptp.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_ptp_hw.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_ptp_hw.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_sbq_cmd.h

-- 
2.20.1

