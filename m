From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 26 Feb 2019 16:35:21 -0800
Subject: [Intel-wired-lan] [PATCH S13 v2 15/17] ice: Restore VLAN switch
 rule if port VLAN existed before
In-Reply-To: <20190227003523.28733-1-anirudh.venkataramanan@intel.com>
References: <20190227003523.28733-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190227003523.28733-16-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Michal Swiatkowski <michal.swiatkowski@intel.com>

The VLAN rule is lost when VM starts or the AVF driver (iavf.ko) is
reloaded. So it is necessary to add this rule again.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned up commit message]
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index b84620068a3c..ca8780891540 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -457,8 +457,10 @@ static int ice_alloc_vsi_res(struct ice_vf *vf)
 	vsi->hw_base_vector += 1;
 
 	/* Check if port VLAN exist before, and restore it accordingly */
-	if (vf->port_vlan_id)
+	if (vf->port_vlan_id) {
 		ice_vsi_manage_pvid(vsi, vf->port_vlan_id, true);
+		ice_vsi_add_vlan(vsi, vf->port_vlan_id & ICE_VLAN_M);
+	}
 
 	eth_broadcast_addr(broadcast);
 
-- 
2.14.5

