From: Colin King <colin.king@canonical.com>
Date: Tue, 27 Jul 2021 18:33:18 +0100
Subject: [Intel-wired-lan] [PATCH][next] i40e: Fix spelling mistake
 "dissable" -> "disable"
Message-ID: <20210727173318.78154-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a dev_info message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index b4a57251256a..4eb9005e85da 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -4638,7 +4638,7 @@ void i40e_vsi_stop_rings(struct i40e_vsi *vsi)
 		err = i40e_control_wait_rx_q(pf, pf_q, false);
 		if (err)
 			dev_info(&pf->pdev->dev,
-				 "VSI seid %d Rx ring %d dissable timeout\n",
+				 "VSI seid %d Rx ring %d disable timeout\n",
 				 vsi->seid, pf_q);
 	}
 
-- 
2.31.1

