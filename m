From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue, 11 Oct 2016 15:26:55 -0700
Subject: [Intel-wired-lan] [next PATCH S50 3/6] i40e: clear mac filter count
	on reset
In-Reply-To: <1476224818-16844-1-git-send-email-bimmy.pujari@intel.com>
References: <1476224818-16844-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1476224818-16844-4-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

When a VF is reset, it gets a new VSI, so all of its MAC filters go
away. Correctly set the number of filters to 0 when freeing VF
resources. This corrects a problem with failure to add filters when the
VF driver is reloaded.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I2acbecf734287b67473bb225293e14b5096acbef
---
Testing Hints : Reload the VF driver and observe
dmesg on the host.

 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 2f1f5e3..69e184b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -811,6 +811,7 @@ static void i40e_free_vf_res(struct i40e_vf *vf)
 		i40e_vsi_release(pf->vsi[vf->lan_vsi_idx]);
 		vf->lan_vsi_idx = 0;
 		vf->lan_vsi_id = 0;
+		vf->num_mac = 0;
 	}
 	msix_vf = pf->hw.func_caps.num_msix_vectors_vf;
 
-- 
2.4.11

