From: Avinash Dayanand <avinash.dayanand@intel.com>
Date: Wed, 17 Feb 2016 16:12:23 -0800
Subject: [Intel-wired-lan] [next PATCH S29 13/14] i40e: let go of the past
In-Reply-To: <1455754344-6372-1-git-send-email-avinash.dayanand@intel.com>
References: <1455754344-6372-1-git-send-email-avinash.dayanand@intel.com>
Message-ID: <1455754344-6372-14-git-send-email-avinash.dayanand@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

If we reset a VF, its VSI goes away, and it gets a new one. So don't
hang on to the now-stale local VSI pointer. It just leads to suffering
and kernel panics.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: Ia8823b4e85893e95e963acee284968022b29177a
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 93d8d98..acd2693 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2203,6 +2203,8 @@ int i40e_ndo_set_vf_port_vlan(struct net_device *netdev,
 		 * and then reloading the VF driver.
 		 */
 		i40e_vc_disable_vf(pf, vf);
+		/* During reset the VF got a new VSI, so refresh the pointer. */
+		vsi = pf->vsi[vf->lan_vsi_idx];
 	}
 
 	/* Check for condition where there was already a port VLAN ID
-- 
2.1.0

