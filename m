From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Thu,  5 Nov 2020 11:28:03 +0100
Subject: [Intel-wired-lan] [RFC PATCH bpf-next v2 0/9] Introduce preferred
 busy-polling
Message-ID: <20201105102812.152836-1-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This series introduces three new features:

1. A new "heavy traffic" busy-polling variant that works in concert
   with the existing napi_defer_hard_irqs and gro_flush_timeout knobs.

2. A new socket option that let a user change the busy-polling NAPI
   budget.

3. Allow busy-polling to be performed on XDP sockets.

The existing busy-polling mode, enabled by the SO_BUSY_POLL socket
option or system-wide using the /proc/sys/net/core/busy_read knob, is
an opportunistic. That means that if the NAPI context is not
scheduled, it will poll it. If, after busy-polling, the budget is
exceeded the busy-polling logic will schedule the NAPI onto the
regular softirq handling.

One implication of the behavior above is that a busy/heavy loaded NAPI
context will never enter/allow for busy-polling. Some applications
prefer that most NAPI processing would be done by busy-polling.

This series adds a new socket option, SO_PREFER_BUSY_POLL, that works
in concert with the napi_defer_hard_irqs and gro_flush_timeout
knobs. The napi_defer_hard_irqs and gro_flush_timeout knobs were
introduced in commit 6f8b12d661d0 ("net: napi: add hard irqs deferral
feature"), and allows for a user to defer interrupts to be enabled and
instead schedule the NAPI context from a watchdog timer. When a user
enables the SO_PREFER_BUSY_POLL, again with the other knobs enabled,
and the NAPI context is being processed by a softirq, the softirq NAPI
processing will exit early to allow the busy-polling to be performed.

If the application stops performing busy-polling via a system call,
the watchdog timer defined by gro_flush_timeout will timeout, and
regular softirq handling will resume.

In summary; Heavy traffic applications that prefer busy-polling over
softirq processing should use this option.

Example usage:

  $ echo 2 | sudo tee /sys/class/net/ens785f1/napi_defer_hard_irqs
  $ echo 200000 | sudo tee /sys/class/net/ens785f1/gro_flush_timeout

Note that the timeout should be larger than the userspace processing
window, otherwise the watchdog will timeout and fall back to regular
softirq processing.

Enable the SO_BUSY_POLL/SO_PREFER_BUSY_POLL options on your socket.


Performance netperf UDP_RR:

Note that netperf UDP_RR is not a heavy traffic tests, and preferred
busy-polling is not typically something we want to use here.

  $ echo 20 | sudo tee /proc/sys/net/core/busy_read
  $ netperf -H 192.168.1.1 -l 30 -t UDP_RR -v 2 -- \
      -o min_latency,mean_latency,max_latency,stddev_latency,transaction_rate

busy-polling blocking sockets:            12,13.33,224,0.63,74731.177

I hacked netperf to use non-blocking sockets and re-ran:

busy-polling non-blocking sockets:        12,13.46,218,0.72,73991.172
prefer busy-polling non-blocking sockets: 12,13.62,221,0.59,73138.448

Using the preferred busy-polling mode does not impact performance.


Performance XDP sockets:

Today, running XDP sockets sample on the same core as the softirq
handling, performance tanks mainly because we do not yield to
user-space when the XDP socket Rx queue is full.

  # taskset -c 5 ./xdpsock -i ens785f1 -q 5 -n 1 -r
  Rx: 64Kpps
  
  # # biased busy-polling, budget 8
  # taskset -c 5 ./xdpsock -i ens785f1 -q 5 -n 1 -r -B -b 8
  Rx 9.9Mpps
  # # biased busy-polling, budget 64
  # taskset -c 5 ./xdpsock -i ens785f1 -q 5 -n 1 -r -B -b 64
  Rx: 19.3Mpps
  # # biased busy-polling, budget 256
  # taskset -c 5 ./xdpsock -i ens785f1 -q 5 -n 1 -r -B -b 256
  Rx: 21.4Mpps
  # # biased busy-polling, budget 512
  # taskset -c 5 ./xdpsock -i ens785f1 -q 5 -n 1 -r -B -b 512
  Rx: 21.7Mpps

Compared to the two-core case:
  # taskset -c 4 ./xdpsock -i ens785f1 -q 20 -n 1 -r
  Rx: 20.7Mpps

We're getting better single-core performance than two, for this na?ve
drop scenario.

The above tests was done for the 'ice' driver.

Thanks to Jakub for suggesting this busy-polling addition [1], and
Eric for the input on the v1 RFC.


Some outstanding questions:

* Currently busy-polling for UDP/TCP is only wired up in the recvmsg()
  path. Does it make sense to extend that to sendmsg() as well?

* Extending xdp_rxq_info_reg() with napi_id touches a lot of drivers,
  and I've only verified the Intel ones. Some drivers initialize NAPI
  (generating the napi_id) after the xdp_rxq_info_reg() call, which
  maybe would open up for another API. I did not send this RFC to all
  the driver authors. I'll do that for a patch proper series.

* Today, enabling busy-polling require CAP_NET_ADMIN. For a NAPI
  context that services multiple socket, this makes sense because one
  socket can affect performance of other sockets. Now, for a
  *dedicated* queue for say XDP socket, would it be OK to drop
  CAP_NET_ADMIN, because it cannot affect other sockets/users.


Changes:

rfc-v1 [2] -> rfc-v2:
  * Changed name from bias to prefer.
  * Base the work on Eric's/Luigi's defer irq/gro timeout work.
  * Proper GRO flushing.
  * Build issues for some XDP drivers.

[1] https://lore.kernel.org/netdev/20200925120652.10b8d7c5 at kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com/
[2] https://lore.kernel.org/bpf/20201028133437.212503-1-bjorn.topel at gmail.com/


Bj?rn T?pel (9):
  net: introduce preferred busy-polling
  net: add SO_BUSY_POLL_BUDGET socket option
  xsk: add support for recvmsg()
  xsk: check need wakeup flag in sendmsg()
  xsk: add busy-poll support for {recv,send}msg()
  xsk: propagate napi_id to XDP socket Rx path
  samples/bpf: use recvfrom() in xdpsock
  samples/bpf: add busy-poll support to xdpsock
  samples/bpf: add option to set the busy-poll budget

 arch/alpha/include/uapi/asm/socket.h          |  3 +
 arch/mips/include/uapi/asm/socket.h           |  3 +
 arch/parisc/include/uapi/asm/socket.h         |  3 +
 arch/sparc/include/uapi/asm/socket.h          |  3 +
 drivers/net/ethernet/amazon/ena/ena_netdev.c  |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  2 +-
 .../ethernet/cavium/thunder/nicvf_queues.c    |  2 +-
 .../net/ethernet/freescale/dpaa2/dpaa2-eth.c  |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  2 +-
 drivers/net/ethernet/intel/ice/ice_base.c     |  4 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c     |  2 +-
 drivers/net/ethernet/intel/igb/igb_main.c     |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  2 +-
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c |  2 +-
 drivers/net/ethernet/marvell/mvneta.c         |  2 +-
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   |  4 +-
 drivers/net/ethernet/mellanox/mlx4/en_rx.c    |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  2 +-
 .../ethernet/netronome/nfp/nfp_net_common.c   |  2 +-
 drivers/net/ethernet/qlogic/qede/qede_main.c  |  2 +-
 drivers/net/ethernet/sfc/rx_common.c          |  2 +-
 drivers/net/ethernet/socionext/netsec.c       |  2 +-
 drivers/net/ethernet/ti/cpsw_priv.c           |  2 +-
 drivers/net/hyperv/netvsc.c                   |  2 +-
 drivers/net/tun.c                             |  2 +-
 drivers/net/veth.c                            |  2 +-
 drivers/net/virtio_net.c                      |  2 +-
 drivers/net/xen-netfront.c                    |  2 +-
 fs/eventpoll.c                                |  3 +-
 include/linux/netdevice.h                     | 35 +++++---
 include/net/busy_poll.h                       | 27 ++++--
 include/net/sock.h                            |  4 +
 include/net/xdp.h                             |  3 +-
 include/uapi/asm-generic/socket.h             |  3 +
 net/core/dev.c                                | 89 ++++++++++++++-----
 net/core/sock.c                               | 19 ++++
 net/core/xdp.c                                |  3 +-
 net/xdp/xsk.c                                 | 36 +++++++-
 net/xdp/xsk_buff_pool.c                       | 13 ++-
 samples/bpf/xdpsock_user.c                    | 53 ++++++++---
 40 files changed, 262 insertions(+), 90 deletions(-)


base-commit: d0b3d2d7e50de5ce121f77a16df4c17e91b09421
-- 
2.27.0

