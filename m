From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Thu,  2 Jul 2020 17:37:26 +0200
Subject: [Intel-wired-lan] [PATCH net-next 0/4] i40e driver performance
 tweaks for AF_XDP
Message-ID: <20200702153730.575738-1-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This series contains four patches worth of driver tweaks for the i40e
AF_XDP Rx path, that in total improves the Rx performance (rx_drop 64B
packets-per-second) with 17%.

Please refer to the individual commits for more details.


Cheers,
Bj?rn


Bj?rn T?pel (4):
  i40e, xsk: remove HW descriptor prefetch in AF_XDP path
  i40e: use 16B HW descriptors instead of 32B
  i40e, xsk: increase budget for AF_XDP path
  i40e, xsk: move buffer allocation out of the Rx processing loop

 drivers/net/ethernet/intel/i40e/i40e.h        |  2 +-
 .../net/ethernet/intel/i40e/i40e_debugfs.c    | 10 +++----
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  4 +--
 drivers/net/ethernet/intel/i40e/i40e_trace.h  |  6 ++--
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 19 +++++++++++--
 drivers/net/ethernet/intel/i40e/i40e_txrx.h   |  2 +-
 .../ethernet/intel/i40e/i40e_txrx_common.h    | 13 ---------
 drivers/net/ethernet/intel/i40e/i40e_type.h   |  5 +++-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c    | 28 +++++++++++++------
 9 files changed, 50 insertions(+), 39 deletions(-)


base-commit: 23212a70077311396cda2823d627317c25e6e5d1
-- 
2.25.1

