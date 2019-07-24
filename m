From: Kevin Laatz <kevin.laatz@intel.com>
Date: Wed, 24 Jul 2019 05:10:40 +0000
Subject: [Intel-wired-lan] [PATCH bpf-next v3 08/11] samples/bpf: add
 unaligned chunks mode support to xdpsock
In-Reply-To: <20190724051043.14348-1-kevin.laatz@intel.com>
References: <20190716030637.5634-1-kevin.laatz@intel.com>
 <20190724051043.14348-1-kevin.laatz@intel.com>
Message-ID: <20190724051043.14348-9-kevin.laatz@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch adds support for the unaligned chunks mode. The addition of the
unaligned chunks option will allow users to run the application with more
relaxed chunk placement in the XDP umem.

Unaligned chunks mode can be used with the '-u' or '--unaligned' command
line options.

Signed-off-by: Kevin Laatz <kevin.laatz@intel.com>
Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 samples/bpf/xdpsock_user.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/samples/bpf/xdpsock_user.c b/samples/bpf/xdpsock_user.c
index 93eaaf7239b2..26ba1a1fd582 100644
--- a/samples/bpf/xdpsock_user.c
+++ b/samples/bpf/xdpsock_user.c
@@ -67,6 +67,8 @@ static int opt_ifindex;
 static int opt_queue;
 static int opt_poll;
 static int opt_interval = 1;
+static u32 opt_umem_flags;
+static int opt_unaligned_chunks;
 static u32 opt_xdp_bind_flags;
 static int opt_xsk_frame_size = XSK_UMEM__DEFAULT_FRAME_SIZE;
 static __u32 prog_id;
@@ -282,7 +284,9 @@ static struct xsk_umem_info *xsk_configure_umem(void *buffer, u64 size)
 		.comp_size = XSK_RING_CONS__DEFAULT_NUM_DESCS,
 		.frame_size = opt_xsk_frame_size,
 		.frame_headroom = XSK_UMEM__DEFAULT_FRAME_HEADROOM,
+		.flags = opt_umem_flags
 	};
+
 	int ret;
 
 	umem = calloc(1, sizeof(*umem));
@@ -291,6 +295,7 @@ static struct xsk_umem_info *xsk_configure_umem(void *buffer, u64 size)
 
 	ret = xsk_umem__create(&umem->umem, buffer, size, &umem->fq, &umem->cq,
 			       &cfg);
+
 	if (ret)
 		exit_with_error(-ret);
 
@@ -352,6 +357,7 @@ static struct option long_options[] = {
 	{"zero-copy", no_argument, 0, 'z'},
 	{"copy", no_argument, 0, 'c'},
 	{"frame-size", required_argument, 0, 'f'},
+	{"unaligned", no_argument, 0, 'u'},
 	{0, 0, 0, 0}
 };
 
@@ -372,6 +378,7 @@ static void usage(const char *prog)
 		"  -z, --zero-copy      Force zero-copy mode.\n"
 		"  -c, --copy           Force copy mode.\n"
 		"  -f, --frame-size=n   Set the frame size (must be a power of two, default is %d).\n"
+		"  -u, --unaligned	Enable unaligned chunk placement\n"
 		"\n";
 	fprintf(stderr, str, prog, XSK_UMEM__DEFAULT_FRAME_SIZE);
 	exit(EXIT_FAILURE);
@@ -384,7 +391,7 @@ static void parse_command_line(int argc, char **argv)
 	opterr = 0;
 
 	for (;;) {
-		c = getopt_long(argc, argv, "Frtli:q:psSNn:czf:", long_options,
+		c = getopt_long(argc, argv, "Frtli:q:psSNn:czf:u", long_options,
 				&option_index);
 		if (c == -1)
 			break;
@@ -424,12 +431,17 @@ static void parse_command_line(int argc, char **argv)
 		case 'c':
 			opt_xdp_bind_flags |= XDP_COPY;
 			break;
+		case 'u':
+			opt_umem_flags |= XDP_UMEM_UNALIGNED_CHUNKS;
+			opt_unaligned_chunks = 1;
+			break;
 		case 'F':
 			opt_xdp_flags &= ~XDP_FLAGS_UPDATE_IF_NOEXIST;
 			break;
 		case 'f':
 			opt_xsk_frame_size = atoi(optarg);
 			break;
+
 		default:
 			usage(basename(argv[0]));
 		}
@@ -442,7 +454,8 @@ static void parse_command_line(int argc, char **argv)
 		usage(basename(argv[0]));
 	}
 
-	if (opt_xsk_frame_size & (opt_xsk_frame_size - 1)) {
+	if ((opt_xsk_frame_size & (opt_xsk_frame_size - 1)) &&
+			!opt_unaligned_chunks) {
 		fprintf(stderr, "--frame-size=%d is not a power of two\n",
 			opt_xsk_frame_size);
 		usage(basename(argv[0]));
-- 
2.17.1

