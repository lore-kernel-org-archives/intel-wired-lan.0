From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 15 Jun 2021 13:14:20 -0700
Subject: [Intel-wired-lan] [PATCH net] ice: do not abort devlink info if PBA
 can't be found
Message-ID: <20210615201420.2001937-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The devlink dev info command reports version information about the
device and firmware running on the board. This includes the "board.id"
field which is supposed to represent an identifier of the board design.
The ice driver uses the Product Board Assembly identifier for this.

In some cases, the PBA is not present in the NVM. If this happens,
devlink dev info will fail with an error. Instead, modify the
ice_info_pba function to just exit without filling in the context
buffer. This will cause the board.id field to be skipped. Log a dev_dbg
message in case someone wants to confirm why board.id is not showing up
for them.

While at it, notice that none of the getter/fallback() functions report
an error anymore. Convert the interface to a void so that it is no
longer possible to add a version field that is fatal. This makes sense,
because we should not fail to report other versions just because one of
the version pieces could not be found.

Finally, clean up the getter functions line wrapping so that none of
them take more than 80 columns, as is the usual style for networking
files.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_devlink.c | 137 +++++++------------
 1 file changed, 53 insertions(+), 84 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
index cf685eeea198..ba6d375d696f 100644
--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
@@ -22,7 +22,7 @@ struct ice_info_ctx {
  *
  * If a version does not exist, for example when attempting to get the
  * inactive version of flash when there is no pending update, the function
- * should leave the buffer in the ctx structure empty and return 0.
+ * should leave the buffer in the ctx structure empty.
  */
 
 static void ice_info_get_dsn(struct ice_pf *pf, struct ice_info_ctx *ctx)
@@ -35,156 +35,137 @@ static void ice_info_get_dsn(struct ice_pf *pf, struct ice_info_ctx *ctx)
 	snprintf(ctx->buf, sizeof(ctx->buf), "%8phD", dsn);
 }
 
-static int ice_info_pba(struct ice_pf *pf, struct ice_info_ctx *ctx)
+static void ice_info_pba(struct ice_pf *pf, struct ice_info_ctx *ctx)
 {
 	struct ice_hw *hw = &pf->hw;
 	enum ice_status status;
 
 	status = ice_read_pba_string(hw, (u8 *)ctx->buf, sizeof(ctx->buf));
 	if (status)
-		return -EIO;
-
-	return 0;
+		/* We failed to locate the PBA, so just skip this entry */
+		dev_dbg(ice_pf_to_dev(pf), "Failed to read Product Board Assembly string, status %s\n",
+			ice_stat_str(status));
 }
 
-static int ice_info_fw_mgmt(struct ice_pf *pf, struct ice_info_ctx *ctx)
+static void ice_info_fw_mgmt(struct ice_pf *pf, struct ice_info_ctx *ctx)
 {
 	struct ice_hw *hw = &pf->hw;
 
-	snprintf(ctx->buf, sizeof(ctx->buf), "%u.%u.%u", hw->fw_maj_ver, hw->fw_min_ver,
-		 hw->fw_patch);
-
-	return 0;
+	snprintf(ctx->buf, sizeof(ctx->buf), "%u.%u.%u",
+		 hw->fw_maj_ver, hw->fw_min_ver, hw->fw_patch);
 }
 
-static int ice_info_fw_api(struct ice_pf *pf, struct ice_info_ctx *ctx)
+static void ice_info_fw_api(struct ice_pf *pf, struct ice_info_ctx *ctx)
 {
 	struct ice_hw *hw = &pf->hw;
 
-	snprintf(ctx->buf, sizeof(ctx->buf), "%u.%u", hw->api_maj_ver, hw->api_min_ver);
-
-	return 0;
+	snprintf(ctx->buf, sizeof(ctx->buf), "%u.%u",
+		 hw->api_maj_ver, hw->api_min_ver);
 }
 
-static int ice_info_fw_build(struct ice_pf *pf, struct ice_info_ctx *ctx)
+static void ice_info_fw_build(struct ice_pf *pf, struct ice_info_ctx *ctx)
 {
 	struct ice_hw *hw = &pf->hw;
 
 	snprintf(ctx->buf, sizeof(ctx->buf), "0x%08x", hw->fw_build);
-
-	return 0;
 }
 
-static int ice_info_orom_ver(struct ice_pf *pf, struct ice_info_ctx *ctx)
+static void ice_info_orom_ver(struct ice_pf *pf, struct ice_info_ctx *ctx)
 {
 	struct ice_orom_info *orom = &pf->hw.flash.orom;
 
-	snprintf(ctx->buf, sizeof(ctx->buf), "%u.%u.%u", orom->major, orom->build, orom->patch);
-
-	return 0;
+	snprintf(ctx->buf, sizeof(ctx->buf), "%u.%u.%u",
+		 orom->major, orom->build, orom->patch);
 }
 
