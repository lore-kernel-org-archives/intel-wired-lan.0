From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 30 Jan 2017 12:29:33 -0800
Subject: [Intel-wired-lan] [next PATCH S59 2/6] i40e: fix RSS queues only
	operating on PF0
In-Reply-To: <1485808177-6333-1-git-send-email-bimmy.pujari@intel.com>
References: <1485808177-6333-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1485808177-6333-3-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Lihong Yang <lihong.yang@intel.com>

This patch fixes the issue that RSS offloading only works on PF0 by
using the direct register writing of the hash keys for the VFs instead
of using the admin queue command to do so.

Signed-off-by: Lihong Yang <lihong.yang@intel.com>
Change-ID: Ia02cda7dbaa23def342e8786097a2c03db6f580b
---
Testing Hints: follow the steps in the HSD.

 drivers/net/ethernet/intel/i40e/i40e_main.c        | 11 +++--------
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  6 ++----
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 8249d50..fa4f648 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8604,13 +8604,10 @@ static int i40e_config_rss_reg(struct i40e_vsi *vsi, const u8 *seed,
 
 		if (vsi->type == I40E_VSI_MAIN) {
 			for (i = 0; i <= I40E_PFQF_HKEY_MAX_INDEX; i++)
-				i40e_write_rx_ctl(hw, I40E_PFQF_HKEY(i),
-						  seed_dw[i]);
+				wr32(hw, I40E_PFQF_HKEY(i), seed_dw[i]);
 		} else if (vsi->type == I40E_VSI_SRIOV) {
 			for (i = 0; i <= I40E_VFQF_HKEY1_MAX_INDEX; i++)
-				i40e_write_rx_ctl(hw,
-						  I40E_VFQF_HKEY1(i, vf_id),
-						  seed_dw[i]);
+				wr32(hw, I40E_VFQF_HKEY1(i, vf_id), seed_dw[i]);
 		} else {
 			dev_err(&pf->pdev->dev, "Cannot set RSS seed - invalid VSI type\n");
 		}
@@ -8628,9 +8625,7 @@ static int i40e_config_rss_reg(struct i40e_vsi *vsi, const u8 *seed,
 			if (lut_size != I40E_VF_HLUT_ARRAY_SIZE)
 				return -EINVAL;
 			for (i = 0; i <= I40E_VFQF_HLUT_MAX_INDEX; i++)
-				i40e_write_rx_ctl(hw,
-						  I40E_VFQF_HLUT1(i, vf_id),
-						  lut_dw[i]);
+				wr32(hw, I40E_VFQF_HLUT1(i, vf_id), lut_dw[i]);
 		} else {
 			dev_err(&pf->pdev->dev, "Cannot set RSS LUT - invalid VSI type\n");
 		}
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index c531045..0a5a05b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -706,10 +706,8 @@ static int i40e_alloc_vsi_res(struct i40e_vf *vf, enum i40e_vsi_type type)
 					 "Could not allocate VF broadcast filter\n");
 		}
 		spin_unlock_bh(&vsi->mac_filter_hash_lock);
-		i40e_write_rx_ctl(&pf->hw, I40E_VFQF_HENA1(0, vf->vf_id),
-				  (u32)hena);
-		i40e_write_rx_ctl(&pf->hw, I40E_VFQF_HENA1(1, vf->vf_id),
-				  (u32)(hena >> 32));
+		wr32(&pf->hw, I40E_VFQF_HENA1(0, vf->vf_id), (u32)hena);
+		wr32(&pf->hw, I40E_VFQF_HENA1(1, vf->vf_id), (u32)(hena >> 32));
 	}
 
 	/* program mac filter */
-- 
2.4.11

