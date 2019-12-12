From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 12 Dec 2019 03:12:53 -0800
Subject: [Intel-wired-lan] [PATCH S35 01/15] ice: Support UDP segmentation
 offload
Message-ID: <20191212111307.33566-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Based on the work done by Alex Duyck on other Intel drivers, add code to
support UDP segmentation offload (USO) for the ice driver.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c |  3 ++-
 drivers/net/ethernet/intel/ice/ice_txrx.c | 15 ++++++++++++---
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d8809a5c07d6..31cd816e7cfb 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2336,7 +2336,8 @@ static void ice_set_netdev_features(struct net_device *netdev)
 			 NETIF_F_HW_VLAN_CTAG_TX     |
 			 NETIF_F_HW_VLAN_CTAG_RX;
 
-	tso_features = NETIF_F_TSO;
+	tso_features = NETIF_F_TSO		|
+		       NETIF_F_GSO_UDP_L4;
 
 	/* set features that user can change */
 	netdev->hw_features = dflt_features | csumo_features |
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 2c212f64d99f..b77514bbd7ba 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1925,6 +1925,7 @@ int ice_tso(struct ice_tx_buf *first, struct ice_tx_offload_params *off)
 	} ip;
 	union {
 		struct tcphdr *tcp;
+		struct udphdr *udp;
 		unsigned char *hdr;
 	} l4;
 	u64 cd_mss, cd_tso_len;
@@ -1958,10 +1959,18 @@ int ice_tso(struct ice_tx_buf *first, struct ice_tx_offload_params *off)
 
 	/* remove payload length from checksum */
 	paylen = skb->len - l4_start;
-	csum_replace_by_diff(&l4.tcp->check, (__force __wsum)htonl(paylen));
 
-	/* compute length of segmentation header */
-	off->header_len = (l4.tcp->doff * 4) + l4_start;
+	if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) {
+		csum_replace_by_diff(&l4.udp->check,
+				     (__force __wsum)htonl(paylen));
+		/* compute length of UDP segmentation header */
+		off->header_len = sizeof(l4.udp) + l4_start;
+	} else {
+		csum_replace_by_diff(&l4.tcp->check,
+				     (__force __wsum)htonl(paylen));
+		/* compute length of TCP segmentation header */
+		off->header_len = (l4.tcp->doff * 4) + l4_start;
+	}
 
 	/* update gso_segs and bytecount */
 	first->gso_segs = skb_shinfo(skb)->gso_segs;
-- 
2.20.1

