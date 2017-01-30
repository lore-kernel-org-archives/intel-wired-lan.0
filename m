From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 30 Jan 2017 12:29:37 -0800
Subject: [Intel-wired-lan] [next PATCH S59 6/6] i40e/i40evf: Change version
	from 1.6.27 to 2.1.7
In-Reply-To: <1485808177-6333-1-git-send-email-bimmy.pujari@intel.com>
References: <1485808177-6333-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1485808177-6333-7-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Bimmy Pujari <bimmy.pujari@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c     | 6 +++---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 736746b..840f04b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -40,9 +40,9 @@ static const char i40e_driver_string[] =
 
 #define DRV_KERN "-k"
 
-#define DRV_VERSION_MAJOR 1
-#define DRV_VERSION_MINOR 6
-#define DRV_VERSION_BUILD 27
+#define DRV_VERSION_MAJOR 2
+#define DRV_VERSION_MINOR 1
+#define DRV_VERSION_BUILD 7
 #define DRV_VERSION __stringify(DRV_VERSION_MAJOR) "." \
 	     __stringify(DRV_VERSION_MINOR) "." \
 	     __stringify(DRV_VERSION_BUILD)    DRV_KERN
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 9492b20..6d666bd 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -37,9 +37,9 @@ static const char i40evf_driver_string[] =
 
 #define DRV_KERN "-k"
 
-#define DRV_VERSION_MAJOR 1
-#define DRV_VERSION_MINOR 6
-#define DRV_VERSION_BUILD 27
+#define DRV_VERSION_MAJOR 2
+#define DRV_VERSION_MINOR 1
+#define DRV_VERSION_BUILD 7
 #define DRV_VERSION __stringify(DRV_VERSION_MAJOR) "." \
 	     __stringify(DRV_VERSION_MINOR) "." \
 	     __stringify(DRV_VERSION_BUILD) \
-- 
2.4.11

