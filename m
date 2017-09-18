From: Richard Cochran <rcochran@linutronix.de>
Date: Mon, 18 Sep 2017 09:41:18 +0200
Subject: [Intel-wired-lan] [PATCH RFC V1 net-next 3/6] net: ipv4: raw: Hook
	into time based transmission.
In-Reply-To: <cover.1505719061.git.rcochran@linutronix.de>
References: <cover.1505719061.git.rcochran@linutronix.de>
Message-ID: <d2c74a2e56e83dd5b0c9385dac4232d14f4c7f60.1505719061.git.rcochran@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

For raw packets, copy the desired future transmit time from the CMSG
cookie into the skb.

Signed-off-by: Richard Cochran <rcochran@linutronix.de>
---
 net/ipv4/raw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 33b70bfd1122..f6805973629b 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -381,6 +381,7 @@ static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
 
 	skb->priority = sk->sk_priority;
 	skb->mark = sk->sk_mark;
+	skb->transmit_time = sockc->transmit_time;
 	skb_dst_set(skb, &rt->dst);
 	*rtp = NULL;
 
@@ -555,6 +556,7 @@ static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	}
 
 	ipc.sockc.tsflags = sk->sk_tsflags;
+	ipc.sockc.transmit_time = 0;
 	ipc.addr = inet->inet_saddr;
 	ipc.opt = NULL;
 	ipc.tx_flags = 0;
-- 
2.11.0

