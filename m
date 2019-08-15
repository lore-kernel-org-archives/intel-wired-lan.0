From: Sridhar Samudrala <sridhar.samudrala@intel.com>
Date: Wed, 14 Aug 2019 20:46:18 -0700
Subject: [Intel-wired-lan] [PATCH bpf-next 0/5] Add support for SKIP_BPF
 flag for AF_XDP sockets
Message-ID: <1565840783-8269-1-git-send-email-sridhar.samudrala@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch series introduces XDP_SKIP_BPF flag that can be specified
during the bind() call of an AF_XDP socket to skip calling the BPF 
program in the receive path and pass the buffer directly to the socket.

When a single AF_XDP socket is associated with a queue and a HW
filter is used to redirect the packets and the app is interested in
receiving all the packets on that queue, we don't need an additional 
BPF program to do further filtering or lookup/redirect to a socket.

Here are some performance numbers collected on 
  - 2 socket 28 core Intel(R) Xeon(R) Platinum 8180 CPU @ 2.50GHz
  - Intel 40Gb Ethernet NIC (i40e)

All tests use 2 cores and the results are in Mpps.

turbo on (default)
---------------------------------------------	
                      no-skip-bpf    skip-bpf
---------------------------------------------	
rxdrop zerocopy           21.9         38.5 
l2fwd  zerocopy           17.0         20.5
rxdrop copy               11.1         13.3
l2fwd  copy                1.9          2.0

no turbo :  echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo
---------------------------------------------	
                      no-skip-bpf    skip-bpf
---------------------------------------------	
rxdrop zerocopy           15.4         29.0
l2fwd  zerocopy           11.8         18.2
rxdrop copy                8.2         10.5
l2fwd  copy                1.7          1.7
---------------------------------------------	

Sridhar Samudrala (5):
  xsk: Convert bool 'zc' field in struct xdp_umem to a u32 bitmap
  xsk: Introduce XDP_SKIP_BPF bind option
  i40e: Enable XDP_SKIP_BPF option for AF_XDP sockets
  ixgbe: Enable XDP_SKIP_BPF option for AF_XDP sockets
  xdpsock_user: Add skip_bpf option

 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 22 +++++++++-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c    |  6 +++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 20 ++++++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  | 16 ++++++-
 include/net/xdp_sock.h                        | 21 ++++++++-
 include/uapi/linux/if_xdp.h                   |  1 +
 include/uapi/linux/xdp_diag.h                 |  1 +
 net/xdp/xdp_umem.c                            |  9 ++--
 net/xdp/xsk.c                                 | 43 ++++++++++++++++---
 net/xdp/xsk_diag.c                            |  5 ++-
 samples/bpf/xdpsock_user.c                    |  8 ++++
 11 files changed, 135 insertions(+), 17 deletions(-)

-- 
2.20.1

