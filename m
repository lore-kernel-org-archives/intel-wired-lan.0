From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 18 Feb 2020 13:41:48 -0800
Subject: [Intel-wired-lan] [next-queue v3] igc: Complete to commit Add
 support for TSO
Message-ID: <20200218214148.1127641-1-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sasha Neftin <sasha.neftin@intel.com>

commit f38b782dccab ("igc: Add support for TSO")
Add option to setting transmit command (TUCMD) of the context
descriptor based on skb_shinfo gso_type and SKB_GSO_UDP_L4 flag.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
v2: add SKB_GSO_UDP_L4 to features check and probe
v3: patch did not apply cleanly to next-queue tree, due to other igc
    patches that had been applied, so fixed up the patch to apply cleanly

 drivers/net/ethernet/intel/igc/igc_defines.h | 1 +
 drivers/net/ethernet/intel/igc/igc_main.c    | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 1b0fd2ffd08d..0746fa42ff3f 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -522,6 +522,7 @@
 #define IGC_VLAPQF_QUEUE_MASK	0x03
 
 #define IGC_ADVTXD_MACLEN_SHIFT		9  /* Adv ctxt desc mac len shift */
+#define IGC_ADVTXD_TUCMD_L4T_UDP	0x00000000  /* L4 Packet TYPE of UDP */
 #define IGC_ADVTXD_TUCMD_IPV4		0x00000400  /* IP Packet Type:1=IPv4 */
 #define IGC_ADVTXD_TUCMD_L4T_TCP	0x00000800  /* L4 Packet Type of TCP */
 #define IGC_ADVTXD_TUCMD_L4T_SCTP	0x00001000 /* L4 packet TYPE of SCTP */
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 972c833a552b..d406aaea24af 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1232,7 +1232,8 @@ static int igc_tso(struct igc_ring *tx_ring,
 	l4.hdr = skb_checksum_start(skb);
 
 	/* ADV DTYP TUCMD MKRLOC/ISCSIHEDLEN */
-	type_tucmd = IGC_ADVTXD_TUCMD_L4T_TCP;
+	type_tucmd = (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) ?
+		      IGC_ADVTXD_TUCMD_L4T_UDP : IGC_ADVTXD_TUCMD_L4T_TCP;
 
 	/* initialize outer IP header fields */
 	if (ip.v4->version == 4) {
@@ -3693,6 +3694,7 @@ igc_features_check(struct sk_buff *skb, struct net_device *dev,
 	if (unlikely(mac_hdr_len > IGC_MAX_MAC_HDR_LEN))
 		return features & ~(NETIF_F_HW_CSUM |
 				    NETIF_F_SCTP_CRC |
+				    NETIF_F_GSO_UDP_L4 |
 				    NETIF_F_HW_VLAN_CTAG_TX |
 				    NETIF_F_TSO |
 				    NETIF_F_TSO6);
@@ -3701,6 +3703,7 @@ igc_features_check(struct sk_buff *skb, struct net_device *dev,
 	if (unlikely(network_hdr_len >  IGC_MAX_NETWORK_HDR_LEN))
 		return features & ~(NETIF_F_HW_CSUM |
 				    NETIF_F_SCTP_CRC |
+				    NETIF_F_GSO_UDP_L4 |
 				    NETIF_F_TSO |
 				    NETIF_F_TSO6);
 
@@ -4903,6 +4906,7 @@ static int igc_probe(struct pci_dev *pdev,
 	netdev->features |= NETIF_F_RXCSUM;
 	netdev->features |= NETIF_F_HW_CSUM;
 	netdev->features |= NETIF_F_SCTP_CRC;
+	netdev->features |= NETIF_F_GSO_UDP_L4;
 
 #define IGC_GSO_PARTIAL_FEATURES (NETIF_F_GSO_GRE | \
 				  NETIF_F_GSO_GRE_CSUM | \
-- 
2.24.1

