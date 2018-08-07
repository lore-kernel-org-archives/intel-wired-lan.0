From: Gustavo A. R. Silva <gustavo@embeddedor.com>
Date: Tue, 7 Aug 2018 18:19:42 -0500
Subject: [Intel-wired-lan] [PATCH 15/33] i40e_main: mark expected switch
 fall-through
In-Reply-To: <cover.1533675546.git.gustavo@embeddedor.com>
References: <cover.1533675546.git.gustavo@embeddedor.com>
Message-ID: <26fb4ceb500109db986fbc938845997cf83e17b4.1533675546.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 114790 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 5176242..a1a274d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1800,6 +1800,7 @@ static void i40e_vsi_setup_queue_map(struct i40e_vsi *vsi,
 						       num_tc_qps);
 					break;
 				}
+				/* fall through */
 			case I40E_VSI_FDIR:
 			case I40E_VSI_SRIOV:
 			case I40E_VSI_VMDQ2:
-- 
2.7.4

