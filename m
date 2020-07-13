From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon, 13 Jul 2020 13:53:10 -0700
Subject: [Intel-wired-lan] [PATCH S50 07/15] ice: Add RL profile bit mask
 check
In-Reply-To: <20200713205318.32425-1-anthony.l.nguyen@intel.com>
References: <20200713205318.32425-1-anthony.l.nguyen@intel.com>
Message-ID: <20200713205318.32425-7-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Tarun Singh <tarun.k.singh@intel.com>

Mask bits before accessing the profile type field.

Signed-off-by: Tarun Singh <tarun.k.singh@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sched.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index 1c29cfa1cf33..ac5b05bb978f 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -2153,8 +2153,8 @@ ice_sched_add_rl_profile(struct ice_port_info *pi,
 	hw = pi->hw;
 	list_for_each_entry(rl_prof_elem, &pi->rl_prof_list[layer_num],
 			    list_entry)
-		if (rl_prof_elem->profile.flags == profile_type &&
-		    rl_prof_elem->bw == bw)
+		if ((rl_prof_elem->profile.flags & ICE_AQC_RL_PROFILE_TYPE_M) ==
+		    profile_type && rl_prof_elem->bw == bw)
 			/* Return existing profile ID info */
 			return rl_prof_elem;
 
@@ -2384,7 +2384,8 @@ ice_sched_rm_rl_profile(struct ice_port_info *pi, u8 layer_num, u8 profile_type,
 	/* Check the existing list for RL profile */
 	list_for_each_entry(rl_prof_elem, &pi->rl_prof_list[layer_num],
 			    list_entry)
-		if (rl_prof_elem->profile.flags == profile_type &&
+		if ((rl_prof_elem->profile.flags & ICE_AQC_RL_PROFILE_TYPE_M) ==
+		    profile_type &&
 		    le16_to_cpu(rl_prof_elem->profile.profile_id) ==
 		    profile_id) {
 			if (rl_prof_elem->prof_id_ref)
@@ -2546,8 +2547,8 @@ ice_sched_set_node_bw(struct ice_port_info *pi, struct ice_sched_node *node,
 		return 0;
 
 	return ice_sched_rm_rl_profile(pi, layer_num,
-				       rl_prof_info->profile.flags,
-				       old_id);
+				       rl_prof_info->profile.flags &
+				       ICE_AQC_RL_PROFILE_TYPE_M, old_id);
 }
 
 /**
-- 
2.20.1

