From: ira.weiny@intel.com <ira.weiny@intel.com>
Date: Fri,  9 Oct 2020 12:50:21 -0700
Subject: [Intel-wired-lan] [PATCH RFC PKS/PMEM 46/58] drives/staging:
 Utilize new kmap_thread()
In-Reply-To: <20201009195033.3208459-1-ira.weiny@intel.com>
References: <20201009195033.3208459-1-ira.weiny@intel.com>
Message-ID: <20201009195033.3208459-47-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Ira Weiny <ira.weiny@intel.com>

These kmap() calls are localized to a single thread.  To avoid the over
head of global PKRS updates use the new kmap_thread() call.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/staging/rts5208/rtsx_transport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
index 0027bcf638ad..f747cc23951b 100644
--- a/drivers/staging/rts5208/rtsx_transport.c
+++ b/drivers/staging/rts5208/rtsx_transport.c
@@ -92,13 +92,13 @@ unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
 			while (sglen > 0) {
 				unsigned int plen = min(sglen, (unsigned int)
 						PAGE_SIZE - poff);
-				unsigned char *ptr = kmap(page);
+				unsigned char *ptr = kmap_thread(page);
 
 				if (dir == TO_XFER_BUF)
 					memcpy(ptr + poff, buffer + cnt, plen);
 				else
 					memcpy(buffer + cnt, ptr + poff, plen);
-				kunmap(page);
+				kunmap_thread(page);
 
 				/* Start at the beginning of the next page */
 				poff = 0;
-- 
2.28.0.rc0.12.gb6a658bd00c9

