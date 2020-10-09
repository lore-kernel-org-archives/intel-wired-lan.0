From: ira.weiny@intel.com <ira.weiny@intel.com>
Date: Fri,  9 Oct 2020 12:49:47 -0700
Subject: [Intel-wired-lan] [PATCH RFC PKS/PMEM 12/58] fs/afs: Utilize new
 kmap_thread()
In-Reply-To: <20201009195033.3208459-1-ira.weiny@intel.com>
References: <20201009195033.3208459-1-ira.weiny@intel.com>
Message-ID: <20201009195033.3208459-13-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Ira Weiny <ira.weiny@intel.com>

The kmap() calls in this FS are localized to a single thread.  To
avoid the over head of global PKRS updates use the new kmap_thread()
call.

Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/afs/dir.c      | 16 ++++++++--------
 fs/afs/dir_edit.c | 16 ++++++++--------
 fs/afs/mntpt.c    |  4 ++--
 fs/afs/write.c    |  4 ++--
 4 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 1d2e61e0ab04..5d01cdb590de 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -127,14 +127,14 @@ static bool afs_dir_check_page(struct afs_vnode *dvnode, struct page *page,
 	qty /= sizeof(union afs_xdr_dir_block);
 
 	/* check them */
-	dbuf = kmap(page);
+	dbuf = kmap_thread(page);
 	for (tmp = 0; tmp < qty; tmp++) {
 		if (dbuf->blocks[tmp].hdr.magic != AFS_DIR_MAGIC) {
 			printk("kAFS: %s(%lx): bad magic %d/%d is %04hx\n",
 			       __func__, dvnode->vfs_inode.i_ino, tmp, qty,
 			       ntohs(dbuf->blocks[tmp].hdr.magic));
 			trace_afs_dir_check_failed(dvnode, off, i_size);
-			kunmap(page);
+			kunmap_thread(page);
 			trace_afs_file_error(dvnode, -EIO, afs_file_error_dir_bad_magic);
 			goto error;
 		}
@@ -146,7 +146,7 @@ static bool afs_dir_check_page(struct afs_vnode *dvnode, struct page *page,
 		((u8 *)&dbuf->blocks[tmp])[AFS_DIR_BLOCK_SIZE - 1] = 0;
 	}
 
-	kunmap(page);
+	kunmap_thread(page);
 
 checked:
 	afs_stat_v(dvnode, n_read_dir);
@@ -177,13 +177,13 @@ static bool afs_dir_check_pages(struct afs_vnode *dvnode, struct afs_read *req)
 		req->pos, req->index, req->nr_pages, req->offset);
 
 	for (i = 0; i < req->nr_pages; i++) {
-		dbuf = kmap(req->pages[i]);
+		dbuf = kmap_thread(req->pages[i]);
 		for (j = 0; j < qty; j++) {
 			union afs_xdr_dir_block *block = &dbuf->blocks[j];
 
 			pr_warn("[%02x] %32phN\n", i * qty + j, block);
 		}
-		kunmap(req->pages[i]);
+		kunmap_thread(req->pages[i]);
 	}
 	return false;
 }
@@ -481,7 +481,7 @@ static int afs_dir_iterate(struct inode *dir, struct dir_context *ctx,
 
 		limit = blkoff & ~(PAGE_SIZE - 1);
 
-		dbuf = kmap(page);
+		dbuf = kmap_thread(page);
 
 		/* deal with the individual blocks stashed on this page */
 		do {
@@ -489,7 +489,7 @@ static int afs_dir_iterate(struct inode *dir, struct dir_context *ctx,
 					       sizeof(union afs_xdr_dir_block)];
 			ret = afs_dir_iterate_block(dvnode, ctx, dblock, blkoff);
 			if (ret != 1) {
-				kunmap(page);
+				kunmap_thread(page);
 				goto out;
 			}
 
@@ -497,7 +497,7 @@ static int afs_dir_iterate(struct inode *dir, struct dir_context *ctx,
 
 		} while (ctx->pos < dir->i_size && blkoff < limit);
 
-		kunmap(page);
+		kunmap_thread(page);
 		ret = 0;
 	}
 
diff --git a/fs/afs/dir_edit.c b/fs/afs/dir_edit.c
index b108528bf010..35ed6828e205 100644
--- a/fs/afs/dir_edit.c
+++ b/fs/afs/dir_edit.c
@@ -218,7 +218,7 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 	need_slots = round_up(12 + name->len + 1 + 4, AFS_DIR_DIRENT_SIZE);
 	need_slots /= AFS_DIR_DIRENT_SIZE;
 
-	meta_page = kmap(page0);
+	meta_page = kmap_thread(page0);
 	meta = &meta_page->blocks[0];
 	if (i_size == 0)
 		goto new_directory;
@@ -247,7 +247,7 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 				set_page_private(page, 1);
 				SetPagePrivate(page);
 			}
