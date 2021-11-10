From: Petr Machata <petrm@nvidia.com>
Date: Wed, 10 Nov 2021 11:27:05 +0100
Subject: [Intel-wired-lan] [PATCH v2 net-next 6/6] docs: net: Add
 description of SyncE interfaces
In-Reply-To: <MW5PR11MB5812D4A8419C37FE9C890D3AEA929@MW5PR11MB5812.namprd11.prod.outlook.com>
References: <20211105205331.2024623-1-maciej.machnikowski@intel.com>
 <20211105205331.2024623-7-maciej.machnikowski@intel.com>
 <87r1bqcyto.fsf@nvidia.com>
 <MW5PR11MB5812B0A4E6227C6896AC12B5EA929@MW5PR11MB5812.namprd11.prod.outlook.com>
 <87mtmdcrf2.fsf@nvidia.com>
 <MW5PR11MB5812D4A8419C37FE9C890D3AEA929@MW5PR11MB5812.namprd11.prod.outlook.com>
Message-ID: <87bl2scnly.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


Machnikowski, Maciej <maciej.machnikowski@intel.com> writes:

>> Ha, ok, so the RANGE call goes away, it's all in the RTM_GETRCLKSTATE.
>
> The functionality needs to be there, but the message will be gone.

Gotcha.

>> >> > +RTM_SETRCLKSTATE
>> >> > +-----------------
>> >> > +Sets the redirection of the recovered clock for a given pin. This
>> message
>> >> > +expects one attribute:
>> >> > +struct if_set_rclk_msg {
>> >> > +	__u32 ifindex; /* interface index */
>> >> > +	__u32 out_idx; /* output index (from a valid range)
>> >> > +	__u32 flags; /* configuration flags */
>> >> > +};
>> >> > +
>> >> > +Supported flags are:
>> >> > +SET_RCLK_FLAGS_ENA - if set in flags - the given output will be enabled,
>> >> > +		     if clear - the output will be disabled.
>> >>
>> >> OK, so here I set up the tracking. ifindex tells me which EEC to
>> >> configure, out_idx is the pin to track, flags tell me whether to set up
>> >> the tracking or tear it down. Thus e.g. on port 2, track pin 2, because
>> >> I somehow know that lane 2 has the best clock.
>> >
>> > It's bound to ifindex to know which PHY port you interact with. It
>> > has nothing to do with the EEC yet.
>>
>> It has in the sense that I'm configuring "TX CLK in", which leads
>> from EEC to the port.
>
> At this stage we only enable the recovered clock. EEC may or may not
> use it depending on many additional factors.
>
>> >> If the above is broadly correct, I've got some questions.
>> >>
>> >> First, what if more than one out_idx is set? What are drivers / HW
>> >> meant to do with this? What is the expected behavior?
>> >
>> > Expected behavior is deployment specific. You can use different phy
>> > recovered clock outputs to implement active/passive mode of clock
>> > failover.
>>
>> How? Which one is primary and which one is backup? I just have two
>> enabled pins...
>
> With this API you only have ports and pins and set up the redirection.

Wait, so how do I do failover? Which of the set pins in primary and
which is backup? Should the backup be sticky, i.e. do primary and backup
switch roles after primary goes into holdover? It looks like there are a
number of policy decisions that would be best served by a userspace
tool.

> The EEC part is out of picture and will be part of DPLL subsystem.

So about that. I don't think it's contentious to claim that you need to
communicate EEC state somehow. This proposal does that through a netdev
object. After the DPLL subsystem comes along, that will necessarily
provide the same information, and the netdev interface will become
redundant, but we will need to keep it around.

That is a strong indication that a first-class DPLL object should be
part of the initial submission.

>> Wouldn't failover be implementable in a userspace daemon? That would get
>> a notification from the system that holdover was entered, and can
>> reconfigure tracking to another pin based on arbitrary rules.
>
> Not necessarily. You can deploy the QL-disabled mode and rely on the
> local DPLL configuration to manage the switching. In that mode you're
> not passing the quality level downstream, so you only need to know if you
> have a source.

The daemon can reconfigure tracking to another pin based on _arbitrary_
rules. They don't have to involve QL in any way. Can be round-robin,
FIFO, random choice... IMO it's better than just enabling a bunch of
pins and not providing any guidance as to the policy.

>> >> Second, as a user-space client, how do I know that if ports 1 and
>> >> 2 both report pin range [A; B], that they both actually share the
>> >> same underlying EEC? Is there some sort of coordination among the
>> >> drivers, such that each pin in the system has a unique ID?
>> >
>> > For now we don't, as we don't have EEC subsystem. But that can be
>> > solved by a config file temporarily.
>>
>> I think it would be better to model this properly from day one.
>
> I want to propose the simplest API that will work for the simplest
> device, follow that with the userspace tool that will help everyone
> understand what we need in the DPLL subsystem, otherwise it'll be hard
> to explain the requirements. The only change will be the addition of
> the DPLL index.

