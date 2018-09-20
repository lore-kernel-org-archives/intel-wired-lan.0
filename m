From: Song Liu <songliubraving@fb.com>
Date: Thu, 20 Sep 2018 22:42:45 +0000
Subject: [Intel-wired-lan] [PATCH net] ixgbe: check return value of
 napi_complete_done()
In-Reply-To: <2ca0e823642d232092017f66e8151652e22e74a1.camel@intel.com>
References: <20180920190113.490005-1-songliubraving@fb.com>
 <c1251d5d-4b18-a1de-acd2-6de829b7c7ac@gmail.com>
 <2ca0e823642d232092017f66e8151652e22e74a1.camel@intel.com>
Message-ID: <0DAF1AF9-E98D-4D0F-BD68-F5936A0312C6@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> On Sep 20, 2018, at 2:01 PM, Jeff Kirsher <jeffrey.t.kirsher@intel.com> wrote:
> 
> On Thu, 2018-09-20 at 13:35 -0700, Eric Dumazet wrote:
>> On 09/20/2018 12:01 PM, Song Liu wrote:
>>> The NIC driver should only enable interrupts when napi_complete_done()
>>> returns true. This patch adds the check for ixgbe.
>>> 
>>> Cc: stable at vger.kernel.org # 4.10+
>>> Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
>>> Suggested-by: Eric Dumazet <edumazet@google.com>
>>> Signed-off-by: Song Liu <songliubraving@fb.com>
>>> ---
>> 
>> 
>> Well, unfortunately we do not know why this is needed,
>> this is why I have not yet sent this patch formally.
>> 
>> netpoll has correct synchronization :
>> 
>> poll_napi() places into napi->poll_owner current cpu number before
>> calling poll_one_napi()
>> 
>> netpoll_poll_lock() does also use napi->poll_owner
>> 
>> When netpoll calls ixgbe poll() method, it passed a budget of 0,
>> meaning napi_complete_done() is not called.
>> 
>> As long as we can not explain the problem properly in the changelog,
>> we should investigate, otherwise we will probably see coming dozens of
>> patches
>> trying to fix a 'potential hazard'.
> 
> Agreed, which is why I have our validation and developers looking into it,
> while we test the current patch from Song.

I figured out what is the issue here. And I have a proposal to fix it. I 
have verified that this fixes the issue in our tests. But Alexei suggests
that it may not be the right way to fix. 

Here is what happened:

netpoll tries to send skb with netpoll_start_xmit(). If that fails, it 
calls netpoll_poll_dev(), which calls ndo_poll_controller(). Then, in 
the driver, ndo_poll_controller() calls napi_schedule() for ALL NAPIs 
within the same NIC. 

This is problematic, because at the end napi_schedule() calls:

    ____napi_schedule(this_cpu_ptr(&softnet_data), n);

which attached these NAPIs to softnet_data on THIS CPU. This is done
via napi->poll_list. 

Then suddenly ksoftirqd on this CPU owns multiple NAPIs. And it will
not give up the ownership until it calls napi_complete_done(). However, 
for a very busy server, we usually use 16 CPUs to poll NAPI, so this
CPU can easily be overloaded. And as a result, each call of napi->poll() 
will hit budget (of 64), and it will not call napi_complete_done(), 
and the NAPI stays in the poll_list of this CPU. 

When this happens, the host usually cannot get out of this state until
we throttle/stop client traffic. 


I am pretty confident this is what happened. Please let me know if 
anything above doesn't make sense. 


Here is my proposal to fix it: Instead of polling all NAPIs within one
NIC, I would have netpoll to only poll the NAPI that will free space
for netpoll_start_xmit(). I attached my two RFC patches to the end of 
this email. 

I chatted with Alexei about this. He think polling only one NAPI may 
not guarantee netpoll make progress with the TX queue we are aiming 
for. Also, the bigger problem may be the fact that NAPIs could get 
pinned to one CPU and cannot get released. 

At this point, I really don't know what is the best way to fix this. 

I will also work on a repro with netperf. 

Please let me know your suggestions. 

Thanks,
Song


========================= RFCs ============================


From 7b6d1d0e21bc7a0034dbcacfdaaec95a0e5f5b14 Mon Sep 17 00:00:00 2001
From: Song Liu <songliubraving@fb.com>
Date: Thu, 20 Sep 2018 13:09:26 -0700
Subject: [RFC net 1/2] net: netpoll: when failed to send a message, only poll
 the target NAPI

Currently, netpoll polls all NAPIs in the NIC if it fails to send data to
one TX queue. This is not necessary and sometimes problematic. This is
because ndo_poll_controller() calls napi_schedule() for all NAPIs in the
NIC, and attach available NAPIs to this_cpu's softnet_data->poll_list.
Modern highend NIC has tens of NAPIs, and requires multiple CPUs to poll
the data from the queues. Attaching multiple NAPIs to one CPU's poll_list
fan-in softirq work of multiple CPUs to one CPU. As a result, we see one
CPU pegged in ksoftirqd, while other CPUs cannot get assgined work.

