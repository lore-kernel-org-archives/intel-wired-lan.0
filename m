From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Fri, 14 Sep 2018 17:37:56 -0700
Subject: [Intel-wired-lan] [PATCH net-next v2 13/14] iavf: finish renaming
 files to iavf
In-Reply-To: <20180915003757.169108-1-jesse.brandeburg@intel.com>
References: <20180915003757.169108-1-jesse.brandeburg@intel.com>
Message-ID: <20180915003757.169108-14-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This finishes the process of renaming the files that
make sense to rename (skipping adminq related files that
talk to i40e), and fixes up the build and the #includes
so that everything builds nicely.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/iavf/Makefile                          | 2 +-
 drivers/net/ethernet/intel/iavf/i40e_adminq.c                     | 8 ++++----
 drivers/net/ethernet/intel/iavf/i40e_adminq.h                     | 4 ++--
 drivers/net/ethernet/intel/iavf/iavf.h                            | 4 ++--
 drivers/net/ethernet/intel/iavf/{i40e_alloc.h => iavf_alloc.h}    | 0
 drivers/net/ethernet/intel/iavf/iavf_client.c                     | 2 +-
 drivers/net/ethernet/intel/iavf/{i40e_common.c => iavf_common.c}  | 4 ++--
 drivers/net/ethernet/intel/iavf/{i40e_devids.h => iavf_devids.h}  | 0
 drivers/net/ethernet/intel/iavf/iavf_main.c                       | 2 +-
 drivers/net/ethernet/intel/iavf/{i40e_osdep.h => iavf_osdep.h}    | 0
 .../ethernet/intel/iavf/{i40e_prototype.h => iavf_prototype.h}    | 4 ++--
 .../net/ethernet/intel/iavf/{i40e_register.h => iavf_register.h}  | 0
 drivers/net/ethernet/intel/iavf/{i40e_status.h => iavf_status.h}  | 0
 drivers/net/ethernet/intel/iavf/iavf_txrx.c                       | 2 +-
 drivers/net/ethernet/intel/iavf/{i40e_type.h => iavf_type.h}      | 8 ++++----
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c                   | 2 +-
 16 files changed, 21 insertions(+), 21 deletions(-)
 rename drivers/net/ethernet/intel/iavf/{i40e_alloc.h => iavf_alloc.h} (100%)
 rename drivers/net/ethernet/intel/iavf/{i40e_common.c => iavf_common.c} (99%)
 rename drivers/net/ethernet/intel/iavf/{i40e_devids.h => iavf_devids.h} (100%)
 rename drivers/net/ethernet/intel/iavf/{i40e_osdep.h => iavf_osdep.h} (100%)
 rename drivers/net/ethernet/intel/iavf/{i40e_prototype.h => iavf_prototype.h} (98%)
 rename drivers/net/ethernet/intel/iavf/{i40e_register.h => iavf_register.h} (100%)
 rename drivers/net/ethernet/intel/iavf/{i40e_status.h => iavf_status.h} (100%)
 rename drivers/net/ethernet/intel/iavf/{i40e_type.h => iavf_type.h} (99%)

diff --git a/drivers/net/ethernet/intel/iavf/Makefile b/drivers/net/ethernet/intel/iavf/Makefile
index fa4c43be2266..87ddfbac2f17 100644
--- a/drivers/net/ethernet/intel/iavf/Makefile
+++ b/drivers/net/ethernet/intel/iavf/Makefile
@@ -12,4 +12,4 @@ subdir-ccflags-y += -I$(src)
 obj-$(CONFIG_IAVF) += iavf.o
 
 iavf-objs := iavf_main.o iavf_ethtool.o iavf_virtchnl.o \
