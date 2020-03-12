From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 11 Mar 2020 18:27:24 -0700
Subject: [Intel-wired-lan] [PATCH v2 7/9] devlink: promote "fw.bundle_id" to
 a generic info version
In-Reply-To: <20200312012726.973301-1-jacob.e.keller@intel.com>
References: <20200312012726.973301-1-jacob.e.keller@intel.com>
Message-ID: <20200312012726.973301-8-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The nfp driver uses ``fw.bundle_id`` to represent a unique identifier of the
entire firmware bundle.

A future change is going to introduce a similar notion in the ice
driver, so promote ``fw.bundle_id`` into a generic version now.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 Documentation/networking/devlink/devlink-info.rst | 5 +++++
 drivers/net/ethernet/netronome/nfp/nfp_devlink.c  | 2 +-
 include/net/devlink.h                             | 2 ++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/devlink/devlink-info.rst b/Documentation/networking/devlink/devlink-info.rst
index 70981dd1b981..b701899b7f42 100644
--- a/Documentation/networking/devlink/devlink-info.rst
+++ b/Documentation/networking/devlink/devlink-info.rst
@@ -98,3 +98,8 @@ fw.roce
 
 RoCE firmware version which is responsible for handling roce
 management.
+
+fw.bundle_id
+------------
+
+Unique identifier of the entire firmware bundle.
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_devlink.c b/drivers/net/ethernet/netronome/nfp/nfp_devlink.c
index c50fce42f473..07dbf4d72227 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_devlink.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_devlink.c
@@ -211,7 +211,7 @@ static const struct nfp_devlink_versions {
 	enum nfp_nsp_versions id;
 	const char *key;
 } nfp_devlink_versions_nsp[] = {
-	{ NFP_VERSIONS_BUNDLE,	"fw.bundle_id", },
+	{ NFP_VERSIONS_BUNDLE,	DEVLINK_INFO_VERSION_GENERIC_FW_BUNDLE_ID, },
 	{ NFP_VERSIONS_BSP,	DEVLINK_INFO_VERSION_GENERIC_FW_MGMT, },
 	{ NFP_VERSIONS_CPLD,	"fw.cpld", },
 	{ NFP_VERSIONS_APP,	DEVLINK_INFO_VERSION_GENERIC_FW_APP, },
diff --git a/include/net/devlink.h b/include/net/devlink.h
index c9ca86b054bc..e68781b9b7d4 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -490,6 +490,8 @@ enum devlink_param_generic_id {
 #define DEVLINK_INFO_VERSION_GENERIC_FW_PSID	"fw.psid"
 /* RoCE FW version */
 #define DEVLINK_INFO_VERSION_GENERIC_FW_ROCE	"fw.roce"
+/* Firmware bundle identifier */
+#define DEVLINK_INFO_VERSION_GENERIC_FW_BUNDLE_ID	"fw.bundle_id"
 
 struct devlink_region;
 struct devlink_info_req;
-- 
2.24.1

