From: Petr Machata <petrm@nvidia.com>
Date: Fri, 3 Dec 2021 19:21:33 +0100
Subject: [Intel-wired-lan] [PATCH v4 net-next 2/4] ethtool: Add ability
 to configure recovered clock for SyncE feature
In-Reply-To: <MW5PR11MB5812AB9B6E0CAEB6F9A84ABAEA6A9@MW5PR11MB5812.namprd11.prod.outlook.com>
References: <20211201180208.640179-1-maciej.machnikowski@intel.com>
 <20211201180208.640179-3-maciej.machnikowski@intel.com>
 <Yai/e5jz3NZAg0pm@shredder>
 <MW5PR11MB5812455176BC656BABCFF1B0EA699@MW5PR11MB5812.namprd11.prod.outlook.com>
 <Yaj13pwDKrG78W5Y@shredder>
 <PH0PR11MB583105F8678665253A362797EA699@PH0PR11MB5831.namprd11.prod.outlook.com>
 <Yao7r4DF7NmobEdp@shredder>
 <MW5PR11MB5812AB9B6E0CAEB6F9A84ABAEA6A9@MW5PR11MB5812.namprd11.prod.outlook.com>
Message-ID: <87ilw5o8gi.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


Machnikowski, Maciej <maciej.machnikowski@intel.com> writes:

