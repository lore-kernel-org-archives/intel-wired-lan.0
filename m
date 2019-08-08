From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu,  8 Aug 2019 07:39:34 -0700
Subject: [Intel-wired-lan] [PATCH S27 11/15] ice: Check root pointer for
 validity
In-Reply-To: <20190808143938.4968-1-anthony.l.nguyen@intel.com>
References: <20190808143938.4968-1-anthony.l.nguyen@intel.com>
Message-ID: <20190808143938.4968-11-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>

ice_sched_get_tc_node uses pi->root without checking for NULL. Add a
check to prevent NULL pointer dereference.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index 79d64f9ed609..fc624b73d05d 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -284,7 +284,7 @@ struct ice_sched_node *ice_sched_get_tc_node(struct ice_port_info *pi, u8 tc)
 {
 	u8 i;
 
-	if (!pi)
+	if (!pi || !pi->root)
 		return NULL;
 	for (i = 0; i < pi->root->num_children; i++)
 		if (pi->root->children[i]->tc_num == tc)
-- 
2.20.1

