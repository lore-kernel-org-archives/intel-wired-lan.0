From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue,  3 May 2016 15:13:19 -0700
Subject: [Intel-wired-lan] [next PATCH S36 11/12] i40e: don't add broadcast
	filter for VFs
In-Reply-To: <1462313600-3123-1-git-send-email-bimmy.pujari@intel.com>
References: <1462313600-3123-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1462313600-3123-12-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

Now that all VSIs are configured to receive broadcasts as default, we
don't need to add a filter. This eliminates an annoying but harmless
error message each time VFs are created or reset.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I4cd6339684df45b0d2722133eeb84c14fa93ea19
---
Testing Hints : Enable VFs. Note annoying error is gone.

 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 333945c..31014a7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -665,8 +665,6 @@ static int i40e_alloc_vsi_res(struct i40e_vf *vf, enum i40e_vsi_type type)
 		goto error_alloc_vsi_res;
 	}
 	if (type == I40E_VSI_SRIOV) {
-		u8 brdcast[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
-
 		vf->lan_vsi_idx = vsi->idx;
 		vf->lan_vsi_id = vsi->id;
 		/* If the port VLAN has been configured and then the
@@ -688,12 +686,6 @@ static int i40e_alloc_vsi_res(struct i40e_vf *vf, enum i40e_vsi_type type)
 					 "Could not add MAC filter %pM for VF %d\n",
 					vf->default_lan_addr.addr, vf->vf_id);
 		}
-		f = i40e_add_filter(vsi, brdcast,
-				    vf->port_vlan_id ? vf->port_vlan_id : -1,
-				    true, false);
-		if (!f)
-			dev_info(&pf->pdev->dev,
-				 "Could not allocate VF broadcast filter\n");
 		spin_unlock_bh(&vsi->mac_filter_list_lock);
 	}
 
-- 
2.4.11

