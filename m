From: Sridhar Samudrala <sridhar.samudrala@intel.com>
Date: Wed, 14 Aug 2019 20:46:23 -0700
Subject: [Intel-wired-lan] [PATCH bpf-next 5/5] xdpsock_user: Add skip_bpf
 option
In-Reply-To: <1565840783-8269-1-git-send-email-sridhar.samudrala@intel.com>
References: <1565840783-8269-1-git-send-email-sridhar.samudrala@intel.com>
Message-ID: <1565840783-8269-6-git-send-email-sridhar.samudrala@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 samples/bpf/xdpsock_user.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/samples/bpf/xdpsock_user.c b/samples/bpf/xdpsock_user.c
index 93eaaf7239b2..509fc6a18af9 100644
--- a/samples/bpf/xdpsock_user.c
+++ b/samples/bpf/xdpsock_user.c
@@ -123,6 +123,9 @@ static void print_benchmark(bool running)
 	if (opt_poll)
 		printf("poll() ");
 
+	if (opt_xdp_bind_flags & XDP_SKIP_BPF)
+		printf("skip-bpf ");
+
 	if (running) {
 		printf("running...");
 		fflush(stdout);
@@ -352,6 +355,7 @@ static struct option long_options[] = {
 	{"zero-copy", no_argument, 0, 'z'},
 	{"copy", no_argument, 0, 'c'},
 	{"frame-size", required_argument, 0, 'f'},
+	{"skip-bpf", no_argument, 0, 's'},
 	{0, 0, 0, 0}
 };
 
@@ -372,6 +376,7 @@ static void usage(const char *prog)
 		"  -z, --zero-copy      Force zero-copy mode.\n"
 		"  -c, --copy           Force copy mode.\n"
 		"  -f, --frame-size=n   Set the frame size (must be a power of two, default is %d).\n"
+		"  -s, --skip-bpf       Skip running bpf program.\n"
 		"\n";
 	fprintf(stderr, str, prog, XSK_UMEM__DEFAULT_FRAME_SIZE);
 	exit(EXIT_FAILURE);
@@ -430,6 +435,9 @@ static void parse_command_line(int argc, char **argv)
 		case 'f':
 			opt_xsk_frame_size = atoi(optarg);
 			break;
+		case 's':
+			opt_xdp_bind_flags |= XDP_SKIP_BPF;
+			break;
 		default:
 			usage(basename(argv[0]));
 		}
-- 
2.20.1

