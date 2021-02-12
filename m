From: Ederson de Souza <ederson.desouza@intel.com>
Date: Thu, 11 Feb 2021 17:42:10 -0800
Subject: [Intel-wired-lan] [PATCH next-queue v1 0/2] PPS and SDP support for
 i225
Message-ID: <20210212014212.41570-1-ederson.desouza@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The i225 device has some PHC Hardware Clock features such as Pulse Per
Seconds interrupts or Software Defined Pins signals. This series add
support to some of them.

Ederson de Souza (2):
  igc: Enable internal i225 PPS
  igc: enable auxiliary PHC functions for the i225

 drivers/net/ethernet/intel/igc/igc.h         |  13 +
 drivers/net/ethernet/intel/igc/igc_defines.h |  63 ++++
 drivers/net/ethernet/intel/igc/igc_main.c    |  63 +++-
 drivers/net/ethernet/intel/igc/igc_ptp.c     | 294 ++++++++++++++++++-
 drivers/net/ethernet/intel/igc/igc_regs.h    |  10 +
 5 files changed, 440 insertions(+), 3 deletions(-)

-- 
2.30.0

