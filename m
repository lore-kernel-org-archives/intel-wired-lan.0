From: ira.weiny@intel.com <ira.weiny@intel.com>
Date: Fri,  9 Oct 2020 12:50:05 -0700
Subject: [Intel-wired-lan] [PATCH RFC PKS/PMEM 30/58] fs/romfs: Utilize new
 kmap_thread()
In-Reply-To: <20201009195033.3208459-1-ira.weiny@intel.com>
References: <20201009195033.3208459-1-ira.weiny@intel.com>
Message-ID: <20201009195033.3208459-31-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Ira Weiny <ira.weiny@intel.com>

The kmap() calls in this FS are localized to a single thread.  To avoid
the over head of global PKRS updates use the new kmap_thread() call.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/romfs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/romfs/super.c b/fs/romfs/super.c
index e582d001f792..9050074c6755 100644
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -107,7 +107,7 @@ static int romfs_readpage(struct file *file, struct page *page)
 	void *buf;
 	int ret;
 
-	buf = kmap(page);
+	buf = kmap_thread(page);
 	if (!buf)
 		return -ENOMEM;
 
@@ -136,7 +136,7 @@ static int romfs_readpage(struct file *file, struct page *page)
 		SetPageUptodate(page);
 
 	flush_dcache_page(page);
-	kunmap(page);
+	kunmap_thread(page);
 	unlock_page(page);
 	return ret;
 }
-- 
2.28.0.rc0.12.gb6a658bd00c9

