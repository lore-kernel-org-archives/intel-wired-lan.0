From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Thu, 28 Feb 2019 15:24:32 -0800
Subject: [Intel-wired-lan] [PATCH S16 11/11] ice: Bump driver version
In-Reply-To: <20190228232432.31659-1-anirudh.venkataramanan@intel.com>
References: <20190228232432.31659-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190228232432.31659-12-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Update driver version to 0.7.4

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index fba4eb086578..94105f0a0b48 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -9,7 +9,7 @@
 #include "ice_lib.h"
 #include "ice_dcb_lib.h"
 
-#define DRV_VERSION	"0.7.3-k"
+#define DRV_VERSION	"0.7.4-k"
 #define DRV_SUMMARY	"Intel(R) Ethernet Connection E800 Series Linux Driver"
 const char ice_drv_ver[] = DRV_VERSION;
 static const char ice_driver_string[] = DRV_SUMMARY;
-- 
2.14.5

