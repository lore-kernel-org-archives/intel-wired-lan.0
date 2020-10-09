From: ira.weiny@intel.com <ira.weiny@intel.com>
Date: Fri,  9 Oct 2020 12:50:01 -0700
Subject: [Intel-wired-lan] [PATCH RFC PKS/PMEM 26/58] fs/zonefs: Utilize new
 kmap_thread()
In-Reply-To: <20201009195033.3208459-1-ira.weiny@intel.com>
References: <20201009195033.3208459-1-ira.weiny@intel.com>
Message-ID: <20201009195033.3208459-27-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Ira Weiny <ira.weiny@intel.com>

The kmap() calls in this FS are localized to a single thread.  To avoid
the over head of global PKRS updates use the new kmap_thread() call.

Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/zonefs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 8ec7c8f109d7..2fd6c86beee1 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -1297,7 +1297,7 @@ static int zonefs_read_super(struct super_block *sb)
 	if (ret)
 		goto free_page;
 
-	super = kmap(page);
+	super = kmap_thread(page);
 
 	ret = -EINVAL;
 	if (le32_to_cpu(super->s_magic) != ZONEFS_MAGIC)
@@ -1349,7 +1349,7 @@ static int zonefs_read_super(struct super_block *sb)
 	ret = 0;
 
 unmap:
-	kunmap(page);
+	kunmap_thread(page);
 free_page:
 	__free_page(page);
 
-- 
2.28.0.rc0.12.gb6a658bd00c9

