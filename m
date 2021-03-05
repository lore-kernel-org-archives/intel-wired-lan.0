From: Gustavo A. R. Silva <gustavoars@kernel.org>
Date: Fri, 5 Mar 2021 02:52:57 -0600
Subject: [Intel-wired-lan] [PATCH RESEND][next] ice: Fix fall-through
 warnings for Clang
Message-ID: <20210305085257.GA138498@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
by explicitly adding a break statement instead of just letting the code
fall through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index 02b12736ea80..207f6ee3a7f6 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -143,6 +143,7 @@ ice_rx_csum(struct ice_ring *ring, struct sk_buff *skb,
 	case ICE_RX_PTYPE_INNER_PROT_UDP:
 	case ICE_RX_PTYPE_INNER_PROT_SCTP:
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
+		break;
 	default:
 		break;
 	}
-- 
2.27.0

