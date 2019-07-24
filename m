From: Kevin Laatz <kevin.laatz@intel.com>
Date: Wed, 24 Jul 2019 05:10:42 +0000
Subject: [Intel-wired-lan] [PATCH bpf-next v3 10/11] samples/bpf: use
 hugepages in xdpsock app
In-Reply-To: <20190724051043.14348-1-kevin.laatz@intel.com>
References: <20190716030637.5634-1-kevin.laatz@intel.com>
 <20190724051043.14348-1-kevin.laatz@intel.com>
Message-ID: <20190724051043.14348-11-kevin.laatz@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch modifies xdpsock to use mmap instead of posix_memalign. With
this change, we can use hugepages when running the application in unaligned
chunks mode. Using hugepages makes it more likely that we have physically
contiguous memory, which supports the unaligned chunk mode better.

Signed-off-by: Kevin Laatz <kevin.laatz@intel.com>
---
 samples/bpf/xdpsock_user.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/samples/bpf/xdpsock_user.c b/samples/bpf/xdpsock_user.c
index f824fa3b5021..d5cf3111d3b0 100644
--- a/samples/bpf/xdpsock_user.c
+++ b/samples/bpf/xdpsock_user.c
@@ -69,6 +69,7 @@ static int opt_poll;
 static int opt_interval = 1;
 static u32 opt_umem_flags;
 static int opt_unaligned_chunks;
+static int opt_mmap_flags;
 static u32 opt_xdp_bind_flags;
 static int opt_xsk_frame_size = XSK_UMEM__DEFAULT_FRAME_SIZE;
 static __u32 prog_id;
@@ -434,6 +435,7 @@ static void parse_command_line(int argc, char **argv)
 		case 'u':
 			opt_umem_flags |= XDP_UMEM_UNALIGNED_CHUNKS;
 			opt_unaligned_chunks = 1;
+			opt_mmap_flags = MAP_HUGETLB;
 			break;
 		case 'F':
 			opt_xdp_flags &= ~XDP_FLAGS_UPDATE_IF_NOEXIST;
@@ -693,11 +695,14 @@ int main(int argc, char **argv)
 		exit(EXIT_FAILURE);
 	}
 
-	ret = posix_memalign(&bufs, getpagesize(), /* PAGE_SIZE aligned */
-			     NUM_FRAMES * opt_xsk_frame_size);
-	if (ret)
-		exit_with_error(ret);
-
+	/* Reserve memory for the umem. Use hugepages if unaligned chunk mode */
+	bufs = mmap(NULL, NUM_FRAMES * opt_xsk_frame_size,
+		    PROT_READ | PROT_WRITE,
+		    MAP_PRIVATE | MAP_ANONYMOUS | opt_mmap_flags, -1, 0);
+	if (bufs == MAP_FAILED) {
+		printf("ERROR: mmap failed\n");
+		exit(EXIT_FAILURE);
+	}
        /* Create sockets... */
 	umem = xsk_configure_umem(bufs, NUM_FRAMES * opt_xsk_frame_size);
 	xsks[num_socks++] = xsk_configure_socket(umem);
-- 
2.17.1