That would be fine if there were a migration path to the more complete
API. But as DPLL object is introduced, even the APIs that are superseded
by the DPLL APIs will need to stay in as a baggage.

>> >> Further, how do I actually know the mapping from ports to pins?
>> >> E.g. as a user, I might know my master is behind swp1. How do I
>> >> know what pins correspond to that port? As a user-space tool
>> >> author, how do I help users to do something like "eec set clock
>> >> eec0 track swp1"?
>> >
>> > That's why driver needs to be smart there and return indexes
>> > properly.
>>
>> What do you mean, properly? Up there you have RTM_GETRCLKRANGE that
>> just gives me a min and a max. Is there a policy about how to
>> correlate numbers in that range to... ifindices, netdevice names,
>> devlink port numbers, I don't know, something?
>
> The driver needs to know the underlying HW and report those ranges
> correctly.

How do I know _as a user_ though? As a user I want to be able to say
something like "eec set dev swp1 track dev swp2". But the "eec" tool has
no way of knowing how to set that up.

>> How do several drivers coordinate this numbering among themselves? Is
>> there a core kernel authority that manages pin number de/allocations?
>
> I believe the goal is to create something similar to the ptp
> subsystem. The driver will need to configure the relationship during
> initialization and the OS will manage the indexes.

Can you point at the index management code, please?

>> >> Additionally, how would things like external GPSs or 1pps be
>> >> modeled? I guess the driver would know about such interface, and
>> >> would expose it as a "pin". When the GPS signal locks, the driver
>> >> starts reporting the pin in the RCLK set. Then it is possible to
>> >> set up tracking of that pin.
>> >
>> > That won't be enabled before we get the DPLL subsystem ready.
>>
>> It might prove challenging to retrofit an existing netdev-centric
>> interface into a more generic model. It would be better to model this
>> properly from day one, and OK, if we can carve out a subset of that
>> model to implement now, and leave the rest for later, fine. But the
>> current model does not strike me as having a natural migration path to
>> something more generic. E.g. reporting the EEC state through the
>> interfaces attached to that EEC... like, that will have to stay, even at
>> a time when it is superseded by a better interface.
>
> The recovered clock API will not change - only EEC_STATE is in
> question. We can either redirect the call to the DPLL subsystem, or
> just add the DPLL IDX Into that call and return it.

It would be better to have a first-class DPLL object, however vestigial,
in the initial submission.

>> >> It seems to me it would be easier to understand, and to write
>> >> user-space tools and drivers for, a model that has EEC as an
>> >> explicit first-class object. That's where the EEC state naturally
>> >> belongs, that's where the pin range naturally belongs. Netdevs
>> >> should have a reference to EEC and pins, not present this
>> >> information as if they own it. A first-class EEC would also allow
>> >> to later figure out how to hook up PHC and EEC.
>> >
>> > We have the userspace tool, but can?t upstream it until we define
>> > kernel Interfaces. It's paragraph 22 :(
>>
>> I'm sure you do, presumably you test this somehow. Still, as a
>> potential consumer of that interface, I will absolutely poke at it to
>> figure out how to use it, what it lets me to do, and what won't work.
>
> That's why now I want to enable very basic functionality that will not
> go away anytime soon.

The issue is that the APIs won't go away any time soon either. That's
why people object to your proposal so strongly. Because we won't be able
to fix this later, and we _already_ see shortcomings now.

> Mapping between port and recovered clock (as in take my clock and
> output on the first PHY's recovered clock output) and checking the
> state of the clock.

Where is that mapping? I see a per-netdev call for a list of pins that
carry RCLK, and the state as well. I don't see a way to distinguish
which is which in any way.

>> BTW, what we've done in the past in a situation like this was, here's
>> the current submission, here's a pointer to a GIT with more stuff we
>> plan to send later on, here's a pointer to a GIT with the userspace
>> stuff. I doubt anybody actually looks at that code, ain't nobody got
>> time for that, but really there's no catch 22.
>
> Unfortunately, the userspace of it will be a part of linuxptp and we
> can't upstream it partially before we get those basics defined here.

Just push it to github or whereever?

> More advanced functionality will be grown organically, as I also have
> a limited view of SyncE and am not expert on switches.

We are growing it organically _right now_. I am strongly advocating an
organic growth in the direction of a first-class DPLL object.