-		 iavf_txrx.o i40e_common.o i40e_adminq.o iavf_client.o
+		 iavf_txrx.o iavf_common.o i40e_adminq.o iavf_client.o
diff --git a/drivers/net/ethernet/intel/iavf/i40e_adminq.c b/drivers/net/ethernet/intel/iavf/i40e_adminq.c
index 8aa817808cd5..d2b165b610fa 100644
--- a/drivers/net/ethernet/intel/iavf/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/iavf/i40e_adminq.c
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
-#include "i40e_status.h"
-#include "i40e_type.h"
-#include "i40e_register.h"
+#include "iavf_status.h"
+#include "iavf_type.h"
+#include "iavf_register.h"
 #include "i40e_adminq.h"
-#include "i40e_prototype.h"
+#include "iavf_prototype.h"
 
 /**
  *  i40e_adminq_init_regs - Initialize AdminQ registers
diff --git a/drivers/net/ethernet/intel/iavf/i40e_adminq.h b/drivers/net/ethernet/intel/iavf/i40e_adminq.h
index e34625e25589..ee983889eab0 100644
--- a/drivers/net/ethernet/intel/iavf/i40e_adminq.h
+++ b/drivers/net/ethernet/intel/iavf/i40e_adminq.h
@@ -4,8 +4,8 @@
 #ifndef _IAVF_ADMINQ_H_
 #define _IAVF_ADMINQ_H_
 
-#include "i40e_osdep.h"
-#include "i40e_status.h"
+#include "iavf_osdep.h"
+#include "iavf_status.h"
 #include "i40e_adminq_cmd.h"
 
 #define IAVF_ADMINQ_DESC(R, i)   \
diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 1d973b4cd973..961c1a71b671 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -34,7 +34,7 @@
 #include <net/tc_act/tc_gact.h>
 #include <net/tc_act/tc_mirred.h>
 
-#include "i40e_type.h"
+#include "iavf_type.h"
 #include <linux/avf/virtchnl.h>
 #include "iavf_txrx.h"
 
@@ -298,7 +298,7 @@ struct iavf_adapter {
 	struct net_device *netdev;
 	struct pci_dev *pdev;
 
-	struct iavf_hw hw; /* defined in i40e_type.h */
+	struct iavf_hw hw; /* defined in iavf_type.h */
 
 	enum iavf_state_t state;
 	unsigned long crit_section;
diff --git a/drivers/net/ethernet/intel/iavf/i40e_alloc.h b/drivers/net/ethernet/intel/iavf/iavf_alloc.h
similarity index 100%
rename from drivers/net/ethernet/intel/iavf/i40e_alloc.h
rename to drivers/net/ethernet/intel/iavf/iavf_alloc.h
diff --git a/drivers/net/ethernet/intel/iavf/iavf_client.c b/drivers/net/ethernet/intel/iavf/iavf_client.c
index f4c195a4167a..a0bfa6b9555e 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_client.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_client.c
@@ -5,7 +5,7 @@
 #include <linux/errno.h>
 
 #include "iavf.h"
-#include "i40e_prototype.h"
+#include "iavf_prototype.h"
 #include "iavf_client.h"
 
 static
diff --git a/drivers/net/ethernet/intel/iavf/i40e_common.c b/drivers/net/ethernet/intel/iavf/iavf_common.c
similarity index 99%
rename from drivers/net/ethernet/intel/iavf/i40e_common.c
rename to drivers/net/ethernet/intel/iavf/iavf_common.c
index d9fd2f24b3e7..768369c89e77 100644
--- a/drivers/net/ethernet/intel/iavf/i40e_common.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_common.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
-#include "i40e_type.h"
+#include "iavf_type.h"
 #include "i40e_adminq.h"
