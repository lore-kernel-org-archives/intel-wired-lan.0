From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Wed, 21 Oct 2015 19:56:24 -0400
Subject: [Intel-wired-lan] [next PATCH S19 15/15] i40e: Bump version to 1.4.2
In-Reply-To: <1445471784-36024-1-git-send-email-catherine.sullivan@intel.com>
References: <1445471784-36024-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1445471784-36024-3-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Bump.

Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
Change-ID: I2d1ce93b2ce74e4eef2394c932aef52cba99713f
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index cd6e278..97aded7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -38,8 +38,8 @@ static const char i40e_driver_string[] =
 #define DRV_KERN "-k"
 
 #define DRV_VERSION_MAJOR 1
-#define DRV_VERSION_MINOR 3
-#define DRV_VERSION_BUILD 46
+#define DRV_VERSION_MINOR 4
+#define DRV_VERSION_BUILD 2
 #define DRV_VERSION __stringify(DRV_VERSION_MAJOR) "." \
 	     __stringify(DRV_VERSION_MINOR) "." \
 	     __stringify(DRV_VERSION_BUILD)    DRV_KERN
-- 
1.9.3

