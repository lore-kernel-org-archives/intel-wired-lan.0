From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 11 May 2016 16:18:19 -0700
Subject: [Intel-wired-lan] [net v2 0/5] igb: fix ptp suspend/resume issue
Message-ID: <20160511231824.22542-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch series (properly) fixes the issue with igb's workqueue item
for overflow check from causing a surprise remove event. To do this,
properly suspend the workqueue items in suspend and then resume them
again during the resume flow.

The patch series has a few extra steps to reduce code duplication and
implement suspend and resume properly, which makes the overall fix a bit
more complicated, and thus review is welcome.

A smaller fix would be to implement suspend and resume irrespective of
the current igb_ptp_stop and igb_ptp_init but this seems more likely to
introduce bugs especially if either function ever changes in the future.

In addition, the ptp_flags variable is added mostly to simplify the work
of writing several complex MAC type checks in the ptp code while doing
this.

Jacob Keller (5):
  igb: introduce ptp_flags variable and use it to replace IGB_FLAG_PTP
  igb: introduce IGB_PTP_OVERFLOW_CHECK flag
  igb: introduce igb_ptp_resume function
  igb: implement igb_ptp_suspend
  igb: call igb_ptp_suspend/igb_ptp_resume during suspend/resume cycle

 drivers/net/ethernet/intel/igb/igb.h      |   8 ++-
 drivers/net/ethernet/intel/igb/igb_main.c |   4 +-
 drivers/net/ethernet/intel/igb/igb_ptp.c  | 110 ++++++++++++++++--------------
 3 files changed, 68 insertions(+), 54 deletions(-)

-- 
2.8.1.493.g7b22612

