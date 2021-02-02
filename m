From: Alexander Lobakin <alobakin@pm.me>
Date: Tue, 02 Feb 2021 13:30:43 +0000
Subject: [Intel-wired-lan] [PATCH RESEND v3 net-next 0/5] net: consolidate
 page_is_pfmemalloc() usage
Message-ID: <20210202133030.5760-1-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

page_is_pfmemalloc() is used mostly by networking drivers to test
if a page can be considered for reusing/recycling.
It doesn't write anything to the struct page itself, so its sole
argument can be constified, as well as the first argument of
skb_propagate_pfmemalloc().
In Page Pool core code, it can be simply inlined instead.
Most of the callers from NIC drivers were just doppelgangers of
the same condition tests. Derive them into a new common function
do deduplicate the code.

Resend of v3 [2]:
 - it missed Patchwork and Netdev archives, probably due to server-side
   issues.

Since v2 [1]:
 - use more intuitive name for the new inline function since there's
   nothing "reserved" in remote pages (Jakub Kicinski, John Hubbard);
 - fold likely() inside the helper itself to make driver code a bit
   fancier (Jakub Kicinski);
 - split function introduction and using into two separate commits;
 - collect some more tags (Jesse Brandeburg, David Rientjes).

Since v1 [0]:
 - new: reduce code duplication by introducing a new common function
   to test if a page can be reused/recycled (David Rientjes);
 - collect autographs for Page Pool bits (Jesper Dangaard Brouer,
   Ilias Apalodimas).

[0] https://lore.kernel.org/netdev/20210125164612.243838-1-alobakin at pm.me
[1] https://lore.kernel.org/netdev/20210127201031.98544-1-alobakin at pm.me
[2] https://lore.kernel.org/lkml/20210131120844.7529-1-alobakin at pm.me

Alexander Lobakin (5):
  mm: constify page_is_pfmemalloc() argument
  skbuff: constify skb_propagate_pfmemalloc() "page" argument
  net: introduce common dev_page_is_reusable()
  net: use the new dev_page_is_reusable() instead of private versions
  net: page_pool: simplify page recycling condition tests

 .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 17 ++++++----------
 drivers/net/ethernet/intel/fm10k/fm10k_main.c | 13 ++++--------
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 15 +-------------
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   | 15 +-------------
 drivers/net/ethernet/intel/ice/ice_txrx.c     | 13 ++----------
 drivers/net/ethernet/intel/igb/igb_main.c     |  9 ++-------
 drivers/net/ethernet/intel/igc/igc_main.c     |  9 ++-------
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  9 ++-------
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c |  9 ++-------
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  7 +------
 include/linux/mm.h                            |  2 +-
 include/linux/skbuff.h                        | 20 +++++++++++++++++--
 net/core/page_pool.c                          | 14 ++++---------
 13 files changed, 46 insertions(+), 106 deletions(-)

-- 
2.30.0


