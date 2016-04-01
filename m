From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri,  1 Apr 2016 16:17:30 -0700
Subject: [Intel-wired-lan] [PATCH v1 0/9] sync upstream fm10k driver
Message-ID: <1459552659-22959-1-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This series contains several fixes and nearly finishes the work of
syncing upstream and out-of-tree fm10k drivers.

Jacob Keller (7):
  fm10k: drop 1588 support
  fm10k: correctly handle LPORT_MAP error
  fm10k: do not disable PCI device in fm10k_io_error_detected
  fm10k: fix documentation of fm10k_tlv_parse_attr
  fm10k: use 8bit notation instead of 10bit notation for diagram
  fm10k: use different name than FM10K_VLAN_CLEAR for override bit
  fm10k: update comment regarding reserved bits check

Ngai-Mint Kwan (2):
  fm10k: Fix multicast mode sync issues
  fm10k: Reset multicast mode when deleting lport

 drivers/net/ethernet/intel/fm10k/Makefile        |   3 +-
 drivers/net/ethernet/intel/fm10k/fm10k.h         |  35 +-
 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c |  30 +-
 drivers/net/ethernet/intel/fm10k/fm10k_main.c    |  22 +-
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c  |  42 +--
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c     | 143 ++-----
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c      | 119 +-----
 drivers/net/ethernet/intel/fm10k/fm10k_pf.h      |  19 +-
 drivers/net/ethernet/intel/fm10k/fm10k_ptp.c     | 462 -----------------------
 drivers/net/ethernet/intel/fm10k/fm10k_tlv.c     |  18 +-
 drivers/net/ethernet/intel/fm10k/fm10k_type.h    |  18 +-
 drivers/net/ethernet/intel/fm10k/fm10k_vf.c      |  61 +--
 drivers/net/ethernet/intel/fm10k/fm10k_vf.h      |  12 +-
 13 files changed, 78 insertions(+), 906 deletions(-)
 delete mode 100644 drivers/net/ethernet/intel/fm10k/fm10k_ptp.c

-- 
2.8.0.rc1.177.g5628860

