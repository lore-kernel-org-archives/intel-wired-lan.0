From: Christopher S. Hall <christopher.s.hall@intel.com>
Date: Mon, 12 Oct 2015 11:45:18 -0700
Subject: [Intel-wired-lan] [PATCH v4 0/4] Patchset enabling hardware based
	cross-timestamps for next gen Intel platforms
Message-ID: <1444675522-4198-1-git-send-email-christopher.s.hall@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Modern Intel hardware adds an Always Running Timer (ART) that allows the
network and audio device clocks to precisely cross timestamp the device
clock with the system clock. This allows a precise correlation of the
device time and system time.

v4 adds a history which enables the audio DSP (a "slow" device) to perform
cross-timestamping.

Christopher S. Hall (4):
  Produce system time from correlated clocksource
  Always running timer correlated clocksource
  Add PTP_SYS_OFFSET_PRECISE for driver crosstimestamping
  Adds hardware supported cross timestamp

 Documentation/ptp/testptp.c                 |   6 +-
 arch/x86/include/asm/cpufeature.h           |   2 +-
 arch/x86/include/asm/tsc.h                  |   2 +
 arch/x86/kernel/tsc.c                       |  48 ++++++-
 drivers/net/ethernet/intel/e1000e/defines.h |   5 +
 drivers/net/ethernet/intel/e1000e/ptp.c     |  77 +++++++++++
 drivers/net/ethernet/intel/e1000e/regs.h    |   4 +
 drivers/ptp/ptp_chardev.c                   |  26 ++++
 include/linux/clocksource.h                 |  33 +++++
 include/linux/ptp_clock_kernel.h            |   6 +
 include/linux/timekeeping.h                 |   4 +
 include/uapi/linux/ptp_clock.h              |  12 +-
 kernel/time/timekeeping.c                   | 203 +++++++++++++++++++++++++++-
 13 files changed, 418 insertions(+), 10 deletions(-)

-- 
2.1.4