-static int
-ice_info_pending_orom_ver(struct ice_pf __always_unused *pf, struct ice_info_ctx *ctx)
+static void
+ice_info_pending_orom_ver(struct ice_pf __always_unused *pf,
+			  struct ice_info_ctx *ctx)
 {
 	struct ice_orom_info *orom = &ctx->pending_orom;
 
 	if (ctx->dev_caps.common_cap.nvm_update_pending_orom)
 		snprintf(ctx->buf, sizeof(ctx->buf), "%u.%u.%u",
 			 orom->major, orom->build, orom->patch);
-
-	return 0;
 }
 
-static int ice_info_nvm_ver(struct ice_pf *pf, struct ice_info_ctx *ctx)
+static void ice_info_nvm_ver(struct ice_pf *pf, struct ice_info_ctx *ctx)
 {
 	struct ice_nvm_info *nvm = &pf->hw.flash.nvm;
 
 	snprintf(ctx->buf, sizeof(ctx->buf), "%x.%02x", nvm->major, nvm->minor);
-
-	return 0;
 }
 
-static int
-ice_info_pending_nvm_ver(struct ice_pf __always_unused *pf, struct ice_info_ctx *ctx)
+static void
+ice_info_pending_nvm_ver(struct ice_pf __always_unused *pf,
+			 struct ice_info_ctx *ctx)
 {
 	struct ice_nvm_info *nvm = &ctx->pending_nvm;
 
 	if (ctx->dev_caps.common_cap.nvm_update_pending_nvm)
-		snprintf(ctx->buf, sizeof(ctx->buf), "%x.%02x", nvm->major, nvm->minor);
-
-	return 0;
+		snprintf(ctx->buf, sizeof(ctx->buf), "%x.%02x",
+			 nvm->major, nvm->minor);
 }
 
-static int ice_info_eetrack(struct ice_pf *pf, struct ice_info_ctx *ctx)
+static void ice_info_eetrack(struct ice_pf *pf, struct ice_info_ctx *ctx)
 {
 	struct ice_nvm_info *nvm = &pf->hw.flash.nvm;
 
 	snprintf(ctx->buf, sizeof(ctx->buf), "0x%08x", nvm->eetrack);
-
-	return 0;
 }
 
-static int
-ice_info_pending_eetrack(struct ice_pf __always_unused *pf, struct ice_info_ctx *ctx)
+static void
+ice_info_pending_eetrack(struct ice_pf *pf, struct ice_info_ctx *ctx)
 {
 	struct ice_nvm_info *nvm = &ctx->pending_nvm;
 
 	if (ctx->dev_caps.common_cap.nvm_update_pending_nvm)
 		snprintf(ctx->buf, sizeof(ctx->buf), "0x%08x", nvm->eetrack);
-
-	return 0;
 }
 
-static int ice_info_ddp_pkg_name(struct ice_pf *pf, struct ice_info_ctx *ctx)
+static void ice_info_ddp_pkg_name(struct ice_pf *pf, struct ice_info_ctx *ctx)
 {
 	struct ice_hw *hw = &pf->hw;
 
 	snprintf(ctx->buf, sizeof(ctx->buf), "%s", hw->active_pkg_name);
-
-	return 0;
 }
 
-static int ice_info_ddp_pkg_version(struct ice_pf *pf, struct ice_info_ctx *ctx)
+static void
+ice_info_ddp_pkg_version(struct ice_pf *pf, struct ice_info_ctx *ctx)
 {
 	struct ice_pkg_ver *pkg = &pf->hw.active_pkg_ver;
 
-	snprintf(ctx->buf, sizeof(ctx->buf), "%u.%u.%u.%u", pkg->major, pkg->minor, pkg->update,
-		 pkg->draft);
-
-	return 0;
+	snprintf(ctx->buf, sizeof(ctx->buf), "%u.%u.%u.%u",
+		 pkg->major, pkg->minor, pkg->update, pkg->draft);
 }
 
-static int ice_info_ddp_pkg_bundle_id(struct ice_pf *pf, struct ice_info_ctx *ctx)
+static void
+ice_info_ddp_pkg_bundle_id(struct ice_pf *pf, struct ice_info_ctx *ctx)
 {
 	snprintf(ctx->buf, sizeof(ctx->buf), "0x%08x", pf->hw.active_track_id);
-
-	return 0;
 }
 
