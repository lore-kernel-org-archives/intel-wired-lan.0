From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Wed, 19 Sep 2018 17:43:08 -0700
Subject: [Intel-wired-lan] [PATCH v2 16/16] ice: Update version string
In-Reply-To: <20180920004308.13772-1-anirudh.venkataramanan@intel.com>
References: <20180920004308.13772-1-anirudh.venkataramanan@intel.com>
Message-ID: <20180920004308.13772-17-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Update version string to 0.7.2-k

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 959506ce597d..cd0389da7dfe 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -8,7 +8,7 @@
 #include "ice.h"
 #include "ice_lib.h"
 
-#define DRV_VERSION	"0.7.1-k"
+#define DRV_VERSION	"0.7.2-k"
 #define DRV_SUMMARY	"Intel(R) Ethernet Connection E800 Series Linux Driver"
 const char ice_drv_ver[] = DRV_VERSION;
 static const char ice_driver_string[] = DRV_SUMMARY;
-- 
2.14.3

