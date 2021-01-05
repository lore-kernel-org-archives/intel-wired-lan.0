From: Vladimir Oltean <olteanv@gmail.com>
Date: Tue,  5 Jan 2021 20:58:56 +0200
Subject: [Intel-wired-lan] [RFC PATCH v2 net-next 06/12] parisc/led:
 reindent the code that gathers device statistics
In-Reply-To: <20210105185902.3922928-1-olteanv@gmail.com>
References: <20210105185902.3922928-1-olteanv@gmail.com>
Message-ID: <20210105185902.3922928-7-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Vladimir Oltean <vladimir.oltean@nxp.com>

The standard in the Linux kernel is to use one tab character per
indentation level.

Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-parisc at vger.kernel.org
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/parisc/led.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/parisc/led.c b/drivers/parisc/led.c
index 36c6613f7a36..3cada632a4be 100644
--- a/drivers/parisc/led.c
+++ b/drivers/parisc/led.c
@@ -359,16 +359,19 @@ static __inline__ int led_get_net_activity(void)
 	/* we are running as a workqueue task, so we can use an RCU lookup */
 	rcu_read_lock();
 	for_each_netdev_rcu(&init_net, dev) {
-	    const struct rtnl_link_stats64 *stats;
-	    struct rtnl_link_stats64 temp;
-	    struct in_device *in_dev = __in_dev_get_rcu(dev);
-	    if (!in_dev || !in_dev->ifa_list)
-		continue;
-	    if (ipv4_is_loopback(in_dev->ifa_list->ifa_local))
-		continue;
-	    stats = dev_get_stats(dev, &temp);
-	    rx_total += stats->rx_packets;
-	    tx_total += stats->tx_packets;
+		const struct rtnl_link_stats64 *stats;
+		struct rtnl_link_stats64 temp;
+		struct in_device *in_dev = __in_dev_get_rcu(dev);
+
+		if (!in_dev || !in_dev->ifa_list)
+			continue;
+
+		if (ipv4_is_loopback(in_dev->ifa_list->ifa_local))
+			continue;
+
+		stats = dev_get_stats(dev, &temp);
+		rx_total += stats->rx_packets;
+		tx_total += stats->tx_packets;
 	}
 	rcu_read_unlock();
 
-- 
2.25.1

