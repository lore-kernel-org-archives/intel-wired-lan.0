From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue,  3 May 2016 15:13:20 -0700
Subject: [Intel-wired-lan] [next PATCH S36 12/12] i40e: Bump version from
	1.5.10 to 1.5.16
In-Reply-To: <1462313600-3123-1-git-send-email-bimmy.pujari@intel.com>
References: <1462313600-3123-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1462313600-3123-13-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Bimmy Pujari <bimmy.pujari@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index e75bf94..d091c76 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -46,7 +46,7 @@ static const char i40e_driver_string[] =
 
 #define DRV_VERSION_MAJOR 1
 #define DRV_VERSION_MINOR 5
-#define DRV_VERSION_BUILD 10
+#define DRV_VERSION_BUILD 16
 #define DRV_VERSION __stringify(DRV_VERSION_MAJOR) "." \
 	     __stringify(DRV_VERSION_MINOR) "." \
 	     __stringify(DRV_VERSION_BUILD)    DRV_KERN
-- 
2.4.11

