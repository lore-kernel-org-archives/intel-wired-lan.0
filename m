From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 13 Sep 2018 15:31:35 -0700
Subject: [Intel-wired-lan] [RFC PATCH net-next v1 05/14] iavf: move i40evf
 files to new name
In-Reply-To: <20180913223144.75823-1-jesse.brandeburg@intel.com>
References: <20180913223144.75823-1-jesse.brandeburg@intel.com>
Message-ID: <20180913223144.75823-6-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Simply move the i40evf files to the new name, updating the #includes
to track the new names, and updating the Makefile as well.

A future patch will remove the i40e references (after the code
removal patches later in this series).

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
v3: renamed more files after review comments
---
 drivers/net/ethernet/intel/iavf/Makefile                              | 4 ++--
 drivers/net/ethernet/intel/iavf/{i40evf.h => iavf.h}                  | 2 +-
 drivers/net/ethernet/intel/iavf/{i40evf_client.c => iavf_client.c}    | 4 ++--
 drivers/net/ethernet/intel/iavf/{i40evf_client.h => iavf_client.h}    | 0
 drivers/net/ethernet/intel/iavf/{i40evf_ethtool.c => iavf_ethtool.c}  | 2 +-
 drivers/net/ethernet/intel/iavf/{i40evf_main.c => iavf_main.c}        | 4 ++--
 drivers/net/ethernet/intel/iavf/{i40e_txrx.c => iavf_txrx.c}          | 2 +-
 drivers/net/ethernet/intel/iavf/{i40e_txrx.h => iavf_txrx.h}          | 0
 .../net/ethernet/intel/iavf/{i40evf_virtchnl.c => iavf_virtchnl.c}    | 4 ++--
 9 files changed, 11 insertions(+), 11 deletions(-)
 rename drivers/net/ethernet/intel/iavf/{i40evf.h => iavf.h} (99%)
 rename drivers/net/ethernet/intel/iavf/{i40evf_client.c => iavf_client.c} (99%)
 rename drivers/net/ethernet/intel/iavf/{i40evf_client.h => iavf_client.h} (100%)
 rename drivers/net/ethernet/intel/iavf/{i40evf_ethtool.c => iavf_ethtool.c} (99%)
 rename drivers/net/ethernet/intel/iavf/{i40evf_main.c => iavf_main.c} (99%)
 rename drivers/net/ethernet/intel/iavf/{i40e_txrx.c => iavf_txrx.c} (99%)
 rename drivers/net/ethernet/intel/iavf/{i40e_txrx.h => iavf_txrx.h} (100%)
 rename drivers/net/ethernet/intel/iavf/{i40evf_virtchnl.c => iavf_virtchnl.c} (99%)

diff --git a/drivers/net/ethernet/intel/iavf/Makefile b/drivers/net/ethernet/intel/iavf/Makefile
index ce2dce1e1ebf..fa4c43be2266 100644
--- a/drivers/net/ethernet/intel/iavf/Makefile
+++ b/drivers/net/ethernet/intel/iavf/Makefile
@@ -11,5 +11,5 @@ subdir-ccflags-y += -I$(src)
 
 obj-$(CONFIG_IAVF) += iavf.o
 
-iavf-objs := i40evf_main.o i40evf_ethtool.o i40evf_virtchnl.o \
-		 i40e_txrx.o i40e_common.o i40e_adminq.o i40evf_client.o
+iavf-objs := iavf_main.o iavf_ethtool.o iavf_virtchnl.o \
+		 iavf_txrx.o i40e_common.o i40e_adminq.o iavf_client.o
diff --git a/drivers/net/ethernet/intel/iavf/i40evf.h b/drivers/net/ethernet/intel/iavf/iavf.h
similarity index 99%
rename from drivers/net/ethernet/intel/iavf/i40evf.h
rename to drivers/net/ethernet/intel/iavf/iavf.h
index 19a93bfdb65c..c7ce2db958b0 100644
--- a/drivers/net/ethernet/intel/iavf/i40evf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -36,7 +36,7 @@
 
 #include "i40e_type.h"
 #include <linux/avf/virtchnl.h>
