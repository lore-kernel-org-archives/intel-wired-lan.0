From: sven.auhagen@voleatech.de <sven.auhagen@voleatech.de>
Date: Sat, 17 Oct 2020 09:12:36 +0200
Subject: [Intel-wired-lan] [PATCH v2 4/6] igb: skb add metasize for xdp
In-Reply-To: <20201017071238.95190-1-sven.auhagen@voleatech.de>
References: <20201017071238.95190-1-sven.auhagen@voleatech.de>
Message-ID: <20201017071238.95190-5-sven.auhagen@voleatech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sven Auhagen <sven.auhagen@voleatech.de>

add metasize if it is set in xdp

Signed-off-by: Sven Auhagen <sven.auhagen@voleatech.de>
Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 088f9ddb0093..36ff8725fdaf 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -8345,6 +8345,7 @@ static struct sk_buff *igb_build_skb(struct igb_ring *rx_ring,
 				     struct xdp_buff *xdp,
 				     union e1000_adv_rx_desc *rx_desc)
 {
+	unsigned int metasize = xdp->data - xdp->data_meta;
 #if (PAGE_SIZE < 8192)
 	unsigned int truesize = igb_rx_pg_size(rx_ring) / 2;
 #else
@@ -8366,6 +8367,9 @@ static struct sk_buff *igb_build_skb(struct igb_ring *rx_ring,
 	skb_reserve(skb, xdp->data - xdp->data_hard_start);
 	__skb_put(skb, xdp->data_end - xdp->data);
 
+	if (metasize)
+		skb_metadata_set(skb, metasize);
+
 	/* pull timestamp out of packet data */
 	if (igb_test_staterr(rx_desc, E1000_RXDADV_STAT_TSIP)) {
 		igb_ptp_rx_pktstamp(rx_ring->q_vector, skb->data, skb);
-- 
2.20.1

