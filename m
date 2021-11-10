From: Petr Machata <petrm@nvidia.com>
Date: Wed, 10 Nov 2021 16:15:10 +0100
Subject: [Intel-wired-lan] [PATCH v2 net-next 6/6] docs: net: Add
 description of SyncE interfaces
In-Reply-To: <MW5PR11MB5812034EA5FC331FA5A2D37CEA939@MW5PR11MB5812.namprd11.prod.outlook.com>
References: <20211105205331.2024623-1-maciej.machnikowski@intel.com>
 <20211105205331.2024623-7-maciej.machnikowski@intel.com>
 <87r1bqcyto.fsf@nvidia.com>
 <MW5PR11MB5812B0A4E6227C6896AC12B5EA929@MW5PR11MB5812.namprd11.prod.outlook.com>
 <87mtmdcrf2.fsf@nvidia.com>
 <MW5PR11MB5812D4A8419C37FE9C890D3AEA929@MW5PR11MB5812.namprd11.prod.outlook.com>
 <87bl2scnly.fsf@nvidia.com>
 <MW5PR11MB5812034EA5FC331FA5A2D37CEA939@MW5PR11MB5812.namprd11.prod.outlook.com>
Message-ID: <874k8kca9t.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


>> >> >> First, what if more than one out_idx is set? What are drivers / HW
>> >> >> meant to do with this? What is the expected behavior?
>> >> >
>> >> > Expected behavior is deployment specific. You can use different phy
>> >> > recovered clock outputs to implement active/passive mode of clock
>> >> > failover.
>> >>
>> >> How? Which one is primary and which one is backup? I just have two
>> >> enabled pins...
>> >
>> > With this API you only have ports and pins and set up the redirection.
>> 
>> Wait, so how do I do failover? Which of the set pins in primary and
>> which is backup? Should the backup be sticky, i.e. do primary and backup
>> switch roles after primary goes into holdover? It looks like there are a
>> number of policy decisions that would be best served by a userspace
>> tool.
>
> The clock priority is configured in the SEC/EEC/DPLL. Recovered clock API
> only configures the redirections (aka. Which clocks will be available to the
> DPLL as references). In some DPLLs the fallback is automatic as long as
> secondary clock is available when the primary goes away. Userspace tool
> can preconfigure that before the failure occurs.

OK, I see. It looks like this priority list implies which pins need to
be enabled. That makes the netdev interface redundant.

>> > The EEC part is out of picture and will be part of DPLL subsystem.
>> 
>> So about that. I don't think it's contentious to claim that you need to
>> communicate EEC state somehow. This proposal does that through a netdev
>> object. After the DPLL subsystem comes along, that will necessarily
>> provide the same information, and the netdev interface will become
>> redundant, but we will need to keep it around.
>> 
>> That is a strong indication that a first-class DPLL object should be
>> part of the initial submission.
>
> That's why only a bare minimum is proposed in this patch - reading the state
> and which signal is used as a reference.

The proposal includes APIs that we know _right now_ will be historical
baggage by the time the DPLL object is added. That does not constitute
bare minimum.

>> >> >> Second, as a user-space client, how do I know that if ports 1 and
>> >> >> 2 both report pin range [A; B], that they both actually share the
>> >> >> same underlying EEC? Is there some sort of coordination among the
>> >> >> drivers, such that each pin in the system has a unique ID?
>> >> >
>> >> > For now we don't, as we don't have EEC subsystem. But that can be
>> >> > solved by a config file temporarily.
>> >>
>> >> I think it would be better to model this properly from day one.
>> >
>> > I want to propose the simplest API that will work for the simplest
>> > device, follow that with the userspace tool that will help everyone
>> > understand what we need in the DPLL subsystem, otherwise it'll be hard
>> > to explain the requirements. The only change will be the addition of
>> > the DPLL index.
>> 
>> That would be fine if there were a migration path to the more complete
>> API. But as DPLL object is introduced, even the APIs that are superseded
>> by the DPLL APIs will need to stay in as a baggage.
>
> The migration paths are:
> A) when the DPLL API is there check if the DPLL object is linked to the given netdev
>      in the rtnl_eec_state_get - if it is - get the state from the DPLL object there
> or
> B) return the DPLL index linked to the given netdev and fail the rtnl_eec_state_get
>      so that the userspace tool will need to switch to the new API

Well, we call B) an API breakage, and it won't fly. That API is there to
stay, and operate like it operates now.

That leaves us with A), where the API becomes a redundant wart that we
can never get rid of.

