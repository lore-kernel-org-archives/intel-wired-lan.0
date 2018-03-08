From: Henrik Austad <henrik@austad.us>
Date: Thu, 8 Mar 2018 15:09:04 +0100
Subject: [Intel-wired-lan] [RFC v3 net-next 00/18] Time based packet
 transmission
In-Reply-To: <20180307011230.24001-1-jesus.sanchez-palencia@intel.com>
References: <20180307011230.24001-1-jesus.sanchez-palencia@intel.com>
Message-ID: <20180308140904.GA28001@sisyphus.home.austad.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Mar 06, 2018 at 05:12:12PM -0800, Jesus Sanchez-Palencia wrote:
> This series is the v3 of the Time based packet transmission RFC, which was
> originally proposed by Richard Cochran (v1: https://lwn.net/Articles/733962/ )
> and further developed by us with the addition of the tbs qdisc
> (v2: https://lwn.net/Articles/744797/ ).

Nice!

> It introduces a new socket option (SO_TXTIME), a new qdisc (tbs) and
> implements support for hw offloading on the igb driver for the Intel
> i210 NIC. The tbs qdisc also supports SW best effort that can be used
> as a fallback.
> 
> The main changes since v2 can be found below.
> 
> Fixes since v2:
>  - skb->tstamp is only cleared on the forwarding path;
>  - ktime_t is no longer the type used for timestamps (s64 is);
>  - get_unaligned() is now used for copying data from the cmsg header;
>  - added getsockopt() support for SO_TXTIME;
>  - restricted SO_TXTIME input range to [0,1];
>  - removed ns_capable() check from __sock_cmsg_send();
>  - the qdisc  control struct now uses a 32 bitmap for config flags;
>  - fixed qdisc backlog decrement bug;
>  - 'overlimits' is now incremented on dequeue() drops in addition to the
>    'dropped' counter;
> 
> Interface changes since v2:
>  * CMSG interface:
>    - added a per-packet clockid parameter to the cmsg (SCM_CLOCKID);
>    - added a per-packet drop_if_late flag to the cmsg (SCM_DROP_IF_LATE);
>  * tc-tbs:
>    - clockid now receives a string;
>      e.g.: CLOCK_REALTIME or /dev/ptp0
>    - offload is now a standalone argument (i.e. no more offload 1);
>    - sorting is now argument that enables txtime based sorting provided
>      by the qdisc;
> 
> Design changes since v2:
>  - Now on the dequeue() path, tbs only drops an expired packet if it has the
>    skb->tc_drop_if_late flag set. In practical terms, this will define if
>    the semantics of txtime on a system is "not earlier than" or "not later
>    than" a given timestamp;
>  - Now on the enqueue() path, the qdisc will drop a packet if its clockid
>    doesn't match the qdisc's one;
>  - Sorting the packets based on their txtime is now an option for the disc.
>    Effectively, this means it can be configured in 4 modes: HW offload or
>    SW best-effort, sorting enabled or disabled;

A lot of new knobs, I see the need, I would've like to have fewer, but 
you've documented them pretty well. Perhaps we should add something to 
Documentation/ at one stage?

Anyways, the patches applied cleanly so I gave them a (very) quick spin. 
Using udp_tai and tcpdump in the other end to grab the frames

Setting up with hw offload and sorting in qdisc.

Sender (every 10ms) (4.16-rc4 on a core2duo 1.8Ghz w/i210 and max_rss 
bypass as dual-core and i210 is not friends):

udp_tai -c1 -i eth2 -p 20 -P 10000000

Receiver (imx7, kernel 4.9.11):
chrt -r 20 tcpdump -i eth0 ether host a0:36:9f:3f:c0:b8 | grep "UDP, length 256" > tai_imx7.log

Note: this involves 2 swtiches and a somewhat hackish kernel running on the 
receiver, so these numbers can only improve.

count    2340.000000
mean        0.043770
std         0.047784
min         0.009025
25%         0.010003
50%         0.010010
75%         0.109998
max         0.120060

I have to dig more into why this is happening, a lot frames delayed much 
more than I'd expect, but at this stage I'm pretty sure this is pebkac. One 
obvious fix is move some hw around and do a direct link, but I didn't have 
time for that right now.

I'm very interested in doing what Richard's original test was when he used 
ptp-synched clocks and also used hw receive-time and compared with expected 
tx-time. So, while I'm getting that up and running, I thought I should 
share the early results.

-Henrik

> The tbs qdisc is designed so it buffers packets until a configurable time before
> their deadline (tx times). If sorting is enabled, regardless of HW offload or SW
> fallback modes, the qdisc uses a rbtree internally so the buffered packets are
> always 'ordered' by the earliest deadline.
> 
> If sorting is disabled, then for HW offload the qdisc will use a 'raw' FIFO
> through qdisc_enqueue_tail() / qdisc_dequeue_head(), whereas for SW best-effort,
> it will use a 'scheduled' FIFO.
> 
> The other configurable parameter from the tbs qdisc is the clockid to be used.
> In order to provide that, this series adds a new API to pkt_sched.h (i.e.
> qdisc_watchdog_init_clockid()).
> 
> The tbs qdisc will drop any packets with a transmission time in the past or
> when a deadline is missed if SCM_DROP_IF_LATE is set. Queueing packets in
> advance plus configuring the delta parameter for the system correctly makes
> all the difference in reducing the number of drops. Moreover, note that the
> delta parameter ends up defining the Tx time when SW best-effort is used
> given that the timestamps won't be used by the NIC on this case.
> 
> Examples:
> 
> # SW best-effort with sorting #
> 
>     $ tc qdisc replace dev enp2s0 parent root handle 100 mqprio num_tc 3 \
>                map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 queues 1 at 0 1 at 1 2 at 2 hw 0
> 
>     $ tc qdisc add dev enp2s0 parent 100:1 tbs delta 100000 \
>                clockid CLOCK_REALTIME sorting
> 
>     In this example first the mqprio qdisc is setup, then the tbs qdisc is
>     configured onto the first hw Tx queue using SW best-effort with sorting
>     enabled. Also, it is configured so the timestamps on each packet are in
>     reference to the clockid CLOCK_REALTIME and so packets are dequeued from
>     the qdisc 100000 nanoseconds before their transmission time.
> 
> 
> # HW offload without sorting #
> 
>     $ tc qdisc replace dev enp2s0 parent root handle 100 mqprio num_tc 3 \
>                map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 queues 1 at 0 1 at 1 2 at 2 hw 0
> 
>     $ tc qdisc add dev enp2s0 parent 100:1 tbs offload
> 
>     In this example, the Qdisc will use HW offload for the control of the
>     transmission time through the network adapter. It's assumed implicitly
>     the timestamp in skbuffs are in reference to the interface's PHC and
>     setting any other valid clockid would be treated as an error. Because
>     there is no scheduling being performed in the qdisc, setting a delta != 0
>     would also be considered an error.
> 
> 
> # HW offload with sorting #
>     $ tc qdisc replace dev enp2s0 parent root handle 100 mqprio num_tc 3 \
>                map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 queues 1 at 0 1 at 1 2 at 2 hw 0
> 
>     $ tc qdisc add dev enp2s0 parent 100:1 tbs offload delta 100000 \
>                clockid CLOCK_REALTIME sorting
> 
>     Here, the Qdisc will use HW offload for the txtime control again,
>     but now sorting will be enabled, and thus there will be scheduling being
>     performed by the qdisc. That is done based on the clockid CLOCK_REALTIME
>     and packets leave the Qdisc "delta" (100000) nanoseconds before
>     their transmission time. Because this will be using HW offload and
>     since dynamic clocks are not supported by the hrtimer, the system clock
>     and the PHC clock must be synchronized for this mode to behave as expected.
> 
> 
> For testing, we've followed a similar approach from the v1 and v2 testing and
> no significant changes on the results were observed. An updated version of
> udp_tai.c is attached to this cover letter.
> 
> For last, most of the To Dos we still have before a final patchset are related
> to further testing the igb support:
>  - testing with L2 only talkers + AF_PACKET sockets;
>  - testing tbs in conjunction with cbs;
> 
> Thanks for all the feedback so far,
> Jesus

-Henrik
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180308/d020e0c8/attachment.asc>
