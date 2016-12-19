From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 19 Dec 2016 12:10:39 -0800
Subject: [Intel-wired-lan] [RFC PATCH 00/20] Enable the use of build_skb in
	igb/ixgbe
Message-ID: <20161219200456.27116.28900.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch series is based off of Dave Miller's latest net tree.  The plan
is to submit it for next-queue once net has been merged back into net-next.

The first 3 patches are in a bit of limbo.  They have been accepted for
linux-mm, however I haven't seen them submitted to Linus's tree as of yet.
According to Andrew Morton they are on his list to pull in post 4.9.

The remaining patches implement the changes to support build_skb and
various other performance improvements.  So far I am doing most of my
performance testing on ixgbe with this patch set and the results are
promising.  I am seeing throughput improvements of 10% with netperf
TCP_STREAM tests w/o LRO.  With VXLAN tunnels I am seeing improvements of
as much as 30% when out checksums are enabled.

Any initial feedback would be useful.  My next steps for this is to look at
generating changes for i40e and adding support to out-of-tree drivers for
these features.

---

Alexander Duyck (20):
      mm: Rename __alloc_page_frag to page_frag_alloc and __free_page_frag to page_frag_free
      mm: Rename __page_frag functions to __page_frag_cache, drop order from drain
      mm: Add documentation for page fragment APIs
      igb: Add support for DMA_ATTR_WEAK_ORDERING
      igb: Use length to determine if descriptor is done
      igb: Limit maximum frame Rx based on MTU
      igb: Add support for padding packet
      igb: Add support for ethtool private flag to allow use of legacy Rx
      igb: Break out Rx buffer page management
      igb: Revert "igb: Revert support for build_skb in igb"
      ixgbe: Add function for checking to see if we can reuse page
      ixgbe: Only DMA sync frame length
      ixgbe: Update driver to make use of DMA attributes in Rx path
      ixgbe: Update code to better handle incrementing page count
      ixgbe: Make use of order 1 pages and 3K buffers independent of FCoE
      ixgbe: Use length to determine if descriptor is done
      ixgbe: Break out Rx buffer page management
      ixgbe: Add support for padding packet
      ixgbe: Add private flag to control buffer mode
      ixgbe: Add support for build_skb


 Documentation/vm/page_frags                      |   42 ++
 drivers/net/ethernet/intel/igb/igb.h             |   55 +++
 drivers/net/ethernet/intel/igb/igb_ethtool.c     |   52 +++
 drivers/net/ethernet/intel/igb/igb_main.c        |  357 ++++++++++++-------
 drivers/net/ethernet/intel/ixgbe/ixgbe.h         |   45 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |   47 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |  414 +++++++++++++++-------
 include/linux/gfp.h                              |    9 
 include/linux/skbuff.h                           |    2 
 mm/page_alloc.c                                  |   33 +-
 net/core/skbuff.c                                |    8 
 11 files changed, 758 insertions(+), 306 deletions(-)
 create mode 100644 Documentation/vm/page_frags

--
