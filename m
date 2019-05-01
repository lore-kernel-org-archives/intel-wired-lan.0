From: Gustavo A. R. Silva <gustavo@embeddedor.com>
Date: Wed, 1 May 2019 15:55:41 -0500
Subject: [Intel-wired-lan] [PATCH][next] i40e: mark expected switch
 fall-through
Message-ID: <20190501205541.GA17995@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

This patch fixes the following warning:

drivers/net/ethernet/intel/i40e/i40e_xsk.c: In function ?i40e_run_xdp_zc?:
drivers/net/ethernet/intel/i40e/i40e_xsk.c:217:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
   bpf_warn_invalid_xdp_action(act);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_xsk.c:218:2: note: here
  case XDP_ABORTED:
  ^~~~

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

This patch fixes the following warning:

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 1b17486543ac..557c565c26fc 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -215,6 +215,7 @@ static int i40e_run_xdp_zc(struct i40e_ring *rx_ring, struct xdp_buff *xdp)
 		break;
 	default:
 		bpf_warn_invalid_xdp_action(act);
+		/* fall through */
 	case XDP_ABORTED:
 		trace_xdp_exception(rx_ring->netdev, xdp_prog, act);
 		/* fallthrough -- handle aborts by dropping packet */
-- 
2.21.0

