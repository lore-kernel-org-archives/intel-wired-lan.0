From: Brian King <brking@linux.vnet.ibm.com>
Date: Fri, 17 Nov 2017 11:05:42 -0600
Subject: [Intel-wired-lan] [PATCH v2 0/7] [net] intel: Use smp_rmb rather
 than read_barrier_depends
Message-ID: <1510938349-17608-1-git-send-email-brking@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch converts several network drivers to use smp_rmb
rather than read_barrier_depends. The initial issue was
discovered with ixgbe on a Power machine which resulted
in skb list corruption due to fetching a stale skb pointer.
More details can be found in the ixgbe patch description.

Changes since v1:
- Remove NULLing of tx_buffer->skb in the ixgbe patch

Brian King (7):
  ixgbe: Fix skb list corruption on Power systems
  i40e: Use smp_rmb rather than read_barrier_depends
  ixgbevf: Use smp_rmb rather than read_barrier_depends
  igbvf: Use smp_rmb rather than read_barrier_depends
  igb: Use smp_rmb rather than read_barrier_depends
  fm10k: Use smp_rmb rather than read_barrier_depends
  i40evf: Use smp_rmb rather than read_barrier_depends

 drivers/net/ethernet/intel/fm10k/fm10k_main.c     | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c       | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c       | 2 +-
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c     | 2 +-
 drivers/net/ethernet/intel/igb/igb_main.c         | 2 +-
 drivers/net/ethernet/intel/igbvf/netdev.c         | 2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     | 2 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

-- 
1.8.3.1

