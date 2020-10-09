From: ira.weiny@intel.com <ira.weiny@intel.com>
Date: Fri,  9 Oct 2020 12:50:03 -0700
Subject: [Intel-wired-lan] [PATCH RFC PKS/PMEM 28/58] fs/cachefiles: Utilize
 new kmap_thread()
In-Reply-To: <20201009195033.3208459-1-ira.weiny@intel.com>
References: <20201009195033.3208459-1-ira.weiny@intel.com>
Message-ID: <20201009195033.3208459-29-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Ira Weiny <ira.weiny@intel.com>

The kmap() calls in this FS are localized to a single thread.  To avoid
the over head of global PKRS updates use the new kmap_thread() call.

Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/cachefiles/rdwr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/cachefiles/rdwr.c b/fs/cachefiles/rdwr.c
index 3080cda9e824..2468e5c067ba 100644
--- a/fs/cachefiles/rdwr.c
+++ b/fs/cachefiles/rdwr.c
@@ -936,9 +936,9 @@ int cachefiles_write_page(struct fscache_storage *op, struct page *page)
 		}
 	}
 
-	data = kmap(page);
+	data = kmap_thread(page);
 	ret = kernel_write(file, data, len, &pos);
-	kunmap(page);
+	kunmap_thread(page);
 	fput(file);
 	if (ret != len)
 		goto error_eio;
-- 
2.28.0.rc0.12.gb6a658bd00c9