>> -----Original Message-----
>> From: Ido Schimmel <idosch@idosch.org>
>> Sent: Friday, December 3, 2021 4:46 PM
>> To: Machnikowski, Maciej <maciej.machnikowski@intel.com>
>> Subject: Re: [PATCH v4 net-next 2/4] ethtool: Add ability to configure
>> recovered clock for SyncE feature
>> 
>> On Thu, Dec 02, 2021 at 05:20:24PM +0000, Machnikowski, Maciej wrote:
>> > > -----Original Message-----
>> > > From: Ido Schimmel <idosch@idosch.org>
>> > > Sent: Thursday, December 2, 2021 5:36 PM
>> > > To: Machnikowski, Maciej <maciej.machnikowski@intel.com>
>> > > Subject: Re: [PATCH v4 net-next 2/4] ethtool: Add ability to configure
>> > > recovered clock for SyncE feature
>> > >
>> > > On Thu, Dec 02, 2021 at 03:17:06PM +0000, Machnikowski, Maciej wrote:
>> > > > > -----Original Message-----
>> > > > > From: Ido Schimmel <idosch@idosch.org>
>> > > > > Sent: Thursday, December 2, 2021 1:44 PM
>> > > > > To: Machnikowski, Maciej <maciej.machnikowski@intel.com>
>> > > > > Subject: Re: [PATCH v4 net-next 2/4] ethtool: Add ability to configure
>> > > > > recovered clock for SyncE feature
>> > > > >
>> > > > > On Wed, Dec 01, 2021 at 07:02:06PM +0100, Maciej Machnikowski wrote:
>> > > > > Looking at the diagram from the previous submission [1]:
>> > > > >
>> > > > >       ???????????????????????
>> > > > >       ? RX       ? TX       ?
>> > > > >   1   ? ports    ? ports    ? 1
>> > > > >   ???????????    ?          ???????
>> > > > >   2   ?     ?    ?          ? 2
>> > > > >   ????????? ?    ?          ???????
>> > > > >   3   ?   ? ?    ?          ? 3
>> > > > >   ??????? ? ?    ?          ???????
>> > > > >       ? ? ? ?    ?          ?
>> > > > >       ? ??????   ?          ?
>> > > > >       ? \____/   ?          ?
>> > > > >       ???????????????????????
>> > > > >         1? 2?        ?
>> > > > >  RCLK out?  ?        ? TX CLK in
>> > > > >          ?  ?        ?
>> > > > >        ???????????????????
>> > > > >        ?                 ?
>> > > > >        ?       SEC       ?
>> > > > >        ?                 ?
>> > > > >        ???????????????????
>> > > > >
>> > > > > Given a netdev (1, 2 or 3 in the diagram), the RCLK_SET
>> > > > > message allows me to redirect the frequency recovered from
>> > > > > this netdev to the EEC via either pin 1, pin 2 or both.
>> > > > >
>> > > > > Given a netdev, the RCLK_GET message allows me to query the
>> > > > > range of pins (RCLK out 1-2 in the diagram) through which the
>> > > > > frequency can be fed into the EEC.
>> > > > >
>> > > > > Questions:
>> > > > >
>> > > > > 1. The query for all the above netdevs will return the same
>> > > > > range of pins. How does user space know that these are the
>> > > > > same pins? That is, how does user space know that RCLK_SET
>> > > > > message to redirect the frequency recovered from netdev 1 to
>> > > > > pin 1 will be overridden by the same message but for netdev
>> > > > > 2?
>> > > >
>> > > > We don't have a way to do so right now. When we have EEC
>> > > > subsystem in place the right thing to do will be to add EEC
>> > > > input index and EEC index as additional arguments
>> > > >
>> > > > > 2. How does user space know the mapping between a netdev and
>> > > > > an EEC? That is, how does user space know that RCLK_SET
>> > > > > message for netdev 1 will cause the Tx frequency of netdev 2
>> > > > > to change according to the frequency recovered from netdev 1?
>> > > >
>> > > > Ditto - currently we don't have any entity to link the pins to
>> > > > ATM, but we can address that in userspace just like PTP pins
>> > > > are used now
>> > > >
>> > > > > 3. If user space sends two RCLK_SET messages to redirect the
>> > > > > frequency recovered from netdev 1 to RCLK out 1 and from
>> > > > > netdev 2 to RCLK out 2, how does it know which recovered
>> > > > > frequency is actually used an input to the EEC?
>> > >
>> > > User space doesn't know this as well?
>> >
>> > In current model it can come from the config file. Once we
>> > implement DPLL subsystem we can implement connection between pins
>> > and DPLLs if they are known.
>> 
>> To be clear, no SyncE patches should be accepted before we have a
>> DPLL subsystem or however the subsystem that will model the EEC is
>> going to be called.
>> 
>> You are asking us to buy into a new uAPI that can never be removed.
>> We pointed out numerous problems with this uAPI and suggested a model
>> that solves them. When asked why it can't work we are answered with
>> vague arguments about this model being "hard".
>
> My argument was never "it's hard" - the answer is we need both APIs.
>
>> In addition, without a representation of the EEC, these patches have
>> no value for user space. They basically allow user space to redirect
>> the recovered frequency from a netdev to an object that does not
>> exist. User space doesn't know if the object is successfully tracking
>> the frequency (the EEC state) and does not know which other
>> components are utilizing this recovered frequency as input (e.g.,
>> other netdevs, PHC).
>
> That's also not true - the proposed uAPI lets you enable recovered
> frequency output pins and redirect the right clock to them. In some
> implementations you may not have anything else.

Wait, are there EEC deployments where there is no way to determine the
EEC state?

>> BTW, what is the use case for enabling two EEC inputs simultaneously?
>> Some seamless failover?
>
> Mainly - redundacy
>
>> >
>> > > > >
>> > > > > 4. Why these pins are represented as attributes of a netdev
>> > > > > and not as attributes of the EEC? That is, why are they
>> > > > > represented as output pins of the PHY as opposed to input
>> > > > > pins of the EEC?
>> > > >
>> > > > They are 2 separate beings. Recovered clock outputs are
>> > > > controlled separately from EEC inputs.
>> > >
>> > > Separate how? What does it mean that they are controlled
>> > > separately? In which sense? That redirection of recovered
>> > > frequency to pin is controlled via PHY registers whereas priority
>> > > setting between EEC inputs is controlled via EEC registers? If
>> > > so, this is an implementation detail of a specific design. It is
>> > > not of any importance to user space.
>> >
>> > They belong to different devices. EEC registers are physically in
>> > the DPLL hanging over I2C and recovered clocks are in the
>> > PHY/integrated PHY in the MAC. Depending on system architecture you
>> > may have control over one piece only
>> 
>> These are implementation details of a specific design and should not
>> influence the design of the uAPI. The uAPI should be influenced by
>> the logical task that it is trying to achieve.
>
> There are 2 logical tasks:
> 1. Enable clocks that are recovered from a specific netdev
> 2. Control the EEC
>
> They are both needed to get to the full solution, but are independent
> from each other. You can't put RCLK redirection to the EEC as it's one
> to many relation and you will need to call the netdev to enable it
> anyway.