-#include "i40e_txrx.h"
+#include "iavf_txrx.h"
 
 #define DEFAULT_DEBUG_LEVEL_SHIFT 3
 #define PFX "iavf: "
diff --git a/drivers/net/ethernet/intel/iavf/i40evf_client.c b/drivers/net/ethernet/intel/iavf/iavf_client.c
similarity index 99%
rename from drivers/net/ethernet/intel/iavf/i40evf_client.c
rename to drivers/net/ethernet/intel/iavf/iavf_client.c
index d2660659174d..16971bfc5e43 100644
--- a/drivers/net/ethernet/intel/iavf/i40evf_client.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_client.c
@@ -4,9 +4,9 @@
 #include <linux/list.h>
 #include <linux/errno.h>
 
-#include "i40evf.h"
+#include "iavf.h"
 #include "i40e_prototype.h"
-#include "i40evf_client.h"
+#include "iavf_client.h"
 
 static
 const char iavf_client_interface_version_str[] = IAVF_CLIENT_VERSION_STR;
diff --git a/drivers/net/ethernet/intel/iavf/i40evf_client.h b/drivers/net/ethernet/intel/iavf/iavf_client.h
similarity index 100%
rename from drivers/net/ethernet/intel/iavf/i40evf_client.h
rename to drivers/net/ethernet/intel/iavf/iavf_client.h
diff --git a/drivers/net/ethernet/intel/iavf/i40evf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
similarity index 99%
rename from drivers/net/ethernet/intel/iavf/i40evf_ethtool.c
rename to drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index 0277df40e53f..74a142802074 100644
--- a/drivers/net/ethernet/intel/iavf/i40evf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -2,7 +2,7 @@
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
 /* ethtool support for iavf */
-#include "i40evf.h"
+#include "iavf.h"
 
 #include <linux/uaccess.h>
 
diff --git a/drivers/net/ethernet/intel/iavf/i40evf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
similarity index 99%
rename from drivers/net/ethernet/intel/iavf/i40evf_main.c
rename to drivers/net/ethernet/intel/iavf/iavf_main.c
index 600ea4040af2..7d815ace2d98 100644
--- a/drivers/net/ethernet/intel/iavf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
-#include "i40evf.h"
+#include "iavf.h"
 #include "i40e_prototype.h"
-#include "i40evf_client.h"
+#include "iavf_client.h"
 /* All iavf tracepoints are defined by the include below, which must
  * be included exactly once across the whole kernel with
  * CREATE_TRACE_POINTS defined
diff --git a/drivers/net/ethernet/intel/iavf/i40e_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
similarity index 99%
rename from drivers/net/ethernet/intel/iavf/i40e_txrx.c
rename to drivers/net/ethernet/intel/iavf/iavf_txrx.c
index 28892a6e730c..d288694a6c83 100644
--- a/drivers/net/ethernet/intel/iavf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -4,7 +4,7 @@
 #include <linux/prefetch.h>
 #include <net/busy_poll.h>
 
-#include "i40evf.h"
+#include "iavf.h"
 #include "i40e_trace.h"
 #include "i40e_prototype.h"
 
diff --git a/drivers/net/ethernet/intel/iavf/i40e_txrx.h b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
similarity index 100%
rename from drivers/net/ethernet/intel/iavf/i40e_txrx.h
rename to drivers/net/ethernet/intel/iavf/iavf_txrx.h
diff --git a/drivers/net/ethernet/intel/iavf/i40evf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
similarity index 99%
rename from drivers/net/ethernet/intel/iavf/i40evf_virtchnl.c
rename to drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 6a2bc501658c..720fe010dbbd 100644
--- a/drivers/net/ethernet/intel/iavf/i40evf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
-#include "i40evf.h"
+#include "iavf.h"
 #include "i40e_prototype.h"
-#include "i40evf_client.h"
+#include "iavf_client.h"
 
 /* busy wait delay in msec */
 #define IAVF_BUSY_WAIT_DELAY 10
-- 
2.14.4

