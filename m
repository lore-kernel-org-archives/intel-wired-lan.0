From: alardam@gmail.com <alardam@gmail.com>
Date: Mon, 16 Nov 2020 10:34:52 +0100
Subject: [Intel-wired-lan] [PATCH 8/8] samples/bpf/xdp: apply netdev XDP/XSK
 modes info
In-Reply-To: <20201116093452.7541-1-marekx.majtyka@intel.com>
References: <20201116093452.7541-1-marekx.majtyka@intel.com>
Message-ID: <20201116093452.7541-9-marekx.majtyka@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Marek Majtyka <marekx.majtyka@intel.com>

Update xdpsock sample so that it utilizes netlink ethtool interface
to get available XDP/XSK modes. This allows to automatically choose
the best available mode of operation, if these are not provided explicitly.

Signed-off-by: Marek Majtyka <marekx.majtyka@intel.com>
---
 samples/bpf/xdpsock_user.c | 117 ++++++++++++++++++++++++++++++++++---
 1 file changed, 108 insertions(+), 9 deletions(-)

diff --git a/samples/bpf/xdpsock_user.c b/samples/bpf/xdpsock_user.c
index 1149e94ca32f..780e5d1d73a0 100644
--- a/samples/bpf/xdpsock_user.c
+++ b/samples/bpf/xdpsock_user.c
@@ -53,6 +53,9 @@
 
 #define DEBUG_HEXDUMP 0
 
+#define XDP_MODES		(XDP_FLAGS_SKB_MODE | XDP_FLAGS_DRV_MODE)
+#define XSK_MODES		(XDP_COPY | XDP_ZEROCOPY)
+
 typedef __u64 u64;
 typedef __u32 u32;
 typedef __u16 u16;
@@ -86,7 +89,7 @@ static u32 irq_no;
 static int irqs_at_init = -1;
 static int opt_poll;
 static int opt_interval = 1;
-static u32 opt_xdp_bind_flags = XDP_USE_NEED_WAKEUP;
+static u16 opt_xdp_bind_flags = XDP_USE_NEED_WAKEUP;
 static u32 opt_umem_flags;
 static int opt_unaligned_chunks;
 static int opt_mmap_flags;
@@ -95,6 +98,8 @@ static int opt_timeout = 1000;
 static bool opt_need_wakeup = true;
 static u32 opt_num_xsks = 1;
 static u32 prog_id;
+static u32 xdp_caps;
+static u16 bind_caps;
 
 struct xsk_ring_stats {
 	unsigned long rx_npkts;
@@ -957,6 +962,26 @@ static void usage(const char *prog)
 	exit(EXIT_FAILURE);
 }
 
+static inline void set_drv_mode(void)
+{
+	opt_xdp_flags |= XDP_FLAGS_DRV_MODE;
+}
+
+static inline void set_skb_mode(void)
+{
+	opt_xdp_flags |= XDP_FLAGS_SKB_MODE;
+}
+
+static inline void set_zc_mode(void)
+{
+	opt_xdp_bind_flags |= XDP_ZEROCOPY;
+}
+
+static inline void set_copy_mode(void)
+{
+	opt_xdp_bind_flags |= XDP_COPY;
+}
+
 static void parse_command_line(int argc, char **argv)
 {
 	int option_index, c;
@@ -989,20 +1014,19 @@ static void parse_command_line(int argc, char **argv)
 			opt_poll = 1;
 			break;
 		case 'S':
-			opt_xdp_flags |= XDP_FLAGS_SKB_MODE;
-			opt_xdp_bind_flags |= XDP_COPY;
+			set_skb_mode();
 			break;
 		case 'N':
-			/* default, set below */
+			set_drv_mode();
 			break;
 		case 'n':
 			opt_interval = atoi(optarg);
 			break;
 		case 'z':
-			opt_xdp_bind_flags |= XDP_ZEROCOPY;
+			set_zc_mode();
 			break;
 		case 'c':
-			opt_xdp_bind_flags |= XDP_COPY;
+			set_copy_mode();
 			break;
 		case 'u':
 			opt_umem_flags |= XDP_UMEM_UNALIGNED_CHUNK_FLAG;
@@ -1069,9 +1093,6 @@ static void parse_command_line(int argc, char **argv)
 		}
 	}
 
-	if (!(opt_xdp_flags & XDP_FLAGS_SKB_MODE))
-		opt_xdp_flags |= XDP_FLAGS_DRV_MODE;
-
 	opt_ifindex = if_nametoindex(opt_if);
 	if (!opt_ifindex) {
 		fprintf(stderr, "ERROR: interface \"%s\" does not exist\n",
@@ -1461,6 +1482,76 @@ static void enter_xsks_into_map(struct bpf_object *obj)
 	}
 }
 
+static inline u32 xdp_mode_not_set(void)
+{
+	return (opt_xdp_flags & XDP_MODES) == 0;
+}
+
+static inline u16 bind_mode_not_set(void)
+{
+	return (opt_xdp_bind_flags & XSK_MODES) == 0;
+}
+
+static inline u16 zc_mode_set(void)
+{
+	return opt_xdp_bind_flags & XDP_ZEROCOPY;
+}
+
+static inline u32 drv_mode_set(void)
+{
+	return opt_xdp_flags & XDP_FLAGS_DRV_MODE;
+}
+
+static inline u16 zc_mode_available(void)
+{
+	return bind_caps & XDP_ZEROCOPY;
+}
+
+static inline u32 drv_mode_available(void)
+{
+	return xdp_caps & XDP_FLAGS_DRV_MODE;
+}
+
+static void set_xsk_default_flags(void)
+{
+	if (drv_mode_available()) {
+		set_drv_mode();
+
+		if (zc_mode_available())
+			set_zc_mode();
+		else
+			set_copy_mode();
+	} else {
+		set_skb_mode();
+		set_copy_mode();
+	}
+}
+
+static void adjust_missing_flags(void)
+{
+	if (xdp_mode_not_set()) {
+		if (bind_mode_not_set()) {
+			set_xsk_default_flags();
+		} else {
+			if (zc_mode_set()) {
+				set_drv_mode();
+			} else {
+				if (drv_mode_available())
+					set_drv_mode();
+				else
+					set_skb_mode();
+			}
+		}
+	} else {
+		if (bind_mode_not_set()) {
+			if (drv_mode_set() && zc_mode_available())
+				set_zc_mode();
+			else
+				set_copy_mode();
+		}
+	}
+}
+
 int main(int argc, char **argv)
 {
 	struct rlimit r = {RLIM_INFINITY, RLIM_INFINITY};
@@ -1473,6 +1564,14 @@ int main(int argc, char **argv)
 
 	parse_command_line(argc, argv);
 
+	ret = xsk_socket__get_caps(opt_if, &xdp_caps, &bind_caps);
+	if (ret) {
+		fprintf(stderr, "ERROR: xsk_socket__get_caps\n");
+		exit(EXIT_FAILURE);
+	}
+
+	adjust_missing_flags();
+
 	if (setrlimit(RLIMIT_MEMLOCK, &r)) {
 		fprintf(stderr, "ERROR: setrlimit(RLIMIT_MEMLOCK) \"%s\"\n",
 			strerror(errno));
-- 
2.20.1

