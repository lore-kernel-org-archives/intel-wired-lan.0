From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 11 May 2017 11:23:09 -0700
Subject: [Intel-wired-lan] [PATCH net-next v3 02/14] i40e/i40evf: create and
	use new unified header file
In-Reply-To: <20170511182321.147850-1-jesse.brandeburg@intel.com>
References: <20170511182321.147850-1-jesse.brandeburg@intel.com>
Message-ID: <20170511182321.147850-3-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This moves a header for i40evf to include/linux/avf/virtchnl.h.
The directory name avf is an acronym for the Intel(R) Adaptive
Virtual Function.

This first step creates the new file, which is a rename of
drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h to
include/linux/avf/virtchnl.h, and should show up in git
as a rename when using git log --follow.

To keep things building after the move, the changes to the i40evf
driver are made to point to the new include file location.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

 delete mode 100644 drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h
 create mode 100644 include/linux/avf/virtchnl.h
---
 MAINTAINERS                                                             | 1 +
 drivers/net/ethernet/intel/i40evf/i40e_common.c                         | 2 +-
 drivers/net/ethernet/intel/i40evf/i40e_prototype.h                      | 2 +-
 drivers/net/ethernet/intel/i40evf/i40evf.h                              | 2 +-
 .../intel/i40evf/i40e_virtchnl.h => include/linux/avf/virtchnl.h        | 0
 5 files changed, 4 insertions(+), 3 deletions(-)
 rename drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h => include/linux/avf/virtchnl.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 45b173a..2a5abf9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6673,6 +6673,7 @@ F:	Documentation/networking/i40e.txt
 F:	Documentation/networking/i40evf.txt
 F:	drivers/net/ethernet/intel/
 F:	drivers/net/ethernet/intel/*/
+F:	include/linux/avf/virtchnl.h
 
 INTEL RDMA RNIC DRIVER
 M:     Faisal Latif <faisal.latif@intel.com>
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_common.c b/drivers/net/ethernet/intel/i40evf/i40e_common.c
index 6729624..1db028a 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_common.c
@@ -27,7 +27,7 @@
 #include "i40e_type.h"
 #include "i40e_adminq.h"
 #include "i40e_prototype.h"
-#include "i40e_virtchnl.h"
+#include <linux/avf/virtchnl.h>
 
 /**
  * i40e_set_mac_type - Sets MAC type
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_prototype.h b/drivers/net/ethernet/intel/i40evf/i40e_prototype.h
index 741223d..227905b 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_prototype.h
@@ -29,7 +29,7 @@
 
 #include "i40e_type.h"
 #include "i40e_alloc.h"
-#include "i40e_virtchnl.h"
+#include <linux/avf/virtchnl.h>
 
 /* Prototypes for shared code functions that are not in
  * the standard function pointer structures.  These are
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf.h b/drivers/net/ethernet/intel/i40evf/i40evf.h
index b8ada6d..75d314b 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf.h
+++ b/drivers/net/ethernet/intel/i40evf/i40evf.h
@@ -43,7 +43,7 @@
 #include <net/udp.h>
 
 #include "i40e_type.h"
-#include "i40e_virtchnl.h"
+#include <linux/avf/virtchnl.h>
 #include "i40e_txrx.h"
 
 #define DEFAULT_DEBUG_LEVEL_SHIFT 3
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h b/include/linux/avf/virtchnl.h
similarity index 100%
rename from drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h
rename to include/linux/avf/virtchnl.h
-- 
2.9.3

