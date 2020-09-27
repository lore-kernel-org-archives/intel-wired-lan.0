From: Thomas Gleixner <tglx@linutronix.de>
Date: Sun, 27 Sep 2020 21:48:49 +0200
Subject: [Intel-wired-lan] [patch 03/35] net: Add netif_rx_any_context()
References: <20200927194846.045411263@linutronix.de>
Message-ID: <20200927194920.103181773@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Quite some drivers make conditional decisions based on in_interrupt() to
invoke either netif_rx() or netif_rx_ni().

Conditionals based on in_interrupt() or other variants of preempt count
checks in drivers should not exist for various reasons and Linus clearly
requested to either split the code pathes or pass an argument to the
common functions which provides the context.

This is obviously the correct solution, but for some of the affected
drivers this needs a major rewrite due to their convoluted structure.

As in_interrupt() usage in drivers needs to be phased out, provide
netif_rx_any_context() as a stop gap for these drivers.

This confines the in_interrupt() conditional to core code which in turn
allows to remove the access to this check for driver code and provides one
central place to do further modifications once the driver maze is cleaned
up.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: netdev at vger.kernel.org
---
 include/linux/netdevice.h |    1 +
 net/core/dev.c            |   15 +++++++++++++++
 2 files changed, 16 insertions(+)

--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3764,6 +3764,7 @@ void generic_xdp_tx(struct sk_buff *skb,
 int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff *skb);
 int netif_rx(struct sk_buff *skb);
 int netif_rx_ni(struct sk_buff *skb);
+int netif_rx_any_context(struct sk_buff *skb);
 int netif_receive_skb(struct sk_buff *skb);
 int netif_receive_skb_core(struct sk_buff *skb);
 void netif_receive_skb_list(struct list_head *head);
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4840,6 +4840,21 @@ int netif_rx_ni(struct sk_buff *skb)
 }
 EXPORT_SYMBOL(netif_rx_ni);
 
+int netif_rx_any_context(struct sk_buff *skb)
+{
+	/*
+	 * If invoked from contexts which do not invoke bottom half
+	 * processing either at return from interrupt or when softrqs are
+	 * reenabled, use netif_rx_ni() which invokes bottomhalf processing
+	 * directly.
+	 */
+	if (in_interrupt())
+		return netif_rx(skb);
+	else
+		return netif_rx_ni(skb);
+}
+EXPORT_SYMBOL(netif_rx_any_context);
+
 static __latent_entropy void net_tx_action(struct softirq_action *h)
 {
 	struct softnet_data *sd = this_cpu_ptr(&softnet_data);

