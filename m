From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Thu, 20 Sep 2018 16:22:16 -0700
Subject: [Intel-wired-lan] [PATCH net] ixgbe: check return value of
 napi_complete_done()
In-Reply-To: <0DAF1AF9-E98D-4D0F-BD68-F5936A0312C6@fb.com>
References: <20180920190113.490005-1-songliubraving@fb.com>
 <c1251d5d-4b18-a1de-acd2-6de829b7c7ac@gmail.com>
 <2ca0e823642d232092017f66e8151652e22e74a1.camel@intel.com>
 <0DAF1AF9-E98D-4D0F-BD68-F5936A0312C6@fb.com>
Message-ID: <ee9b9a55-c967-cec3-7df1-79f84b06154c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 09/20/2018 03:42 PM, Song Liu wrote:
> 
> 
>> On Sep 20, 2018, at 2:01 PM, Jeff Kirsher <jeffrey.t.kirsher@intel.com> wrote:
>>
>> On Thu, 2018-09-20 at 13:35 -0700, Eric Dumazet wrote:
>>> On 09/20/2018 12:01 PM, Song Liu wrote:
>>>> The NIC driver should only enable interrupts when napi_complete_done()
>>>> returns true. This patch adds the check for ixgbe.
>>>>
>>>> Cc: stable at vger.kernel.org # 4.10+
>>>> Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
>>>> Suggested-by: Eric Dumazet <edumazet@google.com>
>>>> Signed-off-by: Song Liu <songliubraving@fb.com>
>>>> ---
>>>
>>>
>>> Well, unfortunately we do not know why this is needed,
>>> this is why I have not yet sent this patch formally.
>>>
>>> netpoll has correct synchronization :
>>>
>>> poll_napi() places into napi->poll_owner current cpu number before
>>> calling poll_one_napi()
>>>
>>> netpoll_poll_lock() does also use napi->poll_owner
>>>
>>> When netpoll calls ixgbe poll() method, it passed a budget of 0,
>>> meaning napi_complete_done() is not called.
>>>
>>> As long as we can not explain the problem properly in the changelog,
>>> we should investigate, otherwise we will probably see coming dozens of
>>> patches
>>> trying to fix a 'potential hazard'.
>>
>> Agreed, which is why I have our validation and developers looking into it,
>> while we test the current patch from Song.
> 
> I figured out what is the issue here. And I have a proposal to fix it. I 
> have verified that this fixes the issue in our tests. But Alexei suggests
> that it may not be the right way to fix. 
> 
> Here is what happened:
> 
> netpoll tries to send skb with netpoll_start_xmit(). If that fails, it 
> calls netpoll_poll_dev(), which calls ndo_poll_controller(). Then, in 
> the driver, ndo_poll_controller() calls napi_schedule() for ALL NAPIs 
> within the same NIC. 
> 
> This is problematic, because at the end napi_schedule() calls:
> 
>     ____napi_schedule(this_cpu_ptr(&softnet_data), n);
> 
> which attached these NAPIs to softnet_data on THIS CPU. This is done
> via napi->poll_list. 
> 
> Then suddenly ksoftirqd on this CPU owns multiple NAPIs. And it will
> not give up the ownership until it calls napi_complete_done(). However, 
> for a very busy server, we usually use 16 CPUs to poll NAPI, so this
> CPU can easily be overloaded. And as a result, each call of napi->poll() 
> will hit budget (of 64), and it will not call napi_complete_done(), 
> and the NAPI stays in the poll_list of this CPU. 
> 
> When this happens, the host usually cannot get out of this state until
> we throttle/stop client traffic. 
> 
> 
> I am pretty confident this is what happened. Please let me know if 
> anything above doesn't make sense. 
> 
> 
> Here is my proposal to fix it: Instead of polling all NAPIs within one
> NIC, I would have netpoll to only poll the NAPI that will free space
> for netpoll_start_xmit(). I attached my two RFC patches to the end of 
> this email. 
> 
> I chatted with Alexei about this. He think polling only one NAPI may 
> not guarantee netpoll make progress with the TX queue we are aiming 
> for. Also, the bigger problem may be the fact that NAPIs could get 
> pinned to one CPU and cannot get released. 
> 
> At this point, I really don't know what is the best way to fix this. 
> 
> I will also work on a repro with netperf. 

Thanks !

> 
> Please let me know your suggestions. 
> 

Yeah, maybe that NICs using NAPI could not provide an ndo_poll_controller() method at all,
since it is very risky (potentially grab many NAPI, and end up in this locked situation)

poll_napi() could attempt to free skbs one napi at a time,
without the current cpu stealing all NAPI.


diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 57557a6a950cc9cdff959391576a03381d328c1a..a992971d366090ba69d5c1af32eadd554d6880cf 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -205,13 +205,8 @@ static void netpoll_poll_dev(struct net_device *dev)
        }
 
        ops = dev->netdev_ops;
-       if (!ops->ndo_poll_controller) {
-               up(&ni->dev_lock);
-               return;
-       }
-
-       /* Process pending work on NIC */
-       ops->ndo_poll_controller(dev);
+       if (ops->ndo_poll_controller)
+               ops->ndo_poll_controller(dev);
 
        poll_napi(dev);

