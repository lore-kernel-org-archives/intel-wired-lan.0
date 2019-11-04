From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon,  4 Nov 2019 01:31:06 -0800
Subject: [Intel-wired-lan] [PATCH S32 v2 13/15] ice: Introduce and use
 ice_vsi_type_str
In-Reply-To: <20191104093108.21542-1-anthony.l.nguyen@intel.com>
References: <20191104093108.21542-1-anthony.l.nguyen@intel.com>
Message-ID: <20191104093108.21542-13-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>

ice_vsi_type_str converts an ice_vsi_type enum value to its string
equivalent. This is expected to help easily identify VSI types from
module print statements.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c  | 21 ++++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_lib.h  |  2 ++
 drivers/net/ethernet/intel/ice/ice_main.c | 16 ++++++++--------
 3 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index c9e0b533da47..af7574b0624b 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -6,6 +6,24 @@
 #include "ice_lib.h"
 #include "ice_dcb_lib.h"
 
+/**
+ * ice_vsi_type_str - maps VSI type enum to string equivalents
+ * @type: VSI type enum
+ */
+const char *ice_vsi_type_str(enum ice_vsi_type type)
+{
+	switch (type) {
+	case ICE_VSI_PF:
+		return "ICE_VSI_PF";
+	case ICE_VSI_VF:
+		return "ICE_VSI_VF";
+	case ICE_VSI_LB:
+		return "ICE_VSI_LB";
+	default:
+		return "unknown";
+	}
+}
+
 /**
  * ice_vsi_ctrl_rx_rings - Start or stop a VSI's Rx rings
  * @vsi: the VSI being configured
@@ -700,7 +718,8 @@ static void ice_set_rss_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi)
 		hash_type = ICE_AQ_VSI_Q_OPT_RSS_TPLZ;
 		break;
 	case ICE_VSI_LB:
-		dev_dbg(&pf->pdev->dev, "Unsupported VSI type %d\n", vsi->type);
+		dev_dbg(&pf->pdev->dev, "Unsupported VSI type %s\n",
+			ice_vsi_type_str(vsi->type));
 		return;
 	default:
 		dev_warn(&pf->pdev->dev, "Unknown VSI type %d\n", vsi->type);
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index 1ec2ad98ac46..364588dfc646 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -6,6 +6,8 @@
 
 #include "ice.h"
 
+const char *ice_vsi_type_str(enum ice_vsi_type type);
+
 int
 ice_add_mac_to_list(struct ice_vsi *vsi, struct list_head *add_list,
 		    const u8 *macaddr);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index aaa398759548..ba9a0b74ef0d 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4635,8 +4635,8 @@ static int ice_vsi_rebuild_by_type(struct ice_pf *pf, enum ice_vsi_type type)
 		err = ice_vsi_rebuild(vsi);
 		if (err) {
 			dev_err(&pf->pdev->dev,
-				"rebuild VSI failed, err %d, VSI index %d, type %d\n",
-				err, vsi->idx, type);
+				"rebuild VSI failed, err %d, VSI index %d, type %s\n",
+				err, vsi->idx, ice_vsi_type_str(type));
 			return err;
 		}
 
@@ -4644,8 +4644,8 @@ static int ice_vsi_rebuild_by_type(struct ice_pf *pf, enum ice_vsi_type type)
 		status = ice_replay_vsi(&pf->hw, vsi->idx);
 		if (status) {
 			dev_err(&pf->pdev->dev,
-				"replay VSI failed, status %d, VSI index %d, type %d\n",
-				status, vsi->idx, type);
+				"replay VSI failed, status %d, VSI index %d, type %s\n",
+				status, vsi->idx, ice_vsi_type_str(type));
 			return -EIO;
 		}
 
@@ -4658,13 +4658,13 @@ static int ice_vsi_rebuild_by_type(struct ice_pf *pf, enum ice_vsi_type type)
 		err = ice_ena_vsi(vsi, false);
 		if (err) {
 			dev_err(&pf->pdev->dev,
-				"enable VSI failed, err %d, VSI index %d, type %d\n",
-				err, vsi->idx, type);
+				"enable VSI failed, err %d, VSI index %d, type %s\n",
+				err, vsi->idx, ice_vsi_type_str(type));
 			return err;
 		}
 
-		dev_info(&pf->pdev->dev, "VSI rebuilt. VSI index %d, type %d\n",
-			 vsi->idx, type);
+		dev_info(&pf->pdev->dev, "VSI rebuilt. VSI index %d, type %s\n",
+			 vsi->idx, ice_vsi_type_str(type));
 	}
 
 	return 0;
-- 
2.20.1

