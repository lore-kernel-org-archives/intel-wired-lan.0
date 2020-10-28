From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Wed, 28 Oct 2020 14:34:35 +0100
Subject: [Intel-wired-lan] [RFC PATCH bpf-next 7/9] samples/bpf: use
 recvfrom() in xdpsock
In-Reply-To: <20201028133437.212503-1-bjorn.topel@gmail.com>
References: <20201028133437.212503-1-bjorn.topel@gmail.com>
Message-ID: <20201028133437.212503-8-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bj?rn T?pel <bjorn.topel@intel.com>

Start using recvfrom() the rxdrop scenario.

Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
---
 samples/bpf/xdpsock_user.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/samples/bpf/xdpsock_user.c b/samples/bpf/xdpsock_user.c
index 1149e94ca32f..96d0b6482ac4 100644
--- a/samples/bpf/xdpsock_user.c
+++ b/samples/bpf/xdpsock_user.c
@@ -1172,7 +1172,7 @@ static inline void complete_tx_only(struct xsk_socket_info *xsk,
 	}
 }
 
-static void rx_drop(struct xsk_socket_info *xsk, struct pollfd *fds)
+static void rx_drop(struct xsk_socket_info *xsk)
 {
 	unsigned int rcvd, i;
 	u32 idx_rx = 0, idx_fq = 0;
@@ -1182,7 +1182,7 @@ static void rx_drop(struct xsk_socket_info *xsk, struct pollfd *fds)
 	if (!rcvd) {
 		if (xsk_ring_prod__needs_wakeup(&xsk->umem->fq)) {
 			xsk->app_stats.rx_empty_polls++;
-			ret = poll(fds, num_socks, opt_timeout);
+			recvfrom(xsk_socket__fd(xsk->xsk), NULL, 0, MSG_DONTWAIT, NULL, NULL);
 		}
 		return;
 	}
@@ -1193,7 +1193,7 @@ static void rx_drop(struct xsk_socket_info *xsk, struct pollfd *fds)
 			exit_with_error(-ret);
 		if (xsk_ring_prod__needs_wakeup(&xsk->umem->fq)) {
 			xsk->app_stats.fill_fail_polls++;
-			ret = poll(fds, num_socks, opt_timeout);
+			recvfrom(xsk_socket__fd(xsk->xsk), NULL, 0, MSG_DONTWAIT, NULL, NULL);
 		}
 		ret = xsk_ring_prod__reserve(&xsk->umem->fq, rcvd, &idx_fq);
 	}
@@ -1235,7 +1235,7 @@ static void rx_drop_all(void)
 		}
 
 		for (i = 0; i < num_socks; i++)
-			rx_drop(xsks[i], fds);
+			rx_drop(xsks[i]);
 
 		if (benchmark_done)
 			break;
-- 
2.27.0

