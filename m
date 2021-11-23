From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Tue, 23 Nov 2021 18:18:31 +0100
Subject: [Intel-wired-lan] [PATCH net-next 0/9] intel: switch to
 napi_build_skb()
Message-ID: <20211123171840.157471-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

napi_build_skb() I introduced earlier this year ([0]) aims
to decrease MM pressure and the overhead from in-place
kmem_cache_alloc() on each Rx entry processing by decaching
skbuff_heads from NAPI per-cpu cache filled prior to that by
napi_consume_skb() (so it is sort of a direct shortcut for
free -> mm -> alloc cycle).
Currently, no in-tree drivers use it. Switch all Intel Ethernet
drivers to it to get slight-to-medium perf boosts depending on
the frame size.

ice driver, 50 Gbps link, pktgen + XDP_PASS (local in) sample:

frame_size/nthreads  64/42  128/20  256/8  512/4  1024/2  1532/1

net-next (Kpps)      46062  34654   18248  9830   5343    2714
series               47438  34708   18330  9875   5435    2777
increase             2.9%   0.15%   0.45%  0.46%  1.72%   2.32%

Additionally, e1000's been switched to napi_consume_skb() as it's
safe and works fine there, and there's no point in napi_build_skb()
without paired NAPI cache feeding point.

[0] https://lore.kernel.org/all/20210213141021.87840-1-alobakin at pm.me

Alexander Lobakin (9):
  e1000: switch to napi_consume_skb()
  e1000: switch to napi_build_skb()
  i40e: switch to napi_build_skb()
  iavf: switch to napi_build_skb()
  ice: switch to napi_build_skb()
  igb: switch to napi_build_skb()
  igc: switch to napi_build_skb()
  ixgbe: switch to napi_build_skb()
  ixgbevf: switch to napi_build_skb()

 drivers/net/ethernet/intel/e1000/e1000_main.c     | 14 ++++++++------
 drivers/net/ethernet/intel/i40e/i40e_txrx.c       |  2 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.c       |  2 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c         |  2 +-
 drivers/net/ethernet/intel/igb/igb_main.c         |  2 +-
 drivers/net/ethernet/intel/igc/igc_main.c         |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     |  2 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |  2 +-
 8 files changed, 15 insertions(+), 13 deletions(-)

--
2.33.1

