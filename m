From: Sridhar Samudrala <sridhar.samudrala@intel.com>
Date: Mon,  7 Oct 2019 23:16:55 -0700
Subject: [Intel-wired-lan] [PATCH bpf-next 4/4] xdpsock: add an option to
 create AF_XDP sockets in XDP_DIRECT mode
In-Reply-To: <1570515415-45593-1-git-send-email-sridhar.samudrala@intel.com>
References: <1570515415-45593-1-git-send-email-sridhar.samudrala@intel.com>
Message-ID: <1570515415-45593-5-git-send-email-sridhar.samudrala@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This option enables an AF_XDP socket to bind with a XDP_DIRECT flag
that allows packets received on the associated queue to be received
directly when an XDP program is not attached.

Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 samples/bpf/xdpsock_user.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/samples/bpf/xdpsock_user.c b/samples/bpf/xdpsock_user.c
index 405c4e091f8b..6f4633769968 100644
--- a/samples/bpf/xdpsock_user.c
+++ b/samples/bpf/xdpsock_user.c
@@ -129,6 +129,9 @@ static void print_benchmark(bool running)
 	if (opt_poll)
 		printf("poll() ");
 
+	if (opt_xdp_bind_flags & XDP_DIRECT)
+		printf("direct-xsk ");
+
 	if (running) {
 		printf("running...");
 		fflush(stdout);
@@ -202,7 +205,8 @@ static void int_exit(int sig)
 	dump_stats();
 	xsk_socket__delete(xsks[0]->xsk);
 	(void)xsk_umem__delete(umem);
-	remove_xdp_program();
+	if (!(opt_xdp_bind_flags & XDP_DIRECT))
+		remove_xdp_program();
 
 	exit(EXIT_SUCCESS);
 }
@@ -213,7 +217,8 @@ static void __exit_with_error(int error, const char *file, const char *func,
 	fprintf(stderr, "%s:%s:%i: errno: %d/\"%s\"\n", file, func,
 		line, error, strerror(error));
 	dump_stats();
-	remove_xdp_program();
+	if (!(opt_xdp_bind_flags & XDP_DIRECT))
+		remove_xdp_program();
 	exit(EXIT_FAILURE);
 }
 
@@ -363,6 +368,7 @@ static struct option long_options[] = {
 	{"frame-size", required_argument, 0, 'f'},
 	{"no-need-wakeup", no_argument, 0, 'm'},
 	{"unaligned", no_argument, 0, 'u'},
+	{"direct-xsk", no_argument, 0, 'd'},
 	{0, 0, 0, 0}
 };
 
@@ -386,6 +392,7 @@ static void usage(const char *prog)
 		"  -m, --no-need-wakeup Turn off use of driver need wakeup flag.\n"
 		"  -f, --frame-size=n   Set the frame size (must be a power of two in aligned mode, default is %d).\n"
 		"  -u, --unaligned	Enable unaligned chunk placement\n"
+		"  -d, --direct-xsk	Direct packets to XDP socket.\n"
 		"\n";
 	fprintf(stderr, str, prog, XSK_UMEM__DEFAULT_FRAME_SIZE);
 	exit(EXIT_FAILURE);
@@ -398,7 +405,7 @@ static void parse_command_line(int argc, char **argv)
 	opterr = 0;
 
 	for (;;) {
-		c = getopt_long(argc, argv, "Frtli:q:psSNn:czf:mu",
+		c = getopt_long(argc, argv, "Frtli:q:psSNn:czf:mud",
 				long_options, &option_index);
 		if (c == -1)
 			break;
@@ -452,7 +459,9 @@ static void parse_command_line(int argc, char **argv)
 			opt_need_wakeup = false;
 			opt_xdp_bind_flags &= ~XDP_USE_NEED_WAKEUP;
 			break;
-
+		case 'd':
+			opt_xdp_bind_flags |= XDP_DIRECT;
+			break;
 		default:
 			usage(basename(argv[0]));
 		}
-- 
2.14.5

