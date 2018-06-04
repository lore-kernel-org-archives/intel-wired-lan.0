From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Mon,  4 Jun 2018 14:06:01 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next 11/11] samples/bpf: xdpsock: use
 skb Tx path for XDP_SKB
In-Reply-To: <20180604120601.18123-1-bjorn.topel@gmail.com>
References: <20180604120601.18123-1-bjorn.topel@gmail.com>
Message-ID: <20180604120601.18123-12-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bj?rn T?pel <bjorn.topel@intel.com>

Make sure that XDP_SKB also uses the skb Tx path.

Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
---
 samples/bpf/xdpsock_user.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/samples/bpf/xdpsock_user.c b/samples/bpf/xdpsock_user.c
index 7494f60fbff8..d69c8d78d3fd 100644
--- a/samples/bpf/xdpsock_user.c
+++ b/samples/bpf/xdpsock_user.c
@@ -75,6 +75,7 @@ static int opt_queue;
 static int opt_poll;
 static int opt_shared_packet_buffer;
 static int opt_interval = 1;
+static u32 opt_xdp_bind_flags;
 
 struct xdp_umem_uqueue {
 	u32 cached_prod;
@@ -541,9 +542,12 @@ static struct xdpsock *xsk_configure(struct xdp_umem *umem)
 	sxdp.sxdp_family = PF_XDP;
 	sxdp.sxdp_ifindex = opt_ifindex;
 	sxdp.sxdp_queue_id = opt_queue;
+
 	if (shared) {
 		sxdp.sxdp_flags = XDP_SHARED_UMEM;
 		sxdp.sxdp_shared_umem_fd = umem->fd;
+	} else {
+		sxdp.sxdp_flags = opt_xdp_bind_flags;
 	}
 
 	lassert(bind(sfd, (struct sockaddr *)&sxdp, sizeof(sxdp)) == 0);
@@ -699,6 +703,7 @@ static void parse_command_line(int argc, char **argv)
 			break;
 		case 'S':
 			opt_xdp_flags |= XDP_FLAGS_SKB_MODE;
+			opt_xdp_bind_flags |= XDP_COPY;
 			break;
 		case 'N':
 			opt_xdp_flags |= XDP_FLAGS_DRV_MODE;
-- 
2.14.1

