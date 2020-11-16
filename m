From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Mon, 16 Nov 2020 12:12:43 +0100
Subject: [Intel-wired-lan] [PATCH bpf-next v3 1/5] samples/bpf: increment Tx
 stats at sending
In-Reply-To: <1605525167-14450-1-git-send-email-magnus.karlsson@gmail.com>
References: <1605525167-14450-1-git-send-email-magnus.karlsson@gmail.com>
Message-ID: <1605525167-14450-2-git-send-email-magnus.karlsson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Magnus Karlsson <magnus.karlsson@intel.com>

Increment the statistics over how many Tx packets have been sent at
the time of sending instead of at the time of completion. This as a
completion event means that the buffer has been sent AND returned to
user space. The packet always gets sent shortly after sendto() is
called. The kernel might, for performance reasons, decide to not
return every single buffer to user space immediately after sending,
for example, only after a batch of packets have been
transmitted. Incrementing the number of packets sent at completion,
will in that case be confusing as if you send a single packet, the
counter might show zero for a while even though the packet has been
transmitted.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
---
 samples/bpf/xdpsock_user.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/samples/bpf/xdpsock_user.c b/samples/bpf/xdpsock_user.c
index 1149e94..2567f0d 100644
--- a/samples/bpf/xdpsock_user.c
+++ b/samples/bpf/xdpsock_user.c
@@ -1146,7 +1146,6 @@ static inline void complete_tx_l2fwd(struct xsk_socket_info *xsk,
 		xsk_ring_prod__submit(&xsk->umem->fq, rcvd);
 		xsk_ring_cons__release(&xsk->umem->cq, rcvd);
 		xsk->outstanding_tx -= rcvd;
-		xsk->ring_stats.tx_npkts += rcvd;
 	}
 }
 
@@ -1168,7 +1167,6 @@ static inline void complete_tx_only(struct xsk_socket_info *xsk,
 	if (rcvd > 0) {
 		xsk_ring_cons__release(&xsk->umem->cq, rcvd);
 		xsk->outstanding_tx -= rcvd;
-		xsk->ring_stats.tx_npkts += rcvd;
 	}
 }
 
@@ -1260,6 +1258,7 @@ static void tx_only(struct xsk_socket_info *xsk, u32 *frame_nb, int batch_size)
 	}
 
 	xsk_ring_prod__submit(&xsk->tx, batch_size);
+	xsk->ring_stats.tx_npkts += batch_size;
 	xsk->outstanding_tx += batch_size;
 	*frame_nb += batch_size;
 	*frame_nb %= NUM_FRAMES;
@@ -1348,6 +1347,7 @@ static void l2fwd(struct xsk_socket_info *xsk, struct pollfd *fds)
 		}
 		return;
 	}
+	xsk->ring_stats.rx_npkts += rcvd;
 
 	ret = xsk_ring_prod__reserve(&xsk->tx, rcvd, &idx_tx);
 	while (ret != rcvd) {
@@ -1379,7 +1379,7 @@ static void l2fwd(struct xsk_socket_info *xsk, struct pollfd *fds)
 	xsk_ring_prod__submit(&xsk->tx, rcvd);
 	xsk_ring_cons__release(&xsk->rx, rcvd);
 
-	xsk->ring_stats.rx_npkts += rcvd;
+	xsk->ring_stats.tx_npkts += rcvd;
 	xsk->outstanding_tx += rcvd;
 }
 
-- 
2.7.4

