From: Michal Swiatkowski <michal.swiatkowski@intel..com>
Date: Tue, 14 Sep 2021 19:25:05 -0400
Subject: [Intel-wired-lan] [PATCH net-next] ice: fix getting UDP tunnel entry
Message-ID: <20210914232505.8117-1-user@wasp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Correct parameters order in call to ice_tunnel_idx_to_entry function.

Entry in sparse port table is correct when the idx is 0. For idx 1 one
correct entry should be skipped, for idx 2 two of them should be skipped
etc. Change if condition to be true when idx is 0, which means that
previous valid entry of this tunnel type were skipped.

Fixes: b20e6c17c468 ("ice: convert to new udp_tunnel infrastructure")
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_flex_pipe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
index df8ed0b40f00..7bcb41cda0a0 100644
--- a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
+++ b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
@@ -1989,7 +1989,7 @@ static u16 ice_tunnel_idx_to_entry(struct ice_hw *hw, enum ice_tunnel_type type,
 	for (i = 0; i < hw->tnl.count && i < ICE_TUNNEL_MAX_ENTRIES; i++)
 		if (hw->tnl.tbl[i].valid &&
 		    hw->tnl.tbl[i].type == type &&
-		    idx--)
+		    idx-- == 0)
 			return i;
 
 	WARN_ON_ONCE(1);
@@ -2149,7 +2149,7 @@ int ice_udp_tunnel_set_port(struct net_device *netdev, unsigned int table,
 	u16 index;
 
 	tnl_type = ti->type == UDP_TUNNEL_TYPE_VXLAN ? TNL_VXLAN : TNL_GENEVE;
-	index = ice_tunnel_idx_to_entry(&pf->hw, idx, tnl_type);
+	index = ice_tunnel_idx_to_entry(&pf->hw, tnl_type, idx);
 
 	status = ice_create_tunnel(&pf->hw, index, tnl_type, ntohs(ti->port));
 	if (status) {
-- 
2.31.1

