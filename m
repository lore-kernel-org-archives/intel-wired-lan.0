From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Fri, 19 May 2017 09:08:54 +0200
Subject: [Intel-wired-lan] [PATCH v5 0/2] i40e: support for XDP
Message-ID: <20170519070856.13900-1-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bj?rn T?pel <bjorn.topel@intel.com>

This series adds XDP support for i40e-based NICs.

The first patch wires up ndo_xdp and implements XDP_DROP semantics for
all actions. The second patch adds egress support via the XDP_TX
action.

Performance numbers (40GbE port, 64B packets) for xdp1 and xdp2
programs, from samples/bpf/:

 IOMMU                      | xdp1      | xdp2
 ---------------------------+-----------+-----------
 iommu=off                  | 29.7 Mpps | 17.1 Mpps
 iommu=pt intel_iommu=on    | 29.7 Mpps | 11.6 Mpps
 iommu=on intel_iommu=on    | 21.8 Mpps |  3.7 Mpps

Future improvements, not covered by the patches:
  * Egress: Create the iova mappings upfront
    (DMA_BIDIRECTIONAL/dma_sync_*), instead of creating a new iova
    mapping in the transmit fast-path. This will improve performance
    for the IOMMU-enabled case.
  * Proper debugfs support.
  * i40evf support.

Thanks to Alex, Daniel, John and Scott for all feedback!

v5:
  * Aligned the implementation to ixgbe's XDP support: naming, favor
    xchg instead of RCU semantics
  * Support for XDP headroom (piggybacking on Alex' build_skb work)
  * Added xdp tracepoints for exception states (as suggested by
    Daniel)

v4:
  * Removed unused i40e_page_is_reserved function
  * Prior running the XDP program, set the struct xdp_buff
    data_hard_start member

v3:
  * Rebased patch set on Jeff's dev-queue branch
  * MSI-X is no longer a prerequisite for XDP
  * RCU locking for the XDP program and XDP_RX support is introduced
    in the same patch
  * Rx bytes is now bumped for XDP
  * Removed pointer-to-pointer clunkiness
  * Added comments to XDP preconditions in ndo_xdp
  * When a non-EOF is received, log once, and drop the frame

v2:
  * Fixed kbuild error for PAGE_SIZE >= 8192.
  * Renamed i40e_try_flip_rx_page to i40e_can_reuse_rx_page, which is
    more in line to the other Intel Ethernet drivers (igb/fm10k).
  * Validate xdp_adjust_head support in ndo_xdp/XDP_SETUP_PROG.

Bj?rn T?pel (2):
  i40e: add XDP support for pass and drop actions
  i40e: add support for XDP_TX action

 drivers/net/ethernet/intel/i40e/i40e.h         |   8 +
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  57 +++++-
 drivers/net/ethernet/intel/i40e/i40e_main.c    | 270 ++++++++++++++++++++++---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c    | 245 ++++++++++++++++++----
 drivers/net/ethernet/intel/i40e/i40e_txrx.h    |  12 ++
 5 files changed, 530 insertions(+), 62 deletions(-)

-- 
2.11.0

