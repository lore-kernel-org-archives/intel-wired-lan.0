From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Date: Thu, 28 May 2020 12:43:32 -0700
Subject: [Intel-wired-lan] [PATCH 04/14] virtual-bus: add comment for
 virtbus entry
In-Reply-To: <20200528194342.3495-1-ranjani.sridharan@linux.intel.com>
References: <20200528194342.3495-1-ranjani.sridharan@linux.intel.com>
Message-ID: <20200528194342.3495-5-ranjani.sridharan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 scripts/mod/file2alias.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index fd3908ed922d..929fc152e404 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -1361,6 +1361,7 @@ static int do_mhi_entry(const char *filename, void *symval, char *alias)
 	return 1;
 }
 
+/* Looks like: virtbus:S */
 static int do_virtbus_entry(const char *filename, void *symval, char *alias)
 {
 	DEF_FIELD_ADDR(symval, virtbus_device_id, name);
-- 
2.17.1

