From: Henrik Austad <henrik@austad.us>
Date: Mon, 18 Sep 2017 13:46:52 +0200
Subject: [Intel-wired-lan] [RFC net-next 0/5] TSN: Add qdisc-based
 config interfaces for traffic shapers
In-Reply-To: <20170918080214.yrejz67wwnp2pjzf@localhost>
References: <20170901012625.14838-1-vinicius.gomes@intel.com>
 <20170918080214.yrejz67wwnp2pjzf@localhost>
Message-ID: <20170918114652.GA13349@sisyphus.home.austad.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Sep 18, 2017 at 10:02:14AM +0200, Richard Cochran wrote:
> On Thu, Aug 31, 2017 at 06:26:20PM -0700, Vinicius Costa Gomes wrote:
> >  * Time-aware shaper (802.1Qbv):
> 
> I just posted a working alternative showing how to handle 802.1Qbv and
> many other Ethernet field buses.

Yes, I saw them, grabbing them for testing now - thanks!

> >    The idea we are currently exploring is to add a "time-aware", priority based
> >    qdisc, that also exposes the Tx queues available and provides a mechanism for
> >    mapping priority <-> traffic class <-> Tx queues in a similar fashion as
> >    mqprio. We are calling this qdisc 'taprio', and its 'tc' cmd line would be:
> > 
> >    $ $ tc qdisc add dev ens4 parent root handle 100 taprio num_tc 4    \
> >      	   map 2 2 1 0 3 3 3 3 3 3 3 3 3 3 3 3                         \
> > 	   queues 0 1 2 3                                              \
> >      	   sched-file gates.sched [base-time <interval>]               \
> >            [cycle-time <interval>] [extension-time <interval>]
> > 
> >    <file> is multi-line, with each line being of the following format:
> >    <cmd> <gate mask> <interval in nanoseconds>
> > 
> >    Qbv only defines one <cmd>: "S" for 'SetGates'
> > 
> >    For example:
> > 
> >    S 0x01 300
> >    S 0x03 500
> > 
> >    This means that there are two intervals, the first will have the gate
> >    for traffic class 0 open for 300 nanoseconds, the second will have
> >    both traffic classes open for 500 nanoseconds.
> 
> The idea of the schedule file will not work in practice.  Consider the
> fact that the application wants to deliver time critical data in a
> particular slot.  How can it find out a) what the time slots are and
> b) when the next slot is scheduled?  With this Qdisc, it cannot do
> this, AFAICT.  The admin might delete the file after configuring the
> Qdisc!
> 
> Using the SO_TXTIME option, the application has total control over the
> scheduling.  The great advantages of this approach is that we can
> support any possible combination of periodic or aperiodic scheduling
> and we can support any priority scheme user space dreams up.

Using SO_TXTIME makes a lot of sense. TSN has a presentation_time, which 
you can use to deduce the time it should be transmitted (Class A has a 2ms 
latency guarantee, B has 50), but given how TSN uses the timestamp, it will 
wrap every 4.3 seconds, using SO_TXTIME allows you to schedule transmission 
at a much later time. It should also lessen the dependency on a specific 
protocol, which is also good.

> For example, one can imaging running two or more loops that only
> occasionally collide.  When they do collide, which packet should be
> sent first?  Just let user space decide.

If 2 userspace apps send to the same Tx-queue with the same priority, would 
it not make sense to just do FIFO? For all practical purposes, they have 
the same importance (same SO_PRIORITY, same SO_TXTIME). If the priority 
differs, then they would be directed to different queues, where one queue 
will take presedence anyway.

How far into the future would it make sense to schedule packets anyway?

I'll have a look at the other series you just posted!

-- 
Henrik Austad
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170918/4ed5b8c4/attachment.asc>
