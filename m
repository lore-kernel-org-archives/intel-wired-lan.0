From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 02 Nov 2017 16:34:41 -0700
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 4/5] dev: Clean-up
 __skb_tx_hash to match up with traffic class based configs
In-Reply-To: <20171102232857.15146.21583.stgit@localhost.localdomain>
References: <20171102232857.15146.21583.stgit@localhost.localdomain>
Message-ID: <20171102233417.15146.6991.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

This patch is mostly just a minor clean-up so that we avoid letting a
packet jump from one traffic class to another just based on the Rx queue.
Instead we now use that queue number as an offset within the traffic class.
Handling it this way allows us to operate more cleanly in a mixed
environment that is doing routing over multiple interfaces that may not
have the same queue configuration.

This patch includes a minor clean-up of variable declaration as well to get
things into the reverse xmas tree format.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 net/core/dev.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 24ac9083bc13..fd51b8703277 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2573,16 +2573,9 @@ void netif_device_attach(struct net_device *dev)
 u16 __skb_tx_hash(const struct net_device *dev, struct sk_buff *skb,
 		  unsigned int num_tx_queues)
 {
-	u32 hash;
-	u16 qoffset = 0;
 	u16 qcount = num_tx_queues;
-
-	if (skb_rx_queue_recorded(skb)) {
-		hash = skb_get_rx_queue(skb);
-		while (unlikely(hash >= num_tx_queues))
-			hash -= num_tx_queues;
-		return hash;
-	}
+	u16 qoffset = 0;
+	u32 hash;
 
 	if (dev->num_tc) {
 		u8 tc = netdev_get_prio_tc_map(dev, skb->priority);
@@ -2591,6 +2584,13 @@ u16 __skb_tx_hash(const struct net_device *dev, struct sk_buff *skb,
 		qcount = dev->tc_to_txq[tc].count;
 	}
 
+	if (skb_rx_queue_recorded(skb)) {
+		hash = skb_get_rx_queue(skb);
+		while (unlikely(hash >= qcount))
+			hash -= qcount;
+		return hash + qoffset;
+	}
+
 	return (u16) reciprocal_scale(skb_get_hash(skb), qcount) + qoffset;
 }
 EXPORT_SYMBOL(__skb_tx_hash);

