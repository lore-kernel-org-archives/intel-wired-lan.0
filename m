From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon,  9 Sep 2019 06:47:47 -0700
Subject: [Intel-wired-lan] [PATCH S29 v3 6/6] ice: Bump version
In-Reply-To: <20190909134747.10415-1-anthony.l.nguyen@intel.com>
References: <20190909134747.10415-1-anthony.l.nguyen@intel.com>
Message-ID: <20190909134747.10415-6-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Bump version to 0.8.1-k

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index a9efc918c625..214cd6eca405 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -10,8 +10,8 @@
 #include "ice_dcb_lib.h"
 
 #define DRV_VERSION_MAJOR 0
-#define DRV_VERSION_MINOR 7
-#define DRV_VERSION_BUILD 5
+#define DRV_VERSION_MINOR 8
+#define DRV_VERSION_BUILD 1
 
 #define DRV_VERSION	__stringify(DRV_VERSION_MAJOR) "." \
 			__stringify(DRV_VERSION_MINOR) "." \
-- 
2.20.1

