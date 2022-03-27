From: Xiaomeng Tong <xiam0nd.tong@gmail.com>
Date: Sun, 27 Mar 2022 14:43:44 +0800
Subject: [Intel-wired-lan] [PATCH] ice: ice_sched: fix an incorrect NULL
 check on list iterator
Message-ID: <20220327064344.7573-1-xiam0nd.tong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The bugs are here:
	if (old_agg_vsi_info)
	if (old_agg_vsi_info && !old_agg_vsi_info->tc_bitmap[0]) {

The list iterator value 'old_agg_vsi_info' will *always* be set
and non-NULL by list_for_each_entry_safe(), so it is incorrect
to assume that the iterator value will be NULL if the list is
empty or no element found (in this case, the check
'if (old_agg_vsi_info)' will always be true unexpectly).

To fix the bug, use a new variable 'iter' as the list iterator,
while use the original variable 'old_agg_vsi_info' as a dedicated
pointer to point to the found element.

Cc: stable at vger.kernel.org
Fixes: 37c592062b16d ("ice: remove the VSI info from previous agg")
Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
---
 drivers/net/ethernet/intel/ice/ice_sched.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index 7947223536e3..fba524148a09 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -2757,6 +2757,7 @@ ice_sched_assoc_vsi_to_agg(struct ice_port_info *pi, u32 agg_id,
 			   u16 vsi_handle, unsigned long *tc_bitmap)
 {
 	struct ice_sched_agg_vsi_info *agg_vsi_info, *old_agg_vsi_info = NULL;
+	struct ice_sched_agg_vsi_info *iter;
 	struct ice_sched_agg_info *agg_info, *old_agg_info;
 	struct ice_hw *hw = pi->hw;
 	int status = 0;
@@ -2774,11 +2775,13 @@ ice_sched_assoc_vsi_to_agg(struct ice_port_info *pi, u32 agg_id,
 	if (old_agg_info && old_agg_info != agg_info) {
 		struct ice_sched_agg_vsi_info *vtmp;
 
-		list_for_each_entry_safe(old_agg_vsi_info, vtmp,
+		list_for_each_entry_safe(iter, vtmp,
 					 &old_agg_info->agg_vsi_list,
 					 list_entry)
-			if (old_agg_vsi_info->vsi_handle == vsi_handle)
+			if (iter->vsi_handle == vsi_handle) {
+				old_agg_vsi_info = iter;
 				break;
+			}
 	}
 
 	/* check if entry already exist */
-- 
2.17.1

