From: Petr Machata <petrm@nvidia.com>
Date: Tue, 9 Nov 2021 15:52:33 +0100
Subject: [Intel-wired-lan] [PATCH v2 net-next 6/6] docs: net: Add
 description of SyncE interfaces
In-Reply-To: <MW5PR11MB5812B0A4E6227C6896AC12B5EA929@MW5PR11MB5812.namprd11.prod.outlook.com>
References: <20211105205331.2024623-1-maciej.machnikowski@intel.com>
 <20211105205331.2024623-7-maciej.machnikowski@intel.com>
 <87r1bqcyto.fsf@nvidia.com>
 <MW5PR11MB5812B0A4E6227C6896AC12B5EA929@MW5PR11MB5812.namprd11.prod.outlook.com>
Message-ID: <87mtmdcrf2.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


Machnikowski, Maciej <maciej.machnikowski@intel.com> writes:

>> Maciej Machnikowski <maciej.machnikowski@intel.com> writes:
>> 
>> > +====================
>> > +Synchronous Ethernet
>> > +====================
>> > +
>> > +Synchronous Ethernet networks use a physical layer clock to syntonize
>> > +the frequency across different network elements.
>> > +
>> > +Basic SyncE node defined in the ITU-T G.8264 consist of an Ethernet
>> > +Equipment Clock (EEC) and a PHY that has dedicated outputs of recovered
>> clocks
>> > +and a dedicated TX clock input that is used as to transmit data to other
>> nodes.
>> > +
>> > +The SyncE capable PHY is able to recover the incomning frequency of the
>> data
>> > +stream on RX lanes and redirect it (sometimes dividing it) to recovered
>> > +clock outputs. In SyncE PHY the TX frequency is directly dependent on the
>> > +input frequency - either on the PHY CLK input, or on a dedicated
>> > +TX clock input.
>> > +
>> > +      ????????????????????????
>> > +      ? RX        ? TX       ?
>> > +  1   ? lanes     ? lanes    ? 1
>> > +  ????????????    ?          ???????
>> > +  2   ?      ?    ?          ? 2
>> > +  ????????   ?    ?          ???????
>> > +  3   ?  ?   ?    ?          ? 3
>> > +  ????????   ?    ?          ???????
>> > +      ? ??????    ?          ?
>> > +      ? \____/    ?          ?
>> > +      ????????????????????????
>> > +        1? 2?        ?
>> > + RCLK out?  ?        ? TX CLK in
>> > +         ?  ?        ?
>> > +       ???????????????????
>> > +       ?                 ?
>> > +       ?       EEC       ?
>> > +       ?                 ?
>> > +       ???????????????????
>> > +
>> > +The EEC can synchronize its frequency to one of the synchronization
>> inputs
>> > +either clocks recovered on traffic interfaces or (in advanced deployments)
>> > +external frequency sources.
>> > +
>> > +Some EEC implementations can select synchronization source through
>> > +priority tables and synchronization status messaging and provide
>> necessary
>> > +filtering and holdover capabilities.
>> > +
>> > +The following interface can be applicable to diffferent packet network
>> types
>> > +following ITU-T G.8261/G.8262 recommendations.
>> > +
>> > +Interface
>> > +=========
>> > +
>> > +The following RTNL messages are used to read/configure SyncE recovered
>> > +clocks.
>> > +
>> > +RTM_GETRCLKRANGE
>> > +-----------------
>> > +Reads the allowed pin index range for the recovered clock outputs.
>> > +This can be aligned to PHY outputs or to EEC inputs, whichever is
>> > +better for a given application.
>> > +Will call the ndo_get_rclk_range function to read the allowed range
>> > +of output pin indexes.
>> > +Will call ndo_get_rclk_range to determine the allowed recovered clock
>> > +range and return them in the IFLA_RCLK_RANGE_MIN_PIN and the
>> > +IFLA_RCLK_RANGE_MAX_PIN attributes
>> > +
>> > +RTM_GETRCLKSTATE
>> > +-----------------
>> > +Read the state of recovered pins that output recovered clock from
>> > +a given port. The message will contain the number of assigned clocks
>> > +(IFLA_RCLK_STATE_COUNT) and an N pin indexes in
>> IFLA_RCLK_STATE_OUT_IDX
>> > +To support multiple recovered clock outputs from the same port, this
>> message
>> > +will return the IFLA_RCLK_STATE_COUNT attribute containing the number
>> of
>> > +active recovered clock outputs (N) and N IFLA_RCLK_STATE_OUT_IDX
>> attributes
>> > +listing the active output indexes.
>> > +This message will call the ndo_get_rclk_range to determine the allowed
>> > +recovered clock indexes and then will loop through them, calling
>> > +the ndo_get_rclk_state for each of them.
>> 
>> Let me make sure I understand the model that you propose. Specifically
>> from the point of view of a multi-port device, because that's my
>> immediate use case.
>> 
>> RTM_GETRCLKRANGE would report number of "pins" that matches the
>> number
>> of lanes in the system. So e.g. a 32-port switch, where each port has 4
>> lanes, would give a range of [1; 128], inclusive. (Or maybe [0; 128) or
>> whatever.)
>> 
>> RTM_GETRCLKSTATE would then return some subset of those pins,
>> depending
>> on which lanes actually managed to establish a connection and carry a
>> valid clock signal. So, say, [1, 2, 3, 4] if the first port has e.g. a
>> 100Gbps established.
>> 
>
> Those 2 will be merged into a single RTM_GETRCLKSTATE that will report
> the state of all available pins for a given port.
>
> Also lanes here should really be ports - will fix in next revision.
>
> But the logic will be: 
> Call the RTM_GETRCLKSTATE. It will return the list of pins and their state
> for a given port. Once you read the range you will send the RTM_SETRCLKSTATE
> to enable the redirection to a given RCLK output from the PHY. If your DPLL/EEC
> is configured to accept it automatically - it's all you need to do and you need to
> wait for the right state of the EEC (locked/locked with HO).

