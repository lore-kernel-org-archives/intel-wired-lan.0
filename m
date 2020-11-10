From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Tue, 10 Nov 2020 12:01:29 +0100
Subject: [Intel-wired-lan] [PATCH bpf-next v2 0/5] xsk: i40e: Tx performance
 improvements
Message-ID: <1605006094-31097-1-git-send-email-magnus.karlsson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch set improves the performance of mainly the Tx processing of
AF_XDP sockets. Though, patch 3 also improves the Rx path. All in all,
this patch set improves the throughput of the l2fwd xdpsock
application by around 11%. If we just take a look at Tx processing part,
it is improved by 35% to 40%.

Hopefully the new batched Tx interfaces should be of value to other
drivers implementing AF_XDP zero-copy support. But patch #3 is generic
and will improve performance of all drivers when using AF_XDP sockets
(under the premises explained in that patch).

@Daniel. In patch 3, I apply all the padding required to hinder the
adjacency prefetcher to prefetch the wrong things. After this patch
set, I will submit another patch set that introduces
____cacheline_padding_in_smp in include/linux/cache.h according to your
suggestions. The last patch in that patch set will then convert the
explicit paddings that we have now to ____cacheline_padding_in_smp.

v1 -> v2:
* Removed added parameter in i40e_setup_tx_descriptors and adopted a
  simpler solution [Maciej]
* Added test for !xs in xsk_tx_peek_release_desc_batch() [John]
* Simplified return path in xsk_tx_peek_release_desc_batch() [John]
* Dropped patch #1 in v1 that introduced lazy completions. Hopefully
  this is not needed when we get busy poll. [Jakub]
* Iterate over local variable in xskq_prod_reserve_addr_batch() for
  improved performance
* Fixed the fallback path in xsk_tx_peek_release_desc_batch() so that
  it also produces a batch of descriptors, albeit by using the slower
  (but more general) older code. This improves the performance of the
  case when multiple sockets are sharing the same device and queue id.

This patch has been applied against commit f52b8fd33257 ("bpf: selftest: Use static globals in tcp_hdr_options and btf_skc_cls_ingress")

Structure of the patch set:

Patch 1: For the xdpsock sample, increment Tx stats at sending instead
         of at completion.
Patch 2: Remove an unnecessary sw ring access from the Tx path in i40e.
Patch 3: Introduce padding between all pointers and fields in the ring.
Patch 4: Introduce batched Tx descriptor interfaces.
Patch 5: Use the new batched interfaces in the i40e driver to get higher
         throughput.

Thanks: Magnus

Magnus Karlsson (5):
  samples/bpf: increment Tx stats at sending
  i40e: remove unnecessary sw_ring access from xsk Tx
  xsk: introduce padding between more ring pointers
  xsk: introduce batched Tx descriptor interfaces
  i40e: use batched xsk Tx interfaces to increase performance

 drivers/net/ethernet/intel/i40e/i40e_txrx.c |  11 +++
 drivers/net/ethernet/intel/i40e/i40e_txrx.h |   1 +
 drivers/net/ethernet/intel/i40e/i40e_xsk.c  | 131 +++++++++++++++++++---------
 include/net/xdp_sock_drv.h                  |   7 ++
 net/xdp/xsk.c                               |  57 ++++++++++++
 net/xdp/xsk_queue.h                         |  96 +++++++++++++++++---
 samples/bpf/xdpsock_user.c                  |   6 +-
 7 files changed, 253 insertions(+), 56 deletions(-)

--
2.7.4
