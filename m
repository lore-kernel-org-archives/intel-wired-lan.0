From: Heiner Kallweit <hkallweit1@gmail.com>
Date: Mon, 17 Feb 2020 22:42:01 +0100
Subject: [Intel-wired-lan] [PATCH net-next 3/3] net: use new helper
 tcp_v6_gso_csum_prep
In-Reply-To: <76cd6cfc-f4f3-ece7-203a-0266b7f02a12@gmail.com>
References: <76cd6cfc-f4f3-ece7-203a-0266b7f02a12@gmail.com>
Message-ID: <9270ae4b-feb1-6a4d-8a22-fbe5e47b7617@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Use new helper tcp_v6_gso_csum_prep in additional network drivers.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/atheros/alx/main.c       |  5 +---
 .../net/ethernet/atheros/atl1c/atl1c_main.c   |  6 ++---
 drivers/net/ethernet/brocade/bna/bnad.c       |  7 +----
 drivers/net/ethernet/cisco/enic/enic_main.c   |  3 +--
 drivers/net/ethernet/intel/e1000/e1000_main.c |  6 +----
 drivers/net/ethernet/intel/e1000e/netdev.c    |  5 +---
 drivers/net/ethernet/jme.c                    |  7 +----
 .../net/ethernet/pensando/ionic/ionic_txrx.c  |  5 +---
 drivers/net/ethernet/qualcomm/emac/emac-mac.c |  7 ++---
 drivers/net/ethernet/socionext/netsec.c       |  6 +----
 drivers/net/hyperv/netvsc_drv.c               |  5 +---
 drivers/net/usb/r8152.c                       | 26 ++-----------------
 drivers/net/vmxnet3/vmxnet3_drv.c             |  5 +---
 13 files changed, 16 insertions(+), 77 deletions(-)

diff --git a/drivers/net/ethernet/atheros/alx/main.c b/drivers/net/ethernet/atheros/alx/main.c
index 1dcbc486e..3e0215887 100644
--- a/drivers/net/ethernet/atheros/alx/main.c
+++ b/drivers/net/ethernet/atheros/alx/main.c
@@ -1416,10 +1416,7 @@ static int alx_tso(struct sk_buff *skb, struct alx_txd *first)
 							 0, IPPROTO_TCP, 0);
 		first->word1 |= 1 << TPD_IPV4_SHIFT;
 	} else if (skb_is_gso_v6(skb)) {
-		ipv6_hdr(skb)->payload_len = 0;
-		tcp_hdr(skb)->check = ~csum_ipv6_magic(&ipv6_hdr(skb)->saddr,
-						       &ipv6_hdr(skb)->daddr,
-						       0, IPPROTO_TCP, 0);
+		tcp_v6_gso_csum_prep(skb, true);
 		/* LSOv2: the first TPD only provides the packet length */
 		first->adrl.l.pkt_len = skb->len;
 		first->word1 |= 1 << TPD_LSO_V2_SHIFT;
diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
index 4c0b1f855..482e18d0d 100644
--- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
@@ -2025,10 +2025,8 @@ static int atl1c_tso_csum(struct atl1c_adapter *adapter,
 						"IPV6 tso with zero data??\n");
 				goto check_sum;
 			} else
-				tcp_hdr(skb)->check = ~csum_ipv6_magic(
-						&ipv6_hdr(skb)->saddr,
-						&ipv6_hdr(skb)->daddr,
-						0, IPPROTO_TCP, 0);
+				tcp_v6_gso_csum_prep(skb, false);
+
 			etpd->word1 |= 1 << TPD_LSO_EN_SHIFT;
 			etpd->word1 |= 1 << TPD_LSO_VER_SHIFT;
 			etpd->pkt_len = cpu_to_le32(skb->len);
