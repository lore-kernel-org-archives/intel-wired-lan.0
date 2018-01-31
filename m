From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Tue, 30 Jan 2018 16:51:07 -0800
Subject: [Intel-wired-lan] [PATCH 0/9] ixgbevf: build_skb support and
 related changes
Message-ID: <20180131005015.19264.44085.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This series includes changes that were previously introduced in igb and
ixgbe. Mainly the changes from Alexander Duyck prior to the introduction
of XDP support in ixgbe.

---

Emil Tantilov (9):
      ixgbevf: use page_address offset from page
      ixgbevf: add ethtool private flag for legacy Rx
      ixgbevf: add support for using order 1 pages to receive large frames
      ixgbevf: setup queue counts
      ixgbevf: add support for padding packet
      ixgbevf: make sure all frames fit minimum size requirements
      ixgbevf: allocate the rings as part of q_vector
      ixgbevf: break out Rx buffer page management
      ixgbevf: add build_skb support


 drivers/net/ethernet/intel/ixgbevf/ethtool.c      |   48 +
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      |   72 ++
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |  823 ++++++++++++---------
 3 files changed, 568 insertions(+), 375 deletions(-)

--
Signature
