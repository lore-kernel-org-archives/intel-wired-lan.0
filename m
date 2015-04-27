From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 27 Apr 2015 14:57:10 -0400
Subject: [Intel-wired-lan] [net-next S5 03/15] i40e: ignore duplicate port
	VLAN requests
In-Reply-To: <1430161042-28494-1-git-send-email-catherine.sullivan@intel.com>
References: <1430161042-28494-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1430161042-28494-4-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

If user attempts to set a port VLAN on a VF that already has the same
port VLAN configured, the driver will go through a completely
unnecessary flurry of filter removals and filter adds. Just check for
this condition and return success instead of doing a bunch of busywork.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: Ia1a9e83e6ed48b3f4658bc20dfc6af0cf525d54a
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 4653b6e..e6ab8ee 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2080,6 +2080,10 @@ int i40e_ndo_set_vf_port_vlan(struct net_device *netdev,
 		goto error_pvid;
 	}
 
+	if (vsi->info.pvid == (vlan_id | (qos << I40E_VLAN_PRIORITY_SHIFT)))
+		/* duplicate request, so just return success */
+		goto error_pvid;
+
 	if (vsi->info.pvid == 0 && i40e_is_vsi_in_vlan(vsi)) {
 		dev_err(&pf->pdev->dev,
 			"VF %d has already configured VLAN filters and the administrator is requesting a port VLAN override.\nPlease unload and reload the VF driver for this change to take effect.\n",
-- 
1.9.3

