From: ira.weiny@intel.com <ira.weiny@intel.com>
Date: Fri,  9 Oct 2020 12:49:55 -0700
Subject: [Intel-wired-lan] [PATCH RFC PKS/PMEM 20/58] fs/jffs2: Utilize new
 kmap_thread()
In-Reply-To: <20201009195033.3208459-1-ira.weiny@intel.com>
References: <20201009195033.3208459-1-ira.weiny@intel.com>
Message-ID: <20201009195033.3208459-21-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Ira Weiny <ira.weiny@intel.com>

The kmap() calls in this FS are localized to a single thread.  To avoid
the over head of global PKRS updates use the new kmap_thread() call.

Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Richard Weinberger <richard@nod.at>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/jffs2/file.c | 4 ++--
 fs/jffs2/gc.c   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/jffs2/file.c b/fs/jffs2/file.c
index f8fb89b10227..3e6d54f9b011 100644
--- a/fs/jffs2/file.c
+++ b/fs/jffs2/file.c
@@ -88,7 +88,7 @@ static int jffs2_do_readpage_nolock (struct inode *inode, struct page *pg)
 
 	BUG_ON(!PageLocked(pg));
 
-	pg_buf = kmap(pg);
+	pg_buf = kmap_thread(pg);
 	/* FIXME: Can kmap fail? */
 
 	ret = jffs2_read_inode_range(c, f, pg_buf, pg->index << PAGE_SHIFT,
@@ -103,7 +103,7 @@ static int jffs2_do_readpage_nolock (struct inode *inode, struct page *pg)
 	}
 
 	flush_dcache_page(pg);
-	kunmap(pg);
+	kunmap_thread(pg);
 
 	jffs2_dbg(2, "readpage finished\n");
 	return ret;
diff --git a/fs/jffs2/gc.c b/fs/jffs2/gc.c
index 373b3b7c9f44..a7259783ab84 100644
--- a/fs/jffs2/gc.c
+++ b/fs/jffs2/gc.c
@@ -1335,7 +1335,7 @@ static int jffs2_garbage_collect_dnode(struct jffs2_sb_info *c, struct jffs2_era
 		return PTR_ERR(page);
 	}
 
-	pg_ptr = kmap(page);
+	pg_ptr = kmap_thread(page);
 	mutex_lock(&f->sem);
 
 	offset = start;
@@ -1400,7 +1400,7 @@ static int jffs2_garbage_collect_dnode(struct jffs2_sb_info *c, struct jffs2_era
 		}
 	}
 
-	kunmap(page);
+	kunmap_thread(page);
 	put_page(page);
 	return ret;
 }
-- 
2.28.0.rc0.12.gb6a658bd00c9

