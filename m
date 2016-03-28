From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
Date: Mon, 28 Mar 2016 04:17:25 -0700
Subject: [Intel-wired-lan] [next PATCH S32 14/14] i40e/i40evf: Bump patch
	from 1.5.2 to 1.5.5
In-Reply-To: <1459163845-28035-1-git-send-email-harshitha.ramamurthy@intel.com>
References: <1459163845-28035-1-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <1459163845-28035-15-git-send-email-harshitha.ramamurthy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c     | 2 +-
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index b7dd9ae..79dd633 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -46,7 +46,7 @@ static const char i40e_driver_string[] =
 
 #define DRV_VERSION_MAJOR 1
 #define DRV_VERSION_MINOR 5
-#define DRV_VERSION_BUILD 2
+#define DRV_VERSION_BUILD 5
 #define DRV_VERSION __stringify(DRV_VERSION_MAJOR) "." \
 	     __stringify(DRV_VERSION_MINOR) "." \
 	     __stringify(DRV_VERSION_BUILD)    DRV_KERN
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 54aa24b..667e0eb 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -38,7 +38,7 @@ static const char i40evf_driver_string[] =
 
 #define DRV_VERSION_MAJOR 1
 #define DRV_VERSION_MINOR 5
-#define DRV_VERSION_BUILD 2
+#define DRV_VERSION_BUILD 5
 #define DRV_VERSION __stringify(DRV_VERSION_MAJOR) "." \
 	     __stringify(DRV_VERSION_MINOR) "." \
 	     __stringify(DRV_VERSION_BUILD) \
-- 
2.4.3

