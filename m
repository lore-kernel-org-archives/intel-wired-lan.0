From: huhai <huhai@kylinos.cn>
Date: Mon, 22 Jul 2019 19:55:59 +0800
Subject: [Intel-wired-lan] [PATCH] i40e: add check on
 i40e_configure_tx_ring() return value
Message-ID: <20190722115559.12041-1-huhai@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When i40e_configure_tx_ring(vsi->tx_rings[i]) returns an error, we should
exit from i40e_vsi_configure_tx and return the error, instead of continuing
to check whether xdp is enable, and configure the xdp transmit ring.

Signed-off-by: huhai <huhai@kylinos.cn>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 9ebbe3da61bb..dbd153c90616 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3360,7 +3360,7 @@ static int i40e_vsi_configure_tx(struct i40e_vsi *vsi)
 	for (i = 0; (i < vsi->num_queue_pairs) && !err; i++)
 		err = i40e_configure_tx_ring(vsi->tx_rings[i]);
 
-	if (!i40e_enabled_xdp_vsi(vsi))
+	if (err || !i40e_enabled_xdp_vsi(vsi))
 		return err;
 
 	for (i = 0; (i < vsi->num_queue_pairs) && !err; i++)
-- 
2.20.1



