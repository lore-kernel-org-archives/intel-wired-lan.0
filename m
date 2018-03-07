From: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
Date: Tue,  6 Mar 2018 17:12:19 -0800
Subject: [Intel-wired-lan] [RFC v3 net-next 07/18] net: packet: Hook into
 time based transmission.
In-Reply-To: <20180307011230.24001-1-jesus.sanchez-palencia@intel.com>
References: <20180307011230.24001-1-jesus.sanchez-palencia@intel.com>
Message-ID: <20180307011230.24001-8-jesus.sanchez-palencia@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Richard Cochran <rcochran@linutronix.de>

For raw layer-2 packets, copy the desired future transmit time from
the CMSG cookie into the skb.

Signed-off-by: Richard Cochran <rcochran@linutronix.de>
Signed-off-by: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
---
 net/packet/af_packet.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 2c5a6fe5d749..b2115fac2a8d 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1976,6 +1976,7 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
 		goto out_unlock;
 	}
 
+	sockc.transmit_time = 0;
 	sockc.tsflags = sk->sk_tsflags;
 	if (msg->msg_controllen) {
 		err = sock_cmsg_send(sk, msg, &sockc);
@@ -1987,6 +1988,7 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
 	skb->dev = dev;
 	skb->priority = sk->sk_priority;
 	skb->mark = sk->sk_mark;
+	skb->tstamp = sockc.transmit_time;
 
 	sock_tx_timestamp(sk, sockc.tsflags, &skb_shinfo(skb)->tx_flags);
 
@@ -2484,6 +2486,7 @@ static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
 	skb->dev = dev;
 	skb->priority = po->sk.sk_priority;
 	skb->mark = po->sk.sk_mark;
+	skb->tstamp = sockc->transmit_time;
 	sock_tx_timestamp(&po->sk, sockc->tsflags, &skb_shinfo(skb)->tx_flags);
 	skb_shinfo(skb)->destructor_arg = ph.raw;
 
@@ -2660,6 +2663,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 	if (unlikely(!(dev->flags & IFF_UP)))
 		goto out_put;
 
+	sockc.transmit_time = 0;
 	sockc.tsflags = po->sk.sk_tsflags;
 	if (msg->msg_controllen) {
 		err = sock_cmsg_send(&po->sk, msg, &sockc);
@@ -2856,6 +2860,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 	if (unlikely(!(dev->flags & IFF_UP)))
 		goto out_unlock;
 
+	sockc.transmit_time = 0;
 	sockc.tsflags = sk->sk_tsflags;
 	sockc.mark = sk->sk_mark;
 	if (msg->msg_controllen) {
@@ -2928,6 +2933,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 	skb->dev = dev;
 	skb->priority = sk->sk_priority;
 	skb->mark = sockc.mark;
+	skb->tstamp = sockc.transmit_time;
 
 	if (has_vnet_hdr) {
 		err = virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le());
-- 
2.16.2

