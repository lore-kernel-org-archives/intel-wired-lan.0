From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 24 Jun 2015 13:34:40 -0700
Subject: [Intel-wired-lan] [PATCH net-next rc1 00/10] fm10k: revised series
Message-ID: <1435178090-25422-1-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This series has been revised to include suggestions from Alexander
Duyck. Changed patches have -rc1 in their patch description.

Alexander Duyck (1):
  fm10k: Only trigger data path reset if fabric is up

Jacob Keller (9):
  fm10k: remove is_slot_appropriate
  fm10k: allow creation of vlan interfaces even while down
  fm10k: don't store sw_vid at reset
  fm10k: TRIVIAL fix up ordering of __always_unused and style
  fm10k: add support for extra debug statistics
  fm10k: send traffic on default vid to vlan device if we have one
  fm10k: TRIVIAL fix typo in fm10k_netdev.c
  fm10k: re-enable VF after a full reset on detection of a Malicious
    event
  fm10k: fix iov_msg_mac_vlan_pf VID checks

 drivers/net/ethernet/intel/fm10k/fm10k.h         |  19 ++
 drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c |   5 +-
 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 224 +++++++++++++++++++----
 drivers/net/ethernet/intel/fm10k/fm10k_iov.c     |   8 +-
 drivers/net/ethernet/intel/fm10k/fm10k_main.c    |  20 +-
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c  |  20 +-
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c     |  52 +++++-
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c      | 105 ++++++-----
 drivers/net/ethernet/intel/fm10k/fm10k_type.h    |   7 +-
 drivers/net/ethernet/intel/fm10k/fm10k_vf.c      |  14 --
 10 files changed, 362 insertions(+), 112 deletions(-)

-- 
2.4.3

