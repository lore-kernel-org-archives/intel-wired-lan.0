From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri,  8 Feb 2019 12:51:01 -0800
Subject: [Intel-wired-lan] [PATCH S13 05/16] ice: Remove unused vsi_id field
In-Reply-To: <20190208205112.12180-1-anirudh.venkataramanan@intel.com>
References: <20190208205112.12180-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190208205112.12180-6-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Remove unused vsi_id field from struct ice_sched_vsi_info.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_type.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 560b0d2d46ff..584f260f2e4f 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -248,7 +248,6 @@ struct ice_sched_vsi_info {
 	struct ice_sched_node *ag_node[ICE_MAX_TRAFFIC_CLASS];
 	struct list_head list_entry;
 	u16 max_lanq[ICE_MAX_TRAFFIC_CLASS];
-	u16 vsi_id;
 };
 
 /* driver defines the policy */
-- 
2.14.5

