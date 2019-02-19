From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 19 Feb 2019 15:04:14 -0800
Subject: [Intel-wired-lan] [PATCH S15 14/14] ice: Bump version
In-Reply-To: <20190219230414.25627-1-anirudh.venkataramanan@intel.com>
References: <20190219230414.25627-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190219230414.25627-15-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Bump driver version to 0.7.3

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 3bed4359886e..68150c81464b 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -8,7 +8,7 @@
 #include "ice.h"
 #include "ice_lib.h"
 
-#define DRV_VERSION	"0.7.2-k"
+#define DRV_VERSION	"0.7.3-k"
 #define DRV_SUMMARY	"Intel(R) Ethernet Connection E800 Series Linux Driver"
 const char ice_drv_ver[] = DRV_VERSION;
 static const char ice_driver_string[] = DRV_SUMMARY;
-- 
2.14.5

