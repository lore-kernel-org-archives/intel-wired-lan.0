From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Fri,  9 Dec 2016 09:22:09 +0100
Subject: [Intel-wired-lan] [PATCH v2 0/3] i40e: Support for XDP
Message-ID: <20161209082212.29549-1-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bj?rn T?pel <bjorn.topel@intel.com>

This series adds XDP support for i40e-based NICs.

The first patch adds XDP_RX support, the second XDP_TX support and the
last patch makes it possible to change an XDP program without
rebuilding the rings.

Thanks to Daniel for pointing out that checking against
xdp_adjust_head support has to be done in ndo_xdp.

v2:
  * Fixed kbuild error for PAGE_SIZE >= 8192.
  * Renamed i40e_try_flip_rx_page to i40e_can_reuse_rx_page, which is
    more in line to the other Intel Ethernet drivers (igb/fm10k).
  * Validate xdp_adjust_head support in ndo_xdp/XDP_SETUP_PROG.


Bj?rn


Bj?rn T?pel (3):
  i40e: Initial support for XDP
  i40e: Add XDP_TX support
  i40e: Don't reset/rebuild rings on XDP program swap

 drivers/net/ethernet/intel/i40e/i40e.h         |  18 +
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c |   3 +
 drivers/net/ethernet/intel/i40e/i40e_main.c    | 361 +++++++++++++++++---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c    | 444 +++++++++++++++++++++----
 drivers/net/ethernet/intel/i40e/i40e_txrx.h    |   7 +
 5 files changed, 717 insertions(+), 116 deletions(-)

-- 
2.9.3

