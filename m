From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 16 May 2016 10:26:33 -0700
Subject: [Intel-wired-lan] [next PATCH S37 03/15] i40e: write HENA for VFs
In-Reply-To: <1463419605-30746-1-git-send-email-bimmy.pujari@intel.com>
References: <1463419605-30746-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1463419605-30746-4-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

Now that VF RSS is configured by the PF driver, it needs to set the RSS
Hash Enable registers by default. Without this, no packets will be
hashed and they'll all end up on queue 0.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I38e425f40ddb81e3b19a951cfbb939fa5b1123f1
---
Testing Hints : Send packets to the VF and observe
which receive queues are in use using ethtool -S.

 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 31014a7..fe2eba6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -665,6 +665,8 @@ static int i40e_alloc_vsi_res(struct i40e_vf *vf, enum i40e_vsi_type type)
 		goto error_alloc_vsi_res;
 	}
 	if (type == I40E_VSI_SRIOV) {
+		u64 hena = i40e_pf_get_default_rss_hena(pf);
+
 		vf->lan_vsi_idx = vsi->idx;
 		vf->lan_vsi_id = vsi->id;
 		/* If the port VLAN has been configured and then the
@@ -687,6 +689,10 @@ static int i40e_alloc_vsi_res(struct i40e_vf *vf, enum i40e_vsi_type type)
 					vf->default_lan_addr.addr, vf->vf_id);
 		}
 		spin_unlock_bh(&vsi->mac_filter_list_lock);
+		i40e_write_rx_ctl(&pf->hw, I40E_VFQF_HENA1(0, vf->vf_id),
+				  (u32)hena);
+		i40e_write_rx_ctl(&pf->hw, I40E_VFQF_HENA1(1, vf->vf_id),
+				  (u32)(hena >> 32));
 	}
 
 	/* program mac filter */
-- 
2.4.11

