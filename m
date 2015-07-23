From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu, 23 Jul 2015 16:54:36 -0400
Subject: [Intel-wired-lan] [next PATCH S9 07/15] i40e: use qos field
	consistently
In-Reply-To: <1437684884-222825-1-git-send-email-catherine.sullivan@intel.com>
References: <1437684884-222825-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1437684884-222825-8-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

In i40e_ndo_set_vf_port_vlan, we were using the qos value
inconsistently, sometimes shifting it, sometimes not. Do the shift-and-
or operation correctly, once, and use the result consistently everywhere
    in the function.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I46f062f3edc90a8a017ecec9137f4d1ab0ab9e41
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index d99c116..f60cd43 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2089,6 +2089,7 @@ error_param:
 int i40e_ndo_set_vf_port_vlan(struct net_device *netdev,
 			      int vf_id, u16 vlan_id, u8 qos)
 {
+	u16 vlanprio = vlan_id | (qos << I40E_VLAN_PRIORITY_SHIFT);
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_pf *pf = np->vsi->back;
 	struct i40e_vsi *vsi;
@@ -2116,8 +2117,7 @@ int i40e_ndo_set_vf_port_vlan(struct net_device *netdev,
 		goto error_pvid;
 	}
 
-	if (le16_to_cpu(vsi->info.pvid) ==
-	    (vlan_id | (qos << I40E_VLAN_PRIORITY_SHIFT)))
+	if (le16_to_cpu(vsi->info.pvid) == vlanprio)
 		/* duplicate request, so just return success */
 		goto error_pvid;
 
@@ -2141,7 +2141,7 @@ int i40e_ndo_set_vf_port_vlan(struct net_device *netdev,
 	 * MAC addresses deleted.
 	 */
 	if ((!(vlan_id || qos) ||
-	    (vlan_id | qos) != le16_to_cpu(vsi->info.pvid)) &&
+	    vlanprio != le16_to_cpu(vsi->info.pvid)) &&
 	    vsi->info.pvid)
 		ret = i40e_vsi_add_vlan(vsi, I40E_VLAN_ANY);
 
@@ -2156,8 +2156,7 @@ int i40e_ndo_set_vf_port_vlan(struct net_device *netdev,
 		}
 	}
 	if (vlan_id || qos)
-		ret = i40e_vsi_add_pvid(vsi,
-				vlan_id | (qos << I40E_VLAN_PRIORITY_SHIFT));
+		ret = i40e_vsi_add_pvid(vsi, vlanprio);
 	else
 		i40e_vsi_remove_pvid(vsi);
 
-- 
1.9.3