diff --git a/drivers/net/ethernet/brocade/bna/bnad.c b/drivers/net/ethernet/brocade/bna/bnad.c
index 01a50a4b2..c301ad736 100644
--- a/drivers/net/ethernet/brocade/bna/bnad.c
+++ b/drivers/net/ethernet/brocade/bna/bnad.c
@@ -2504,12 +2504,7 @@ bnad_tso_prepare(struct bnad *bnad, struct sk_buff *skb)
 					   IPPROTO_TCP, 0);
 		BNAD_UPDATE_CTR(bnad, tso4);
 	} else {
-		struct ipv6hdr *ipv6h = ipv6_hdr(skb);
-
-		ipv6h->payload_len = 0;
-		tcp_hdr(skb)->check =
-			~csum_ipv6_magic(&ipv6h->saddr, &ipv6h->daddr, 0,
-					 IPPROTO_TCP, 0);
+		tcp_v6_gso_csum_prep(skb, true);
 		BNAD_UPDATE_CTR(bnad, tso6);
 	}
 
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index ddf60dc9a..683c628ef 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -696,8 +696,7 @@ static void enic_preload_tcp_csum(struct sk_buff *skb)
 		tcp_hdr(skb)->check = ~csum_tcpudp_magic(ip_hdr(skb)->saddr,
 			ip_hdr(skb)->daddr, 0, IPPROTO_TCP, 0);
 	} else if (skb->protocol == cpu_to_be16(ETH_P_IPV6)) {
-		tcp_hdr(skb)->check = ~csum_ipv6_magic(&ipv6_hdr(skb)->saddr,
-			&ipv6_hdr(skb)->daddr, 0, IPPROTO_TCP, 0);
+		tcp_v6_gso_csum_prep(skb, false);
 	}
 }
 
diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 2bced34c1..0664985e8 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -2715,11 +2715,7 @@ static int e1000_tso(struct e1000_adapter *adapter,
 			cmd_length = E1000_TXD_CMD_IP;
 			ipcse = skb_transport_offset(skb) - 1;
 		} else if (skb_is_gso_v6(skb)) {
-			ipv6_hdr(skb)->payload_len = 0;
-			tcp_hdr(skb)->check =
-				~csum_ipv6_magic(&ipv6_hdr(skb)->saddr,
-						 &ipv6_hdr(skb)->daddr,
-						 0, IPPROTO_TCP, 0);
+			tcp_v6_gso_csum_prep(skb, true);
 			ipcse = 0;
 		}
 		ipcss = skb_network_offset(skb);
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index db4ea58ba..7dda7d407 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -5462,10 +5462,7 @@ static int e1000_tso(struct e1000_ring *tx_ring, struct sk_buff *skb,
 		cmd_length = E1000_TXD_CMD_IP;
 		ipcse = skb_transport_offset(skb) - 1;
 	} else if (skb_is_gso_v6(skb)) {
-		ipv6_hdr(skb)->payload_len = 0;
-		tcp_hdr(skb)->check = ~csum_ipv6_magic(&ipv6_hdr(skb)->saddr,
-						       &ipv6_hdr(skb)->daddr,
-						       0, IPPROTO_TCP, 0);
+		tcp_v6_gso_csum_prep(skb, true);
 		ipcse = 0;
 	}
 	ipcss = skb_network_offset(skb);