-#include "i40e_prototype.h"
+#include "iavf_prototype.h"
 #include <linux/avf/virtchnl.h>
 
 /**
diff --git a/drivers/net/ethernet/intel/iavf/i40e_devids.h b/drivers/net/ethernet/intel/iavf/iavf_devids.h
similarity index 100%
rename from drivers/net/ethernet/intel/iavf/i40e_devids.h
rename to drivers/net/ethernet/intel/iavf/iavf_devids.h
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 74b547634f48..54d8a1ed05ac 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -2,7 +2,7 @@
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
 #include "iavf.h"
-#include "i40e_prototype.h"
+#include "iavf_prototype.h"
 #include "iavf_client.h"
 /* All iavf tracepoints are defined by the include below, which must
  * be included exactly once across the whole kernel with
diff --git a/drivers/net/ethernet/intel/iavf/i40e_osdep.h b/drivers/net/ethernet/intel/iavf/iavf_osdep.h
similarity index 100%
rename from drivers/net/ethernet/intel/iavf/i40e_osdep.h
rename to drivers/net/ethernet/intel/iavf/iavf_osdep.h
diff --git a/drivers/net/ethernet/intel/iavf/i40e_prototype.h b/drivers/net/ethernet/intel/iavf/iavf_prototype.h
similarity index 98%
rename from drivers/net/ethernet/intel/iavf/i40e_prototype.h
rename to drivers/net/ethernet/intel/iavf/iavf_prototype.h
index dca62e3b951f..a0cd43b7a368 100644
--- a/drivers/net/ethernet/intel/iavf/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_prototype.h
@@ -4,8 +4,8 @@
 #ifndef _IAVF_PROTOTYPE_H_
 #define _IAVF_PROTOTYPE_H_
 
-#include "i40e_type.h"
-#include "i40e_alloc.h"
+#include "iavf_type.h"
+#include "iavf_alloc.h"
 #include <linux/avf/virtchnl.h>
 
 /* Prototypes for shared code functions that are not in
diff --git a/drivers/net/ethernet/intel/iavf/i40e_register.h b/drivers/net/ethernet/intel/iavf/iavf_register.h
similarity index 100%
rename from drivers/net/ethernet/intel/iavf/i40e_register.h
rename to drivers/net/ethernet/intel/iavf/iavf_register.h
diff --git a/drivers/net/ethernet/intel/iavf/i40e_status.h b/drivers/net/ethernet/intel/iavf/iavf_status.h
similarity index 100%
rename from drivers/net/ethernet/intel/iavf/i40e_status.h
rename to drivers/net/ethernet/intel/iavf/iavf_status.h
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index 517c37a44026..add3188ccedf 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -6,7 +6,7 @@
 
 #include "iavf.h"
 #include "iavf_trace.h"
-#include "i40e_prototype.h"
+#include "iavf_prototype.h"
 
 static inline __le64 build_ctob(u32 td_cmd, u32 td_offset, unsigned int size,
 				u32 td_tag)
diff --git a/drivers/net/ethernet/intel/iavf/i40e_type.h b/drivers/net/ethernet/intel/iavf/iavf_type.h
similarity index 99%
rename from drivers/net/ethernet/intel/iavf/i40e_type.h
rename to drivers/net/ethernet/intel/iavf/iavf_type.h
index 6a917dbfb981..f0c8cf981b92 100644
--- a/drivers/net/ethernet/intel/iavf/i40e_type.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_type.h
@@ -4,11 +4,11 @@
 #ifndef _IAVF_TYPE_H_
 #define _IAVF_TYPE_H_
 
-#include "i40e_status.h"
-#include "i40e_osdep.h"
-#include "i40e_register.h"
+#include "iavf_status.h"
+#include "iavf_osdep.h"
+#include "iavf_register.h"
 #include "i40e_adminq.h"
-#include "i40e_devids.h"
+#include "iavf_devids.h"
 
 #define IAVF_RXQ_CTX_DBUFF_SHIFT 7
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 8622d7781fd7..fa5be220a7ec 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -2,7 +2,7 @@
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
 #include "iavf.h"
-#include "i40e_prototype.h"
+#include "iavf_prototype.h"
 #include "iavf_client.h"
 
 /* busy wait delay in msec */
-- 
2.14.4

