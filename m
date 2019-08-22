From: Kevin Laatz <kevin.laatz@intel.com>
Date: Thu, 22 Aug 2019 01:44:26 +0000
Subject: [Intel-wired-lan] [PATCH bpf-next v5 10/11] samples/bpf: use
 hugepages in xdpsock app
In-Reply-To: <20190822014427.49800-1-kevin.laatz@intel.com>
References: <20190730085400.10376-1-kevin.laatz@intel.com>
 <20190822014427.49800-1-kevin.laatz@intel.com>
Message-ID: <20190822014427.49800-11-kevin.laatz@intel.com>
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
index dc3d50f8ed86..102eace22956 100644
--- a/samples/bpf/xdpsock_user.c
+++ b/samples/bpf/xdpsock_user.c
@@ -70,6 +70,7 @@ static int opt_interval = 1;
 static u32 opt_xdp_bind_flags = XDP_USE_NEED_WAKEUP;
 static u32 opt_umem_flags;
 static int opt_unaligned_chunks;
+static int opt_mmap_flags;
 static u32 opt_xdp_bind_flags;
 static int opt_xsk_frame_size = XSK_UMEM__DEFAULT_FRAME_SIZE;
 static int opt_timeout = 1000;
@@ -440,6 +441,7 @@ static void parse_command_line(int argc, char **argv)
 		case 'u':
 			opt_umem_flags |= XDP_UMEM_UNALIGNED_CHUNK_FLAG;
 			opt_unaligned_chunks = 1;
+			opt_mmap_flags = MAP_HUGETLB;
 			break;
 		case 'F':
 			opt_xdp_flags &= ~XDP_FLAGS_UPDATE_IF_NOEXIST;
@@ -742,11 +744,14 @@ int main(int argc, char **argv)
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

