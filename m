From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 25 Sep 2019 19:28:18 -0700
Subject: [Intel-wired-lan] [net-next v2 0/2] new PTP ioctl fixes
Message-ID: <20190926022820.7900-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

I noticed recently that Filip added new versions of the PTP ioctls which
correctly honor the reserved fields (making it so that we can safely extend
them in the future).

Unfortunately, this breaks the old ioctls for a couple of reasons. First,
the flags for the old ioctls get cleared. This means that the external
timestamp request can never be enabled. Further, it means future new flags
will *not* be cleared, and thus old ioctl will potentially send non-zero
data and be mis-interpreted.

Additionally, new flags are not protected against in-driver, because no
current driver verifies that the flags are only one of the supported ones.
This means new flags will be mis-interpreted by the drivers.

This series provides patches to fix drivers to verify and reject unsupported
flags, as well as to fix the ioctls to clear flags on the old version of the
ioctl properly.

Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Christopher Hall <christopher.s.hall@intel.com>

Range-diff from v1:
1:  c317dc1cc7eb = 1:  c317dc1cc7eb ptp: correctly disable flags on old ioctls
2:  08ce725c7f2a ! 2:  5537762fb9cc net: reject ptp requests with unsupported flags
    @@ drivers/net/phy/dp83640.c: static int ptp_dp83640_enable(struct ptp_clock_info *
      	switch (rq->type) {
      	case PTP_CLK_REQ_EXTTS:
     +		/* Reject requests with unsupported flags */
    -+		if (rq->extts.flags & ~(PTP_FEATURE_ENABLE |
    ++		if (rq->extts.flags & ~(PTP_ENABLE_FEATURE |
     +					PTP_RISING_EDGE |
     +					PTP_FALLING_EDGE))
     +			return -EOPNOTSUPP;

Jacob Keller (2):
  ptp: correctly disable flags on old ioctls
  net: reject ptp requests with unsupported flags

 drivers/net/dsa/mv88e6xxx/ptp.c               |  5 +++++
 drivers/net/ethernet/broadcom/tg3.c           |  4 ++++
 drivers/net/ethernet/intel/igb/igb_ptp.c      |  8 +++++++
 .../ethernet/mellanox/mlx5/core/lib/clock.c   | 10 +++++++++
 drivers/net/ethernet/microchip/lan743x_ptp.c  |  4 ++++
 drivers/net/ethernet/renesas/ravb_ptp.c       |  9 ++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_ptp.c  |  4 ++++
 drivers/net/phy/dp83640.c                     |  8 +++++++
 drivers/ptp/ptp_chardev.c                     |  4 ++--
 include/uapi/linux/ptp_clock.h                | 22 +++++++++++++++++++
 10 files changed, 76 insertions(+), 2 deletions(-)

-- 
2.23.0.245.gf157bbb9169d

