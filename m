From: Ciara Loftus <ciara.loftus@intel.com>
Date: Fri, 13 Sep 2019 10:39:48 +0000
Subject: [Intel-wired-lan] [PATCH bpf-next v2 3/3] samples/bpf: fix xdpsock
 l2fwd tx for unaligned mode
In-Reply-To: <20190913103948.32053-1-ciara.loftus@intel.com>
References: <20190913103948.32053-1-ciara.loftus@intel.com>
Message-ID: <20190913103948.32053-4-ciara.loftus@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Preserve the offset of the address of the received descriptor, and include
it in the address set for the tx descriptor, so the kernel can correctly
locate the start of the packet data.

Fixes: 03895e63ff97 ("samples/bpf: add buffer recycling for unaligned chunks to xdpsock")
Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 samples/bpf/xdpsock_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/xdpsock_user.c b/samples/bpf/xdpsock_user.c
index 102eace22956..df011ac33402 100644
--- a/samples/bpf/xdpsock_user.c
+++ b/samples/bpf/xdpsock_user.c
@@ -685,7 +685,7 @@ static void l2fwd(struct xsk_socket_info *xsk, struct pollfd *fds)
 	for (i = 0; i < rcvd; i++) {
 		u64 addr = xsk_ring_cons__rx_desc(&xsk->rx, idx_rx)->addr;
 		u32 len = xsk_ring_cons__rx_desc(&xsk->rx, idx_rx++)->len;
-		u64 orig = xsk_umem__extract_addr(addr);
+		u64 orig = addr;
 
 		addr = xsk_umem__add_offset_to_addr(addr);
 		char *pkt = xsk_umem__get_data(xsk->umem->buffer, addr);
-- 
2.17.1

