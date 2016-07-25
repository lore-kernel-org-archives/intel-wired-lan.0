From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 25 Jul 2016 16:15:55 -0700
Subject: [Intel-wired-lan] [next PATCH S40 13/13] i40e/i40evf-Bump version
	from 1.6.11 to 1.6.12
In-Reply-To: <1469488555-28187-1-git-send-email-bimmy.pujari@intel.com>
References: <1469488555-28187-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1469488555-28187-14-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Bimmy Pujari <Bimmy.pujari@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c     | 2 +-
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index a33e902..d90ad77 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -41,7 +41,7 @@ static const char i40e_driver_string[] =
 
 #define DRV_VERSION_MAJOR 1
 #define DRV_VERSION_MINOR 6
-#define DRV_VERSION_BUILD 11
+#define DRV_VERSION_BUILD 12
 #define DRV_VERSION __stringify(DRV_VERSION_MAJOR) "." \
 	     __stringify(DRV_VERSION_MINOR) "." \
 	     __stringify(DRV_VERSION_BUILD)    DRV_KERN
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index eaadeef..24f88ec 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -38,7 +38,7 @@ static const char i40evf_driver_string[] =
 
 #define DRV_VERSION_MAJOR 1
 #define DRV_VERSION_MINOR 6
-#define DRV_VERSION_BUILD 11
+#define DRV_VERSION_BUILD 12
 #define DRV_VERSION __stringify(DRV_VERSION_MAJOR) "." \
 	     __stringify(DRV_VERSION_MINOR) "." \
 	     __stringify(DRV_VERSION_BUILD) \
-- 
2.4.11

