From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Mon, 11 Dec 2017 10:36:44 -0800
Subject: [Intel-wired-lan] [PATCH 0/9] ixgbevf: update Rx/Tx code path for
 build_skb
Message-ID: <20171211183537.21524.10133.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This series includes changes that were previously introduced in igb and
ixgbe. Mainly the changes from Alexander Duyck prior to the new Rx page
and build_skb support. The goal is to bring the Tx/Rx code path closer
to igb/ixgbe and eventually introduce XDP support as well.

---

Emil Tantilov (9):
      ixgbevf: add function for checking if we can reuse page
      ixgbevf: only DMA sync frame length
      ixgbevf: use length to determine if descriptor is done
      ixgbevf: add support for DMA_ATTR_SKIP_CPU_SYNC/WEAK_ORDERING
      ixgbevf: update code to better handle incrementing page count
      ixgbevf: add counters for Rx page allocations
      ixgbevf: clear rx_buffer_info in configure instead of clean
      ixgbevf: improve performance and reduce size of ixgbevf_tx_map()
      ixgbevf: don't bother clearing tx_buffer_info in ixgbevf_clean_tx_ring()


 drivers/net/ethernet/intel/ixgbevf/ethtool.c      |    3 
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      |   16 +
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |  362 +++++++++++++--------
 3 files changed, 234 insertions(+), 147 deletions(-)

--
Signature
