From: Deepthi Kavalur <deepthi.kavalur@intel.com>
Date: Fri, 13 Nov 2015 15:47:05 -0800
Subject: [Intel-wired-lan] [next PATCH S22 05/14] i40e: don't add zero MAC
	filter
In-Reply-To: <1447458434-4555-1-git-send-email-deepthi.kavalur@intel.com>
References: <1447458434-4555-1-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <1447458434-4555-6-git-send-email-deepthi.kavalur@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

When VFs are created, the MAC address defaults to all zeros, indicating
to the VF driver that it should use a random MAC address. However, the
PF driver was incorrectly adding this zero MAC to the filter table,
along with the VF's randomly generated MAC address.

Check for a good address before adding the default filter. While we're
at it, make the error message a bit more useful.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: Ia100947d68140e0f73a19ba755cbffc3e79a8fcf
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index c04e3b7..b6be4a5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -549,12 +549,15 @@ static int i40e_alloc_vsi_res(struct i40e_vf *vf, enum i40e_vsi_type type)
 			i40e_vsi_add_pvid(vsi, vf->port_vlan_id);
 
 		spin_lock_bh(&vsi->mac_filter_list_lock);
-		f = i40e_add_filter(vsi, vf->default_lan_addr.addr,
-				    vf->port_vlan_id ? vf->port_vlan_id : -1,
-				    true, false);
-		if (!f)
-			dev_info(&pf->pdev->dev,
-				 "Could not allocate VF MAC addr\n");
+		if (is_valid_ether_addr(vf->default_lan_addr.addr)) {
+			f = i40e_add_filter(vsi, vf->default_lan_addr.addr,
+				       vf->port_vlan_id ? vf->port_vlan_id : -1,
+				       true, false);
+			if (!f)
+				dev_info(&pf->pdev->dev,
+					 "Could not add MAC filter %pM for VF %d\n",
+					vf->default_lan_addr.addr, vf->vf_id);
+		}
 		f = i40e_add_filter(vsi, brdcast,
 				    vf->port_vlan_id ? vf->port_vlan_id : -1,
 				    true, false);
-- 
2.1.0

