From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 29 Sep 2020 22:25:36 +0200
Subject: [Intel-wired-lan] [patch V2 27/36] net: brcmfmac: Convey allocation
 mode as argument
References: <20200929202509.673358734@linutronix.de>
Message-ID: <20200929203502.180883992@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The usage of in_interrupt() in drivers is phased out and Linus clearly
requested that code which changes behaviour depending on context should
either be seperated or the context be conveyed in an argument passed by the
caller, which usually knows the context.

brcmf_fweh_process_event() uses in_interrupt() to select the allocation
mode GFP_KERNEL/GFP_ATOMIC. Aside of the above reasons this check is
incomplete as it cannot detect contexts which just have preemption or
interrupts disabled.

All callchains leading to brcmf_fweh_process_event() can clearly identify
the calling context. Convey a 'gfp' argument through the callchains and let
the callers hand in the appropriate GFP mode.

This has also the advantage that any change of execution context or
preemption/interrupt state in these callchains will be detected by the
memory allocator for all GFP_KERNEL allocations.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Adopt to the 'inirq' changes
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c   |   10 ++++++----
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c   |    8 ++------
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h   |    7 ++++---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c |    2 +-
 4 files changed, 13 insertions(+), 14 deletions(-)

--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -513,10 +513,12 @@ void brcmf_rx_frame(struct device *dev,
 		brcmf_proto_rxreorder(ifp, skb, inirq);
 	} else {
 		/* Process special event packets */
-		if (handle_event)
-			brcmf_fweh_process_skb(ifp->drvr, skb,
-					       BCMILCP_SUBTYPE_VENDOR_LONG);
+		if (handle_event) {
+			gfp_t gfp = inirq ? GFP_ATOMIC : GFP_KERNEL;
 
+			brcmf_fweh_process_skb(ifp->drvr, skb,
+					       BCMILCP_SUBTYPE_VENDOR_LONG, gfp);
+		}
 		brcmf_netif_rx(ifp, skb, inirq);
 	}
 }
@@ -532,7 +534,7 @@ void brcmf_rx_event(struct device *dev,
 	if (brcmf_rx_hdrpull(drvr, skb, &ifp))
 		return;
 
-	brcmf_fweh_process_skb(ifp->drvr, skb, 0);
+	brcmf_fweh_process_skb(ifp->drvr, skb, 0, GFP_KERNEL);
 	brcmu_pkt_buf_free_skb(skb);
 }
 
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
@@ -388,12 +388,11 @@ int brcmf_fweh_activate_events(struct br
  */
 void brcmf_fweh_process_event(struct brcmf_pub *drvr,
 			      struct brcmf_event *event_packet,
-			      u32 packet_len)
+			      u32 packet_len, gfp_t gfp)
 {
 	enum brcmf_fweh_event_code code;
 	struct brcmf_fweh_info *fweh = &drvr->fweh;
 	struct brcmf_fweh_queue_item *event;
-	gfp_t alloc_flag = GFP_KERNEL;
 	void *data;
 	u32 datalen;
 
@@ -412,10 +411,7 @@ void brcmf_fweh_process_event(struct brc
 	    datalen + sizeof(*event_packet) > packet_len)
 		return;
 
-	if (in_interrupt())
-		alloc_flag = GFP_ATOMIC;
-
-	event = kzalloc(sizeof(*event) + datalen, alloc_flag);
+	event = kzalloc(sizeof(*event) + datalen, gfp);
 	if (!event)
 		return;
 
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h
@@ -319,11 +319,12 @@ void brcmf_fweh_unregister(struct brcmf_
 int brcmf_fweh_activate_events(struct brcmf_if *ifp);
 void brcmf_fweh_process_event(struct brcmf_pub *drvr,
 			      struct brcmf_event *event_packet,
-			      u32 packet_len);
+			      u32 packet_len, gfp_t gfp);
 void brcmf_fweh_p2pdev_setup(struct brcmf_if *ifp, bool ongoing);
 
 static inline void brcmf_fweh_process_skb(struct brcmf_pub *drvr,
-					  struct sk_buff *skb, u16 stype)
+					  struct sk_buff *skb, u16 stype,
+					  gfp_t gfp)
 {
 	struct brcmf_event *event_packet;
 	u16 subtype, usr_stype;
@@ -354,7 +355,7 @@ static inline void brcmf_fweh_process_sk
 	if (usr_stype != BCMILCP_BCM_SUBTYPE_EVENT)
 		return;
 
-	brcmf_fweh_process_event(drvr, event_packet, skb->len + ETH_HLEN);
+	brcmf_fweh_process_event(drvr, event_packet, skb->len + ETH_HLEN, gfp);
 }
 
 #endif /* FWEH_H_ */
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c
@@ -1129,7 +1129,7 @@ static void brcmf_msgbuf_process_event(s
 
 	skb->protocol = eth_type_trans(skb, ifp->ndev);
 
-	brcmf_fweh_process_skb(ifp->drvr, skb, 0);
+	brcmf_fweh_process_skb(ifp->drvr, skb, 0, GFP_KERNEL);
 
 exit:
 	brcmu_pkt_buf_free_skb(skb);

