From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 02 Nov 2017 16:34:58 -0700
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 5/5] dev: Cap number
 of queues even with accel_priv
In-Reply-To: <20171102232857.15146.21583.stgit@localhost.localdomain>
References: <20171102232857.15146.21583.stgit@localhost.localdomain>
Message-ID: <20171102233447.15146.63844.stgit@localhost.localdomain>
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
index fd51b8703277..59dcc1b26ae2 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3393,8 +3393,7 @@ struct netdev_queue *netdev_pick_tx(struct net_device *dev,
 		else
 			queue_index = __netdev_pick_tx(dev, skb);
 
-		if (!accel_priv)
-			queue_index = netdev_cap_txqueue(dev, queue_index);
+		queue_index = netdev_cap_txqueue(dev, queue_index);
 	}
 
 	skb_set_queue_mapping(skb, queue_index);

