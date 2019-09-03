From: Stefan Assmann <sassmann@kpanic.de>
Date: Tue,  3 Sep 2019 08:08:10 +0200
Subject: [Intel-wired-lan] [PATCH] i40e: clear __I40E_VIRTCHNL_OP_PENDING on
 invalid min tx rate
Message-ID: <20190903060810.30775-1-sassmann@kpanic.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In the case of an invalid min tx rate being requested
i40e_ndo_set_vf_bw() immediately returns -EINVAL instead of releasing
__I40E_VIRTCHNL_OP_PENDING first.

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index f8aa4deceb5e..3d2440838822 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -4263,7 +4263,8 @@ int i40e_ndo_set_vf_bw(struct net_device *netdev, int vf_id, int min_tx_rate,
 	if (min_tx_rate) {
 		dev_err(&pf->pdev->dev, "Invalid min tx rate (%d) (greater than 0) specified for VF %d.\n",
 			min_tx_rate, vf_id);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto error;
 	}
 
 	vf = &pf->vf[vf_id];
-- 
2.21.0

