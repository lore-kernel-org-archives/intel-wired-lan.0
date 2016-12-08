From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Thu,  8 Dec 2016 18:00:19 +0100
Subject: [Intel-wired-lan] [PATCH 0/3] i40e: Support for XDP
Message-ID: <20161208170022.11555-1-bjorn.topel@gmail.com>
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


Bj?rn


Bj?rn T?pel (3):
  i40e: Initial support for XDP
  i40e: Add XDP_TX support
  i40e: Don't reset/rebuild rings on XDP program swap

 drivers/net/ethernet/intel/i40e/i40e.h         |  18 +
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c |   3 +
 drivers/net/ethernet/intel/i40e/i40e_main.c    | 358 +++++++++++++++++---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c    | 445 +++++++++++++++++++++----
 drivers/net/ethernet/intel/i40e/i40e_txrx.h    |   7 +
 5 files changed, 715 insertions(+), 116 deletions(-)

-- 
2.9.3

