From: Maxim Mikityanskiy <maximmi@mellanox.com>
Date: Thu, 5 Dec 2019 15:51:12 +0000
Subject: [Intel-wired-lan] [PATCH bpf 1/4] xsk: Add rcu_read_lock around the
 XSK wakeup
In-Reply-To: <20191205155028.28854-1-maximmi@mellanox.com>
References: <20191205155028.28854-1-maximmi@mellanox.com>
Message-ID: <20191205155028.28854-2-maximmi@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The XSK wakeup callback in drivers makes some sanity checks before
triggering NAPI. However, some configuration changes may occur during
this function that affect the result of those checks. For example, the
interface can go down, and all the resources will be destroyed after the
checks in the wakeup function, but before it attempts to use these
resources. Wrap this callback in rcu_read_lock to allow driver to
synchronize_rcu before actually destroying the resources.

Signed-off-by: Maxim Mikityanskiy <maximmi@mellanox.com>
---
 net/xdp/xsk.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 956793893c9d..d2261c90f03a 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -337,9 +337,13 @@ EXPORT_SYMBOL(xsk_umem_consume_tx);
 static int xsk_zc_xmit(struct xdp_sock *xs)
 {
 	struct net_device *dev = xs->dev;
+	int err;
 
-	return dev->netdev_ops->ndo_xsk_wakeup(dev, xs->queue_id,
-					       XDP_WAKEUP_TX);
+	rcu_read_lock();
+	err = dev->netdev_ops->ndo_xsk_wakeup(dev, xs->queue_id, XDP_WAKEUP_TX);
+	rcu_read_unlock();
+
+	return err;
 }
 
 static void xsk_destruct_skb(struct sk_buff *skb)
-- 
2.20.1

