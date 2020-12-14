From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Mon, 14 Dec 2020 16:13:00 +0100
Subject: [Intel-wired-lan] [PATCH v2 net-next 0/8] i40e/ice cleanups
Message-ID: <20201214151308.15275-1-maciej.fijalkowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

This series is mostly about the cleanups on Rx (ZC/normal) paths both in
ice and i40e drivers. Things that stand out are the simplifactions of
ice_change_mtu and i40e_xdp_setup.

Thanks!

v2: fix kdoc in patch 5 (Jakub)

Bj?rn T?pel (1):
  i40e, xsk: Simplify the do-while allocation loop

Maciej Fijalkowski (7):
  i40e: drop redundant check when setting xdp prog
  i40e: drop misleading function comments
  i40e: adjust i40e_is_non_eop
  ice: simplify ice_run_xdp
  ice: move skb pointer from rx_buf to rx_ring
  ice: remove redundant checks in ice_change_mtu
  ice: skip NULL check against XDP prog in ZC path

 drivers/net/ethernet/intel/i40e/i40e_main.c |  3 --
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 56 +++++----------------
 drivers/net/ethernet/intel/i40e/i40e_xsk.c  |  4 +-
 drivers/net/ethernet/intel/ice/ice_main.c   |  9 ----
 drivers/net/ethernet/intel/ice/ice_txrx.c   | 44 +++++++---------
 drivers/net/ethernet/intel/ice/ice_txrx.h   |  2 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c    |  7 ++-
 7 files changed, 34 insertions(+), 91 deletions(-)

-- 
2.20.1

