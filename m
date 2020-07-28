From: Andre Guedes <andre.guedes@intel.com>
Date: Tue, 28 Jul 2020 16:37:50 -0700
Subject: [Intel-wired-lan] [PATCH 0/4] igc: PTP tx fixes
Message-ID: <20200728233754.65747-1-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi all,

This patch series fixes some issues in the PTP tx code from the IGC driver.
The most relevant one is a race condition between igc_xmit_frame_ring() and
igc_ptp_tx_hang() which is fixed by the last patch.

- Andre

Andre Guedes (4):
  igc: Rename IGC_TSYNCTXCTL_VALID macro
  igc: Don't reschedule ptp_tx work
  igc: Remove timeout check from ptp_tx work
  igc: Fix race condition in PTP tx code

 drivers/net/ethernet/intel/igc/igc.h         |  5 +-
 drivers/net/ethernet/intel/igc/igc_defines.h |  2 +-
 drivers/net/ethernet/intel/igc/igc_main.c    |  7 ++-
 drivers/net/ethernet/intel/igc/igc_ptp.c     | 60 +++++++++++---------
 4 files changed, 43 insertions(+), 31 deletions(-)

-- 
2.26.2

