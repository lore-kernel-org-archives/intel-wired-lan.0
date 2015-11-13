From: Deepthi Kavalur <deepthi.kavalur@intel.com>
Date: Fri, 13 Nov 2015 15:47:14 -0800
Subject: [Intel-wired-lan] [next PATCH S22 14/14] i40e/i40evf: Bump version
	to 1.4.7 for i40e and 1.4.3 for i40evf
In-Reply-To: <1447458434-4555-1-git-send-email-deepthi.kavalur@intel.com>
References: <1447458434-4555-1-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <1447458434-4555-15-git-send-email-deepthi.kavalur@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Catherine Sullivan <catherine.sullivan@intel.com>

Bump.

Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
Change-ID: Id8c83c64c973349a722bab40d285ad8ded8c28f7
---
 drivers/net/ethernet/intel/i40e/i40e_main.c     | 2 +-
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index e8b5821..c22167b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -39,7 +39,7 @@ static const char i40e_driver_string[] =
 
 #define DRV_VERSION_MAJOR 1
 #define DRV_VERSION_MINOR 4
-#define DRV_VERSION_BUILD 4
+#define DRV_VERSION_BUILD 7
 #define DRV_VERSION __stringify(DRV_VERSION_MAJOR) "." \
 	     __stringify(DRV_VERSION_MINOR) "." \
 	     __stringify(DRV_VERSION_BUILD)    DRV_KERN
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 2d03d02..debabd3 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -38,7 +38,7 @@ static const char i40evf_driver_string[] =
 
 #define DRV_VERSION_MAJOR 1
 #define DRV_VERSION_MINOR 4
-#define DRV_VERSION_BUILD 1
+#define DRV_VERSION_BUILD 3
 #define DRV_VERSION __stringify(DRV_VERSION_MAJOR) "." \
 	     __stringify(DRV_VERSION_MINOR) "." \
 	     __stringify(DRV_VERSION_BUILD) \
-- 
2.1.0

