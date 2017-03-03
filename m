From: John Fastabend <john.fastabend@gmail.com>
Date: Fri, 03 Mar 2017 09:56:42 -0800
Subject: [Intel-wired-lan] [net-next PATCH v3 0/3] ixgbe XDP series
Message-ID: <20170303175526.25015.12183.stgit@john-Precision-Tower-5810>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

To remaining items to consider but I think they can go in as
follow up patches,

  (a) rx_buffer vs xdp usage in rx clean routine. It may be
      possible to use xdp_buff directly in skb build routines.

  (b) batching on tx is still needed.

---

John Fastabend (3):
      ixgbe: add XDP support for pass and drop actions
      ixgbe: add support for XDP_TX action
      ixgbe: xdp support for adjust head


 drivers/net/ethernet/intel/ixgbe/ixgbe.h         |   22 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |   29 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c     |   87 ++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |  423 ++++++++++++++++++++--
 4 files changed, 500 insertions(+), 61 deletions(-)

--
Signature
