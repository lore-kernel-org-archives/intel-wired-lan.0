From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Fri,  7 Feb 2020 10:24:41 -0800
Subject: [Intel-wired-lan] [next-queue PATCH v2 0/2] igc: Add initial TSN
 qdiscs offloading
Message-ID: <20200207182443.1501016-1-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


Hi,

Changes from v1:
  - Fixed review comments (Andre Guedes);

Original cover letter:

This adds support for offloading taprio (which handles what was
formerly known as Qbv) and ETF (using the LaunchTime feature) to i225.

To try and keep things organized, a new file is added: igc_tsn.c. The
idea is that the more TSN specific code will live here, in the future
this will include frame-preemption support, and CBS (formerly Qav)
support.

The current support has a few limitations:
  - because the BASET registers can only be written once per reset,
    when removing taprio or ETF, we force the NIC to reset;
  - In part because of the above limitation, we don't support changing
    schedules;
  - The way the registers for the schedule are organized, each queue
    can only be opened and closed once per cycle, so some schedules
    provided by the user are going to be rejected by the driver;

Future improvements:
  - When configuring a Qbv cycle, when we detect that a queue would
    stay open for two intervals, we could want to merge them;
  - More testing with taprio and ETF together, when ETF is installed
    under taprio (when using them separately, it works fine);

--
Cheers,

Vinicius Costa Gomes (2):
  igc: Add support for taprio offloading
  igc: Add support for ETF offloading

 drivers/net/ethernet/intel/igc/Makefile      |   2 +-
 drivers/net/ethernet/intel/igc/igc.h         |   7 +
 drivers/net/ethernet/intel/igc/igc_defines.h |  14 ++
 drivers/net/ethernet/intel/igc/igc_main.c    | 184 ++++++++++++++++++-
 drivers/net/ethernet/intel/igc/igc_regs.h    |  12 ++
 drivers/net/ethernet/intel/igc/igc_tsn.c     | 156 ++++++++++++++++
 drivers/net/ethernet/intel/igc/igc_tsn.h     |   9 +
 7 files changed, 380 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/igc/igc_tsn.c
 create mode 100644 drivers/net/ethernet/intel/igc/igc_tsn.h

-- 
2.25.0

