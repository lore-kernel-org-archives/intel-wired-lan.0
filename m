From: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 21 Mar 2018 15:22:11 +0100 (CET)
Subject: [Intel-wired-lan] [RFC v3 net-next 14/18] net/sched: Add HW
 offloading capability to TBS
In-Reply-To: <20180307011230.24001-15-jesus.sanchez-palencia@intel.com>
References: <20180307011230.24001-1-jesus.sanchez-palencia@intel.com>
 <20180307011230.24001-15-jesus.sanchez-palencia@intel.com>
Message-ID: <alpine.DEB.2.21.1803211448310.3754@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 6 Mar 2018, Jesus Sanchez-Palencia wrote:
> $ tc qdisc replace dev enp2s0 parent root handle 100 mqprio num_tc 3 \
>            map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 queues 1 at 0 1 at 1 2 at 2 hw 0
> 
> $ tc qdisc add dev enp2s0 parent 100:1 tbs offload
> 
> In this example, the Qdisc will use HW offload for the control of the
> transmission time through the network adapter. It's assumed the timestamp
> in skbuffs are in reference to the interface's PHC and setting any other
> valid clockid would be treated as an error. Because there is no
> scheduling being performed in the qdisc, setting a delta != 0 would also
> be considered an error.

Which clockid will be handed in from the application? The network adapter
time has no fixed clockid. The only way you can get to it is via a fd based
posix clock and that does not work at all because the qdisc setup might
have a different FD than the application which queues packets.

I think this should look like this:

    clock_adapter:	1 = clock of the network adapter
    			0 = system clock selected by clock_system

    clock_system:	0 = CLOCK_REALTIME
    			1 = CLOCK_MONOTONIC

or something like that.

> Example 2:
> 
> $ tc qdisc replace dev enp2s0 parent root handle 100 mqprio num_tc 3 \
>            map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 queues 1 at 0 1 at 1 2 at 2 hw 0
> 
> $ tc qdisc add dev enp2s0 parent 100:1 tbs offload delta 100000 \
> 	   clockid CLOCK_REALTIME sorting
> 
> Here, the Qdisc will use HW offload for the txtime control again,
> but now sorting will be enabled, and thus there will be scheduling being
> performed by the qdisc. That is done based on the clockid CLOCK_REALTIME
> reference and packets leave the Qdisc "delta" (100000) nanoseconds before
> their transmission time. Because this will be using HW offload and
> since dynamic clocks are not supported by the hrtimer, the system clock
> and the PHC clock must be synchronized for this mode to behave as expected.

So what you do here is queueing the packets in the qdisk and then schedule
them at some point ahead of actual transmission time for delivery to the
hardware. That delivery uses the same txtime as used for qdisc scheduling
to tell the hardware when the packet should go on the wire. That's needed
when the network adapter does not support queueing of multiple packets.

Bah, and probably there you need CLOCK_TAI because that's what PTP is based
on, so clock_system needs to accomodate that as well. Dammit, there goes
the simple 2 bits implementation. CLOCK_TAI is 11, so we'd need 4 clock
bits plus the adapter bit.

Though we could spare a bit. The fixed CLOCK_* space goes from 0 to 15. I
don't see us adding new fixed clocks, so we really can reserve #15 for
selecting the adapter clock if sparing that extra bit is truly required.

Thanks,

	tglx


