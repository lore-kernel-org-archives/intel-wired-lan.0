From: Alice Michael <alice.michael@intel.com>
Date: Thu, 28 Feb 2019 09:52:49 -0800
Subject: [Intel-wired-lan] [next PATCH S3 3/9] i40e: remove error msg when
 vf with port vlan tries to remove vlan 0
In-Reply-To: <20190228175255.54754-1-alice.michael@intel.com>
References: <20190228175255.54754-1-alice.michael@intel.com>
Message-ID: <20190228175255.54754-3-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

VF's attempt to delete vlan 0 when a port vlan is configured is harmless
in this case pf driver just does nothing.  If vf will try to remove
other vlans when a port vlan is configured it will still produce error
as before.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 71cd159e7902..24628de8e624 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2766,7 +2766,8 @@ static int i40e_vc_remove_vlan_msg(struct i40e_vf *vf, u8 *msg)
 
 	vsi = pf->vsi[vf->lan_vsi_idx];
 	if (vsi->info.pvid) {
-		aq_ret = I40E_ERR_PARAM;
+		if (vfl->num_elements > 1 || vfl->vlan_id[0])
+			aq_ret = I40E_ERR_PARAM;
 		goto error_param;
 	}
 
-- 
2.19.2

