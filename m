From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Mon, 18 Jan 2021 16:13:07 +0100
Subject: [Intel-wired-lan] [PATCH v3 net-next 00/11] intel driver cleanups
Message-ID: <20210118151318.12324-1-maciej.fijalkowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

This series is mostly about the cleanups on Rx (ZC/normal) paths both in
ice and i40e drivers. Things that stand out are the simplifactions of
ice_change_mtu and i40e_xdp_setup.

Third iteration of this includes patches that optimize the handling of
*_rx_offset() calls per each processed frame. Some cycles can be saved
by storing the result of that function onto rx ring. For that, I am
using existing holes within ring structs (checked with pahole).

Thanks!

v3: rebase, fix handling rx offset
v2: fix kdoc in patch 5 (Jakub)


Bj?rn T?pel (1):
  i40e, xsk: Simplify the do-while allocation loop

Maciej Fijalkowski (10):
  i40e: drop redundant check when setting xdp prog
  i40e: drop misleading function comments
  i40e: adjust i40e_is_non_eop
  ice: simplify ice_run_xdp
  ice: move skb pointer from rx_buf to rx_ring
  ice: remove redundant checks in ice_change_mtu
  ice: skip NULL check against XDP prog in ZC path
  i40e: store the result of i40e_rx_offset() onto i40e_ring
  ice: store the result of ice_rx_offset() onto ice_ring
  ixgbe: store the result of ixgbe_rx_offset() onto ixgbe_ring

 drivers/net/ethernet/intel/i40e/i40e_main.c   |  3 -
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 91 ++++++-------------
 drivers/net/ethernet/intel/i40e/i40e_txrx.h   |  1 +
 drivers/net/ethernet/intel/i40e/i40e_xsk.c    |  4 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |  9 --
 drivers/net/ethernet/intel/ice/ice_txrx.c     | 88 ++++++++----------
 drivers/net/ethernet/intel/ice/ice_txrx.h     |  3 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c      |  7 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 15 +--
 10 files changed, 86 insertions(+), 136 deletions(-)

-- 
2.20.1

