From: Machnikowski, Maciej <maciej.machnikowski@intel.com>
Date: Fri, 3 Dec 2021 16:50:07 +0000
Subject: [Intel-wired-lan] [PATCH v4 net-next 2/4] ethtool: Add ability
 to configure recovered clock for SyncE feature
In-Reply-To: <87lf11odsv.fsf@nvidia.com>
References: <20211201180208.640179-1-maciej.machnikowski@intel.com>
 <20211201180208.640179-3-maciej.machnikowski@intel.com>
 <Yai/e5jz3NZAg0pm@shredder>
 <MW5PR11MB5812455176BC656BABCFF1B0EA699@MW5PR11MB5812.namprd11.prod.outlook.com>
 <Yaj13pwDKrG78W5Y@shredder>
 <PH0PR11MB583105F8678665253A362797EA699@PH0PR11MB5831.namprd11.prod.outlook.com>
 <87pmqdojby.fsf@nvidia.com>
 <MW5PR11MB581202E2A601D34E30F1E5AEEA6A9@MW5PR11MB5812.namprd11.prod.outlook.com>
 <87lf11odsv.fsf@nvidia.com>
Message-ID: <MW5PR11MB5812A86416E3100444894879EA6A9@MW5PR11MB5812.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Petr Machata <petrm@nvidia.com>
> Sent: Friday, December 3, 2021 5:26 PM
> To: Machnikowski, Maciej <maciej.machnikowski@intel.com>
> Subject: Re: [PATCH v4 net-next 2/4] ethtool: Add ability to configure
> recovered clock for SyncE feature
> 
> 
> Machnikowski, Maciej <maciej.machnikowski@intel.com> writes:
> 
> >> -----Original Message-----
> >> From: Petr Machata <petrm@nvidia.com>
> >> Sent: Friday, December 3, 2021 3:27 PM
> >> To: Machnikowski, Maciej <maciej.machnikowski@intel.com>
> >> Subject: Re: [PATCH v4 net-next 2/4] ethtool: Add ability to configure
> >> recovered clock for SyncE feature
> >>
> >>
> >> Machnikowski, Maciej <maciej.machnikowski@intel.com> writes:
> >>
> >> >> -----Original Message-----
> >> >> From: Ido Schimmel <idosch@idosch.org>
> >> >>
> >> >> On Thu, Dec 02, 2021 at 03:17:06PM +0000, Machnikowski, Maciej
> wrote:
> >> >> > > -----Original Message-----
> >> >> > > From: Ido Schimmel <idosch@idosch.org>
> >> >> > >
> >> >> > > On Wed, Dec 01, 2021 at 07:02:06PM +0100, Maciej Machnikowski
> >> wrote:
> >> >> > > Looking at the diagram from the previous submission [1]:
> >> >> > >
> >> >> > >       ???????????????????????
> >> >> > >       ? RX       ? TX       ?
> >> >> > >   1   ? ports    ? ports    ? 1
> >> >> > >   ???????????    ?          ???????
> >> >> > >   2   ?     ?    ?          ? 2
> >> >> > >   ????????? ?    ?          ???????
> >> >> > >   3   ?   ? ?    ?          ? 3
> >> >> > >   ??????? ? ?    ?          ???????
> >> >> > >       ? ? ? ?    ?          ?
> >> >> > >       ? ??????   ?          ?
> >> >> > >       ? \____/   ?          ?
> >> >> > >       ???????????????????????
> >> >> > >         1? 2?        ?
> >> >> > >  RCLK out?  ?        ? TX CLK in
> >> >> > >          ?  ?        ?
> >> >> > >        ???????????????????
> >> >> > >        ?                 ?
> >> >> > >        ?       SEC       ?
> >> >> > >        ?                 ?
> >> >> > >        ???????????????????
> >> >> > >
> >> >> > > Given a netdev (1, 2 or 3 in the diagram), the RCLK_SET message
> >> allows
> >> >> > > me to redirect the frequency recovered from this netdev to the
> EEC
> >> via
> >> >> > > either pin 1, pin 2 or both.
> >> >> > >
> >> >> > > Given a netdev, the RCLK_GET message allows me to query the
> range
> >> of
> >> >> > > pins (RCLK out 1-2 in the diagram) through which the frequency can
> be
> >> >> > > fed into the EEC.
> >> >> > >
> >> >> > > Questions:
> >> >> > >
> >> >> > > 1. The query for all the above netdevs will return the same range
> >> >> > > of pins. How does user space know that these are the same pins?
> >> >> > > That is, how does user space know that RCLK_SET message to
> >> >> > > redirect the frequency recovered from netdev 1 to pin 1 will be
> >> >> > > overridden by the same message but for netdev 2?
> >> >> >
> >> >> > We don't have a way to do so right now. When we have EEC
> subsystem
> >> >> > in place the right thing to do will be to add EEC input index and
> >> >> > EEC index as additional arguments
> >> >> >
> >> >> > > 2. How does user space know the mapping between a netdev and
> an
> >> >> > > EEC? That is, how does user space know that RCLK_SET message
> for
> >> >> > > netdev 1 will cause the Tx frequency of netdev 2 to change
> >> >> > > according to the frequency recovered from netdev 1?
> >> >> >
> >> >> > Ditto - currently we don't have any entity to link the pins to ATM,
> >> >> > but we can address that in userspace just like PTP pins are used
> >> >> > now
> >> >> >
> >> >> > > 3. If user space sends two RCLK_SET messages to redirect the
> >> >> > > frequency recovered from netdev 1 to RCLK out 1 and from netdev
> 2
> >> >> > > to RCLK out 2, how does it know which recovered frequency is
> >> >> > > actually used an input to the EEC?
> >> >>
> >> >> User space doesn't know this as well?
> >> >
> >> > In current model it can come from the config file. Once we implement
> DPLL
> >> > subsystem we can implement connection between pins and DPLLs if
> they
> >> are
> >> > known.
> >> >
> >> >> > >
> >> >> > > 4. Why these pins are represented as attributes of a netdev and
> not as
> >> >> > > attributes of the EEC? That is, why are they represented as output
> >> pins
> >> >> > > of the PHY as opposed to input pins of the EEC?
> >> >> >
> >> >> > They are 2 separate beings. Recovered clock outputs are controlled
> >> >> > separately from EEC inputs.
> >> >>
> >> >> Separate how? What does it mean that they are controlled separately?
> In
> >> >> which sense? That redirection of recovered frequency to pin is
> >> >> controlled via PHY registers whereas priority setting between EEC
> inputs
> >> >> is controlled via EEC registers? If so, this is an implementation detail
> >> >> of a specific design. It is not of any importance to user space.
> >> >
> >> > They belong to different devices. EEC registers are physically in the DPLL
> >> > hanging over I2C and recovered clocks are in the PHY/integrated PHY in
> >> > the MAC. Depending on system architecture you may have control over
> >> > one piece only
> >>
> >> What does ETHTOOL_MSG_RCLK_SET actually configure, physically? Say I
> >> have this message:
> >>
> >> ETHTOOL_MSG_RCLK_SET dev = eth0
> >> - ETHTOOL_A_RCLK_OUT_PIN_IDX = n
> >> - ETHTOOL_A_RCLK_PIN_FLAGS |= ETHTOOL_RCLK_PIN_FLAGS_ENA
> >>
> >> Eventually this lands in ops->set_rclk_out(dev, out_idx, new_state).
> >> What does the MAC driver do next?
> >
> > It goes to the PTY layer, enables the clock recovery from a given physical
> lane,
> > optionally configure the clock divider and pin output muxes. This will be
> > HW-specific though, but the general concept will look like that.
> 
> The reason I am asking is that I suspect that by exposing this
> functionality through netdev, you assume that the NIC driver will do
> whatever EEC configuration necessary _anyway_. So why couldn't it just
> instantiate the EEC object as well?

