From: Vladimir Oltean <olteanv@gmail.com>
Date: Tue,  5 Jan 2021 20:58:55 +0200
Subject: [Intel-wired-lan] [RFC PATCH v2 net-next 05/12]
 s390/appldata_net_sum: hold the netdev lists lock when retrieving device
 statistics
In-Reply-To: <20210105185902.3922928-1-olteanv@gmail.com>
References: <20210105185902.3922928-1-olteanv@gmail.com>
Message-ID: <20210105185902.3922928-6-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Vladimir Oltean <vladimir.oltean@nxp.com>

In the effort of making .ndo_get_stats64 be able to sleep, we need to
ensure the callers of dev_get_stats do not use atomic context.

In the case of the appldata driver, an RCU read-side critical section is
used to ensure the integrity of the list of network interfaces, because
the driver iterates through all net devices in the netns to aggregate
statistics. We still need some protection against an interface
registering or deregistering, and the writer-side lock, the netns's
mutex, is fine for that, because it offers sleepable context.

The ops->callback function is called from under appldata_ops_mutex
protection, so this is proof that the context is sleepable and holding
a mutex is therefore fine.

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: linux-s390 at vger.kernel.org
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 arch/s390/appldata/appldata_net_sum.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/s390/appldata/appldata_net_sum.c b/arch/s390/appldata/appldata_net_sum.c
index 59c282ca002f..4db886980cba 100644
--- a/arch/s390/appldata/appldata_net_sum.c
+++ b/arch/s390/appldata/appldata_net_sum.c
@@ -78,8 +78,9 @@ static void appldata_get_net_sum_data(void *data)
 	tx_dropped = 0;
 	collisions = 0;
 
-	rcu_read_lock();
-	for_each_netdev_rcu(&init_net, dev) {
+	netif_lists_lock(&init_net);
+
+	for_each_netdev(&init_net, dev) {
 		const struct rtnl_link_stats64 *stats;
 		struct rtnl_link_stats64 temp;
 
@@ -95,7 +96,8 @@ static void appldata_get_net_sum_data(void *data)
 		collisions += stats->collisions;
 		i++;
 	}
-	rcu_read_unlock();
+
+	netif_lists_unlock(&init_net);
 
 	net_data->nr_interfaces = i;
 	net_data->rx_packets = rx_packets;
-- 
2.25.1

