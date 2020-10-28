From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Wed, 28 Oct 2020 14:34:36 +0100
Subject: [Intel-wired-lan] [RFC PATCH bpf-next 8/9] samples/bpf: add
 busy-poll support to xdpsock
In-Reply-To: <20201028133437.212503-1-bjorn.topel@gmail.com>
References: <20201028133437.212503-1-bjorn.topel@gmail.com>
Message-ID: <20201028133437.212503-9-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bj?rn T?pel <bjorn.topel@intel.com>

Add a new option to xdpsock, 'B', for busy-polling. This option will
also set the batching size, 'b' option, to the busy-poll budget.

Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
---
 samples/bpf/xdpsock_user.c | 40 +++++++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/samples/bpf/xdpsock_user.c b/samples/bpf/xdpsock_user.c
index 96d0b6482ac4..7ef2c01a1094 100644
--- a/samples/bpf/xdpsock_user.c
+++ b/samples/bpf/xdpsock_user.c
@@ -95,6 +95,7 @@ static int opt_timeout = 1000;
 static bool opt_need_wakeup = true;
 static u32 opt_num_xsks = 1;
 static u32 prog_id;
+static bool opt_busy_poll;
 
 struct xsk_ring_stats {
 	unsigned long rx_npkts;
@@ -911,6 +912,7 @@ static struct option long_options[] = {
 	{"quiet", no_argument, 0, 'Q'},
 	{"app-stats", no_argument, 0, 'a'},
 	{"irq-string", no_argument, 0, 'I'},
+	{"busy-poll", no_argument, 0, 'B'},
 	{0, 0, 0, 0}
 };
 
@@ -949,6 +951,7 @@ static void usage(const char *prog)
 		"  -Q, --quiet          Do not display any stats.\n"
 		"  -a, --app-stats	Display application (syscall) statistics.\n"
 		"  -I, --irq-string	Display driver interrupt statistics for interface associated with irq-string.\n"
+		"  -B, --busy-poll      Busy poll.\n"
 		"\n";
 	fprintf(stderr, str, prog, XSK_UMEM__DEFAULT_FRAME_SIZE,
 		opt_batch_size, MIN_PKT_SIZE, MIN_PKT_SIZE,
@@ -964,7 +967,7 @@ static void parse_command_line(int argc, char **argv)
 	opterr = 0;
 
 	for (;;) {
-		c = getopt_long(argc, argv, "Frtli:q:pSNn:czf:muMd:b:C:s:P:xQaI:",
+		c = getopt_long(argc, argv, "Frtli:q:pSNn:czf:muMd:b:C:s:P:xQaI:B",
 				long_options, &option_index);
 		if (c == -1)
 			break;
@@ -1062,7 +1065,9 @@ static void parse_command_line(int argc, char **argv)
 				fprintf(stderr, "ERROR: Failed to get irqs for %s\n", opt_irq_str);
 				usage(basename(argv[0]));
 			}
-
+			break;
+		case 'B':
+			opt_busy_poll = 1;
 			break;
 		default:
 			usage(basename(argv[0]));
@@ -1132,7 +1137,7 @@ static inline void complete_tx_l2fwd(struct xsk_socket_info *xsk,
 		while (ret != rcvd) {
 			if (ret < 0)
 				exit_with_error(-ret);
-			if (xsk_ring_prod__needs_wakeup(&umem->fq)) {
+			if (opt_busy_poll || xsk_ring_prod__needs_wakeup(&umem->fq)) {
 				xsk->app_stats.fill_fail_polls++;
 				ret = poll(fds, num_socks, opt_timeout);
 			}
@@ -1180,7 +1185,7 @@ static void rx_drop(struct xsk_socket_info *xsk)
 
 	rcvd = xsk_ring_cons__peek(&xsk->rx, opt_batch_size, &idx_rx);
 	if (!rcvd) {
-		if (xsk_ring_prod__needs_wakeup(&xsk->umem->fq)) {
+		if (opt_busy_poll || xsk_ring_prod__needs_wakeup(&xsk->umem->fq)) {
 			xsk->app_stats.rx_empty_polls++;
 			recvfrom(xsk_socket__fd(xsk->xsk), NULL, 0, MSG_DONTWAIT, NULL, NULL);
 		}
@@ -1191,7 +1196,7 @@ static void rx_drop(struct xsk_socket_info *xsk)
 	while (ret != rcvd) {
 		if (ret < 0)
 			exit_with_error(-ret);
-		if (xsk_ring_prod__needs_wakeup(&xsk->umem->fq)) {
+		if (opt_busy_poll || xsk_ring_prod__needs_wakeup(&xsk->umem->fq)) {
 			xsk->app_stats.fill_fail_polls++;
 			recvfrom(xsk_socket__fd(xsk->xsk), NULL, 0, MSG_DONTWAIT, NULL, NULL);
 		}
@@ -1342,7 +1347,7 @@ static void l2fwd(struct xsk_socket_info *xsk, struct pollfd *fds)
 
 	rcvd = xsk_ring_cons__peek(&xsk->rx, opt_batch_size, &idx_rx);
 	if (!rcvd) {
-		if (xsk_ring_prod__needs_wakeup(&xsk->umem->fq)) {
+		if (opt_busy_poll || xsk_ring_prod__needs_wakeup(&xsk->umem->fq)) {
 			xsk->app_stats.rx_empty_polls++;
 			ret = poll(fds, num_socks, opt_timeout);
 		}
@@ -1354,7 +1359,7 @@ static void l2fwd(struct xsk_socket_info *xsk, struct pollfd *fds)
 		if (ret < 0)
 			exit_with_error(-ret);
 		complete_tx_l2fwd(xsk, fds);
-		if (xsk_ring_prod__needs_wakeup(&xsk->tx)) {
+		if (opt_busy_poll || xsk_ring_prod__needs_wakeup(&xsk->tx)) {
 			xsk->app_stats.tx_wakeup_sendtos++;
 			kick_tx(xsk);
 		}
@@ -1461,6 +1466,24 @@ static void enter_xsks_into_map(struct bpf_object *obj)
 	}
 }
 
+static void apply_setsockopt(struct xsk_socket_info *xsk)
+{
+	int sock_opt;
+
+	if (!opt_busy_poll)
+		return;
+
+	sock_opt = 1;
+	if (setsockopt(xsk_socket__fd(xsk->xsk), SOL_SOCKET, SO_BIAS_BUSY_POLL,
+		       (void *)&sock_opt, sizeof(sock_opt)) < 0)
+		exit_with_error(errno);
+
+	sock_opt = 20; // randomly picked :-P
+	if (setsockopt(xsk_socket__fd(xsk->xsk), SOL_SOCKET, SO_BUSY_POLL,
+		       (void *)&sock_opt, sizeof(sock_opt)) < 0)
+		exit_with_error(errno);
+}
+
 int main(int argc, char **argv)
 {
 	struct rlimit r = {RLIM_INFINITY, RLIM_INFINITY};
@@ -1502,6 +1525,9 @@ int main(int argc, char **argv)
 	for (i = 0; i < opt_num_xsks; i++)
 		xsks[num_socks++] = xsk_configure_socket(umem, rx, tx);
 
+	for (i = 0; i < opt_num_xsks; i++)
+		apply_setsockopt(xsks[i]);
+
 	if (opt_bench == BENCH_TXONLY) {
 		gen_eth_hdr_data();
 
-- 
2.27.0

