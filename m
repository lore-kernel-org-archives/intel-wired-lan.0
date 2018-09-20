From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Wed, 19 Sep 2018 17:23:31 -0700
Subject: [Intel-wired-lan] [PATCH 08/16] ice: Notify VF of link status change
In-Reply-To: <20180920002339.11107-1-anirudh.venkataramanan@intel.com>
References: <20180920002339.11107-1-anirudh.venkataramanan@intel.com>
Message-ID: <20180920002339.11107-9-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When PF gets a link status change event, notify the VFs of the same.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c        |  2 ++
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 12 ++++++++++++
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h |  3 +++
 3 files changed, 17 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 61273cce46ed..28f6d9f63a18 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -665,6 +665,8 @@ ice_link_event(struct ice_pf *pf, struct ice_port_info *pi)
 		}
 	}
 
+	ice_vc_notify_link_state(pf);
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index ddc7720bf292..5d14b9f2682a 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -887,6 +887,18 @@ static bool ice_reset_vf(struct ice_vf *vf, bool is_vflr)
 	return true;
 }
 
+/**
+ * ice_vc_notify_link_state - Inform all VFs on a PF of link status
+ * @pf: pointer to the PF structure
+ */
+void ice_vc_notify_link_state(struct ice_pf *pf)
+{
+	int i;
+
+	for (i = 0; i < pf->num_alloc_vfs; i++)
+		ice_vc_notify_vf_link_state(&pf->vf[i]);
+}
+
 /**
  * ice_vc_notify_reset - Send pending reset message to all VFs
  * @pf: pointer to the PF structure
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
index 72e85ab3e85d..94295fb779df 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
@@ -78,6 +78,7 @@ int ice_get_vf_cfg(struct net_device *netdev, int vf_id,
 
 void ice_free_vfs(struct ice_pf *pf);
 void ice_vc_process_vf_msg(struct ice_pf *pf, struct ice_rq_event_info *event);
+void ice_vc_notify_link_state(struct ice_pf *pf);
 void ice_vc_notify_reset(struct ice_pf *pf);
 bool ice_reset_all_vfs(struct ice_pf *pf, bool is_vflr);
 
@@ -96,7 +97,9 @@ int ice_set_vf_spoofchk(struct net_device *netdev, int vf_id, bool ena);
 #define ice_process_vflr_event(pf) do {} while (0)
 #define ice_free_vfs(pf) do {} while (0)
 #define ice_vc_process_vf_msg(pf, event) do {} while (0)
+#define ice_vc_notify_link_state(pf) do {} while (0)
 #define ice_vc_notify_reset(pf) do {} while (0)
+
 static inline bool
 ice_reset_all_vfs(struct ice_pf __always_unused *pf,
 		  bool __always_unused is_vflr)
-- 
2.14.3

