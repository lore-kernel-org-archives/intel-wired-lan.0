From: ira.weiny@intel.com <ira.weiny@intel.com>
Date: Fri,  9 Oct 2020 12:50:02 -0700
Subject: [Intel-wired-lan] [PATCH RFC PKS/PMEM 27/58] fs/ubifs: Utilize new
 kmap_thread()
In-Reply-To: <20201009195033.3208459-1-ira.weiny@intel.com>
References: <20201009195033.3208459-1-ira.weiny@intel.com>
Message-ID: <20201009195033.3208459-28-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Ira Weiny <ira.weiny@intel.com>

The kmap() calls in this FS are localized to a single thread.  To avoid
the over head of global PKRS updates use the new kmap_thread() call.

Cc: Richard Weinberger <richard@nod.at>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/ubifs/file.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index b77d1637bbbc..a3537447a885 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -111,7 +111,7 @@ static int do_readpage(struct page *page)
 	ubifs_assert(c, !PageChecked(page));
 	ubifs_assert(c, !PagePrivate(page));
 
-	addr = kmap(page);
+	addr = kmap_thread(page);
 
 	block = page->index << UBIFS_BLOCKS_PER_PAGE_SHIFT;
 	beyond = (i_size + UBIFS_BLOCK_SIZE - 1) >> UBIFS_BLOCK_SHIFT;
@@ -174,7 +174,7 @@ static int do_readpage(struct page *page)
 	SetPageUptodate(page);
 	ClearPageError(page);
 	flush_dcache_page(page);
-	kunmap(page);
+	kunmap_thread(page);
 	return 0;
 
 error:
@@ -182,7 +182,7 @@ static int do_readpage(struct page *page)
 	ClearPageUptodate(page);
 	SetPageError(page);
 	flush_dcache_page(page);
-	kunmap(page);
+	kunmap_thread(page);
 	return err;
 }
 
@@ -616,7 +616,7 @@ static int populate_page(struct ubifs_info *c, struct page *page,
 	dbg_gen("ino %lu, pg %lu, i_size %lld, flags %#lx",
 		inode->i_ino, page->index, i_size, page->flags);
 
-	addr = zaddr = kmap(page);
+	addr = zaddr = kmap_thread(page);
 
 	end_index = (i_size - 1) >> PAGE_SHIFT;
 	if (!i_size || page->index > end_index) {
@@ -692,7 +692,7 @@ static int populate_page(struct ubifs_info *c, struct page *page,
 	SetPageUptodate(page);
 	ClearPageError(page);
 	flush_dcache_page(page);
-	kunmap(page);
+	kunmap_thread(page);
 	*n = nn;
 	return 0;
 
@@ -700,7 +700,7 @@ static int populate_page(struct ubifs_info *c, struct page *page,
 	ClearPageUptodate(page);
 	SetPageError(page);
 	flush_dcache_page(page);
-	kunmap(page);
+	kunmap_thread(page);
 	ubifs_err(c, "bad data node (block %u, inode %lu)",
 		  page_block, inode->i_ino);
 	return -EINVAL;
@@ -918,7 +918,7 @@ static int do_writepage(struct page *page, int len)
 	/* Update radix tree tags */
 	set_page_writeback(page);
 
-	addr = kmap(page);
+	addr = kmap_thread(page);
 	block = page->index << UBIFS_BLOCKS_PER_PAGE_SHIFT;
 	i = 0;
 	while (len) {
@@ -950,7 +950,7 @@ static int do_writepage(struct page *page, int len)
 	ClearPagePrivate(page);
 	ClearPageChecked(page);
 
-	kunmap(page);
+	kunmap_thread(page);
 	unlock_page(page);
 	end_page_writeback(page);
 	return err;
-- 
2.28.0.rc0.12.gb6a658bd00c9

