From: Miroslav Lichvar <mlichvar@redhat.com>
Date: Fri, 26 Oct 2018 18:27:38 +0200
Subject: [Intel-wired-lan] [RFC PATCH 0/4] More accurate PHC<->system clock
 synchronization
Message-ID: <20181026162742.631-1-mlichvar@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This series adds support for a more accurate synchronization between a
PTP hardware clock and the system clock.

The first patch adds an extended version of the PTP_SYS_OFFSET ioctl,
which returns three timestamps for each measurement. The idea is to
shorten the interval between the system timestamps to contain just the
reading of the lowest register of the PHC in order to reduce the error
in the measured offset and give a better bound on the maximum error.

The other patches add support for the new ioctl to the e1000e, igb,
and ixgbe driver. Tests with few different NICs in different machines
(and PCIe slots) show that:
- with an I219 (e1000e) the measured delay improved from 2500 to 1300 ns
  and the error in the measured offset, when compared to cross
  timestamping, was reduced by a factor of 5
- with an I210 (igb) the delay improved from 5100 to 1700 ns
- with an I350 (igb) the delay improved from 2300 to 750 ns
- with an X550 (ixgbe) the delay improved from 1950 to 650 ns

There is some duplication of code in the igb and ixgbe drivers, which I
don't like very much, but I thought it's better than extending and
wrapping the existing functions like in the e1000e driver. Also, mixing
SYSTIM and "system time" in the code will probably be confusing.

I wasn't able to find a better name for the ioctl, the structures, and
the driver function. If anyone has suggestions, please let me know.

Miroslav Lichvar (4):
  ptp: add PTP_SYS_OFFSET_EXTENDED ioctl
  e1000e: add support for extended PHC gettime
  igb: add support for extended PHC gettime
  ixgbe: add support for extended PHC gettime

 drivers/net/ethernet/intel/e1000e/e1000.h    |  3 ++
 drivers/net/ethernet/intel/e1000e/netdev.c   | 48 +++++++++++++----
 drivers/net/ethernet/intel/e1000e/ptp.c      | 21 ++++++++
 drivers/net/ethernet/intel/igb/igb_ptp.c     | 43 +++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c | 57 ++++++++++++++++++++
 drivers/ptp/ptp_chardev.c                    | 39 ++++++++++++++
 include/linux/ptp_clock_kernel.h             | 26 +++++++++
 include/uapi/linux/ptp_clock.h               | 12 +++++
 8 files changed, 239 insertions(+), 10 deletions(-)

-- 
2.17.2

