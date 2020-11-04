From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Wed,  4 Nov 2020 15:08:56 +0100
Subject: [Intel-wired-lan] [PATCH bpf-next 0/6] xsk: i40e: Tx performance
 improvements
Message-ID: <1604498942-24274-1-git-send-email-magnus.karlsson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Subject: xsk: i40e: Tx performance improvements

This patch set improves the performance of mainly the Tx processing of
AF_XDP sockets. Though, patch 4 also improves the Rx path. All in all,
this patch set improves the throughput of the l2fwd xdpsock
application by around 14%. If we just take a look at Tx processing part,
it is improved by nearly 50%.

Hopefully the new batched Tx interfaces should be of value to other
drivers implementing AF_XDP zero-copy support. But patch #4 is generic
and will improve performance of all drivers when using AF_XDP sockets
(under the premises explained in that patch).

@Daniel. In patch 4, I apply all the padding required to hinder the
adjacency prefetcher to prefetch the wrong things. After this patch
set, I will submit another patch set that introduces
____cacheline_padding_in_smp in include/linux/cache.h according to your
suggestions. The last patch in that patch set will then convert the
explicit paddings that we have now to ____cacheline_padding_in_smp.

This patch has been applied against commit d0b3d2d7e50d ("Merge branch 'selftests/bpf: Migrate test_tcpbpf_user to be a part of test_progs'")

Structure of the patch set:

Patch 1: Introduce lazy Tx completions in the i40e driver.
Patch 2: For the xdpsock sample, increment Tx stats at sending instead
         of at completion.
Patch 3: Remove an unnecessary sw ring access from the Tx path in i40e.
Patch 4: Introduce padding between all pointers and fields in the ring.
Patch 5: Introduce batched Tx descriptor interfaces.
Patch 6: Use the new batched interfaces in the i40e driver to get higher
         throughput.

Thanks: Magnus

Magnus Karlsson (6):
  i40e: introduce lazy Tx completions for AF_XDP zero-copy
  samples/bpf: increment Tx stats at sending
  i40e: remove unnecessary sw_ring access from xsk Tx
  xsk: introduce padding between more ring pointers
  xsk: introduce batched Tx descriptor interfaces
  i40e: use batched xsk Tx interfaces to increase performance

 drivers/net/ethernet/intel/i40e/i40e_ethtool.c |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c    |   4 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c    |  14 ++-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h    |   3 +-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c     | 140 +++++++++++++++++--------
 include/net/xdp_sock_drv.h                     |   7 ++
 net/xdp/xsk.c                                  |  43 ++++++++
 net/xdp/xsk_queue.h                            |  93 +++++++++++++---
 samples/bpf/xdpsock_user.c                     |   6 +-
 9 files changed, 249 insertions(+), 63 deletions(-)

--
2.7.4