-static int ice_info_netlist_ver(struct ice_pf *pf, struct ice_info_ctx *ctx)
+static void ice_info_netlist_ver(struct ice_pf *pf, struct ice_info_ctx *ctx)
 {
 	struct ice_netlist_info *netlist = &pf->hw.flash.netlist;
 
 	/* The netlist version fields are BCD formatted */
-	snprintf(ctx->buf, sizeof(ctx->buf), "%x.%x.%x-%x.%x.%x", netlist->major, netlist->minor,
-		 netlist->type >> 16, netlist->type & 0xFFFF, netlist->rev,
-		 netlist->cust_ver);
-
-	return 0;
+	snprintf(ctx->buf, sizeof(ctx->buf), "%x.%x.%x-%x.%x.%x",
+		 netlist->major, netlist->minor,
+		 netlist->type >> 16, netlist->type & 0xFFFF,
+		 netlist->rev, netlist->cust_ver);
 }
 
-static int ice_info_netlist_build(struct ice_pf *pf, struct ice_info_ctx *ctx)
+static void ice_info_netlist_build(struct ice_pf *pf, struct ice_info_ctx *ctx)
 {
 	struct ice_netlist_info *netlist = &pf->hw.flash.netlist;
 
 	snprintf(ctx->buf, sizeof(ctx->buf), "0x%08x", netlist->hash);
-
-	return 0;
 }
 
-static int
-ice_info_pending_netlist_ver(struct ice_pf __always_unused *pf, struct ice_info_ctx *ctx)
+static void
+ice_info_pending_netlist_ver(struct ice_pf __always_unused *pf,
+			     struct ice_info_ctx *ctx)
 {
 	struct ice_netlist_info *netlist = &ctx->pending_netlist;
 
@@ -192,21 +173,18 @@ ice_info_pending_netlist_ver(struct ice_pf __always_unused *pf, struct ice_info_
 	if (ctx->dev_caps.common_cap.nvm_update_pending_netlist)
 		snprintf(ctx->buf, sizeof(ctx->buf), "%x.%x.%x-%x.%x.%x",
 			 netlist->major, netlist->minor,
-			 netlist->type >> 16, netlist->type & 0xFFFF, netlist->rev,
-			 netlist->cust_ver);
-
-	return 0;
+			 netlist->type >> 16, netlist->type & 0xFFFF,
+			 netlist->rev, netlist->cust_ver);
 }
 
-static int
-ice_info_pending_netlist_build(struct ice_pf __always_unused *pf, struct ice_info_ctx *ctx)
+static void
+ice_info_pending_netlist_build(struct ice_pf __always_unused *pf,
+			       struct ice_info_ctx *ctx)
 {
 	struct ice_netlist_info *netlist = &ctx->pending_netlist;
 
 	if (ctx->dev_caps.common_cap.nvm_update_pending_netlist)
 		snprintf(ctx->buf, sizeof(ctx->buf), "0x%08x", netlist->hash);
-
-	return 0;
 }
 
 #define fixed(key, getter) { ICE_VERSION_FIXED, key, getter, NULL }
@@ -236,8 +214,8 @@ enum ice_version_type {
 static const struct ice_devlink_version {
 	enum ice_version_type type;
 	const char *key;
-	int (*getter)(struct ice_pf *pf, struct ice_info_ctx *ctx);
-	int (*fallback)(struct ice_pf *pf, struct ice_info_ctx *ctx);
+	void (*getter)(struct ice_pf *pf, struct ice_info_ctx *ctx);
+	void (*fallback)(struct ice_pf *pf, struct ice_info_ctx *ctx);
 } ice_devlink_versions[] = {
 	fixed(DEVLINK_INFO_VERSION_GENERIC_BOARD_ID, ice_info_pba),
 	running(DEVLINK_INFO_VERSION_GENERIC_FW_MGMT, ice_info_fw_mgmt),
@@ -340,24 +318,15 @@ static int ice_devlink_info_get(struct devlink *devlink,
 
 		memset(ctx->buf, 0, sizeof(ctx->buf));
 
-		err = ice_devlink_versions[i].getter(pf, ctx);
-		if (err) {
-			NL_SET_ERR_MSG_MOD(extack, "Unable to obtain version info");
-			goto out_free_ctx;
-		}
+		ice_devlink_versions[i].getter(pf, ctx);
 
 		/* If the default getter doesn't report a version, use the
 		 * fallback function. This is primarily useful in the case of
 		 * "stored" versions that want to report the same value as the
 		 * running version in the normal case of no pending update.
 		 */
-		if (ctx->buf[0] == '\0' && ice_devlink_versions[i].fallback) {
-			err = ice_devlink_versions[i].fallback(pf, ctx);
-			if (err) {
-				NL_SET_ERR_MSG_MOD(extack, "Unable to obtain version info");
-				goto out_free_ctx;
-			}
-		}
+		if (ctx->buf[0] == '\0' && ice_devlink_versions[i].fallback)
+			ice_devlink_versions[i].fallback(pf, ctx);
 
 		/* Do not report missing versions */
 		if (ctx->buf[0] == '\0')

base-commit: 0fb695405d6a624582cb07f8009f37ccae78c250
-- 
2.31.1.331.gb0c09ab8796f

