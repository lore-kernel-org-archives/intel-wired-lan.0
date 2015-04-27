From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 27 Apr 2015 14:57:13 -0400
Subject: [Intel-wired-lan] [net-next S5 06/15] i40e: correctly program
	filters for VFs
In-Reply-To: <1430161042-28494-1-git-send-email-catherine.sullivan@intel.com>
References: <1430161042-28494-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1430161042-28494-7-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

MAC filters for VFs were being programmed with 0 for the VLAN value when
there was no VLAN assigned. This is incorrect and actually assigns the
VF to VLAN 0. Instead, we must use -1 to indicate that no VLAN is in
use. This change programs the filters correctly and gets rid of a bogus
error message when setting a port VLAN on an active VF.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: Ica9a9906d768405377ff3308e27f7d0b5b2ea96e
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index e6ab8ee..5c7af7d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -542,11 +542,13 @@ static int i40e_alloc_vsi_res(struct i40e_vf *vf, enum i40e_vsi_type type)
 		if (vf->port_vlan_id)
 			i40e_vsi_add_pvid(vsi, vf->port_vlan_id);
 		f = i40e_add_filter(vsi, vf->default_lan_addr.addr,
-				    vf->port_vlan_id, true, false);
+				    vf->port_vlan_id ? vf->port_vlan_id : -1,
+				    true, false);
 		if (!f)
 			dev_info(&pf->pdev->dev,
 				 "Could not allocate VF MAC addr\n");
-		f = i40e_add_filter(vsi, brdcast, vf->port_vlan_id,
+		f = i40e_add_filter(vsi, brdcast,
+				    vf->port_vlan_id ? vf->port_vlan_id : -1,
 				    true, false);
 		if (!f)
 			dev_info(&pf->pdev->dev,
@@ -2015,7 +2017,8 @@ int i40e_ndo_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
 	}
 
 	/* delete the temporary mac address */
-	i40e_del_filter(vsi, vf->default_lan_addr.addr, vf->port_vlan_id,
+	i40e_del_filter(vsi, vf->default_lan_addr.addr,
+			vf->port_vlan_id ? vf->port_vlan_id : -1,
 			true, false);
 
 	/* Delete all the filters for this VSI - we're going to kill it
-- 
1.9.3

