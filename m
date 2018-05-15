From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Tue, 15 May 2018 21:06:06 +0200
Subject: [Intel-wired-lan] [RFC PATCH bpf-next 03/12] xsk: introduce
 xdp_umem_frame
In-Reply-To: <20180515190615.23099-1-bjorn.topel@gmail.com>
References: <20180515190615.23099-1-bjorn.topel@gmail.com>
Message-ID: <20180515190615.23099-4-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bj?rn T?pel <bjorn.topel@intel.com>

The xdp_umem_frame holds the address for a frame. Trade memory for
faster lookup. Later, we'll add DMA address here as well.

Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
---
 include/net/xdp_sock.h |  8 +++++---
 net/xdp/xdp_umem.c     | 29 +++++++++++++++++++++++++----
 net/xdp/xdp_umem.h     |  9 +--------
 3 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index c959aa43fb01..09068c4f068e 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -29,16 +29,18 @@ struct xdp_umem_props {
 	u32 nframes;
 };
 
+struct xdp_umem_frame {
+	void *addr;
+};
+
 struct xdp_umem {
 	struct xsk_queue *fq;
 	struct xsk_queue *cq;
+	struct xdp_umem_frame *frames;
 	struct page **pgs;
 	struct xdp_umem_props props;
 	u32 npgs;
 	u32 frame_headroom;
-	u32 nfpp_mask;
-	u32 nfpplog2;
-	u32 frame_size_log2;
 	struct user_struct *user;
 	struct pid *pid;
 	unsigned long address;
diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
index 7cc162799744..b426cbe3151a 100644
--- a/net/xdp/xdp_umem.c
+++ b/net/xdp/xdp_umem.c
@@ -92,6 +92,9 @@ static void xdp_umem_release(struct xdp_umem *umem)
 		umem->pgs = NULL;
 	}
 
+	kfree(umem->frames);
+	umem->frames = NULL;
+
 	xdp_umem_unaccount_pages(umem);
 out:
 	kfree(umem);
@@ -181,7 +184,8 @@ int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
 {
 	u32 frame_size = mr->frame_size, frame_headroom = mr->frame_headroom;
 	u64 addr = mr->addr, size = mr->len;
-	unsigned int nframes, nfpp;
+	u32 nfpplog2, frame_size_log2;
+	unsigned int nframes, nfpp, i;
 	int size_chk, err;
 
 	if (!umem)
@@ -234,9 +238,6 @@ int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
 	umem->pgs = NULL;
 	umem->user = NULL;
 
-	umem->frame_size_log2 = ilog2(frame_size);
-	umem->nfpp_mask = nfpp - 1;
-	umem->nfpplog2 = ilog2(nfpp);
 	atomic_set(&umem->users, 1);
 
 	err = xdp_umem_account_pages(umem);
@@ -246,6 +247,26 @@ int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
 	err = xdp_umem_pin_pages(umem);
 	if (err)
 		goto out_account;
+
+	umem->frames = kcalloc(nframes, sizeof(*umem->frames), GFP_KERNEL);
+	if (!umem->frames) {
+		err = -ENOMEM;
+		goto out_account;
+	}
+
+	frame_size_log2 = ilog2(frame_size);
+	nfpplog2 = ilog2(nfpp);
+	for (i = 0; i < nframes; i++) {
+		u64 pg, off;
+		char *data;
+
+		pg = i >> nfpplog2;
+		off = (i & (nfpp - 1)) << frame_size_log2;
+
+		data = page_address(umem->pgs[pg]);
+		umem->frames[i].addr = data + off;
+	}
+
 	return 0;
 
 out_account:
diff --git a/net/xdp/xdp_umem.h b/net/xdp/xdp_umem.h
index 32ad59b7322f..0a969384af93 100644
--- a/net/xdp/xdp_umem.h
+++ b/net/xdp/xdp_umem.h
@@ -19,14 +19,7 @@
 
 static inline char *xdp_umem_get_data(struct xdp_umem *umem, u32 idx)
 {
-	u64 pg, off;
-	char *data;
-
-	pg = idx >> umem->nfpplog2;
-	off = (idx & umem->nfpp_mask) << umem->frame_size_log2;
-
-	data = page_address(umem->pgs[pg]);
-	return data + off;
+	return umem->frames[idx].addr;
 }
 
 static inline char *xdp_umem_get_data_with_headroom(struct xdp_umem *umem,
-- 
2.14.1

