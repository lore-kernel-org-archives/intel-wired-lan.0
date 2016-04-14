From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
Date: Thu, 14 Apr 2016 06:19:26 -0700
Subject: [Intel-wired-lan] [next PATCH S35 06/14] i40e: Clear mac filter
	count on reset
In-Reply-To: <1460639974-2556-1-git-send-email-harshitha.ramamurthy@intel.com>
References: <1460639974-2556-1-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <1460639974-2556-7-git-send-email-harshitha.ramamurthy@intel.com>
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
Change-Id: Ic8c1ee87118b9b45fe23b5b8a9cd935160d1b2d3
---
Testing Hints : Reload the VF driver and observe
dmesg on the host.

 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 41be42d..205eca6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -805,6 +805,7 @@ static void i40e_free_vf_res(struct i40e_vf *vf)
 		i40e_vsi_release(pf->vsi[vf->lan_vsi_idx]);
 		vf->lan_vsi_idx = 0;
 		vf->lan_vsi_id = 0;
+		vf->num_mac = 0;
 	}
 	msix_vf = pf->hw.func_caps.num_msix_vectors_vf;
 
-- 
2.4.3