-			dir_page = kmap(page);
+			dir_page = kmap_thread(page);
 		}
 
 		/* Abandon the edit if we got a callback break. */
@@ -284,7 +284,7 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 
 		if (page != page0) {
 			unlock_page(page);
-			kunmap(page);
+			kunmap_thread(page);
 			put_page(page);
 		}
 	}
@@ -323,7 +323,7 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 	afs_set_contig_bits(block, slot, need_slots);
 	if (page != page0) {
 		unlock_page(page);
-		kunmap(page);
+		kunmap_thread(page);
 		put_page(page);
 	}
 
@@ -337,7 +337,7 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 
 out_unmap:
 	unlock_page(page0);
-	kunmap(page0);
+	kunmap_thread(page0);
 	put_page(page0);
 	_leave("");
 	return;
@@ -346,7 +346,7 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 	trace_afs_edit_dir(vnode, why, afs_edit_dir_create_inval, 0, 0, 0, 0, name->name);
 	clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
 	if (page != page0) {
-		kunmap(page);
+		kunmap_thread(page);
 		put_page(page);
 	}
 	goto out_unmap;
@@ -398,7 +398,7 @@ void afs_edit_dir_remove(struct afs_vnode *vnode,
 	need_slots = round_up(12 + name->len + 1 + 4, AFS_DIR_DIRENT_SIZE);
 	need_slots /= AFS_DIR_DIRENT_SIZE;
 
-	meta_page = kmap(page0);
+	meta_page = kmap_thread(page0);
 	meta = &meta_page->blocks[0];
 
 	/* Find a page that has sufficient slots available.  Each VM page
@@ -410,7 +410,7 @@ void afs_edit_dir_remove(struct afs_vnode *vnode,
 			page = find_lock_page(vnode->vfs_inode.i_mapping, index);
 			if (!page)
 				goto error;
-			dir_page = kmap(page);
+			dir_page = kmap_thread(page);
 		} else {
 			page = page0;
 			dir_page = meta_page;
diff --git a/fs/afs/mntpt.c b/fs/afs/mntpt.c
index 79bc5f1338ed..562454e2fd5c 100644
--- a/fs/afs/mntpt.c
+++ b/fs/afs/mntpt.c
@@ -139,11 +139,11 @@ static int afs_mntpt_set_params(struct fs_context *fc, struct dentry *mntpt)
 			return ret;
 		}
 
-		buf = kmap(page);
+		buf = kmap_thread(page);
 		ret = -EINVAL;
 		if (buf[size - 1] == '.')
 			ret = vfs_parse_fs_string(fc, "source", buf, size - 1);
-		kunmap(page);
+		kunmap_thread(page);
 		put_page(page);
 		if (ret < 0)
 			return ret;
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 4b2265cb1891..c56e5b4db4ae 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -38,9 +38,9 @@ static int afs_fill_page(struct afs_vnode *vnode, struct key *key,
 	if (pos >= vnode->vfs_inode.i_size) {
 		p = pos & ~PAGE_MASK;
 		ASSERTCMP(p + len, <=, PAGE_SIZE);
-		data = kmap(page);
+		data = kmap_thread(page);
 		memset(data + p, 0, len);
-		kunmap(page);
+		kunmap_thread(page);
 		return 0;
 	}
 
-- 
2.28.0.rc0.12.gb6a658bd00c9

