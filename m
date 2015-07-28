From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 28 Jul 2015 20:26:01 +0000
Subject: [Intel-wired-lan] [next PATCH S9 15/15] i40e/i40evf: Bump i40e
 to	1.3.12 and i40evf to 1.3.6
In-Reply-To: <1437684884-222825-16-git-send-email-catherine.sullivan@intel.com>
References: <1437684884-222825-1-git-send-email-catherine.sullivan@intel.com>
 <1437684884-222825-16-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A016BE459@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Verified-by: Andrew Bowers <Andrewx.bowers@intel.com>
Present  in git log, code changes present in tree, drivers report correct versions through modinfo.

-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Catherine Sullivan
Sent: Thursday, July 23, 2015 1:55 PM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [next PATCH S9 15/15] i40e/i40evf: Bump i40e to 1.3.12 and i40evf to 1.3.6

Bump.

Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
Change-ID: Iaf6c969d620704b374584ff82d09922a4d57b025
---
 drivers/net/ethernet/intel/i40e/i40e_main.c     | 2 +-
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 1681e7f..aef0a4c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -40,7 +40,7 @@ static const char i40e_driver_string[] =
 
 #define DRV_VERSION_MAJOR 1
 #define DRV_VERSION_MINOR 3
-#define DRV_VERSION_BUILD 9
+#define DRV_VERSION_BUILD 12
 #define DRV_VERSION __stringify(DRV_VERSION_MAJOR) "." \
 	     __stringify(DRV_VERSION_MINOR) "." \
 	     __stringify(DRV_VERSION_BUILD)    DRV_KERN
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 588cacf..177fd47 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -35,7 +35,7 @@ char i40evf_driver_name[] = "i40evf";  static const char i40evf_driver_string[] =
 	"Intel(R) XL710/X710 Virtual Function Network Driver";
 
-#define DRV_VERSION "1.3.5"
+#define DRV_VERSION "1.3.6"
 const char i40evf_driver_version[] = DRV_VERSION;  static const char i40evf_copyright[] =
 	"Copyright (c) 2013 - 2015 Intel Corporation.";
--
1.9.3

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at lists.osuosl.org
http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
