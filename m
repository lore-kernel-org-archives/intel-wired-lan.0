From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri,  8 Feb 2019 12:50:57 -0800
Subject: [Intel-wired-lan] [PATCH S13 01/16] ice: fix static analysis
 warnings
In-Reply-To: <20190208205112.12180-1-anirudh.venkataramanan@intel.com>
References: <20190208205112.12180-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190208205112.12180-2-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

cppcheck warns "Identical condition '<var>', second condition is always
false". Fix them.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> rewrote commit message]
---
 drivers/net/ethernet/intel/ice/ice_common.c | 2 +-
 drivers/net/ethernet/intel/ice/ice_main.c   | 2 +-
 drivers/net/ethernet/intel/ice/ice_sched.c  | 2 +-
 drivers/net/ethernet/intel/ice/ice_switch.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index d2e1e6f440b8..db6ec77506df 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -331,7 +331,7 @@ ice_aq_get_link_info(struct ice_port_info *pi, bool ena_lse,
 	/* flag cleared so calling functions don't call AQ again */
 	pi->phy.get_link_info = false;
 
-	return status;
+	return 0;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index dcb5a9fab87d..f43ce0e4f82f 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2647,7 +2647,7 @@ static int ice_up_complete(struct ice_vsi *vsi)
 
 	ice_service_task_schedule(pf);
 
-	return err;
+	return 0;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index 56049739a250..086a4c7254c5 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -1502,7 +1502,7 @@ ice_sched_update_vsi_child_nodes(struct ice_port_info *pi, u16 vsi_handle,
 
 	vsi_ctx->sched.max_lanq[tc] = new_numqs;
 
-	return status;
+	return 0;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index bee08d1a44e0..2a30caef6687 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -398,7 +398,7 @@ ice_add_vsi(struct ice_hw *hw, u16 vsi_handle, struct ice_vsi_ctx *vsi_ctx,
 			tmp_vsi_ctx->vsi_num = vsi_ctx->vsi_num;
 	}
 
-	return status;
+	return 0;
 }
 
 /**
-- 
2.14.5

