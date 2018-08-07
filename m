From: Gustavo A. R. Silva <gustavo@embeddedor.com>
Date: Tue, 7 Aug 2018 18:20:27 -0500
Subject: [Intel-wired-lan] [PATCH 16/33] i40e_txrx: mark expected switch
 fall-through
In-Reply-To: <cover.1533675546.git.gustavo@embeddedor.com>
References: <cover.1533675546.git.gustavo@embeddedor.com>
Message-ID: <7997bf34df88375f097d0a7d60608620718e81db.1533675546.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 114791 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index b151ae3..b5042d1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2253,9 +2253,10 @@ static struct sk_buff *i40e_run_xdp(struct i40e_ring *rx_ring,
 		break;
 	default:
 		bpf_warn_invalid_xdp_action(act);
+		/* fall through */
 	case XDP_ABORTED:
 		trace_xdp_exception(rx_ring->netdev, xdp_prog, act);
-		/* fallthrough -- handle aborts by dropping packet */
+		/* fall through -- handle aborts by dropping packet */
 	case XDP_DROP:
 		result = I40E_XDP_CONSUMED;
 		break;
-- 
2.7.4

