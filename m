From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
Date: Thu, 14 Apr 2016 06:19:29 -0700
Subject: [Intel-wired-lan] [next PATCH S35 09/14] i40e/i40evf: Rename
	version macro
In-Reply-To: <1460639974-2556-1-git-send-email-harshitha.ramamurthy@intel.com>
References: <1460639974-2556-1-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <1460639974-2556-10-git-send-email-harshitha.ramamurthy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Catherine Sullivan <catherine.sullivan@intel.com>

Change the '-k' version description macro to DRV_VERSION_DESC
to be more generic.

Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
Change-Id: I422bc6727b854f230217f04c61e750447435d183
---
 drivers/net/ethernet/intel/i40e/i40e_main.c     | 5 +++--
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 19a2d30..6308218 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -42,14 +42,15 @@ const char i40e_driver_name[] = "i40e";
 static const char i40e_driver_string[] =
 			"Intel(R) Ethernet Connection XL710 Network Driver";
 
-#define DRV_KERN "-k"
+#define DRV_VERSION_DESC "-k"
 
 #define DRV_VERSION_MAJOR 1
 #define DRV_VERSION_MINOR 5
 #define DRV_VERSION_BUILD 10
 #define DRV_VERSION __stringify(DRV_VERSION_MAJOR) "." \
 	     __stringify(DRV_VERSION_MINOR) "." \
-	     __stringify(DRV_VERSION_BUILD)    DRV_KERN
+	     __stringify(DRV_VERSION_BUILD)    \
+	     DRV_VERSION_DESC
 const char i40e_driver_version_str[] = DRV_VERSION;
 static const char i40e_copyright[] = "Copyright (c) 2013 - 2014 Intel Corporation.";
 
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 4c86687..1b8dc22 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -34,7 +34,7 @@ char i40evf_driver_name[] = "i40evf";
 static const char i40evf_driver_string[] =
 	"Intel(R) 40-10 Gigabit Virtual Function Network Driver";
 
-#define DRV_KERN "-k"
+#define DRV_VF_VERSION_DESC "-k"
 
 #define DRV_VERSION_MAJOR 1
 #define DRV_VERSION_MINOR 5
@@ -42,7 +42,7 @@ static const char i40evf_driver_string[] =
 #define DRV_VERSION __stringify(DRV_VERSION_MAJOR) "." \
 	     __stringify(DRV_VERSION_MINOR) "." \
 	     __stringify(DRV_VERSION_BUILD) \
-	     DRV_KERN
+			DRV_VF_VERSION_DESC
 const char i40evf_driver_version[] = DRV_VERSION;
 static const char i40evf_copyright[] =
 	"Copyright (c) 2013 - 2015 Intel Corporation.";
-- 
2.4.3

