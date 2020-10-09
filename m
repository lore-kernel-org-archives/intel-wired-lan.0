From: ira.weiny@intel.com <ira.weiny@intel.com>
Date: Fri,  9 Oct 2020 12:50:07 -0700
Subject: [Intel-wired-lan] [PATCH RFC PKS/PMEM 32/58] fs/hostfs: Utilize new
 kmap_thread()
In-Reply-To: <20201009195033.3208459-1-ira.weiny@intel.com>
References: <20201009195033.3208459-1-ira.weiny@intel.com>
Message-ID: <20201009195033.3208459-33-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Ira Weiny <ira.weiny@intel.com>

The kmap() calls in this FS are localized to a single thread.  To avoid
the over head of global PKRS updates use the new kmap_thread() call.

Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/hostfs/hostfs_kern.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index c070c0d8e3e9..608efd0f83cb 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -409,7 +409,7 @@ static int hostfs_writepage(struct page *page, struct writeback_control *wbc)
 	if (page->index >= end_index)
 		count = inode->i_size & (PAGE_SIZE-1);
 
-	buffer = kmap(page);
+	buffer = kmap_thread(page);
 
 	err = write_file(HOSTFS_I(inode)->fd, &base, buffer, count);
 	if (err != count) {
@@ -425,7 +425,7 @@ static int hostfs_writepage(struct page *page, struct writeback_control *wbc)
 	err = 0;
 
  out:
-	kunmap(page);
+	kunmap_thread(page);
 
 	unlock_page(page);
 	return err;
@@ -437,7 +437,7 @@ static int hostfs_readpage(struct file *file, struct page *page)
 	loff_t start = page_offset(page);
 	int bytes_read, ret = 0;
 
-	buffer = kmap(page);
+	buffer = kmap_thread(page);
 	bytes_read = read_file(FILE_HOSTFS_I(file)->fd, &start, buffer,
 			PAGE_SIZE);
 	if (bytes_read < 0) {
@@ -454,7 +454,7 @@ static int hostfs_readpage(struct file *file, struct page *page)
 
  out:
 	flush_dcache_page(page);
-	kunmap(page);
+	kunmap_thread(page);
 	unlock_page(page);
 	return ret;
 }
@@ -480,9 +480,9 @@ static int hostfs_write_end(struct file *file, struct address_space *mapping,
 	unsigned from = pos & (PAGE_SIZE - 1);
 	int err;
 
-	buffer = kmap(page);
+	buffer = kmap_thread(page);
 	err = write_file(FILE_HOSTFS_I(file)->fd, &pos, buffer + from, copied);
-	kunmap(page);
+	kunmap_thread(page);
 
 	if (!PageUptodate(page) && err == PAGE_SIZE)
 		SetPageUptodate(page);
-- 
2.28.0.rc0.12.gb6a658bd00c9

