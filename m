From: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
Date: Tue,  6 Mar 2018 17:12:21 -0800
Subject: [Intel-wired-lan] [RFC v3 net-next 09/18] net: ipv4: raw: Handle
 remaining txtime parameters
In-Reply-To: <20180307011230.24001-1-jesus.sanchez-palencia@intel.com>
References: <20180307011230.24001-1-jesus.sanchez-palencia@intel.com>
Message-ID: <20180307011230.24001-10-jesus.sanchez-palencia@intel.com>
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
 net/ipv4/raw.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 8e05970ba7c4..61b6acccc72b 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -79,6 +79,7 @@
 #include <linux/netfilter_ipv4.h>
 #include <linux/compat.h>
 #include <linux/uio.h>
+#include <linux/posix-timers.h>
 
 struct raw_frag_vec {
 	struct msghdr *msg;
@@ -382,6 +383,8 @@ static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
 	skb->priority = sk->sk_priority;
 	skb->mark = sk->sk_mark;
 	skb->tstamp = sockc->transmit_time;
+	skb->txtime_clockid = sockc->clockid;
+	skb->tc_drop_if_late = sockc->drop_if_late;
 	skb_dst_set(skb, &rt->dst);
 	*rtp = NULL;
 
@@ -564,6 +567,8 @@ static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	ipc.sockc.tsflags = sk->sk_tsflags;
 	ipc.sockc.transmit_time = 0;
+	ipc.sockc.drop_if_late = 0;
+	ipc.sockc.clockid = CLOCKID_INVALID;
 	ipc.addr = inet->inet_saddr;
 	ipc.opt = NULL;
 	ipc.tx_flags = 0;
-- 
2.16.2

