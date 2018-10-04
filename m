From: Alice Michael <alice.michael@intel.com>
Date: Thu,  4 Oct 2018 15:18:29 -0700
Subject: [Intel-wired-lan] [next PATCH S97 6/7] i40e: update driver version
In-Reply-To: <20181004221830.16212-1-alice.michael@intel.com>
References: <20181004221830.16212-1-alice.michael@intel.com>
Message-ID: <20181004221830.16212-6-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The version numbers have not been kept up to date and this is
an effort to ammend that.

Signed-off-by: Alice Michael <alice.michael@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index de82129..42d7404 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -26,8 +26,8 @@ static const char i40e_driver_string[] =
 #define DRV_KERN "-k"
 
 #define DRV_VERSION_MAJOR 2
-#define DRV_VERSION_MINOR 3
-#define DRV_VERSION_BUILD 2
+#define DRV_VERSION_MINOR 7
+#define DRV_VERSION_BUILD 6
 #define DRV_VERSION __stringify(DRV_VERSION_MAJOR) "." \
 	     __stringify(DRV_VERSION_MINOR) "." \
 	     __stringify(DRV_VERSION_BUILD)    DRV_KERN
-- 
2.9.5

