From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Mon,  7 Sep 2020 17:02:13 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next 0/4] xsk: increase NAPI budget
 for AF_XDP zero-copy path
Message-ID: <20200907150217.30888-1-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The NAPI budget (NAPI_POLL_WEIGHT), meaning the number of received
packets that are allowed to be processed for each NAPI invocation,
takes into consideration that each received packet is aimed for the
kernel networking stack.

That is not the case for the AF_XDP receive path, where the cost of
each packet is significantly less. Therefore, this commit adds a new
NAPI budget, which is the NAPI_POLL_WEIGHT scaled by 4. Typically that
would be 256 in most configuration. It is encouraged that AF_XDP
zero-copy capable drivers use the XSK_NAPI_WEIGHT, when zero-copy is
enabled.

Processing 256 packets targeted for AF_XDP is still less work than 64
(NAPI_POLL_WEIGHT) packets going to the kernel networking stack.

Jakub suggested in [1] that a more generic approach was preferred over
"driver hacks". It is arguable if adding the budget as a define which
is a scaled NAPI_POLL_WEIGHT would classify as "generic", but it is a
bit further away from "driver hacks". ;-)

The first patch adds the actual define, and last three make the Intel
drivers use it.

The AF_XDP Rx performance for "rxdrop" is up ~8% on my machine.

Routing this series via bpf-next instead of Intel Wired/netdev, since
it is a core AF_XDP addition, and hopefully Nvidia will pick this up
for the mlx5 driver.


Bj?rn

[1] https://lore.kernel.org/netdev/20200728131512.17c41621 at kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com/

Bj?rn T?pel (4):
  xsk: add XSK_NAPI_WEIGHT define
  i40e, xsk: use XSK_NAPI_WEIGHT as NAPI poll budget
  ice, xsk: use XSK_NAPI_WEIGHT as NAPI poll budget
  ixgbe, xsk: use XSK_NAPI_WEIGHT as NAPI poll budget

 drivers/net/ethernet/intel/i40e/i40e_xsk.c   | 2 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c     | 2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 2 +-
 include/net/xdp_sock_drv.h                   | 3 +++
 4 files changed, 6 insertions(+), 3 deletions(-)


base-commit: bc0b5a03079bd78fb3d5cba1ccabf0a7efb1d99f
-- 
2.25.1