> Also the rtnl_eec_state_get won't get obsolete in all cases once we get the DPLL
> subsystem, as there are solutions where SyncE DPLL is embedded in the PHY
> in which case the rtnl_eec_state_get will return all needed information without
> the need to create a separate DPLL object.

So the NIC or PHY driver will register the object. Easy peasy.

Allowing the interface to go through a netdev sometimes, and through a
dedicated object other times, just makes everybody's life harder. It's
two cases that need to be handled in user documentation, in scripts, in
UAPI clients, when reviewing kernel code.

This is a "hysterical raisins" sort of baggage, except we see up front
that's where it goes.

> The DPLL object makes sense for advanced SyncE DPLLs that provide
> additional functionality, such as external reference/output pins.

That does not need to be the case.

>> >> >> Further, how do I actually know the mapping from ports to pins?
>> >> >> E.g. as a user, I might know my master is behind swp1. How do I
>> >> >> know what pins correspond to that port? As a user-space tool
>> >> >> author, how do I help users to do something like "eec set clock
>> >> >> eec0 track swp1"?
>> >> >
>> >> > That's why driver needs to be smart there and return indexes
>> >> > properly.
>> >>
>> >> What do you mean, properly? Up there you have RTM_GETRCLKRANGE
>> that
>> >> just gives me a min and a max. Is there a policy about how to
>> >> correlate numbers in that range to... ifindices, netdevice names,
>> >> devlink port numbers, I don't know, something?
>> >
>> > The driver needs to know the underlying HW and report those ranges
>> > correctly.
>> 
>> How do I know _as a user_ though? As a user I want to be able to say
>> something like "eec set dev swp1 track dev swp2". But the "eec" tool has
>> no way of knowing how to set that up.
>
> There's no such flexibility. It's more like timing pins in the PTP subsystem - we
> expose the API to control them, but it's up to the final user to decide how 
> to use them.

As a user, say I know the signal coming from swp1 is freqency-locked.
How can I instruct the switch ASIC to propagate that signal to the other
ports? Well, I go through swp2..swpN, and issue RTM_SETRCLKSTATE or
whatever, with flags indicating I set up tracking, and pin number...
what exactly? How do I know which pin carries clock recovered from swp1?

> If we index the PHY outputs in the same way as the DPLL subsystem will
> see them in the references part it should be sufficient to make sense
> out of them.

What do you mean by indexing PHY outputs? Where are those indexed?

>> >> How do several drivers coordinate this numbering among themselves?
>> >> Is there a core kernel authority that manages pin number
>> >> de/allocations?
>> >
>> > I believe the goal is to create something similar to the ptp
>> > subsystem. The driver will need to configure the relationship
>> > during initialization and the OS will manage the indexes.
>> 
>> Can you point at the index management code, please?
>
> Look for the ptp_clock_register function in the kernel - it owns the
> registration of the ptp clock to the subsystem.

But I'm talking about the SyncE code.

>> >> >> Additionally, how would things like external GPSs or 1pps be
>> >> >> modeled? I guess the driver would know about such interface, and
>> >> >> would expose it as a "pin". When the GPS signal locks, the driver
>> >> >> starts reporting the pin in the RCLK set. Then it is possible to
>> >> >> set up tracking of that pin.
>> >> >
>> >> > That won't be enabled before we get the DPLL subsystem ready.
>> >>
>> >> It might prove challenging to retrofit an existing netdev-centric
>> >> interface into a more generic model. It would be better to model this
>> >> properly from day one, and OK, if we can carve out a subset of that
>> >> model to implement now, and leave the rest for later, fine. But the
>> >> current model does not strike me as having a natural migration path to
>> >> something more generic. E.g. reporting the EEC state through the
>> >> interfaces attached to that EEC... like, that will have to stay, even at
>> >> a time when it is superseded by a better interface.
>> >
>> > The recovered clock API will not change - only EEC_STATE is in
>> > question. We can either redirect the call to the DPLL subsystem, or
>> > just add the DPLL IDX Into that call and return it.
>> 
>> It would be better to have a first-class DPLL object, however vestigial,
>> in the initial submission.
>
> As stated above - DPLL subsystem won't render EEC state useless.

Of course not, the state is still important. But it will render the API
useless, and worse, an extra baggage everyone needs to know about and
support.

>> > More advanced functionality will be grown organically, as I also have
>> > a limited view of SyncE and am not expert on switches.
>> 
>> We are growing it organically _right now_. I am strongly advocating an
>> organic growth in the direction of a first-class DPLL object.
>
> If it helps - I can separate the PHY RCLK control patches and leave EEC state
> under review

Not sure what you mean by that.
