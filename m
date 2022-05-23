From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 23 May 2022 14:31:16 -0700
Subject: [Intel-wired-lan] [PATCH net-next v5 00/11] ethtool: Add
 support for frame preemption
In-Reply-To: <20220523203214.ooixl3vb5q6cgwfq@skbuf>
References: <20220520011538.1098888-1-vinicius.gomes@intel.com>
 <20220520153413.16c6830b@kernel.org>
 <20220521150304.3lhpraxpssjxfhai@skbuf>
 <20220523125238.6f73b9f5@kernel.org>
 <20220523203214.ooixl3vb5q6cgwfq@skbuf>
Message-ID: <20220523143116.47df6b34@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 23 May 2022 20:32:15 +0000 Vladimir Oltean wrote:
> > > | In a port of a Bridge or station that supports frame preemption, a frame
> > > | of priority n is not available for transmission if that priority is
> > > | identified in the frame preemption status table (6.7.2) as preemptible
> > > | and either the holdRequest object (12.30.1.5) is set to the value hold,
> > > | or the transmission of a prior preemptible frame has yet to complete
> > > | because it has been interrupted to allow the transmission of an express
> > > | frame.
> > > 
> > > So since the managed objects for frame preemption are stipulated by IEEE
> > > per priority:
> > > 
> > > | The framePreemptionStatusTable (6.7.2) consists of 8
> > > | framePreemptionAdminStatus values (12.30.1.1.1), one per priority.
> > > 
> > > I think it is only reasonable for Linux to expose the same thing, and
> > > let drivers do the priority to queue or traffic class remapping as they
> > > see fit, when tc-mqprio or tc-taprio or other qdiscs that change this
> > > mapping are installed (if their preemption hardware implementation is
> > > per TC or queue rather than per priority). After all, you can have 2
> > > priorities mapped to the same TC, but still have one express and one
> > > preemptible. That is to say, you can implement preemption even in single
> > > "queue" devices, and it even makes sense.  
> > 
> > Honestly I feel like I'm missing a key detail because all you wrote
> > sounds like an argument _against_ exposing the queue mask in ethtool.  
> 
> Yeah, I guess the key detail that you're missing is that there's no such
> thing as "preemptible queue mask" in 802.1Q. My feeling is that both
> Vinicius and myself were confused in different ways by some spec
> definitions and had slightly different things in mind, and we've
> essentially ended up debating where a non-standard thing should go.
> 
> In my case, I said in my reply to the previous patch set that a priority
> is essentially synonymous with a traffic class (which it isn't, as per
> the definitions above), so I used the "traffic class" term incorrectly
> and didn't capitalize the "priority" word, which I should have.
> https://patchwork.kernel.org/project/netdevbpf/patch/20210626003314.3159402-3-vinicius.gomes at intel.com/#24812068
> 
> In Vinicius' case, part of the confusion might come from the fact that
> his hardware really has preemption configurable per queue, and he
> mistook it for the standard itself.
> 
> > Neither the standard calls for it, nor is it convenient to the user
> > who sets the prio->tc and queue allocation in TC.
> > 
> > If we wanted to expose prio mask in ethtool, that's a different story.  
> 
> Re-reading what I've said, I can't say "I was right all along"
> (not by a long shot, sorry for my part in the confusion),

Sorry, I admit I did not go back to the archives to re-read your
feedback today. I'm purely reacting to the fact that the "preemptible
queue mask" attribute which I have successfully fought off in the
past have now returned.

Let me also spell out the source of my objection - high speed NICs
have multitude of queues, queue groups and sub-interfaces. ethtool
uAPI which uses a zero-based integer ID will lead to confusion and lack
of portability because users will not know the mapping and vendors
will invent whatever fits their HW best.

> but I guess the conclusion is that:
> 
> (a) "preemptable queues" needs to become "preemptable priorities" in the
>     UAPI. The question becomes how to expose the mask of preemptable
>     priorities. A simple u8 bit mask where "BIT(i) == 1" means "prio i
>     is preemptable", or with a nested netlink attribute scheme similar
>     to DCB_PFC_UP_ATTR_0 -> DCB_PFC_UP_ATTR_7?

No preference there, we can also put it in DCBnl, if it fits better.

> (b) keeping the "preemptable priorities" away from tc-qdisc is ok

Ack.

> (c) non-standard hardware should deal with prio <-> queue mapping by
>     itself if its queues are what are preemptable

I'd prefer if the core had helpers to do the mapping for drivers, 
but in principle yes - make the preemptible queues an implementation
detail if possible.
