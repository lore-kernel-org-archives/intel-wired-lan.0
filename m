From: Henrik Austad <henrik@austad.us>
Date: Tue, 19 Sep 2017 15:14:43 +0200
Subject: [Intel-wired-lan] [RFC net-next 0/5] TSN: Add qdisc-based
 config interfaces for traffic shapers
In-Reply-To: <20170919052244.77umdxuze53t6j22@localhost>
References: <20170901012625.14838-1-vinicius.gomes@intel.com>
 <20170918080214.yrejz67wwnp2pjzf@localhost>
 <87k20vip3f.fsf@intel.com>
 <20170919052244.77umdxuze53t6j22@localhost>
Message-ID: <20170919131443.GA28667@sisyphus.home.austad.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi all,

On Tue, Sep 19, 2017 at 07:22:44AM +0200, Richard Cochran wrote:
> On Mon, Sep 18, 2017 at 04:06:28PM -0700, Vinicius Costa Gomes wrote:
> > That's the point, the application does not need to know that, and asking
> > that would be stupid.
> 
> On the contrary, this information is essential to the application.
> Probably you have never seen an actual Ethernet field bus in
> operation?  In any case, you are missing the point.
> 
> > (And that's another nice point of how 802.1Qbv works, applications do
> > not need to be changed to use it, and I think we should work to achieve
> > this on the Linux side)
> 
> Once you start to care about real time performance, then you need to
> consider the applications.  This is industrial control, not streaming
> your tunes from your ipod.

Do not underestimate the need for media over TSN. I fully see your point of 
real-time systems, but they are not the only valid use-cases for TSN.

> > That being said, that only works for kinds of traffic that maps well to
> > this configuration in advance model, which is the model that the IEEE
> > (see 802.1Qcc) and the AVNU Alliance[1] are pushing for.
> 
> Again, you are missing the point of what they aiming for.  I have
> looked at a number of production systems, and in each case the
> developers want total control over the transmission, in order to
> reduce latency to an absolute minimum.  Typically the data to be sent
> are available only microseconds before the transmission deadline.
> 
> Consider OpenAVB on github that people are already using.  Take a look
> at simple_talker.c and explain how "applications do not need to be
> changed to use it."

I do not think simple-talker was everintended to be how users of AVB should 
be implemented, but as a demonstration of what the protocol could do.

ALSA/V4L2 should supply some interface to this so that you can attach 
media-applications to it without the application itself having to be "TSN 
aware".

> > [1]
> > http://avnu.org/theory-of-operation-for-tsn-enabled-industrial-systems/
> 
> Did you even read this?
> 
>     [page 24]
> 
>     As described in section 2, some industrial control systems require
>     predictable, very low latency and cycle-to-cycle variation to meet
>     hard real-time application requirements. In these systems,
>     multiple distributed controllers commonly synchronize their
>     sensor/actuator operations with other controllers by scheduling
>     these operations in time, typically using a repeating control
>     cycle.
>     ...
>     The gate control mechanism is itself a time-aware PTP application
>     operating within a bridge or end station port.
> 
> It is an application, not a "god box."
>
> > In short, I see a per-packet transmission time and a per-queue schedule
> > as solutions to different problems.
> 
> Well, I can agree with that.  For some non real-time applications,
> bandwidth shaping is enough, and your Qdisc idea is sufficient.  For
> the really challenging TSN targets (industrial control, automotive),
> your idea of an opaque schedule file won't fly.

Would it make sense to adapt the proposed Qdisc here as well as the 
back-o-the-napkin idea in the other thread to to a per-socket queue for 
each priority and then sort those sockets based on SO_TXTIME?

TSN operates on a per-StreamID basis, and that should map fairly well to a 
per-socket approach I think (let us just assume that an application that 
sends TSN traffic will open up a separate socket for each stream.

This should allow a userspace application that is _very_ aware of its 
timing constraints to send frames exactly when it needs to as you have 
SO_TXTIME available. It would also let applications that basically want a 
fine-grained rate control (audio and video comes to mind) to use the same 
qdisc.

For those sockets that do not support SO_TXTIME, but still map to a 
priority handled by sch_cbs (or whatever it'll end up being called) you can 
set the transmit-time to be the time of the last skb in the queue + an 
delta which will give you the correct rate (TSN operates on observation 
intervals which you can specify via tc when you create the queues).

Then you can have, as you propose in your other series, a hrtimer that is 
being called when the next SO_TXTIME enters, grab a skb and move it to the 
hw-queue. This should also allow you to keep a sorted per-socket queue 
should an application send frames in the wrong order, without having to 
rearrange descriptors for the DMA machinery.

If this makes sense, I am more than happy to give it a stab and see how it 
goes.

-Henrik
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170919/05b03c2f/attachment.asc>
