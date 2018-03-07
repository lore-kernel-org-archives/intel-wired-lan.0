From: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
Date: Tue,  6 Mar 2018 17:12:22 -0800
Subject: [Intel-wired-lan] [RFC v3 net-next 10/18] net: ipv4: udp: Handle
 remaining txtime parameters
In-Reply-To: <20180307011230.24001-1-jesus.sanchez-palencia@intel.com>
References: <20180307011230.24001-1-jesus.sanchez-palencia@intel.com>
Message-ID: <20180307011230.24001-11-jesus.sanchez-palencia@intel.com>
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
 net/ipv4/udp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index d683bbde526b..4bea8d5ab968 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -115,6 +115,7 @@
 #include "udp_impl.h"
 #include <net/sock_reuseport.h>
 #include <net/addrconf.h>
+#include <linux/posix-timers.h>
 
 struct udp_table udp_table __read_mostly;
 EXPORT_SYMBOL(udp_table);
@@ -927,6 +928,8 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	ipc.sockc.tsflags = sk->sk_tsflags;
 	ipc.sockc.transmit_time = 0;
+	ipc.sockc.drop_if_late = 0;
+	ipc.sockc.clockid = CLOCKID_INVALID;
 	ipc.addr = inet->inet_saddr;
 	ipc.oif = sk->sk_bound_dev_if;
 
@@ -1043,6 +1046,8 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		err = PTR_ERR(skb);
 		if (!IS_ERR_OR_NULL(skb)) {
 			skb->tstamp = ipc.sockc.transmit_time;
+			skb->txtime_clockid = ipc.sockc.clockid;
+			skb->tc_drop_if_late = ipc.sockc.drop_if_late;
 			err = udp_send_skb(skb, fl4);
 		}
 		goto out;
-- 
2.16.2

