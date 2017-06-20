From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 20 Jun 2017 15:16:58 -0700
Subject: [Intel-wired-lan] [next PATCH S73-V2 6/9] i40e/i40evf: make ipv6
	atr code clearer
In-Reply-To: <20170620221701.46765-1-jeffrey.t.kirsher@intel.com>
References: <20170620221701.46765-1-jeffrey.t.kirsher@intel.com>
Message-ID: <20170620221701.46765-6-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

This just reorders some local vars and makes the code flow
clearer.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index b936feb..c9a1496 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2451,9 +2451,15 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
 		hlen = (hdr.network[0] & 0x0F) << 2;
 		l4_proto = hdr.ipv4->protocol;
 	} else {
-		hlen = hdr.network - skb->data;
-		l4_proto = ipv6_find_hdr(skb, &hlen, IPPROTO_TCP, NULL, NULL);
-		hlen -= hdr.network - skb->data;
+		/* find the start of the innermost ipv6 header */
+		unsigned int inner_hlen = hdr.network - skb->data;
+		unsigned int h_offset = inner_hlen;
+
+		/* this function updates h_offset to the end of the header */
+		l4_proto =
+		  ipv6_find_hdr(skb, &h_offset, IPPROTO_TCP, NULL, NULL);
+		/* hlen will contain our best estimate of the tcp header */
+		hlen = h_offset - inner_hlen;
 	}
 
 	if (l4_proto != IPPROTO_TCP)
-- 
2.9.3

