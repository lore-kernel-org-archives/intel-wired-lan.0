From: Christopher S. Hall <christopher.s.hall@intel.com>
Date: Fri, 21 Aug 2015 11:52:04 -0700
Subject: [Intel-wired-lan] [PATCH v3 0/4] Patchset enabling hardware based
	cross-timestamps for next gen Intel platforms
Message-ID: <1440183128-1384-1-git-send-email-christopher.s.hall@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

6th generation Intel platforms will have an Always Running
Timer (ART) that always runs when the system is powered and
is available to both the CPU and various on-board devices.
Initially, those devices include audio and network.  The
ART will give these devices the capability of precisely
cross timestamping their local device clock with the system
clock.  The ART is precisely related to the TSC by a ratio
read from CPUID leaf 0x15.

A device (such as the network controller) produces cross timestamps in 
terms of the ART and the local device clock.  The ART value on its
own isn't useful.

The first two patches enable translation of ART to system time.
The first patch adds the correlated clocksource concept which is
an auxiliary clock directly relate-able to a clock registered as
a clocksource. The second patch adds the Intel specific ART 
correlated clocksource.

The last two patches modify the PTP character driver to call a
cross timestamp function (getsynctime()) in the driver when
available and perform the cross timestamp in the e1000e driver.

The patches taken together enable sub-microsecond cross timestamps
between the system clock and network device clock

Changelog since v2:

Split out x86 architecture specific code from common timekeeping code
	additions

Split ART initialization between early TSC initialization and TSC
	frequency refinement.  Now, cpu_has_art can be used in
	driver initialization code

Added e1000e PTP init code that detects presence of ART/spt disabling
	cross timestamp if they're not available

Added additional commenting in TSC/ART init code, minor renaming of
	functions and variables for greater clarity

Fixed a few formatting problems in e1000e driver patch


Christopher Hall (2):
  Add support for driver cross-timestamp to PTP_SYS_OFFSET ioctl
  Enabling hardware supported PTP system/device crosstimestamping

Christopher S. Hall (2):
  Add correlated clocksource deriving system time from an auxiliary
    clocksource
  Added ART correlated clocksource and ART CPU feature

 Documentation/ptp/testptp.c                 |  6 +-
 arch/x86/include/asm/cpufeature.h           |  3 +-
 arch/x86/include/asm/tsc.h                  |  2 +
 arch/x86/kernel/tsc.c                       | 54 ++++++++++++++++++
 drivers/net/ethernet/intel/e1000e/defines.h |  5 ++
 drivers/net/ethernet/intel/e1000e/ptp.c     | 88 +++++++++++++++++++++++++++++
 drivers/net/ethernet/intel/e1000e/regs.h    |  4 ++
 drivers/ptp/ptp_chardev.c                   | 29 +++++++---
 include/linux/clocksource.h                 | 33 +++++++++++
 include/linux/ptp_clock_kernel.h            |  7 +++
 include/linux/timekeeping.h                 |  4 ++
 include/uapi/linux/ptp_clock.h              |  4 +-
 kernel/time/timekeeping.c                   | 65 +++++++++++++++++++++
 13 files changed, 292 insertions(+), 12 deletions(-)

-- 
2.1.4

