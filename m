From: Colin King <colin.king@canonical.com>
Date: Tue,  4 Oct 2016 12:20:16 +0100
Subject: [Intel-wired-lan] [PATCH] i40e: Add missing \n to end of dev_err
	message
Message-ID: <20161004112016.12011-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Colin Ian King <colin.king@canonical.com>

Trival fix, dev_err message is missing a \n, so add it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 54b8ee2..64e54a5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2940,7 +2940,7 @@ int i40e_ndo_set_vf_bw(struct net_device *netdev, int vf_id, int min_tx_rate,
 	}
 
 	if (max_tx_rate > speed) {
-		dev_err(&pf->pdev->dev, "Invalid max tx rate %d specified for VF %d.",
+		dev_err(&pf->pdev->dev, "Invalid max tx rate %d specified for VF %d.\n",
 			max_tx_rate, vf->vf_id);
 		ret = -EINVAL;
 		goto error;
-- 
2.9.3

