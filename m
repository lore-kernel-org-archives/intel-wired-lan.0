From: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
Date: Thu, 22 Mar 2018 16:15:15 -0700
Subject: [Intel-wired-lan] [RFC v3 net-next 14/18] net/sched: Add HW
 offloading capability to TBS
In-Reply-To: <alpine.DEB.2.21.1803211448310.3754@nanos.tec.linutronix.de>
References: <20180307011230.24001-1-jesus.sanchez-palencia@intel.com>
 <20180307011230.24001-15-jesus.sanchez-palencia@intel.com>
 <alpine.DEB.2.21.1803211448310.3754@nanos.tec.linutronix.de>
Message-ID: <8b6e4036-2357-3f7c-f72d-b6594da32348@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,


On 03/21/2018 07:22 AM, Thomas Gleixner wrote:
> On Tue, 6 Mar 2018, Jesus Sanchez-Palencia wrote:
>> $ tc qdisc replace dev enp2s0 parent root handle 100 mqprio num_tc 3 \
>>            map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 queues 1 at 0 1 at 1 2 at 2 hw 0
>>
>> $ tc qdisc add dev enp2s0 parent 100:1 tbs offload
>>
>> In this example, the Qdisc will use HW offload for the control of the
>> transmission time through the network adapter. It's assumed the timestamp
>> in skbuffs are in reference to the interface's PHC and setting any other
>> valid clockid would be treated as an error. Because there is no
>> scheduling being performed in the qdisc, setting a delta != 0 would also
>> be considered an error.
> 
> Which clockid will be handed in from the application? The network adapter
> time has no fixed clockid. The only way you can get to it is via a fd based
> posix clock and that does not work at all because the qdisc setup might
> have a different FD than the application which queues packets.


Yes. As a result, we came up with a rather simplistic solution that would still
allow for dynamic clocks to be used in the future without any API changes. As of
the v3 RFC, the qdisc returns -EINVAL if a netlink application (i.e. tc) tries
to initialize it in 'raw' hw offload passing any clockid != CLOCKID_INVALID. The
skbuffs' clockid was initialized with the same value, so if the application sets
its value to any other valid clockids through the cmsg interface, the qdisc
would just drop the patches on enqueue() due to the mismatch.

In other words, dynamic clocks are currently not used at all.

(I noticed later that this was broken anyway because the definition of invalid
clockids from posix-timers.h is actually only valid for negative numbers.)

Given all the feedback against adding the clockid into struct sk_buff, for the
next version, we'll have to re-think this anyway now that clockid will be set
per socket (i.e. as an argument to the SO_TXTIME) and not per packet anymore.




> 
> I think this should look like this:
> 
>     clock_adapter:	1 = clock of the network adapter
>     			0 = system clock selected by clock_system
> 
>     clock_system:	0 = CLOCK_REALTIME
>     			1 = CLOCK_MONOTONIC
> 
> or something like that.
> 
>> Example 2:
>>
>> $ tc qdisc replace dev enp2s0 parent root handle 100 mqprio num_tc 3 \
>>            map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 queues 1 at 0 1 at 1 2 at 2 hw 0
>>
>> $ tc qdisc add dev enp2s0 parent 100:1 tbs offload delta 100000 \
>> 	   clockid CLOCK_REALTIME sorting
>>
>> Here, the Qdisc will use HW offload for the txtime control again,
>> but now sorting will be enabled, and thus there will be scheduling being
>> performed by the qdisc. That is done based on the clockid CLOCK_REALTIME
>> reference and packets leave the Qdisc "delta" (100000) nanoseconds before
>> their transmission time. Because this will be using HW offload and
>> since dynamic clocks are not supported by the hrtimer, the system clock
>> and the PHC clock must be synchronized for this mode to behave as expected.
> 
> So what you do here is queueing the packets in the qdisk and then schedule
> them at some point ahead of actual transmission time for delivery to the
> hardware. That delivery uses the same txtime as used for qdisc scheduling
> to tell the hardware when the packet should go on the wire. That's needed
> when the network adapter does not support queueing of multiple packets.
> 
> Bah, and probably there you need CLOCK_TAI because that's what PTP is based
> on, so clock_system needs to accomodate that as well. Dammit, there goes
> the simple 2 bits implementation. CLOCK_TAI is 11, so we'd need 4 clock
> bits plus the adapter bit.
> 
> Though we could spare a bit. The fixed CLOCK_* space goes from 0 to 15. I
> don't see us adding new fixed clocks, so we really can reserve #15 for
> selecting the adapter clock if sparing that extra bit is truly required.


So what about just using the previous single 'clockid' argument, but then just
adding to uapi time.h something like:

#define DYNAMIC_CLOCKID 15

And using it for that, instead. This way applications that will use the raw hw
offload mode must use this value for their per-socket clockid, and the qdisc's
clockid would be implicitly initialized to the same value.

What do you think?

Thanks,
Jesus



> 
> Thanks,
> 
> 	tglx
> 
> 
