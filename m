From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 17 Jan 2020 07:39:19 -0800
Subject: [Intel-wired-lan] [PATCH S36 8/8] ice: Bump version
In-Reply-To: <20200117153919.50321-1-anthony.l.nguyen@intel.com>
References: <20200117153919.50321-1-anthony.l.nguyen@intel.com>
Message-ID: <20200117153919.50321-8-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Bump version to 0.8.2-k

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 121b245a0004..190ce8488dd9 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -13,7 +13,7 @@
 
 #define DRV_VERSION_MAJOR 0
 #define DRV_VERSION_MINOR 8
-#define DRV_VERSION_BUILD 1
+#define DRV_VERSION_BUILD 2
 
 #define DRV_VERSION	__stringify(DRV_VERSION_MAJOR) "." \
 			__stringify(DRV_VERSION_MINOR) "." \
-- 
2.20.1

