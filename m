From: ira.weiny@intel.com <ira.weiny@intel.com>
Date: Fri,  9 Oct 2020 12:49:49 -0700
Subject: [Intel-wired-lan] [PATCH RFC PKS/PMEM 14/58] fs/cifs: Utilize new
 kmap_thread()
In-Reply-To: <20201009195033.3208459-1-ira.weiny@intel.com>
References: <20201009195033.3208459-1-ira.weiny@intel.com>
Message-ID: <20201009195033.3208459-15-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Ira Weiny <ira.weiny@intel.com>

The kmap() calls in this FS are localized to a single thread.  To avoid
the over head of global PKRS updates use the new kmap_thread() call.

Cc: Steve French <sfrench@samba.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/cifs/cifsencrypt.c |  6 +++---
 fs/cifs/file.c        | 16 ++++++++--------
 fs/cifs/smb2ops.c     |  8 ++++----
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/cifs/cifsencrypt.c b/fs/cifs/cifsencrypt.c
index 9daa256f69d4..2f8232d01a56 100644
--- a/fs/cifs/cifsencrypt.c
+++ b/fs/cifs/cifsencrypt.c
@@ -82,17 +82,17 @@ int __cifs_calc_signature(struct smb_rqst *rqst,
 
 		rqst_page_get_length(rqst, i, &len, &offset);
 
-		kaddr = (char *) kmap(rqst->rq_pages[i]) + offset;
+		kaddr = (char *) kmap_thread(rqst->rq_pages[i]) + offset;
 
 		rc = crypto_shash_update(shash, kaddr, len);
 		if (rc) {
 			cifs_dbg(VFS, "%s: Could not update with payload\n",
 				 __func__);
-			kunmap(rqst->rq_pages[i]);
+			kunmap_thread(rqst->rq_pages[i]);
 			return rc;
 		}
 
-		kunmap(rqst->rq_pages[i]);
+		kunmap_thread(rqst->rq_pages[i]);
 	}
 
 	rc = crypto_shash_final(shash, signature);
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index be46fab4c96d..6db2caab8852 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -2145,17 +2145,17 @@ static int cifs_partialpagewrite(struct page *page, unsigned from, unsigned to)
 	inode = page->mapping->host;
 
 	offset += (loff_t)from;
-	write_data = kmap(page);
+	write_data = kmap_thread(page);
 	write_data += from;
 
 	if ((to > PAGE_SIZE) || (from > to)) {
-		kunmap(page);
+		kunmap_thread(page);
 		return -EIO;
 	}
 
 	/* racing with truncate? */
 	if (offset > mapping->host->i_size) {
-		kunmap(page);
+		kunmap_thread(page);
 		return 0; /* don't care */
 	}
 
@@ -2183,7 +2183,7 @@ static int cifs_partialpagewrite(struct page *page, unsigned from, unsigned to)
 			rc = -EIO;
 	}
 
-	kunmap(page);
+	kunmap_thread(page);
 	return rc;
 }
 
@@ -2559,10 +2559,10 @@ static int cifs_write_end(struct file *file, struct address_space *mapping,
 		   known which we might as well	leverage */
 		/* BB check if anything else missing out of ppw
 		   such as updating last write time */
-		page_data = kmap(page);
+		page_data = kmap_thread(page);
 		rc = cifs_write(cfile, pid, page_data + offset, copied, &pos);
 		/* if (rc < 0) should we set writebehind rc? */
-		kunmap(page);
+		kunmap_thread(page);
 
 		free_xid(xid);
 	} else {
@@ -4511,7 +4511,7 @@ static int cifs_readpage_worker(struct file *file, struct page *page,
 	if (rc == 0)
 		goto read_complete;
 
-	read_data = kmap(page);
+	read_data = kmap_thread(page);
 	/* for reads over a certain size could initiate async read ahead */
 
 	rc = cifs_read(file, read_data, PAGE_SIZE, poffset);
@@ -4540,7 +4540,7 @@ static int cifs_readpage_worker(struct file *file, struct page *page,
 	rc = 0;
 
 io_error:
-	kunmap(page);
+	kunmap_thread(page);
 	unlock_page(page);
 
 read_complete:
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 32f90dc82c84..a3e7ebab38b6 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -4068,12 +4068,12 @@ smb3_init_transform_rq(struct TCP_Server_Info *server, int num_rqst,
 
 			rqst_page_get_length(&new_rq[i], j, &len, &offset);
 
-			dst = (char *) kmap(new_rq[i].rq_pages[j]) + offset;
-			src = (char *) kmap(old_rq[i - 1].rq_pages[j]) + offset;
+			dst = (char *) kmap_thread(new_rq[i].rq_pages[j]) + offset;
+			src = (char *) kmap_thread(old_rq[i - 1].rq_pages[j]) + offset;
 
 			memcpy(dst, src, len);
-			kunmap(new_rq[i].rq_pages[j]);
-			kunmap(old_rq[i - 1].rq_pages[j]);
+			kunmap_thread(new_rq[i].rq_pages[j]);
+			kunmap_thread(old_rq[i - 1].rq_pages[j]);
 		}
 	}
 
-- 
2.28.0.rc0.12.gb6a658bd00c9

