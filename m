From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu,  8 Aug 2019 07:39:30 -0700
Subject: [Intel-wired-lan] [PATCH S27 07/15] ice: Only disable VLAN pruning
 for the VF when all VLANs are removed
In-Reply-To: <20190808143938.4968-1-anthony.l.nguyen@intel.com>
References: <20190808143938.4968-1-anthony.l.nguyen@intel.com>
Message-ID: <20190808143938.4968-7-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Currently if the VF adds a VLAN, VLAN pruning will be enabled for that VSI.
Also, when a VLAN gets deleted it will disable VLAN pruning even if other
VLAN(s) exists for the VF. Fix this by only disabling VLAN pruning on the
VF VSI when removing the last VF (i.e. vf->num_vlan == 0).

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index c58e3e3212df..c38939b1d496 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -2767,8 +2767,9 @@ static int ice_vc_process_vlan_msg(struct ice_vf *vf, u8 *msg, bool add_v)
 			}
 
 			vf->num_vlan--;
-			/* Disable VLAN pruning when removing VLAN */
-			ice_cfg_vlan_pruning(vsi, false, false);
+			/* Disable VLAN pruning when the last VLAN is removed */
+			if (!vf->num_vlan)
+				ice_cfg_vlan_pruning(vsi, false, false);
 
 			/* Disable Unicast/Multicast VLAN promiscuous mode */
 			if (vlan_promisc) {
-- 
2.20.1

