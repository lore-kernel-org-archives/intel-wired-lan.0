From: Andre Guedes <andre.guedes@intel.com>
Date: Tue, 24 Mar 2020 17:38:14 -0700
Subject: [Intel-wired-lan] [PATCH 00/10] igc: Align log messages
Message-ID: <20200325003824.5487-1-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Throughout IGC code we print log messages using different log helpers such as
dev_*, pr_*, and netdev_*, generating inconsistent output.

Since this is a network device driver, we should preferably use netdev_*
helpers because they append the interface name to the message, helping making
sense out of the logs especially when we have more than one adapter in the
system.

This patchset converts all dev_* and pr_* calls to netdev_*. There are just a
few exceptions that cannot be converted because we don't have the netdev
allocated yet (e.g. when the module is loaded and on PCI probe). It also takes
the opportunity to improve some messages and remove the '\n' character at the
end of them since is it automatically added to by netdev_* log helpers.

Regards,

Andre

Andre Guedes (10):
  igc: Use netdev log helpers in igc_main.c
  igc: Use netdev log helpers in igc_ethtool.c
  igc: Use netdev log helpers in igc_ptp.c
  igc: Use netdev log helpers in igc_dump.c
  igc: Use netdev log helpers in igc_base.c
  igc: Use netdev log helpers in igc_diag.c
  igc: Remove '\n' from log strings in igc_i225.c
  igc: Remove '\n' from log strings in igc_mac.c
  igc: Remove '\n' from log messages in igc_nvm.c
  igc: Remove '\n' from log strings in igc_phy.c

 drivers/net/ethernet/intel/igc/igc_base.c    |  16 +--
 drivers/net/ethernet/intel/igc/igc_diag.c    |  22 ++--
 drivers/net/ethernet/intel/igc/igc_dump.c    | 109 ++++++++--------
 drivers/net/ethernet/intel/igc/igc_ethtool.c |  48 ++++---
 drivers/net/ethernet/intel/igc/igc_i225.c    |  22 ++--
 drivers/net/ethernet/intel/igc/igc_mac.c     |  42 +++---
 drivers/net/ethernet/intel/igc/igc_main.c    | 129 +++++++++----------
 drivers/net/ethernet/intel/igc/igc_nvm.c     |  12 +-
 drivers/net/ethernet/intel/igc/igc_phy.c     |  52 ++++----
 drivers/net/ethernet/intel/igc/igc_ptp.c     |  12 +-
 10 files changed, 223 insertions(+), 241 deletions(-)

-- 
2.25.0

