From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 22 Nov 2017 10:57:41 -0800
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 15/16] net: Cap number
 of queues even with accel_priv
In-Reply-To: <20171122185256.29785.93548.stgit@localhost.localdomain>
References: <20171122185256.29785.93548.stgit@localhost.localdomain>
Message-ID: <20171122185741.29785.75334.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

With the recent fix to ixgbe we can cap the number of queues always
regardless of if accel_priv is being used or not since the actual number of
queues are being reported via real_num_tx_queues.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 net/core/dev.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 8ee29f4f5fa9..8ad5634e92f2 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3375,8 +3375,7 @@ struct netdev_queue *netdev_pick_tx(struct net_device *dev,
 		else
 			queue_index = __netdev_pick_tx(dev, skb);
 
-		if (!accel_priv)
-			queue_index = netdev_cap_txqueue(dev, queue_index);
+		queue_index = netdev_cap_txqueue(dev, queue_index);
 	}
 
 	skb_set_queue_mapping(skb, queue_index);