diff --git a/drivers/net/ethernet/jme.c b/drivers/net/ethernet/jme.c
index 2e4975572..cde9be497 100644
--- a/drivers/net/ethernet/jme.c
+++ b/drivers/net/ethernet/jme.c
@@ -2077,12 +2077,7 @@ jme_tx_tso(struct sk_buff *skb, __le16 *mss, u8 *flags)
 								IPPROTO_TCP,
 								0);
 		} else {
-			struct ipv6hdr *ip6h = ipv6_hdr(skb);
-
-			tcp_hdr(skb)->check = ~csum_ipv6_magic(&ip6h->saddr,
-								&ip6h->daddr, 0,
-								IPPROTO_TCP,
-								0);
+			tcp_v6_gso_csum_prep(skb, false);
 		}
 
 		return 0;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index e452f4242..3d8469d97 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -632,10 +632,7 @@ static int ionic_tx_tcp_pseudo_csum(struct sk_buff *skb)
 					   ip_hdr(skb)->daddr,
 					   0, IPPROTO_TCP, 0);
 	} else if (skb->protocol == cpu_to_be16(ETH_P_IPV6)) {
-		tcp_hdr(skb)->check =
-			~csum_ipv6_magic(&ipv6_hdr(skb)->saddr,
-					 &ipv6_hdr(skb)->daddr,
-					 0, IPPROTO_TCP, 0);
+		tcp_v6_gso_csum_prep(skb, false);
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/qualcomm/emac/emac-mac.c b/drivers/net/ethernet/qualcomm/emac/emac-mac.c
index bebe38d74..01bcc5e68 100644
--- a/drivers/net/ethernet/qualcomm/emac/emac-mac.c
+++ b/drivers/net/ethernet/qualcomm/emac/emac-mac.c
@@ -1288,11 +1288,8 @@ static int emac_tso_csum(struct emac_adapter *adpt,
 			memset(tpd, 0, sizeof(*tpd));
 			memset(&extra_tpd, 0, sizeof(extra_tpd));
 
-			ipv6_hdr(skb)->payload_len = 0;
-			tcp_hdr(skb)->check =
-				~csum_ipv6_magic(&ipv6_hdr(skb)->saddr,
-						 &ipv6_hdr(skb)->daddr,
-						 0, IPPROTO_TCP, 0);
+			tcp_v6_gso_csum_prep(skb, true);
+
 			TPD_PKT_LEN_SET(&extra_tpd, skb->len);
 			TPD_LSO_SET(&extra_tpd, 1);
 			TPD_LSOV_SET(&extra_tpd, 1);
diff --git a/drivers/net/ethernet/socionext/netsec.c b/drivers/net/ethernet/socionext/netsec.c
index e8224b543..d7a033053 100644
--- a/drivers/net/ethernet/socionext/netsec.c
+++ b/drivers/net/ethernet/socionext/netsec.c
@@ -1148,11 +1148,7 @@ static netdev_tx_t netsec_netdev_start_xmit(struct sk_buff *skb,
 				~tcp_v4_check(0, ip_hdr(skb)->saddr,
 					      ip_hdr(skb)->daddr, 0);
 		} else {
-			ipv6_hdr(skb)->payload_len = 0;
-			tcp_hdr(skb)->check =
-				~csum_ipv6_magic(&ipv6_hdr(skb)->saddr,
-						 &ipv6_hdr(skb)->daddr,
-						 0, IPPROTO_TCP, 0);
+			tcp_v6_gso_csum_prep(skb, true);
 		}
 
 		tx_ctrl.tcp_seg_offload_flag = true;
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 65e12cb07..f41e48634 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -638,10 +638,7 @@ static int netvsc_xmit(struct sk_buff *skb, struct net_device *net, bool xdp_tx)
 		} else {
 			lso_info->lso_v2_transmit.ip_version =
 				NDIS_TCP_LARGE_SEND_OFFLOAD_IPV6;
-			ipv6_hdr(skb)->payload_len = 0;
-			tcp_hdr(skb)->check =
-				~csum_ipv6_magic(&ipv6_hdr(skb)->saddr,
-						 &ipv6_hdr(skb)->daddr, 0, IPPROTO_TCP, 0);
+			tcp_v6_gso_csum_prep(skb, true);
 		}
 		lso_info->lso_v2_transmit.tcp_header_offset = skb_transport_offset(skb);
 		lso_info->lso_v2_transmit.mss = skb_shinfo(skb)->gso_size;
diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 78ddbaf64..4ad2a1d42 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -1948,29 +1948,6 @@ static void r8152_csum_workaround(struct r8152 *tp, struct sk_buff *skb,
 	}
 }
 
-/* msdn_giant_send_check()
- * According to the document of microsoft, the TCP Pseudo Header excludes the
- * packet length for IPv6 TCP large packets.
- */
-static int msdn_giant_send_check(struct sk_buff *skb)
-{
-	const struct ipv6hdr *ipv6h;
-	struct tcphdr *th;
-	int ret;
-
-	ret = skb_cow_head(skb, 0);
-	if (ret)
-		return ret;
-
-	ipv6h = ipv6_hdr(skb);
-	th = tcp_hdr(skb);
-
-	th->check = 0;
-	th->check = ~tcp_v6_check(0, &ipv6h->saddr, &ipv6h->daddr, 0);
-
-	return ret;
-}
-
 static inline void rtl_tx_vlan_tag(struct tx_desc *desc, struct sk_buff *skb)
 {
 	if (skb_vlan_tag_present(skb)) {
@@ -2016,10 +1993,11 @@ static int r8152_tx_csum(struct r8152 *tp, struct tx_desc *desc,
 			break;
 
 		case htons(ETH_P_IPV6):
-			if (msdn_giant_send_check(skb)) {
+			if (skb_cow_head(skb, 0)) {
 				ret = TX_CSUM_TSO;
 				goto unavailable;
 			}
+			tcp_v6_gso_csum_prep(skb, false);
 			opts1 |= GTSENDV6;
 			break;
 
diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 18f152fa0..92c2ecf3f 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -942,10 +942,7 @@ vmxnet3_prepare_tso(struct sk_buff *skb,
 		tcph->check = ~csum_tcpudp_magic(iph->saddr, iph->daddr, 0,
 						 IPPROTO_TCP, 0);
 	} else if (ctx->ipv6) {
-		struct ipv6hdr *iph = ipv6_hdr(skb);
-
-		tcph->check = ~csum_ipv6_magic(&iph->saddr, &iph->daddr, 0,
-					       IPPROTO_TCP, 0);
+		tcp_v6_gso_csum_prep(skb, false);
 	}
 }
 
-- 
2.25.0


