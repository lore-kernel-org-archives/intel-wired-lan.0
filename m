From: Richard Cochran <rcochran@linutronix.de>
Date: Mon, 18 Sep 2017 09:41:19 +0200
Subject: [Intel-wired-lan] [PATCH RFC V1 net-next 4/6] net: ipv4: udp: Hook
	into time based transmission.
In-Reply-To: <cover.1505719061.git.rcochran@linutronix.de>
References: <cover.1505719061.git.rcochran@linutronix.de>
Message-ID: <d0d4e04282773badbf6aebb9fbe0fa43491e20b6.1505719061.git.rcochran@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

For udp packets, copy the desired future transmit time from the CMSG
cookie into the skb.

Signed-off-by: Richard Cochran <rcochran@linutronix.de>
---
 net/ipv4/udp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index ef29df8648e4..669f63495877 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -949,6 +949,7 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	}
 
 	ipc.sockc.tsflags = sk->sk_tsflags;
+	ipc.sockc.transmit_time = 0;
 	ipc.addr = inet->inet_saddr;
 	ipc.oif = sk->sk_bound_dev_if;
 
@@ -1050,8 +1051,10 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 				  sizeof(struct udphdr), &ipc, &rt,
 				  msg->msg_flags);
 		err = PTR_ERR(skb);
-		if (!IS_ERR_OR_NULL(skb))
+		if (!IS_ERR_OR_NULL(skb)) {
+			skb->transmit_time = ipc.sockc.transmit_time;
 			err = udp_send_skb(skb, fl4);
+		}
 		goto out;
 	}
 
-- 
2.11.0

