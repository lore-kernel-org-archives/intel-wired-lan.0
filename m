From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 10 Mar 2021 17:35:08 -0800
Subject: [Intel-wired-lan] [RFC PATCH 00/10] ethtool: Factor out common code
 related to writing ethtool strings
Message-ID: <161542634192.13546.4185974647834631704.stgit@localhost.localdomain>
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
the code so that we have one central function, ethtool_gsprintf that does
all this whch takes a double pointer to access the data, a formatted string
to print, and the variable arguments that are associated with the string.


---

Alexander Duyck (10):
      ethtool: Add common function for filling out strings
      intel: Update drivers to use ethtool_gsprintf
      nfp: Replace nfp_pr_et with ethtool_gsprintf
      hisilicon: Update drivers to use ethtool_gsprintf
      ena: Update driver to use ethtool_gsprintf
      netvsc: Update driver to use ethtool_gsprintf
      virtio_net: Update driver to use ethtool_gsprintf
      vmxnet3: Update driver to use ethtool_gsprintf
      bna: Update driver to use ethtool_gsprintf
      ionic: Update driver to use ethtool_gsprintf


 drivers/net/ethernet/amazon/ena/ena_ethtool.c |  25 +-
 .../net/ethernet/brocade/bna/bnad_ethtool.c   | 266 +++++++-----------
 .../ethernet/hisilicon/hns/hns_dsaf_gmac.c    |   7 +-
 .../net/ethernet/hisilicon/hns/hns_dsaf_ppe.c |  37 +--
 .../net/ethernet/hisilicon/hns/hns_dsaf_rcb.c |  89 ++----
 .../ethernet/hisilicon/hns/hns_dsaf_xgmac.c   |   6 +-
 .../net/ethernet/hisilicon/hns/hns_ethtool.c  |  97 +++----
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
 18 files changed, 381 insertions(+), 631 deletions(-)

--