This patch fixes this issue by only polls target NAPI when send fails.
New hook ndo_netpoll_get_napi() is added for the driver to map busy
TX queue to the NAPI to poll. If the driver implements this hook, netpoll
will only poll the NAPI of the target TX queue.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 include/linux/netdevice.h |  5 +++++
 net/core/netpoll.c        | 30 ++++++++++++++++++++++++------
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 6a7ac01fa605..576414b150ff 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1033,6 +1033,9 @@ struct dev_ifalias {
  *
  * void (*ndo_poll_controller)(struct net_device *dev);
  *     Run napi_schedule() for all NAPI within this device.
+ * struct napi_struct* (*ndo_netpoll_get_napi)(struct net_device *dev,
+ *                                             struct netdev_queue *txq);
+ *     Returns the NAPI to poll for the given TX queue.
  *
  *     SR-IOV management functions.
  * int (*ndo_set_vf_mac)(struct net_device *dev, int vf, u8* mac);
@@ -1267,6 +1270,8 @@ struct net_device_ops {
                                                        __be16 proto, u16 vid);
 #ifdef CONFIG_NET_POLL_CONTROLLER
        void                    (*ndo_poll_controller)(struct net_device *dev);
+       struct napi_struct*     (*ndo_netpoll_get_napi)(struct net_device *dev,
+                                                       struct netdev_queue *txq);
        int                     (*ndo_netpoll_setup)(struct net_device *dev,
                                                     struct netpoll_info *info);
        void                    (*ndo_netpoll_cleanup)(struct net_device *dev);
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 57557a6a950c..218a46acbdfc 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -187,7 +187,7 @@ static void poll_napi(struct net_device *dev)
        }
 }

-static void netpoll_poll_dev(struct net_device *dev)
+static void netpoll_poll_dev(struct net_device *dev, struct napi_struct *napi)
 {
        const struct net_device_ops *ops;
        struct netpoll_info *ni = rcu_dereference_bh(dev->npinfo);
@@ -210,10 +210,23 @@ static void netpoll_poll_dev(struct net_device *dev)
                return;
        }

-       /* Process pending work on NIC */
-       ops->ndo_poll_controller(dev);
+       if (napi) {
+               int cpu = smp_processor_id();

-       poll_napi(dev);
+               /* If we know which NAPI to poll, just poll it. */
+               napi_schedule(napi);
+               if (cmpxchg(&napi->poll_owner, -1, cpu) == -1) {
+                       poll_one_napi(napi);
+                       smp_store_release(&napi->poll_owner, -1);
+               }
+       } else {
+               /* If we are not sure which NAPI to poll, process all
+                * pending work on NIC.
+                */
+               ops->ndo_poll_controller(dev);
+
+               poll_napi(dev);
+       }

        up(&ni->dev_lock);

@@ -303,7 +316,7 @@ static struct sk_buff *find_skb(struct netpoll *np, int len, int reserve)

        if (!skb) {
                if (++count < 10) {
-                       netpoll_poll_dev(np->dev);
+                       netpoll_poll_dev(np->dev, NULL);
                        goto repeat;
                }
                return NULL;
@@ -345,8 +358,13 @@ void netpoll_send_skb_on_dev(struct netpoll *np, struct sk_buff *skb,
        /* don't get messages out of order, and no recursion */
        if (skb_queue_len(&npinfo->txq) == 0 && !netpoll_owner_active(dev)) {
                struct netdev_queue *txq;
+               struct napi_struct *napi;

                txq = netdev_pick_tx(dev, skb, NULL);
+               if (dev->netdev_ops->ndo_netpoll_get_napi)
+                       napi = dev->netdev_ops->ndo_netpoll_get_napi(dev, txq);
+               else
+                       napi = NULL;

                /* try until next clock tick */
                for (tries = jiffies_to_usecs(1)/USEC_PER_POLL;
@@ -363,7 +381,7 @@ void netpoll_send_skb_on_dev(struct netpoll *np, struct sk_buff *skb,
                        }

                        /* tickle device maybe there is some cleanup */
-                       netpoll_poll_dev(np->dev);
+                       netpoll_poll_dev(np->dev, napi);

                        udelay(USEC_PER_POLL);
                }
--
2.17.1






From 9f6bd53cf011820054802f17ede2f73de0ec7d41 Mon Sep 17 00:00:00 2001
From: Song Liu <songliubraving@fb.com>
Date: Thu, 20 Sep 2018 15:08:33 -0700
Subject: [RFC net 2/2] net: bnxt: add ndo_netpoll_get_napi

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 177587f9c3f1..0a82a61a16d9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7685,6 +7685,20 @@ static void bnxt_poll_controller(struct net_device *dev)
                napi_schedule(&txr->bnapi->napi);
        }
 }
+
+static struct napi_struct* bnxt_netpoll_get_napi(struct net_device *dev,
+                                                struct netdev_queue *txq)
+{
+       struct bnxt *bp = netdev_priv(dev);
+       int i;
+
+       for (i = 0; i < bp->tx_nr_rings; i++) {
+               struct bnxt_tx_ring_info *txr = &bp->tx_ring[i];
+               if (txq == netdev_get_tx_queue(dev, txr->txq_index))
+                       return &txr->bnapi->napi;
+       }
+       return NULL;
+}
 #endif

 static void bnxt_timer(struct timer_list *t)
@@ -8522,6 +8536,7 @@ static const struct net_device_ops bnxt_netdev_ops = {
 #endif
 #ifdef CONFIG_NET_POLL_CONTROLLER
        .ndo_poll_controller    = bnxt_poll_controller,
+       .ndo_netpoll_get_napi   = bnxt_netpoll_get_napi,
 #endif
        .ndo_setup_tc           = bnxt_setup_tc,
 #ifdef CONFIG_RFS_ACCEL
--
2.17.1




