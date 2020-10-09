From: ira.weiny@intel.com <ira.weiny@intel.com>
Date: Fri,  9 Oct 2020 12:50:09 -0700
Subject: [Intel-wired-lan] [PATCH RFC PKS/PMEM 34/58] fs/erofs: Utilize new
 kmap_thread()
In-Reply-To: <20201009195033.3208459-1-ira.weiny@intel.com>
References: <20201009195033.3208459-1-ira.weiny@intel.com>
Message-ID: <20201009195033.3208459-35-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Ira Weiny <ira.weiny@intel.com>

The kmap() calls in this FS are localized to a single thread.  To avoid
the over head of global PKRS updates use the new kmap_thread() call.

Cc: Gao Xiang <xiang@kernel.org>
Cc: Chao Yu <chao@kernel.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/erofs/super.c | 4 ++--
 fs/erofs/xattr.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index ddaa516c008a..41696b60f1b3 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -139,7 +139,7 @@ static int erofs_read_superblock(struct super_block *sb)
 
 	sbi = EROFS_SB(sb);
 
-	data = kmap(page);
+	data = kmap_thread(page);
 	dsb = (struct erofs_super_block *)(data + EROFS_SUPER_OFFSET);
 
 	ret = -EINVAL;
@@ -189,7 +189,7 @@ static int erofs_read_superblock(struct super_block *sb)
 	}
 	ret = 0;
 out:
-	kunmap(page);
+	kunmap_thread(page);
 	put_page(page);
 	return ret;
 }
diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index c8c381eadcd6..1771baa99d77 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -20,7 +20,7 @@ static inline void xattr_iter_end(struct xattr_iter *it, bool atomic)
 {
 	/* the only user of kunmap() is 'init_inode_xattrs' */
 	if (!atomic)
-		kunmap(it->page);
+		kunmap_thread(it->page);
 	else
 		kunmap_atomic(it->kaddr);
 
@@ -96,7 +96,7 @@ static int init_inode_xattrs(struct inode *inode)
 	}
 
 	/* read in shared xattr array (non-atomic, see kmalloc below) */
-	it.kaddr = kmap(it.page);
+	it.kaddr = kmap_thread(it.page);
 	atomic_map = false;
 
 	ih = (struct erofs_xattr_ibody_header *)(it.kaddr + it.ofs);
-- 
2.28.0.rc0.12.gb6a658bd00c9

