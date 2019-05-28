From: Vedang Patel <vedang.patel@intel.com>
Date: Tue, 28 May 2019 10:46:48 -0700
Subject: [Intel-wired-lan] [PATCH net-next v1 7/7] taprio: Adjust timestamps
 for TCP packets.
In-Reply-To: <1559065608-27888-1-git-send-email-vedang.patel@intel.com>
References: <1559065608-27888-1-git-send-email-vedang.patel@intel.com>
Message-ID: <1559065608-27888-8-git-send-email-vedang.patel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When the taprio qdisc is running in "txtime offload" mode, it will
set the launchtime value (in skb->tstamp) for all the packets which do
not have the SO_TXTIME socket option. But, the TCP packets already have
this value set and it indicates the earliest departure time represented
in CLOCK_MONOTONIC clock.

We need to respect the timestamp set by the TCP subsystem. So, convert
this time to the clock which taprio is using and ensure that the packet
is not transmitted before the deadline set by TCP.

Signed-off-by: Vedang Patel <vedang.patel@intel.com>
---
 net/sched/sch_taprio.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index b892fa32ea2b..cadb2f5d16f0 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -22,6 +22,7 @@
 #include <net/pkt_cls.h>
 #include <net/sch_generic.h>
 #include <net/sock.h>
+#include <net/tcp.h>
 
 static LIST_HEAD(taprio_list);
 static DEFINE_SPINLOCK(taprio_list_lock);
@@ -280,6 +281,41 @@ static inline ktime_t get_cycle_start(struct sched_gate_list *sched,
 	return ktime_sub(time, cycle_elapsed);
 }
 
+/* This returns the tstamp value set by TCP in terms of the set clock. */
+static ktime_t get_tcp_tstamp(struct taprio_sched *q, struct sk_buff *skb)
+{
+	unsigned int offset = skb_network_offset(skb);
+	const struct ipv6hdr *ipv6h;
+	const struct iphdr *iph;
+	struct ipv6hdr _ipv6h;
+
+	ipv6h = skb_header_pointer(skb, offset, sizeof(_ipv6h), &_ipv6h);
+	if (!ipv6h)
+		return 0;
+
+	if (ipv6h->version == 4) {
+		iph = (struct iphdr *)ipv6h;
+		offset += iph->ihl * 4;
+
+		/* special-case 6in4 tunnelling, as that is a common way to get
+		 * v6 connectivity in the home
+		 */
+		if (iph->protocol == IPPROTO_IPV6) {
+			ipv6h = skb_header_pointer(skb, offset,
+						   sizeof(_ipv6h), &_ipv6h);
+
+			if (!ipv6h || ipv6h->nexthdr != IPPROTO_TCP)
+				return 0;
+		} else if (iph->protocol != IPPROTO_TCP) {
+			return 0;
+		}
+	} else if (ipv6h->version == 6 && ipv6h->nexthdr != IPPROTO_TCP) {
+		return 0;
+	}
+
+	return ktime_mono_to_any(skb->skb_mstamp_ns, q->tk_offset);
+}
+
 /* There are a few scenarios where we will have to modify the txtime from
  * what is read from next_txtime in sched_entry. They are:
  * 1. If txtime is in the past,
@@ -297,7 +333,7 @@ static inline ktime_t get_cycle_start(struct sched_gate_list *sched,
  */
 static long get_packet_txtime(struct sk_buff *skb, struct Qdisc *sch)
 {
-	ktime_t transmit_end_time, interval_end, interval_start;
+	ktime_t transmit_end_time, interval_end, interval_start, tcp_tstamp;
 	int len, packet_transmit_time, sched_changed;
 	struct taprio_sched *q = qdisc_priv(sch);
 	ktime_t minimum_time, now, txtime;
@@ -307,6 +343,9 @@ static long get_packet_txtime(struct sk_buff *skb, struct Qdisc *sch)
 	now = taprio_get_time(q);
 	minimum_time = ktime_add_ns(now, q->txtime_delay);
 
+	tcp_tstamp = get_tcp_tstamp(q, skb);
+	minimum_time = max_t(ktime_t, minimum_time, tcp_tstamp);
+
 	rcu_read_lock();
 	admin = rcu_dereference(q->admin_sched);
 	sched = rcu_dereference(q->oper_sched);
-- 
2.17.0

