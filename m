From: Joshua Hay <joshua.a.hay@intel.com>
Date: Thu, 10 Dec 2015 11:38:51 -0800
Subject: [Intel-wired-lan] [v2 next PATCH S23 13/13] i40e: bump version to
	1.4.10
In-Reply-To: <1449776331-8330-1-git-send-email-joshua.a.hay@intel.com>
References: <1449776331-8330-1-git-send-email-joshua.a.hay@intel.com>
Message-ID: <1449776331-8330-3-git-send-email-joshua.a.hay@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Catherine Sullivan <catherine.sullivan@intel.com>

Bump.

Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
Change-ID: Ic9a495feb9ab0606f953c3848b0acf67169d3930
---
V2: remove second change-id

Testing Hints: check version

 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index cc83332..fb58608 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -48,7 +48,7 @@ static const char i40e_driver_string[] =
 
 #define DRV_VERSION_MAJOR 1
 #define DRV_VERSION_MINOR 4
-#define DRV_VERSION_BUILD 8
+#define DRV_VERSION_BUILD 10
 #define DRV_VERSION __stringify(DRV_VERSION_MAJOR) "." \
 	     __stringify(DRV_VERSION_MINOR) "." \
 	     __stringify(DRV_VERSION_BUILD)    DRV_KERN
-- 
2.1.0

