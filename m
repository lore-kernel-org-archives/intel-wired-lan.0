From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Tue, 15 May 2018 21:06:12 +0200
Subject: [Intel-wired-lan] [RFC PATCH bpf-next 09/12] samples/bpf: minor
 *_nb_free performance fix
In-Reply-To: <20180515190615.23099-1-bjorn.topel@gmail.com>
References: <20180515190615.23099-1-bjorn.topel@gmail.com>
Message-ID: <20180515190615.23099-10-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Magnus Karlsson <magnus.karlsson@intel.com>

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 samples/bpf/xdpsock_user.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/samples/bpf/xdpsock_user.c b/samples/bpf/xdpsock_user.c
index 7fe60f6f7d53..50b9cabba4e8 100644
--- a/samples/bpf/xdpsock_user.c
+++ b/samples/bpf/xdpsock_user.c
@@ -159,15 +159,15 @@ static const char pkt_data[] =
 
 static inline u32 umem_nb_free(struct xdp_umem_uqueue *q, u32 nb)
 {
-	u32 free_entries = q->size - (q->cached_prod - q->cached_cons);
+	u32 free_entries = q->cached_cons - q->cached_prod;
 
 	if (free_entries >= nb)
 		return free_entries;
 
 	/* Refresh the local tail pointer */
-	q->cached_cons = q->ring->ptrs.consumer;
+	q->cached_cons = q->ring->ptrs.consumer + q->size;
 
-	return q->size - (q->cached_prod - q->cached_cons);
+	return q->cached_cons - q->cached_prod;
 }
 
 static inline u32 xq_nb_free(struct xdp_uqueue *q, u32 ndescs)
@@ -432,6 +432,7 @@ static struct xdp_umem *xdp_umem_configure(int sfd)
 
 	umem->fq.mask = FQ_NUM_DESCS - 1;
 	umem->fq.size = FQ_NUM_DESCS;
+	umem->fq.cached_cons = FQ_NUM_DESCS;
 
 	umem->cq.ring = mmap(0, sizeof(struct xdp_umem_ring) +
 			     CQ_NUM_DESCS * sizeof(u32),
@@ -514,6 +515,7 @@ static struct xdpsock *xsk_configure(struct xdp_umem *umem)
 
 	xsk->tx.mask = NUM_DESCS - 1;
 	xsk->tx.size = NUM_DESCS;
+	xsk->tx.cached_cons = NUM_DESCS;
 
 	sxdp.sxdp_family = PF_XDP;
 	sxdp.sxdp_ifindex = opt_ifindex;
-- 
2.14.1