"Call the netdev"? When EEC decides a configuration needs to be done, it
will defer to a callback set up by whoever created the EEC object. EEC
doesn't care. If you have a disk that somehow contains an EEC to
syntonize disk spinning across the data center, go ahead and create the
object from a disk driver. Then the EEC object will invoke disk driver
code.

> Also, when we tried to add EEC state to PTP subsystem the answer was
> that we can't mix subsystems. The proposal to configure recovered
> clocks through EEC would mix netdev with EEC.

Involving MAC driver through an abstract interface is not mixing
subsystems. It's just loose coupling.

>> > > What do you mean by "multiple devices"? A multi-port adapter with
>> > > a single EEC or something else?
>> >
>> > Multiple MACs that use a single EEC clock.
>> >
>> > > > Also if we make those pins attributes of the EEC it'll become
>> > > > extremally hard to map them to netdevs and control them from
>> > > > the userspace app that will receive the ESMC message with a
>> > > > given QL level on netdev X.
>> > >
>> > > Hard how? What is the problem with something like:
>> > >
>> > > # eec set source 1 type netdev dev swp1
>> > >
>> > > The EEC object should be registered by the same entity that
>> > > registers the netdevs whose Tx frequency is controlled by the
>> > > EEC, the MAC driver.
>> >
>> > But the EEC object may not be controlled by the MAC - in which case
>> > this model won't work.
>> 
>> Why wouldn't it work? Leave individual kernel modules alone and look
>> at the kernel. It is registering all the necessary logical objects
>> such netdevs, PHCs and EECs. There is no way user space knows better
>> than the kernel how these objects fit together as the purpose of the
>> kernel is to abstract the hardware to user space.
>> 
>> User space's request to use the Rx frequency recovered from netdev X
>> as an input to EEC Y will be processed by the DPLL subsystem. In
>> turn, this subsystem will invoke whichever kernel modules it needs to
>> fulfill the request.
>
> But how would that call go through the kernel? What would you like to
> give to the EEC object and how should it react. I'm fine with the
> changes, but I don't see the solution in that proposal

You will give EEC object handle, RCLK source handle, and a handle of the
output pin to configure. These are all objects in the EEC subsystem.

Some of the RCLK sources are pre-attached to a netdevice, so they carry
an ifindex reference. Some are external and do not have a netdevice
(that's for NIC-to-NIC frequency bridges, external GPS's and whatnot).

Eventually to implement the request, the EEC object would call its
creator through a callback appropriate for the request.

> and this model would mix independent subsystems.

The only place where netdevices are tightly coupled to the EEC are those
pre-attached pins. But OK, EEC just happens to be very, very often part
of a NIC, and being able to say, this RCLK comes from swp1, is just
very, very handy. But it is not a requirement. The EEC model can just as
easily represent external pins, or weird stuff like boards that have
nothing _but_ external pins.

> The netdev -> EEC should be a downstream relation, just like the PTP
> is now If a netdev wants to check what's the state of EEC driving it -
> it can do it, but I don't see a way for the EEC subsystem to directly
> configure something in Potentially couple different MAC chips without
> calling a kind of netdev API. And that's what those patches address.

Either the device packages everything, e.g. a switch, or an EEC-enabled
NIC. In that case, the NIC driver instantiates the EEC, and pins, and
RCLK sources, and netdevices. EEC configuration ends up getting handled
by this device driver, because that's the way it set things up.

Or we have a NIC separate from the EEC, but there is still an option to
hook those up somehow. That looks like something that should probably be
represented by an EEC with some external RCLK sources. (Or maybe they
are just inout pins or whatever, that is a detail.) Then the EEC driver
ends up instantiating the object, and implementing the requests. And the
admin needs to have external information to know that external pin such
and such is actually connected to PHY such and such.
