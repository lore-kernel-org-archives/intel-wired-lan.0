From: Christopher S. Hall <christopher.s.hall@intel.com>
Date: Mon,  4 Jan 2016 04:45:17 -0800
Subject: [Intel-wired-lan] [RFC v5 0/6] Patchset enabling hardware based
	cross-timestamps for next gen Intel platforms
Message-ID: <1451911523-8534-1-git-send-email-christopher.s.hall@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Modern Intel hardware adds an Always Running Timer (ART) that allows the
network and audio device clocks to precisely cross timestamp the device
clock with the system clock. This allows a precise correlation of the
device time and system time.

This patchset adds interfaces to the timekeeping code allowing drivers
to translate ART time to system time.

Changelog:

Changes from v4 to v5:

*	Changes the history mechanism to interpolate system time using
	a single historic system time pair (monotonic raw, realtime)
	rather than implementing a precise history using shadow
	timekeeper (see v4 changes). The advantage of this approach is
	that the history can be arbitrarily long. This approach may
	also be simpler in terms of coding. The major disadvantage is
	that the realtime clock can be adjusted.  When adjusted, the
	realtime clock time (when interpolating from history) is
	always approximate. In general, the longer the interpolation
	period the larger the potential error. There isn't any error
	interpolating the monotonic raw clock time.
*	This patchset also addresses objections to the previous
	patchsets overly complex correlated timestamp structure. This
	patchset splits that structure into several smaller
	structures.  The correlated timestamp interface is renamed
	cross timestamp to avoid any confusion with the correlated
	clocksource.
*	The correlated clocksource is separated from the cross
	timestamp mechanism.
*	Add monotonic raw to the PTP user interface
*	Add e1000e driver configuration option that wraps Intel PCH
	specific code

Changes v3 to v4: 

*	Adds a history mechanism to accomodate slower devices. In this
	case the response time for timestamp reads to the Intel DSP
	are too slow to be accomodated by the original correlated time
	mechanism. The history mechanism turns shadow timekeeper into
	an array where the history is stored.

Christopher S. Hall (6):
  Timekeeping cross timestamp interface for device drivers
  Always Running Timer (ART) correlated clocksource
  Add history to cross timestamp interface supporting slower devices
  Remove duplicate code from ktime_get_raw_and_real code
  Add PTP_SYS_OFFSET_PRECISE for driver crosstimestamping
  Adds hardware supported cross timestamp

 Documentation/ptp/testptp.c                 |   6 +-
 arch/x86/include/asm/cpufeature.h           |   2 +-
 arch/x86/include/asm/tsc.h                  |   2 +
 arch/x86/kernel/tsc.c                       |  46 ++++++
 drivers/net/ethernet/intel/Kconfig          |   9 ++
 drivers/net/ethernet/intel/e1000e/defines.h |   5 +
 drivers/net/ethernet/intel/e1000e/ptp.c     | 92 +++++++++++++++++++++++++++++
 drivers/net/ethernet/intel/e1000e/regs.h    |   4 +
 drivers/ptp/ptp_chardev.c                   |  31 ++++
 include/linux/clocksource.h                 |  43 +++++
 include/linux/ptp_clock_kernel.h            |   8 +
 include/linux/timekeeper_internal.h         |   4 +
 include/linux/timekeeping.h                 |  42 +++++
 include/uapi/linux/ptp_clock.h              |  13 +-
 kernel/time/timekeeping.c                   | 243 ++++++++++++++++++++++++++--
 15 files changed, 521 insertions(+), 21 deletions(-)

-- 
2.1.4

