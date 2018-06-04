From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Mon,  4 Jun 2018 14:05:51 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next 01/11] xsk: moved struct xdp_umem
 definition
In-Reply-To: <20180604120601.18123-1-bjorn.topel@gmail.com>
References: <20180604120601.18123-1-bjorn.topel@gmail.com>
Message-ID: <20180604120601.18123-2-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bj?rn T?pel <bjorn.topel@intel.com>

Moved struct xdp_umem to xdp_sock.h, in order to prepare for zero-copy
support.

Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
---
 include/net/xdp_sock.h | 24 +++++++++++++++++++++++-
 net/xdp/xdp_umem.c     |  1 +
 net/xdp/xdp_umem.h     | 22 +---------------------
 net/xdp/xsk_queue.h    |  3 +--
 4 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 7a647c56ec15..3a6cd88f179d 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -6,12 +6,34 @@
 #ifndef _LINUX_XDP_SOCK_H
 #define _LINUX_XDP_SOCK_H
 
+#include <linux/workqueue.h>
+#include <linux/if_xdp.h>
 #include <linux/mutex.h>
+#include <linux/mm.h>
 #include <net/sock.h>
 
 struct net_device;
 struct xsk_queue;
-struct xdp_umem;
+
+struct xdp_umem_props {
+	u64 chunk_mask;
+	u64 size;
+};
+
+struct xdp_umem {
+	struct xsk_queue *fq;
+	struct xsk_queue *cq;
+	struct page **pgs;
+	struct xdp_umem_props props;
+	u32 headroom;
+	u32 chunk_size_nohr;
+	struct user_struct *user;
+	struct pid *pid;
+	unsigned long address;
+	refcount_t users;
+	struct work_struct work;
+	u32 npgs;
+};
 
 struct xdp_sock {
 	/* struct sock must be the first member of struct xdp_sock */
diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
index 9ad791ff4739..2793a503223e 100644
--- a/net/xdp/xdp_umem.c
+++ b/net/xdp/xdp_umem.c
@@ -13,6 +13,7 @@
 #include <linux/mm.h>
 
 #include "xdp_umem.h"
+#include "xsk_queue.h"
 
 #define XDP_UMEM_MIN_CHUNK_SIZE 2048
 
diff --git a/net/xdp/xdp_umem.h b/net/xdp/xdp_umem.h
index aeadd1bcb72d..9433e8af650a 100644
--- a/net/xdp/xdp_umem.h
+++ b/net/xdp/xdp_umem.h
@@ -6,27 +6,7 @@
 #ifndef XDP_UMEM_H_
 #define XDP_UMEM_H_
 
-#include <linux/mm.h>
-#include <linux/if_xdp.h>
-#include <linux/workqueue.h>
-
-#include "xsk_queue.h"
-#include "xdp_umem_props.h"
-
-struct xdp_umem {
-	struct xsk_queue *fq;
-	struct xsk_queue *cq;
-	struct page **pgs;
-	struct xdp_umem_props props;
-	u32 headroom;
-	u32 chunk_size_nohr;
-	struct user_struct *user;
-	struct pid *pid;
-	unsigned long address;
-	refcount_t users;
-	struct work_struct work;
-	u32 npgs;
-};
+#include <net/xdp_sock.h>
 
 static inline char *xdp_umem_get_data(struct xdp_umem *umem, u64 addr)
 {
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 337e5ad3b10e..5246ed420a16 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -8,8 +8,7 @@
 
 #include <linux/types.h>
 #include <linux/if_xdp.h>
-
-#include "xdp_umem_props.h"
+#include <net/xdp_sock.h>
 
 #define RX_BATCH_SIZE 16
 
-- 
2.14.1

