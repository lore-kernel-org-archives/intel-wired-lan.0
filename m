From: Alice Michael <alice.michael@intel.com>
Date: Fri,  4 Aug 2017 09:52:15 -0400
Subject: [Intel-wired-lan] [next PATCH S78-V4 05/12] i40e: drop i40e_pf *pf
	from i40e_vc_disable_vf()
In-Reply-To: <20170804135222.46684-1-alice.michael@intel.com>
References: <20170804135222.46684-1-alice.michael@intel.com>
Message-ID: <20170804135222.46684-5-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

It's never used, and the vf structure could get back to the PF if
necessary. Lets just drop the extra unneeded parameter.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index fd85dd8..2adcc7f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -154,12 +154,11 @@ void i40e_vc_notify_vf_reset(struct i40e_vf *vf)
 
 /**
  * i40e_vc_disable_vf
- * @pf: pointer to the PF info
  * @vf: pointer to the VF info
  *
  * Disable the VF through a SW reset
  **/
-static inline void i40e_vc_disable_vf(struct i40e_pf *pf, struct i40e_vf *vf)
+static inline void i40e_vc_disable_vf(struct i40e_vf *vf)
 {
 	i40e_vc_notify_vf_reset(vf);
 	i40e_reset_vf(vf, false);
@@ -2914,7 +2913,7 @@ int i40e_ndo_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
 	}
 
 	/* Force the VF driver stop so it has to reload with new MAC address */
-	i40e_vc_disable_vf(pf, vf);
+	i40e_vc_disable_vf(vf);
 	dev_info(&pf->pdev->dev, "Reload the VF driver to make this change effective.\n");
 
 error_param:
@@ -3009,7 +3008,7 @@ int i40e_ndo_set_vf_port_vlan(struct net_device *netdev, int vf_id,
 		 * the right thing by reconfiguring his network correctly
 		 * and then reloading the VF driver.
 		 */
-		i40e_vc_disable_vf(pf, vf);
+		i40e_vc_disable_vf(vf);
 		/* During reset the VF got a new VSI, so refresh the pointer. */
 		vsi = pf->vsi[vf->lan_vsi_idx];
 	}
-- 
2.9.4

