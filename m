From: Alice Michael <alice.michael@intel.com>
Date: Wed, 17 Apr 2019 15:17:29 -0700
Subject: [Intel-wired-lan] [next PATCH S4 iavf 1/9] iavf: Rename
 i40e_adminq* files to iavf_adminq*
Message-ID: <20190417221737.11460-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

With the rename of the iavf driver, there were some
files that were missed in renaming.  Update these to
be iavf as well.

Signed-off-by: Alice Michael <alice.michael@intel.com>
---
 drivers/net/ethernet/intel/iavf/Makefile                        | 2 +-
 .../net/ethernet/intel/iavf/{i40e_adminq.c => iavf_adminq.c}    | 2 +-
 .../net/ethernet/intel/iavf/{i40e_adminq.h => iavf_adminq.h}    | 2 +-
 .../intel/iavf/{i40e_adminq_cmd.h => iavf_adminq_cmd.h}         | 0
 drivers/net/ethernet/intel/iavf/iavf_common.c                   | 2 +-
 drivers/net/ethernet/intel/iavf/iavf_type.h                     | 2 +-
 6 files changed, 5 insertions(+), 5 deletions(-)
 rename drivers/net/ethernet/intel/iavf/{i40e_adminq.c => iavf_adminq.c} (99%)
 rename drivers/net/ethernet/intel/iavf/{i40e_adminq.h => iavf_adminq.h} (99%)
 rename drivers/net/ethernet/intel/iavf/{i40e_adminq_cmd.h => iavf_adminq_cmd.h} (100%)

diff --git a/drivers/net/ethernet/intel/iavf/Makefile b/drivers/net/ethernet/intel/iavf/Makefile
index 9cbb5743ed12..c997063ed728 100644
--- a/drivers/net/ethernet/intel/iavf/Makefile
+++ b/drivers/net/ethernet/intel/iavf/Makefile
@@ -12,4 +12,4 @@ subdir-ccflags-y += -I$(src)
 obj-$(CONFIG_IAVF) += iavf.o
 
 iavf-objs := iavf_main.o iavf_ethtool.o iavf_virtchnl.o \
-	     iavf_txrx.o iavf_common.o i40e_adminq.o iavf_client.o
+	     iavf_txrx.o iavf_common.o iavf_adminq.o iavf_client.o
diff --git a/drivers/net/ethernet/intel/iavf/i40e_adminq.c b/drivers/net/ethernet/intel/iavf/iavf_adminq.c
similarity index 99%
rename from drivers/net/ethernet/intel/iavf/i40e_adminq.c
rename to drivers/net/ethernet/intel/iavf/iavf_adminq.c
index fca1ecfd9f71..04b44614ec38 100644
--- a/drivers/net/ethernet/intel/iavf/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_adminq.c
@@ -4,7 +4,7 @@
 #include "iavf_status.h"
 #include "iavf_type.h"
 #include "iavf_register.h"
-#include "i40e_adminq.h"
+#include "iavf_adminq.h"
 #include "iavf_prototype.h"
 
 /**
diff --git a/drivers/net/ethernet/intel/iavf/i40e_adminq.h b/drivers/net/ethernet/intel/iavf/iavf_adminq.h
similarity index 99%
rename from drivers/net/ethernet/intel/iavf/i40e_adminq.h
rename to drivers/net/ethernet/intel/iavf/iavf_adminq.h
index ee983889eab0..7c06752c0fea 100644
--- a/drivers/net/ethernet/intel/iavf/i40e_adminq.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_adminq.h
@@ -6,7 +6,7 @@
 
 #include "iavf_osdep.h"
 #include "iavf_status.h"
-#include "i40e_adminq_cmd.h"
+#include "iavf_adminq_cmd.h"
 
 #define IAVF_ADMINQ_DESC(R, i)   \
 	(&(((struct i40e_aq_desc *)((R).desc_buf.va))[i]))
diff --git a/drivers/net/ethernet/intel/iavf/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/iavf/iavf_adminq_cmd.h
similarity index 100%
rename from drivers/net/ethernet/intel/iavf/i40e_adminq_cmd.h
rename to drivers/net/ethernet/intel/iavf/iavf_adminq_cmd.h
diff --git a/drivers/net/ethernet/intel/iavf/iavf_common.c b/drivers/net/ethernet/intel/iavf/iavf_common.c
index 768369c89e77..d9d9f6060353 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_common.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_common.c
@@ -2,7 +2,7 @@
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
 #include "iavf_type.h"
-#include "i40e_adminq.h"
+#include "iavf_adminq.h"
 #include "iavf_prototype.h"
 #include <linux/avf/virtchnl.h>
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf_type.h b/drivers/net/ethernet/intel/iavf/iavf_type.h
index ca89583613fb..58b3efd1ed04 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_type.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_type.h
@@ -7,7 +7,7 @@
 #include "iavf_status.h"
 #include "iavf_osdep.h"
 #include "iavf_register.h"
-#include "i40e_adminq.h"
+#include "iavf_adminq.h"
 #include "iavf_devids.h"
 
 #define IAVF_RXQ_CTX_DBUFF_SHIFT 7
-- 
2.19.2

