From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Fri,  4 Sep 2020 15:53:25 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next 0/6] xsk: exit NAPI loop when
 AF_XDP Rx ring is full
Message-ID: <20200904135332.60259-1-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This series addresses a problem that arises when AF_XDP zero-copy is
enabled, and the kernel softirq Rx processing and userland process is
running on the same core.

In contrast to the two-core case, when the userland process/Rx softirq
shares one core, it it very important that the kernel is not doing
unnecessary work, but instead let the userland process run. This has
not been the case.

For the Intel drivers, when the XDP_REDIRECT fails due to a full Rx
ring, the NAPI loop will simply drop the packet and continue
processing the next packet. The XDP_REDIRECT operation will then fail
again, since userland has not been able to empty the full Rx ring.

The fix for this is letting the NAPI loop exit early, if the AF_XDP
socket Rx ring is full.

The outline is as following; The first patch cleans up the error codes
returned by xdp_do_redirect(), so that a driver can figure out when
the Rx ring is full (ENOBUFS). Patch two adds an extended
xdp_do_redirect() variant that returns what kind of map that was used
in the XDP_REDIRECT action. The third patch adds an AF_XDP driver
helper to figure out if the Rx ring was full. Finally, the last three
patches implements the "early exit" support for Intel.

On my machine the "one core scenario Rx drop" performance went from
~65Kpps to 21Mpps. In other words, from "not usable" to
"usable". YMMV.

I prefer to route this series via bpf-next, since it include core
changes, and not only driver changes.


Have a nice weekend!
Bj?rn

Bj?rn T?pel (6):
  xsk: improve xdp_do_redirect() error codes
  xdp: introduce xdp_do_redirect_ext() function
  xsk: introduce xsk_do_redirect_rx_full() helper
  i40e, xsk: finish napi loop if AF_XDP Rx queue is full
  ice, xsk: finish napi loop if AF_XDP Rx queue is full
  ixgbe, xsk: finish napi loop if AF_XDP Rx queue is full

 drivers/net/ethernet/intel/i40e/i40e_xsk.c   | 23 ++++++++++++++------
 drivers/net/ethernet/intel/ice/ice_xsk.c     | 23 ++++++++++++++------
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 23 ++++++++++++++------
 include/linux/filter.h                       |  2 ++
 include/net/xdp_sock_drv.h                   |  9 ++++++++
 net/core/filter.c                            | 16 ++++++++++++--
 net/xdp/xsk.c                                |  2 +-
 net/xdp/xsk_queue.h                          |  2 +-
 8 files changed, 75 insertions(+), 25 deletions(-)


base-commit: 8eb629585d2231e90112148009e2a11b0979ca38
-- 
2.25.1

