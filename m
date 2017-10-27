From: Alice Michael <alice.michael@intel.com>
Date: Fri, 27 Oct 2017 11:06:56 -0400
Subject: [Intel-wired-lan] [next PATCH S81-V3 9/9] i40e/i40evf: Bump driver
	versions
In-Reply-To: <20171027150656.68250-1-alice.michael@intel.com>
References: <20171027150656.68250-1-alice.michael@intel.com>
Message-ID: <20171027150656.68250-9-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Bump the i40e driver from 2.1.14 to 2.3.2.

Bump the i40evf driver from 3.0.1 to 3.2.2

Signed-off-by: Alice Michael <alice.michael@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c     | 4 ++--
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 5b1bd3c..70ba48a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -47,8 +47,8 @@ static const char i40e_driver_string[] =
 #define DRV_KERN "-k"
 
 #define DRV_VERSION_MAJOR 2
-#define DRV_VERSION_MINOR 1
-#define DRV_VERSION_BUILD 14
+#define DRV_VERSION_MINOR 3
+#define DRV_VERSION_BUILD 2
 #define DRV_VERSION __stringify(DRV_VERSION_MAJOR) "." \
 	     __stringify(DRV_VERSION_MINOR) "." \
 	     __stringify(DRV_VERSION_BUILD)    DRV_KERN
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 45cff72..75dc94f 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -45,8 +45,8 @@ static const char i40evf_driver_string[] =
 #define DRV_KERN "-k"
 
 #define DRV_VERSION_MAJOR 3
-#define DRV_VERSION_MINOR 0
-#define DRV_VERSION_BUILD 1
+#define DRV_VERSION_MINOR 2
+#define DRV_VERSION_BUILD 2
 #define DRV_VERSION __stringify(DRV_VERSION_MAJOR) "." \
 	     __stringify(DRV_VERSION_MINOR) "." \
 	     __stringify(DRV_VERSION_BUILD) \
-- 
2.9.5