Ha, ok, so the RANGE call goes away, it's all in the RTM_GETRCLKSTATE.

>> > +
>> > +RTM_SETRCLKSTATE
>> > +-----------------
>> > +Sets the redirection of the recovered clock for a given pin. This message
>> > +expects one attribute:
>> > +struct if_set_rclk_msg {
>> > +	__u32 ifindex; /* interface index */
>> > +	__u32 out_idx; /* output index (from a valid range)
>> > +	__u32 flags; /* configuration flags */
>> > +};
>> > +
>> > +Supported flags are:
>> > +SET_RCLK_FLAGS_ENA - if set in flags - the given output will be enabled,
>> > +		     if clear - the output will be disabled.
>> 
>> OK, so here I set up the tracking. ifindex tells me which EEC to
>> configure, out_idx is the pin to track, flags tell me whether to set up
>> the tracking or tear it down. Thus e.g. on port 2, track pin 2, because
>> I somehow know that lane 2 has the best clock.
>
> It's bound to ifindex to know which PHY port you interact with. It has nothing to
> do with the EEC yet.

It has in the sense that I'm configuring "TX CLK in", which leads from
EEC to the port.

>> If the above is broadly correct, I've got some questions.
>> 
>> First, what if more than one out_idx is set? What are drivers / HW meant
>> to do with this? What is the expected behavior?
>
> Expected behavior is deployment specific. You can use different phy recovered
> clock outputs to implement active/passive mode of clock failover.

How? Which one is primary and which one is backup? I just have two
enabled pins...

Wouldn't failover be implementable in a userspace daemon? That would get
a notification from the system that holdover was entered, and can
reconfigure tracking to another pin based on arbitrary rules.

>> Also GETRCLKSTATE and SETRCLKSTATE have a somewhat different scope:
>> one
>> reports which pins carry a clock signal, the other influences tracking.
>> That seems wrong. There also does not seems to be an UAPI to retrieve
>> the tracking settings.
>
> They don't. Get reads the redirection state and SET sets it - nothing more,
> nothing less. In ICE we use EEC pin indexes so that the model translates easier
> to the one when we support DPLL subsystem.
>
>> Second, as a user-space client, how do I know that if ports 1 and 2 both
>> report pin range [A; B], that they both actually share the same
>> underlying EEC? Is there some sort of coordination among the drivers,
>> such that each pin in the system has a unique ID?
>
> For now we don't, as we don't have EEC subsystem. But that can be solved
> by a config file temporarily.

I think it would be better to model this properly from day one.

>> Further, how do I actually know the mapping from ports to pins? E.g. as
>> a user, I might know my master is behind swp1. How do I know what pins
>> correspond to that port? As a user-space tool author, how do I help
>> users to do something like "eec set clock eec0 track swp1"?
>
> That's why driver needs to be smart there and return indexes properly.

What do you mean, properly? Up there you have RTM_GETRCLKRANGE that just
gives me a min and a max. Is there a policy about how to correlate
numbers in that range to... ifindices, netdevice names, devlink port
numbers, I don't know, something?

How do several drivers coordinate this numbering among themselves? Is
there a core kernel authority that manages pin number de/allocations?

>> Additionally, how would things like external GPSs or 1pps be modeled? I
>> guess the driver would know about such interface, and would expose it as
>> a "pin". When the GPS signal locks, the driver starts reporting the pin
>> in the RCLK set. Then it is possible to set up tracking of that pin.
>
> That won't be enabled before we get the DPLL subsystem ready.

It might prove challenging to retrofit an existing netdev-centric
interface into a more generic model. It would be better to model this
properly from day one, and OK, if we can carve out a subset of that
model to implement now, and leave the rest for later, fine. But the
current model does not strike me as having a natural migration path to
something more generic. E.g. reporting the EEC state through the
interfaces attached to that EEC... like, that will have to stay, even at
a time when it is superseded by a better interface.

>> It seems to me it would be easier to understand, and to write user-space
>> tools and drivers for, a model that has EEC as an explicit first-class
>> object. That's where the EEC state naturally belongs, that's where the
>> pin range naturally belongs. Netdevs should have a reference to EEC and
>> pins, not present this information as if they own it. A first-class EEC
>> would also allow to later figure out how to hook up PHC and EEC.
>
> We have the userspace tool, but can?t upstream it until we define
> kernel Interfaces. It's paragraph 22 :(

I'm sure you do, presumably you test this somehow. Still, as a potential
consumer of that interface, I will absolutely poke at it to figure out
how to use it, what it lets me to do, and what won't work.

BTW, what we've done in the past in a situation like this was, here's
the current submission, here's a pointer to a GIT with more stuff we
plan to send later on, here's a pointer to a GIT with the userspace
stuff. I doubt anybody actually looks at that code, ain't nobody got
time for that, but really there's no catch 22.