Not necessarily. The EEC can be supported by totally different driver. I.e there
are Renesas DPLL drivers available now in the ptp subsystem. The DPLL
can be connected anywhere in the system.

> >> >> > If we mix them it'll be hard to control everything especially that a
> >> >> > single EEC can support multiple devices.
> >> >>
> >> >> Hard how? Please provide concrete examples.
> >> >
> >> > From the EEC perspective it's one to many relation - one EEC input
> >> > pin will serve even 4,16,48 netdevs. I don't see easy way of
> >> > starting from EEC input of EEC device and figuring out which
> >> > netdevs are connected to it to talk to the right one. In current
> >> > model it's as simple as:
> >> > - I received QL-PRC on netdev ens4f0
> >> > - I send back enable recovered clock on pin 0 of the ens4f0
> >>
> >> How do I know it's pin 0 though? Config file?
> >
> > You can find that by sending the ETHTOOL_MSG_RCLK_GET without any
> pin
> > index to get the acceptable/supported range.
> 
> Ha, OK, pin0 means the RCLK pin. OK.
> 
> >> > - go to EEC that will be linked to it
> >> > - see the state of it - if its locked - report QL-EEC downsteam
> >> >
> >> > How would you this control look in the EEC/DPLL implementation?
> Maybe
> >> > I missed something.
> >>
> >> In the EEC-centric model this is what happens:
> >>
> >> - QL-PRC packet is received on ens4f0
> >> - Userspace consults a UAPI to figure out what EEC and pin ID this
> >>   netdevice corresponds to
> >> - Userspace instructs through a UAPI the indicated EEC to use the
> >>   indicated pin as a source
> >> - Userspace then monitors the indicated EEC through a UAPI. When the
> EEC
> >>   locks, QL-EEC is reported downstream
> >
> > This is still missing the port/lane->pin mapping. This is what will
> > happen in the EEC/DPLL subsystem.
> 
> You asked how the control looks in the ECC-centric model. So this is
> how. That this stuff is missing is fairly obvious, we are talking about
> a different model.
> 
> I don't buy the "extremely hard" argument. The set of steps to do might
> be longer, but they are still just steps. No jumps, hoops, sommersaults.
> On the flip side we get a proper UAPI that can stay useful for a while.
> 
> >> >> What do you mean by "multiple devices"? A multi-port adapter with a
> >> >> single EEC or something else?
> >> >
> >> > Multiple MACs that use a single EEC clock.
> >> >
> >> >> > Also if we make those pins attributes of the EEC it'll become
> >> >> > extremally hard to map them to netdevs and control them from the
> >> >> > userspace app that will receive the ESMC message with a given QL
> >> >> > level on netdev X.
> >> >>
> >> >> Hard how? What is the problem with something like:
> >> >>
> >> >> # eec set source 1 type netdev dev swp1
> >> >>
> >> >> The EEC object should be registered by the same entity that registers
> >> >> the netdevs whose Tx frequency is controlled by the EEC, the MAC
> driver.
> >> >
> >> > But the EEC object may not be controlled by the MAC - in which case
> >> > this model won't work.
> >>
> >> In that case the driver for the device that controls EEC would
> >> instantiates the object. It doesn't have to be a MAC driver.
> >>
> >> But if it is controlled by the MAC, the MAC driver instantiates it. And
> >> can set up the connection between the MAC and the EEC, so that in the
> >> shell snippet above "eec" knows how to get the EEC handle from the
> >> netdevice.
> >
> > But it still needs to talk to MAC driver somehow to enable the clock
> > recovery on a given pin - that's where the API defined here is needed.
> 
> Yes, there needs to be an API between the EEC object and its owner. That
> API can be internal though. E.g. a set of callbacks or a notifier chain.
> This is how loose coupling is typically done in the kernel.
> 
> >> >> > > 5. What is the problem with the following model?
> >> >> > >
> >> >> > > - The EEC is a separate object with following attributes:
> >> >> > >   * State: Invalid / Freerun / Locked / etc
> >> >> > >   * Sources: Netdev / external / etc
> >> >> > >   * Potentially more
> >> >> > >
> >> >> > > - Notifications are emitted to user space when the state of the EEC
> >> >> > >   changes. Drivers will either poll the state from the device or get
> >> >> > >   interrupts
> >> >> > >
> >> >> > > - The mapping from netdev to EEC is queried via ethtool
> >> >> >
> >> >> > Yep - that will be part of the EEC (DPLL) subsystem
> >> >>
> >> >> This model avoids all the problems I pointed out in the current
> >> >> proposal.
> >> >
> >> > That's the go-to model, but first we need control over the source as
> >> > well :)
> >>
> >> Why is that? Can you illustrate a case that breaks with the above model?
> >
> > If you have 32 port switch chip with 2 recovered clock outputs how will you
> > tell the chip to get the 18th port to pin 0 and from port 20 to pin 1? That's
> > the part those patches addresses. The further side of "which clock should
> the
> > EEC use" belongs to the DPLL subsystem and I agree with that.
> 
> So the claim is that in some cases the owner of the EEC does not know
> about the netdevices?
> 
> If that is the case, how do netdevices know about the EEC, like the
> netdev-centric model assumes?
> 
> Anyway, to answer the question, something like the following would
> happen:
> 
> - Ask EEC to enumerate all input pins it knows about
> - Find the one that references swp18
> - Ask EEC to forward that input pin to output pin 0
> - Repeat for swp20 and output pin 1
> 
> The switch driver (or multi-port NIC driver) just instantiates all of
> netdevices, the EEC object, and pin objects, and therefore can set up
> arbitrary linking between the three.

This will end up with a model in which pin X of the EEC will link to dozens
ports - userspace tool would need to find out the relation between them and
EECs somehow. It's far more convenient if a given netdev knows where it is
connected to and which pin can it drive.

I.e. send the netdev swp20 ETHTOOL_MSG_RCLK_GET and get the pin indexes
of the EEC and send the future message to find which EEC that is (or even return
EEC index in RCLK_GET?). Set the recovered clock on that pin with the 
ETHTOOL_MSG_RCLK_SET.
Then go to the given EEC and configure it to use the pin that was returned
before as a frequency source and monitor the EEC state.

Additionally, the EEC device may be instantiated by a totally different driver,
in which case the relation between its pins and netdevs may not even be known.

> > Or to put it into different words:
> > This API will configure given quality level  frequency reference outputs on
> chip's
> > Dedicated outputs. On a board you will connect those to the EEC's
> reference inputs.
> >
> > The EEC's job is to validate the inputs and lock to them following certain
> rules,
> > The PHY/MAC (and this API) job is to deliver reference signals to the EEC.
