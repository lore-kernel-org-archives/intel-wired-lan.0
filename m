From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 16 Mar 2021 17:30:26 -0700
Subject: [Intel-wired-lan] [net-next PATCH v2 00/10] ethtool: Factor out
 common code related to writing ethtool strings
Message-ID: <161594093708.5644.11391417312031401152.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch set is meant to be a cleanup and refactoring of common code bits
from several drivers. Specificlly a number of drivers engage in a pattern
where they will use some variant on an sprintf or memcpy to write a string
into the ethtool string array and then they will increment their pointer by
ETH_GSTRING_LEN.

Instead of having each driver implement this independently I am refactoring
the code so that we have one central function, ethtool_sprintf that does
all this and takes a double pointer to access the data, a formatted string
to print, and the variable arguments that are associated with the string.

Changes from v1:
Fixed usage of char ** vs  unsigned char ** in hisilicon drivers

Changes from RFC:
Renamed ethtool_gsprintf to ethtool_sprintf
Fixed reverse xmas tree issue in patch 2

---

Alexander Duyck (10):
      ethtool: Add common function for filling out strings
      intel: Update drivers to use ethtool_sprintf
      nfp: Replace nfp_pr_et with ethtool_sprintf
      hisilicon: Update drivers to use ethtool_sprintf
      ena: Update driver to use ethtool_sprintf
      netvsc: Update driver to use ethtool_sprintf
      virtio_net: Update driver to use ethtool_sprintf
      vmxnet3: Update driver to use ethtool_sprintf
      bna: Update driver to use ethtool_sprintf
      ionic: Update driver to use ethtool_sprintf


 drivers/net/ethernet/amazon/ena/ena_ethtool.c |  25 +-
 .../net/ethernet/brocade/bna/bnad_ethtool.c   | 266 +++++++-----------
 .../ethernet/hisilicon/hns/hns_dsaf_gmac.c    |   9 +-
 .../net/ethernet/hisilicon/hns/hns_dsaf_ppe.c |  41 +--
 .../net/ethernet/hisilicon/hns/hns_dsaf_rcb.c |  91 +++---
 .../ethernet/hisilicon/hns/hns_dsaf_xgmac.c   |   8 +-
 .../net/ethernet/hisilicon/hns/hns_ethtool.c  | 103 +++----
 .../net/ethernet/intel/i40e/i40e_ethtool.c    |  16 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  55 ++--
 drivers/net/ethernet/intel/igb/igb_ethtool.c  |  40 +--
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |  40 +--
 drivers/net/ethernet/netronome/nfp/abm/main.c |   4 +-
 .../ethernet/netronome/nfp/nfp_net_ethtool.c  |  79 +++---
 drivers/net/ethernet/netronome/nfp/nfp_port.h |   2 -
 .../net/ethernet/pensando/ionic/ionic_stats.c | 145 ++++------
 drivers/net/hyperv/netvsc_drv.c               |  33 +--
 drivers/net/virtio_net.c                      |  18 +-
 drivers/net/vmxnet3/vmxnet3_ethtool.c         |  53 ++--
 18 files changed, 389 insertions(+), 639 deletions(-)

--

