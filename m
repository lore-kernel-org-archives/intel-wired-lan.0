From: Alice Michael <alice.michael@intel.com>
Date: Tue, 22 Aug 2017 06:57:48 -0400
Subject: [Intel-wired-lan] [next PATCH S78-V8 06/12] i40e: make use of
	i40e_vc_disable_vf
In-Reply-To: <20170822105754.29486-1-alice.michael@intel.com>
References: <20170822105754.29486-1-alice.michael@intel.com>
Message-ID: <20170822105754.29486-7-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Replace i40e_vc_notify_vf_reset and i40e_reset_vf with a call to
i40e_vc_disable_vf which does this exact thing. This matches similar
code patterns throughout the driver.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index d0ae545..083caff 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -3385,8 +3385,7 @@ int i40e_ndo_set_vf_trust(struct net_device *netdev, int vf_id, bool setting)
 		goto out;
 
 	vf->trusted = setting;
-	i40e_vc_notify_vf_reset(vf);
-	i40e_reset_vf(vf, false);
+	i40e_vc_disable_vf(vf);
 	dev_info(&pf->pdev->dev, "VF %u is now %strusted\n",
 		 vf_id, setting ? "" : "un");
 out:
-- 
2.9.4

