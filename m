From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 23 May 2022 22:49:44 +0000
Subject: [Intel-wired-lan] [PATCH net-next v5 00/11] ethtool: Add
 support for frame preemption
In-Reply-To: <20220523143116.47df6b34@kernel.org>
References: <20220520011538.1098888-1-vinicius.gomes@intel.com>
 <20220520153413.16c6830b@kernel.org> <20220521150304.3lhpraxpssjxfhai@skbuf>
 <20220523125238.6f73b9f5@kernel.org> <20220523203214.ooixl3vb5q6cgwfq@skbuf>
 <20220523143116.47df6b34@kernel.org>
Message-ID: <20220523224943.75oyvbxmyp2kjiwi@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, May 23, 2022 at 02:31:16PM -0700, Jakub Kicinski wrote:
> > > If we wanted to expose prio mask in ethtool, that's a different story.  
> > 
> > Re-reading what I've said, I can't say "I was right all along"
> > (not by a long shot, sorry for my part in the confusion),
> 
> Sorry, I admit I did not go back to the archives to re-read your
> feedback today. I'm purely reacting to the fact that the "preemptible
> queue mask" attribute which I have successfully fought off in the
> past have now returned.
> 
> Let me also spell out the source of my objection - high speed NICs
> have multitude of queues, queue groups and sub-interfaces. ethtool
> uAPI which uses a zero-based integer ID will lead to confusion and lack
> of portability because users will not know the mapping and vendors
> will invent whatever fits their HW best.

I'm re-reading even further back and noticing that I really did not use
the "traffic class" term with its correct meaning. I really meant
"priority" here too, in Dec 2020:
https://patchwork.kernel.org/project/netdevbpf/cover/20201202045325.3254757-1-vinicius.gomes at intel.com/#23827347

I see you were opposed to the "preemptable queue mask" idea, and so was
I, but apparently the way in which I formulated this was not quite clear.

> > but I guess the conclusion is that:
> > 
> > (a) "preemptable queues" needs to become "preemptable priorities" in the
> >     UAPI. The question becomes how to expose the mask of preemptable
> >     priorities. A simple u8 bit mask where "BIT(i) == 1" means "prio i
> >     is preemptable", or with a nested netlink attribute scheme similar
> >     to DCB_PFC_UP_ATTR_0 -> DCB_PFC_UP_ATTR_7?
> 
> No preference there, we can also put it in DCBnl, if it fits better.

TBH I don't think I understand what exactly belongs in dcbnl and what
doesn't. My running hypothesis so far was that it's the stuff negotiable
through the DCBX protocol, documented as 802.1Q clause 38 to be
(a) Enhanced Transmission Selection (ETS)
(b) Priority-based Flow Control (PFC)
(c) Application Priority TLV
(d) Application VLAN TLV

but
(1) Frame Preemption isn't negotiated through DCBX, so we should be safe there
(2) I never quite understood why the existence of the DCBX protocol or
    any other protocol would mandate what the kernel interfaces should
    look like. Following this model results in absurdities - unless I'm
    misunderstanding something, an extreme case of this seems to be ETS
    itself. As per the spec, the ETS parameters are numTrafficClassesSupported,
    TCPriorityAssignment and TCBandwidth. What's funny, though, is that
    coincidentally they aren't ETS-specific information, and we seem to
    be able to set the number of TCs of a port both with DCB_CMD_SNUMTCS
    and with tc-mqprio. Same with the priority -> tc map (struct ieee_ets ::
    prio_tc), not to mention shapers per traffic class which are also in
    tc-mqprio, etc.

My instinct so far was to stay away from adding new code to dcbnl and I
think I will continue to do that going forward, thank you.

> > (b) keeping the "preemptable priorities" away from tc-qdisc is ok
> 
> Ack.
> 
> > (c) non-standard hardware should deal with prio <-> queue mapping by
> >     itself if its queues are what are preemptable
> 
> I'd prefer if the core had helpers to do the mapping for drivers, 
> but in principle yes - make the preemptible queues an implementation
> detail if possible.

Yeah, those are details already.
