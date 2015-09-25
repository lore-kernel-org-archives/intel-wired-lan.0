From: Nelson, Shannon <shannon.nelson@intel.com>
Date: Fri, 25 Sep 2015 19:26:04 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: add GRE tunnel type to csum encoding
Message-ID: <FC41C24E35F18A40888AACA1A36F3E418AF8DF2A@fmsmsx115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


Make sure the tx checksum encoder knows about GRE protocol and sets the
descriptor flag appropriately.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index d51b8ed..72a1b52 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2325,6 +2325,9 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 			l4_tunnel = I40E_TXD_CTX_UDP_TUNNELING;
 			*tx_flags |= I40E_TX_FLAGS_VXLAN_TUNNEL;
 			break;
+		case IPPROTO_GRE:
+			l4_tunnel = I40E_TXD_CTX_GRE_TUNNELING;
+			break;
 		default:
 			return;
 		}
-- 
1.8.3.1

