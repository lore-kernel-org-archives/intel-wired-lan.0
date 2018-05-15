From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Tue, 15 May 2018 21:06:05 +0200
Subject: [Intel-wired-lan] [RFC PATCH bpf-next 02/12] xsk: moved struct
 xdp_umem definition
In-Reply-To: <20180515190615.23099-1-bjorn.topel@gmail.com>
References: <20180515190615.23099-1-bjorn.topel@gmail.com>
Message-ID: <20180515190615.23099-3-bjorn.topel@gmail.com>
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
 include/net/xdp_sock.h   | 27 ++++++++++++++++++++++++++-
 net/xdp/xdp_umem.c       |  1 +
 net/xdp/xdp_umem.h       | 25 +------------------------
 net/xdp/xdp_umem_props.h | 23 -----------------------
 net/xdp/xsk_queue.h      |  3 +--
 5 files changed, 29 insertions(+), 50 deletions(-)
 delete mode 100644 net/xdp/xdp_umem_props.h

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 185f4928fbda..c959aa43fb01 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -15,12 +15,37 @@
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
+	u32 frame_size;
+	u32 nframes;
+};
+
+struct xdp_umem {
+	struct xsk_queue *fq;
+	struct xsk_queue *cq;
+	struct page **pgs;
+	struct xdp_umem_props props;
+	u32 npgs;
+	u32 frame_headroom;
+	u32 nfpp_mask;
+	u32 nfpplog2;
+	u32 frame_size_log2;
+	struct user_struct *user;
+	struct pid *pid;
+	unsigned long address;
+	size_t size;
+	atomic_t users;
+	struct work_struct work;
+};
 
 struct xdp_sock {
 	/* struct sock must be the first member of struct xdp_sock */
diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
index 2b47a1dd7c6c..7cc162799744 100644
--- a/net/xdp/xdp_umem.c
+++ b/net/xdp/xdp_umem.c
@@ -22,6 +22,7 @@
 #include <linux/mm.h>
 
 #include "xdp_umem.h"
+#include "xsk_queue.h"
 
 #define XDP_UMEM_MIN_FRAME_SIZE 2048
 
diff --git a/net/xdp/xdp_umem.h b/net/xdp/xdp_umem.h
index 7e0b2fab8522..32ad59b7322f 100644
--- a/net/xdp/xdp_umem.h
+++ b/net/xdp/xdp_umem.h
@@ -15,30 +15,7 @@
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
-	u32 npgs;
-	u32 frame_headroom;
-	u32 nfpp_mask;
-	u32 nfpplog2;
-	u32 frame_size_log2;
-	struct user_struct *user;
-	struct pid *pid;
-	unsigned long address;
-	size_t size;
-	atomic_t users;
-	struct work_struct work;
-};
+#include <net/xdp_sock.h>
 
 static inline char *xdp_umem_get_data(struct xdp_umem *umem, u32 idx)
 {
diff --git a/net/xdp/xdp_umem_props.h b/net/xdp/xdp_umem_props.h
deleted file mode 100644
index 77fb5daf29f3..000000000000
--- a/net/xdp/xdp_umem_props.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0
- * XDP user-space packet buffer
- * Copyright(c) 2018 Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- */
-
-#ifndef XDP_UMEM_PROPS_H_
-#define XDP_UMEM_PROPS_H_
-
-struct xdp_umem_props {
-	u32 frame_size;
-	u32 nframes;
-};
-
-#endif /* XDP_UMEM_PROPS_H_ */
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 7aa9a535db0e..599a8d43c69a 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -17,8 +17,7 @@
 
 #include <linux/types.h>
 #include <linux/if_xdp.h>
-
-#include "xdp_umem_props.h"
+#include <net/xdp_sock.h>
 
 #define RX_BATCH_SIZE 16
 
-- 
2.14.1

