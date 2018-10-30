From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 30 Oct 2018 10:50:46 -0700
Subject: [Intel-wired-lan] [next S97 v2 5/6] i40e: update driver version
In-Reply-To: <20181030175047.18874-1-jeffrey.t.kirsher@intel.com>
References: <20181030175047.18874-1-jeffrey.t.kirsher@intel.com>
Message-ID: <20181030175047.18874-5-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alice Michael <alice.michael@intel.com>

The version numbers have not been kept up to date and this is
an effort to ammend that.

Signed-off-by: Alice Michael <alice.michael@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index c14a1c5b1c21..61a99a8e9566 100644
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
2.17.2

