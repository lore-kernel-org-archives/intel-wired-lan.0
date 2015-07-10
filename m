From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Fri, 10 Jul 2015 19:36:10 -0400
Subject: [Intel-wired-lan] [intel-wired-lan][next PATCH S8 15/15]
	i40e/i40evf: Bump i40e to 1.3.9 and i40evf to 1.3.5
In-Reply-To: <1436571370-103673-1-git-send-email-catherine.sullivan@intel.com>
References: <1436571370-103673-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1436571370-103673-15-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Bump version and update the copyright year for i40evf.

Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
Change-ID: Iddb81b9dba09f0dc57ab54937b5821ecdd721ff6
---
 drivers/net/ethernet/intel/i40e/i40e_main.c     | 2 +-
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index ea3dbcd..3b21305 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -40,7 +40,7 @@ static const char i40e_driver_string[] =
 
 #define DRV_VERSION_MAJOR 1
 #define DRV_VERSION_MINOR 3
-#define DRV_VERSION_BUILD 6
+#define DRV_VERSION_BUILD 9
 #define DRV_VERSION __stringify(DRV_VERSION_MAJOR) "." \
 	     __stringify(DRV_VERSION_MINOR) "." \
 	     __stringify(DRV_VERSION_BUILD)    DRV_KERN
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 57e2224..ad42025 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -35,10 +35,10 @@ char i40evf_driver_name[] = "i40evf";
 static const char i40evf_driver_string[] =
 	"Intel(R) XL710/X710 Virtual Function Network Driver";
 
-#define DRV_VERSION "1.3.2"
+#define DRV_VERSION "1.3.5"
 const char i40evf_driver_version[] = DRV_VERSION;
 static const char i40evf_copyright[] =
-	"Copyright (c) 2013 - 2014 Intel Corporation.";
+	"Copyright (c) 2013 - 2015 Intel Corporation.";
 
 /* i40evf_pci_tbl - PCI Device ID Table
  *
-- 
1.9.3

