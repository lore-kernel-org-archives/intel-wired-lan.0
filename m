From: Deepthi Kavalur <deepthi.kavalur@intel.com>
Date: Fri, 13 Nov 2015 16:55:22 -0800
Subject: [Intel-wired-lan] [next PATCH S22 13/14] i40evf: change version
	string generation
Message-ID: <1447462522-5407-1-git-send-email-deepthi.kavalur@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

Generate version strings like the PF driver does. This gives us more
flexibility to add suffixes to the version string at build time.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I0a5ca0783dd8fb849516bfc1e37ea070127847bd
---
V2: Only description change in the above section. No code change.

 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 451c5f0..2d03d02 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -34,7 +34,15 @@ char i40evf_driver_name[] = "i40evf";
 static const char i40evf_driver_string[] =
 	"Intel(R) XL710/X710 Virtual Function Network Driver";
 
-#define DRV_VERSION "1.4.1"
+#define DRV_KERN "-k"
+
+#define DRV_VERSION_MAJOR 1
+#define DRV_VERSION_MINOR 4
+#define DRV_VERSION_BUILD 1
+#define DRV_VERSION __stringify(DRV_VERSION_MAJOR) "." \
+	     __stringify(DRV_VERSION_MINOR) "." \
+	     __stringify(DRV_VERSION_BUILD) \
+	     DRV_KERN
 const char i40evf_driver_version[] = DRV_VERSION;
 static const char i40evf_copyright[] =
 	"Copyright (c) 2013 - 2015 Intel Corporation.";
-- 
2.1.0

