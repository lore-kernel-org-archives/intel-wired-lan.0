From: ira.weiny@intel.com <ira.weiny@intel.com>
Date: Fri,  9 Oct 2020 12:50:24 -0700
Subject: [Intel-wired-lan] [PATCH RFC PKS/PMEM 49/58] drivers/misc: Utilize
 new kmap_thread()
In-Reply-To: <20201009195033.3208459-1-ira.weiny@intel.com>
References: <20201009195033.3208459-1-ira.weiny@intel.com>
Message-ID: <20201009195033.3208459-50-ira.weiny@intel.com>
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
 drivers/misc/vmw_vmci/vmci_queue_pair.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_queue_pair.c b/drivers/misc/vmw_vmci/vmci_queue_pair.c
index 8531ae781195..f308abb8ad03 100644
--- a/drivers/misc/vmw_vmci/vmci_queue_pair.c
+++ b/drivers/misc/vmw_vmci/vmci_queue_pair.c
@@ -343,7 +343,7 @@ static int qp_memcpy_to_queue_iter(struct vmci_queue *queue,
 		size_t to_copy;
 
 		if (kernel_if->host)
-			va = kmap(kernel_if->u.h.page[page_index]);
+			va = kmap_thread(kernel_if->u.h.page[page_index]);
 		else
 			va = kernel_if->u.g.vas[page_index + 1];
 			/* Skip header. */
@@ -357,12 +357,12 @@ static int qp_memcpy_to_queue_iter(struct vmci_queue *queue,
 		if (!copy_from_iter_full((u8 *)va + page_offset, to_copy,
 					 from)) {
 			if (kernel_if->host)
-				kunmap(kernel_if->u.h.page[page_index]);
+				kunmap_thread(kernel_if->u.h.page[page_index]);
 			return VMCI_ERROR_INVALID_ARGS;
 		}
 		bytes_copied += to_copy;
 		if (kernel_if->host)
-			kunmap(kernel_if->u.h.page[page_index]);
+			kunmap_thread(kernel_if->u.h.page[page_index]);
 	}
 
 	return VMCI_SUCCESS;
@@ -391,7 +391,7 @@ static int qp_memcpy_from_queue_iter(struct iov_iter *to,
 		int err;
 
 		if (kernel_if->host)
-			va = kmap(kernel_if->u.h.page[page_index]);
+			va = kmap_thread(kernel_if->u.h.page[page_index]);
 		else
 			va = kernel_if->u.g.vas[page_index + 1];
 			/* Skip header. */
@@ -405,12 +405,12 @@ static int qp_memcpy_from_queue_iter(struct iov_iter *to,
 		err = copy_to_iter((u8 *)va + page_offset, to_copy, to);
 		if (err != to_copy) {
 			if (kernel_if->host)
-				kunmap(kernel_if->u.h.page[page_index]);
+				kunmap_thread(kernel_if->u.h.page[page_index]);
 			return VMCI_ERROR_INVALID_ARGS;
 		}
 		bytes_copied += to_copy;
 		if (kernel_if->host)
-			kunmap(kernel_if->u.h.page[page_index]);
+			kunmap_thread(kernel_if->u.h.page[page_index]);
 	}
 
 	return VMCI_SUCCESS;
-- 
2.28.0.rc0.12.gb6a658bd00c9

