From: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
Date: Wed, 17 Jan 2018 15:06:14 -0800
Subject: [Intel-wired-lan] [RFC v2 net-next 03/10] net: ipv4: udp: Hook into
 time based transmission.
In-Reply-To: <20180117230621.26074-1-jesus.sanchez-palencia@intel.com>
References: <20180117230621.26074-1-jesus.sanchez-palencia@intel.com>
Message-ID: <20180117230621.26074-4-jesus.sanchez-palencia@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Richard Cochran <rcochran@linutronix.de>

For udp packets, copy the desired future transmit time from the CMSG
cookie into the skb.

Signed-off-by: Richard Cochran <rcochran@linutronix.de>
Signed-off-by: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
---
 net/ipv4/udp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 853321555a4e..89257422503a 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -926,6 +926,7 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	}
 
 	ipc.sockc.tsflags = sk->sk_tsflags;
+	ipc.sockc.transmit_time = 0;
 	ipc.addr = inet->inet_saddr;
 	ipc.oif = sk->sk_bound_dev_if;
 
@@ -1027,8 +1028,10 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 				  sizeof(struct udphdr), &ipc, &rt,
 				  msg->msg_flags);
 		err = PTR_ERR(skb);
-		if (!IS_ERR_OR_NULL(skb))
+		if (!IS_ERR_OR_NULL(skb)) {
+			skb->tstamp = ipc.sockc.transmit_time;
 			err = udp_send_skb(skb, fl4);
+		}
 		goto out;
 	}
 
-- 
2.15.1

