From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Tue, 25 Aug 2020 13:35:53 +0200
Subject: [Intel-wired-lan] [PATCH net-next v2 0/3] i40e driver performance
 tweaks for AF_XDP
Message-ID: <20200825113556.18342-1-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This series contains three patches worth of driver tweaks for the i40e
AF_XDP Rx path, that in total improves the Rx performance (rx_drop 64B
packets-per-second) with 9%.

Please refer to the individual commits for more details.

v1->v2: Removed the napi budget increase patch [1]. Instead, that will
        be sent out as a more generic series that addresses all AF_XDP
        zero-copy capable drivers, as suggested by Jakub. [2]

Cheers,
Bj?rn

[1] https://lore.kernel.org/netdev/20200702153730.575738-4-bjorn.topel at gmail.com/
[2] https://lore.kernel.org/netdev/20200728131653.3b90336b at kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com/


Bj?rn T?pel (3):
  i40e, xsk: remove HW descriptor prefetch in AF_XDP path
  i40e: use 16B HW descriptors instead of 32B
  i40e, xsk: move buffer allocation out of the Rx processing loop

 drivers/net/ethernet/intel/i40e/i40e.h        |  2 +-
 .../net/ethernet/intel/i40e/i40e_debugfs.c    | 10 ++++----
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  4 ++--
 drivers/net/ethernet/intel/i40e/i40e_trace.h  |  6 ++---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 19 ++++++++++++---
 drivers/net/ethernet/intel/i40e/i40e_txrx.h   |  2 +-
 .../ethernet/intel/i40e/i40e_txrx_common.h    | 13 ----------
 drivers/net/ethernet/intel/i40e/i40e_type.h   |  5 +++-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c    | 24 ++++++++++++-------
 9 files changed, 47 insertions(+), 38 deletions(-)


base-commit: 079f921e9f4d3992968a2fc5dc3af0a3540853cc
-- 
2.25.1

