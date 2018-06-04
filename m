From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Mon,  4 Jun 2018 14:05:52 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next 02/11] xsk: introduce
 xdp_umem_page
In-Reply-To: <20180604120601.18123-1-bjorn.topel@gmail.com>
References: <20180604120601.18123-1-bjorn.topel@gmail.com>
Message-ID: <20180604120601.18123-3-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bj?rn T?pel <bjorn.topel@intel.com>

The xdp_umem_page holds the address for a page. Trade memory for
faster lookup. Later, we'll add DMA address here as well.

Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
---
 include/net/xdp_sock.h |  7 ++++++-
 net/xdp/xdp_umem.c     | 15 ++++++++++++++-
 net/xdp/xdp_umem.h     |  3 +--
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 3a6cd88f179d..caf343a7e224 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -20,10 +20,14 @@ struct xdp_umem_props {
 	u64 size;
 };
 
+struct xdp_umem_page {
+	void *addr;
+};
+
 struct xdp_umem {
 	struct xsk_queue *fq;
 	struct xsk_queue *cq;
-	struct page **pgs;
+	struct xdp_umem_page *pages;
 	struct xdp_umem_props props;
 	u32 headroom;
 	u32 chunk_size_nohr;
@@ -32,6 +36,7 @@ struct xdp_umem {
 	unsigned long address;
 	refcount_t users;
 	struct work_struct work;
+	struct page **pgs;
 	u32 npgs;
 };
 
diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
index 2793a503223e..aca826011f6c 100644
--- a/net/xdp/xdp_umem.c
+++ b/net/xdp/xdp_umem.c
@@ -65,6 +65,9 @@ static void xdp_umem_release(struct xdp_umem *umem)
 		goto out;
 
 	mmput(mm);
+	kfree(umem->pages);
+	umem->pages = NULL;
+
 	xdp_umem_unaccount_pages(umem);
 out:
 	kfree(umem);
@@ -155,7 +158,7 @@ static int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
 	u32 chunk_size = mr->chunk_size, headroom = mr->headroom;
 	unsigned int chunks, chunks_per_page;
 	u64 addr = mr->addr, size = mr->len;
-	int size_chk, err;
+	int size_chk, err, i;
 
 	if (chunk_size < XDP_UMEM_MIN_CHUNK_SIZE || chunk_size > PAGE_SIZE) {
 		/* Strictly speaking we could support this, if:
@@ -213,6 +216,16 @@ static int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
 	err = xdp_umem_pin_pages(umem);
 	if (err)
 		goto out_account;
+
+	umem->pages = kcalloc(umem->npgs, sizeof(*umem->pages), GFP_KERNEL);
+	if (!umem->pages) {
+		err = -ENOMEM;
+		goto out_account;
+	}
+
+	for (i = 0; i < umem->npgs; i++)
+		umem->pages[i].addr = page_address(umem->pgs[i]);
+
 	return 0;
 
 out_account:
diff --git a/net/xdp/xdp_umem.h b/net/xdp/xdp_umem.h
index 9433e8af650a..40e8fa4a92af 100644
--- a/net/xdp/xdp_umem.h
+++ b/net/xdp/xdp_umem.h
@@ -10,8 +10,7 @@
 
 static inline char *xdp_umem_get_data(struct xdp_umem *umem, u64 addr)
 {
-	return page_address(umem->pgs[addr >> PAGE_SHIFT]) +
-		(addr & (PAGE_SIZE - 1));
+	return umem->pages[addr >> PAGE_SHIFT].addr + (addr & (PAGE_SIZE - 1));
 }
 
 bool xdp_umem_validate_queues(struct xdp_umem *umem);
-- 
2.14.1

