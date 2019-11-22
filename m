From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Thu, 21 Nov 2019 18:02:20 -0800
Subject: [Intel-wired-lan] [next-queue PATCH v1 0/4] igc: Add basic support
 for Timestamping/PTP
Message-ID: <20191122020224.1102649-1-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

This adds basic support for Timestamping and enables ptp4l/phc2sys to
work using i225.

To get ptp4l/phc2sys to work we need 2 basic feature sets:
 (1) reading/adjusting the PHC clock;
 (2) enabling/retrieving HW timestamps;

Patch 1/4 adds support for (1), patch 2/4 and 3/4 adds support for (2)
and patch 4/4 implements the ethtool ioctl that ptp4l uses to check
what timestamping methods are supported.

As most of the functionality is similar to i210, this code uses that
as a base. To keep this short, only the features necessary to make
time synchronization using linuxptp are added.

The most important differences from i210 is that there's now support
for multiple PTP domains, with multiple timestamping registers.

Still aiming to keep this series short, only support for one PTP
domain is added, and also only one of the timestamping registers is
used.

Missing from this series is also support configuring/using the
programmable pins.


Cheers,
--
Vinicius

Vinicius Costa Gomes (4):
  igc: Add basic skeleton for PTP
  igc: Add support for RX timestamping
  igc: Add support for TX timestamping
  igc: Add support for ethtool GET_TS_INFO command

 drivers/net/ethernet/intel/igc/Makefile      |   2 +-
 drivers/net/ethernet/intel/igc/igc.h         |  45 ++
 drivers/net/ethernet/intel/igc/igc_defines.h |  64 ++
 drivers/net/ethernet/intel/igc/igc_ethtool.c |  34 +
 drivers/net/ethernet/intel/igc/igc_main.c    |  86 +++
 drivers/net/ethernet/intel/igc/igc_ptp.c     | 713 +++++++++++++++++++
 drivers/net/ethernet/intel/igc/igc_regs.h    |  27 +
 7 files changed, 970 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/intel/igc/igc_ptp.c

-- 
2.24.0

