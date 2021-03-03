From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Wed,  3 Mar 2021 16:39:25 +0100
Subject: [Intel-wired-lan] [PATCH intel-net 0/3] intel: Rx headroom fixes
Message-ID: <20210303153928.11764-1-maciej.fijalkowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fix Rx headroom by calling *_rx_offset() after the build_skb Rx ring
flag is set.

It was reported by Jesper in [0] that XDP_REDIRECT stopped working after
[1] patch in i40e.

Thanks and sorry!
Maciej

[0]: https://lore.kernel.org/netdev/20210301131832.0d765179 at carbon/
[1]: https://lore.kernel.org/bpf/20210118151318.12324-10-maciej.fijalkowski at intel.com/

Maciej Fijalkowski (3):
  i40e: move headroom initialization to i40e_configure_rx_ring
  ice: move headroom initialization to ice_setup_rx_ctx
  ixgbe: move headroom initialization to ixgbe_configure_rx_ring

 drivers/net/ethernet/intel/i40e/i40e_main.c   | 13 +++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 12 ------------
 drivers/net/ethernet/intel/ice/ice_base.c     | 18 ++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_txrx.c     | 17 -----------------
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  3 ++-
 5 files changed, 33 insertions(+), 30 deletions(-)

-- 
2.20.1

