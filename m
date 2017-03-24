From: John Fastabend <john.fastabend@gmail.com>
Date: Thu, 23 Mar 2017 21:30:40 -0700
Subject: [Intel-wired-lan] [PATCH v7 0/2] XDP support for ixgbe
Message-ID: <20170324042949.10293.43329.stgit@john-Precision-Tower-5810>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This version fixes a couple issues with q_vector allocation and query on XDP
program.

---

John Fastabend (2):
      ixgbe: add XDP support for pass and drop actions
      ixgbe: add support for XDP_TX action


 drivers/net/ethernet/intel/ixgbe/ixgbe.h         |   23 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |   29 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c     |   78 +++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |  434 +++++++++++++++++++---
 4 files changed, 490 insertions(+), 74 deletions(-)

--
Signature
