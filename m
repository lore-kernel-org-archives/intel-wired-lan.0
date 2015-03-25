From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 24 Mar 2015 21:30:25 -0700
Subject: [Intel-wired-lan] [next-queue S2 15/15] i40e: Bump to version 1.3.1
In-Reply-To: <1427257825-24519-1-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1427257825-24519-1-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <1427257825-24519-15-git-send-email-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Catherine Sullivan <catherine.sullivan@intel.com>

Bump.

Change-ID: I7dc88baa33264e5919bc938adf76706573209432
Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 89a2d76..63de3f4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -38,8 +38,8 @@ static const char i40e_driver_string[] =
 #define DRV_KERN "-k"
 
 #define DRV_VERSION_MAJOR 1
-#define DRV_VERSION_MINOR 2
-#define DRV_VERSION_BUILD 43
+#define DRV_VERSION_MINOR 3
+#define DRV_VERSION_BUILD 1
 #define DRV_VERSION __stringify(DRV_VERSION_MAJOR) "." \
 	     __stringify(DRV_VERSION_MINOR) "." \
 	     __stringify(DRV_VERSION_BUILD)    DRV_KERN
-- 
1.9.3

