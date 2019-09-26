From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 26 Sep 2019 11:11:02 -0700
Subject: [Intel-wired-lan] [net-next v3 0/7] new PTP ioctl fixes
Message-ID: <20190926181109.4871-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This series contains patches to fix the various drivers which implemented
external pin input/output support. The drivers did not explicitly reject
unknown/unsupported flags.

Changes since v2:
* Split the external timestamp changes to separate patches per-driver
* Change the check for external timestamp flags to always accept all three
  current flags.
* Add cc for authors of the PTP support, hopefully receiving feedback

Jacob Keller (7):
  ptp: correctly disable flags on old ioctls
  net: reject PTP periodic output requests with unsupported flags
  mv88e6xxx: reject unsupported external timestamp flags
  dp83640: reject unsupported external timestamp flags
  igb: reject unsupported external timestamp flags
  mlx5: reject unsupported external timestamp flags
  renesas: reject unsupported external timestamp flags

 drivers/net/dsa/mv88e6xxx/ptp.c               |  6 +++++
 drivers/net/ethernet/broadcom/tg3.c           |  4 ++++
 drivers/net/ethernet/intel/igb/igb_ptp.c      | 10 +++++++++
 .../ethernet/mellanox/mlx5/core/lib/clock.c   | 10 +++++++++
 drivers/net/ethernet/microchip/lan743x_ptp.c  |  4 ++++
 drivers/net/ethernet/renesas/ravb_ptp.c       | 10 +++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_ptp.c  |  4 ++++
 drivers/net/phy/dp83640.c                     |  8 +++++++
 drivers/ptp/ptp_chardev.c                     |  4 ++--
 include/uapi/linux/ptp_clock.h                | 22 +++++++++++++++++++
 10 files changed, 80 insertions(+), 2 deletions(-)

-- 
2.23.0.245.gf157bbb9169d

