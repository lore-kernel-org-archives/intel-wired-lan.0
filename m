From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 19 Aug 2020 14:58:37 -0700
Subject: [Intel-wired-lan] [PATCH 2/3] ice: add the DDP Track ID to devlink
 info
In-Reply-To: <20200819215838.3834786-1-jacob.e.keller@intel.com>
References: <20200819215838.3834786-1-jacob.e.keller@intel.com>
Message-ID: <20200819215838.3834786-3-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add "fw.app.bundle_id" to display the DDP Track ID of the active DDP
package. This id is similar to "fw.bundle_id" and is a unique identifier
for the DDP package that is loaded in the device. Each new DDP has
a unique Track ID generated for it, and the ID can be used to identify
and track the DDP package.

Add documentation for the new devlink info version.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 Documentation/networking/devlink/ice.rst     | 5 +++++
 drivers/net/ethernet/intel/ice/ice_devlink.c | 8 ++++++++
 2 files changed, 13 insertions(+)

diff --git a/Documentation/networking/devlink/ice.rst b/Documentation/networking/devlink/ice.rst
index 237848d56f9b..aca5c009c0aa 100644
--- a/Documentation/networking/devlink/ice.rst
+++ b/Documentation/networking/devlink/ice.rst
@@ -69,6 +69,11 @@ The ``ice`` driver reports the following versions
       - The version of the DDP package that is active in the device. Note
         that both the name (as reported by ``fw.app.name``) and version are
         required to uniquely identify the package.
+    * - ``fw.app.bundle_id``
+      - 0xc0000001
+      - Unique identifier for the DDP package loaded in the device. Also
+        referred to as the DDP Track ID. Can be used to uniquely identify
+        the specific DDP package.
     * - ``fw.netlist``
       - running
       - 1.1.2000-6.7.0
diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
index d8ccf177190e..e1ec724c38c3 100644
--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
@@ -102,6 +102,13 @@ static int ice_info_ddp_pkg_version(struct ice_pf *pf, char *buf, size_t len)
 	return 0;
 }
 
+static int ice_info_ddp_pkg_bundle_id(struct ice_pf *pf, char *buf, size_t len)
+{
+	snprintf(buf, len, "0x%08x", pf->hw.active_track_id);
+
+	return 0;
+}
+
 static int ice_info_netlist_ver(struct ice_pf *pf, char *buf, size_t len)
 {
 	struct ice_netlist_ver_info *netlist = &pf->hw.netlist_ver;
@@ -146,6 +153,7 @@ static const struct ice_devlink_version {
 	running(DEVLINK_INFO_VERSION_GENERIC_FW_BUNDLE_ID, ice_info_eetrack),
 	running("fw.app.name", ice_info_ddp_pkg_name),
 	running(DEVLINK_INFO_VERSION_GENERIC_FW_APP, ice_info_ddp_pkg_version),
+	running("fw.app.bundle_id", ice_info_ddp_pkg_bundle_id),
 	running("fw.netlist", ice_info_netlist_ver),
 	running("fw.netlist.build", ice_info_netlist_build),
 };
-- 
2.28.0.218.ge27853923b9d.dirty

