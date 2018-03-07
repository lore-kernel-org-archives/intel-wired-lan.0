From: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
Date: Tue,  6 Mar 2018 17:12:23 -0800
Subject: [Intel-wired-lan] [RFC v3 net-next 11/18] net: packet: Handle
 remaining txtime parameters
In-Reply-To: <20180307011230.24001-1-jesus.sanchez-palencia@intel.com>
References: <20180307011230.24001-1-jesus.sanchez-palencia@intel.com>
Message-ID: <20180307011230.24001-12-jesus.sanchez-palencia@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Initialize clockid to CLOCKID_INVALID instead of 0 (i.e.
CLOCK_REALTIME), and copy both drop_if_late and clockid from CMSG cookie
into skb.

Signed-off-by: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
---
 net/packet/af_packet.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index b2115fac2a8d..e455fbf5a356 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -94,6 +94,7 @@
 #endif
 #include <linux/bpf.h>
 #include <net/compat.h>
+#include <linux/posix-timers.h>
 
 #include "internal.h"
 
@@ -1977,6 +1978,8 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
 	}
 
 	sockc.transmit_time = 0;
+	sockc.drop_if_late = 0;
+	sockc.clockid = CLOCKID_INVALID;
 	sockc.tsflags = sk->sk_tsflags;
 	if (msg->msg_controllen) {
 		err = sock_cmsg_send(sk, msg, &sockc);
@@ -1989,6 +1992,8 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
 	skb->priority = sk->sk_priority;
 	skb->mark = sk->sk_mark;
 	skb->tstamp = sockc.transmit_time;
+	skb->tc_drop_if_late = sockc.drop_if_late;
+	skb->txtime_clockid = sockc.clockid;
 
 	sock_tx_timestamp(sk, sockc.tsflags, &skb_shinfo(skb)->tx_flags);
 
@@ -2487,6 +2492,8 @@ static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
 	skb->priority = po->sk.sk_priority;
 	skb->mark = po->sk.sk_mark;
 	skb->tstamp = sockc->transmit_time;
+	skb->tc_drop_if_late = sockc->drop_if_late;
+	skb->txtime_clockid = sockc->clockid;
 	sock_tx_timestamp(&po->sk, sockc->tsflags, &skb_shinfo(skb)->tx_flags);
 	skb_shinfo(skb)->destructor_arg = ph.raw;
 
@@ -2664,6 +2671,8 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 		goto out_put;
 
 	sockc.transmit_time = 0;
+	sockc.drop_if_late = 0;
+	sockc.clockid = CLOCKID_INVALID;
 	sockc.tsflags = po->sk.sk_tsflags;
 	if (msg->msg_controllen) {
 		err = sock_cmsg_send(&po->sk, msg, &sockc);
@@ -2861,6 +2870,8 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 		goto out_unlock;
 
 	sockc.transmit_time = 0;
+	sockc.drop_if_late = 0;
+	sockc.clockid = CLOCKID_INVALID;
 	sockc.tsflags = sk->sk_tsflags;
 	sockc.mark = sk->sk_mark;
 	if (msg->msg_controllen) {
@@ -2934,6 +2945,8 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 	skb->priority = sk->sk_priority;
 	skb->mark = sockc.mark;
 	skb->tstamp = sockc.transmit_time;
+	skb->tc_drop_if_late = sockc.drop_if_late;
+	skb->txtime_clockid = sockc.clockid;
 
 	if (has_vnet_hdr) {
 		err = virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le());
-- 
2.16.2

