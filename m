From: Machnikowski, Maciej <maciej.machnikowski@intel.com>
Date: Fri, 3 Dec 2021 19:07:15 +0000
Subject: [Intel-wired-lan] [PATCH v4 net-next 2/4] ethtool: Add ability
 to configure recovered clock for SyncE feature
In-Reply-To: <87fsr9o7di.fsf@nvidia.com>
References: <20211201180208.640179-1-maciej.machnikowski@intel.com>
 <20211201180208.640179-3-maciej.machnikowski@intel.com>
 <Yai/e5jz3NZAg0pm@shredder>
 <MW5PR11MB5812455176BC656BABCFF1B0EA699@MW5PR11MB5812.namprd11.prod.outlook.com>
 <Yaj13pwDKrG78W5Y@shredder>
 <PH0PR11MB583105F8678665253A362797EA699@PH0PR11MB5831.namprd11.prod.outlook.com>
 <87pmqdojby.fsf@nvidia.com>
 <MW5PR11MB581202E2A601D34E30F1E5AEEA6A9@MW5PR11MB5812.namprd11.prod.outlook.com>
 <87lf11odsv.fsf@nvidia.com>
 <MW5PR11MB5812A86416E3100444894879EA6A9@MW5PR11MB5812.namprd11.prod.outlook.com>
 <87fsr9o7di.fsf@nvidia.com>
Message-ID: <MW5PR11MB5812AA2C625AC00616F94A2AEA6A9@MW5PR11MB5812.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Petr Machata <petrm@nvidia.com>
> Sent: Friday, December 3, 2021 7:45 PM
> To: Machnikowski, Maciej <maciej.machnikowski@intel.com>
> Subject: Re: [PATCH v4 net-next 2/4] ethtool: Add ability to configure
> recovered clock for SyncE feature
> 
> 
> Machnikowski, Maciej <maciej.machnikowski@intel.com> writes:
> 
> >> -----Original Message-----
> >> From: Petr Machata <petrm@nvidia.com>
> >>
> >> Machnikowski, Maciej <maciej.machnikowski@intel.com> writes:
> >>
> >> >> -----Original Message-----
> >> >> From: Petr Machata <petrm@nvidia.com>
> >> >>
> >> >> Machnikowski, Maciej <maciej.machnikowski@intel.com> writes:
> >> >>
> >> >> >> -----Original Message-----
> >> >> >> From: Ido Schimmel <idosch@idosch.org>
> >> >> >>
> >> >> >> On Thu, Dec 02, 2021 at 03:17:06PM +0000, Machnikowski, Maciej
> wrote:
> >> >> >> > > -----Original Message-----
> >> >> >> > > From: Ido Schimmel <idosch@idosch.org>
> >> >> >> > >
> >> >> >> > > 4. Why these pins are represented as attributes of a netdev
> >> >> >> > > and not as attributes of the EEC? That is, why are they
> >> >> >> > > represented as output pins of the PHY as opposed to input
> >> >> >> > > pins of the EEC?
> >> >> >> >
> >> >> >> > They are 2 separate beings. Recovered clock outputs are
> >> >> >> > controlled separately from EEC inputs.
> >> >> >>
> >> >> >> Separate how? What does it mean that they are controlled
> >> >> >> separately? In which sense? That redirection of recovered
> >> >> >> frequency to pin is controlled via PHY registers whereas
> >> >> >> priority setting between EEC inputs is controlled via EEC
> >> >> >> registers? If so, this is an implementation detail of a
> >> >> >> specific design. It is not of any importance to user space.
> >> >> >
> >> >> > They belong to different devices. EEC registers are physically
> >> >> > in the DPLL hanging over I2C and recovered clocks are in the
> >> >> > PHY/integrated PHY in the MAC. Depending on system architecture
> >> >> > you may have control over one piece only
> >> >>
> >> >> What does ETHTOOL_MSG_RCLK_SET actually configure, physically?
> Say
> >> >> I have this message:
> >> >>
> >> >> ETHTOOL_MSG_RCLK_SET dev = eth0
> >> >> - ETHTOOL_A_RCLK_OUT_PIN_IDX = n
> >> >> - ETHTOOL_A_RCLK_PIN_FLAGS |= ETHTOOL_RCLK_PIN_FLAGS_ENA
> >> >>
> >> >> Eventually this lands in ops->set_rclk_out(dev, out_idx,
> >> >> new_state). What does the MAC driver do next?
> >> >
> >> > It goes to the PTY layer, enables the clock recovery from a given
> >> > physical lane, optionally configure the clock divider and pin
> >> > output muxes. This will be HW-specific though, but the general
> >> > concept will look like that.
> >>
> >> The reason I am asking is that I suspect that by exposing this
> >> functionality through netdev, you assume that the NIC driver will do
> >> whatever EEC configuration necessary _anyway_. So why couldn't it just
> >> instantiate the EEC object as well?
> >
> > Not necessarily. The EEC can be supported by totally different driver.
> > I.e there are Renesas DPLL drivers available now in the ptp subsystem.
> > The DPLL can be connected anywhere in the system.
> >
> >> >> >> > > 5. What is the problem with the following model?
> >> >> >> > >
> >> >> >> > > - The EEC is a separate object with following attributes:
> >> >> >> > >   * State: Invalid / Freerun / Locked / etc
> >> >> >> > >   * Sources: Netdev / external / etc
> >> >> >> > >   * Potentially more
> >> >> >> > >
> >> >> >> > > - Notifications are emitted to user space when the state of
> >> >> >> > >   the EEC changes. Drivers will either poll the state from
> >> >> >> > >   the device or get interrupts
> >> >> >> > >
> >> >> >> > > - The mapping from netdev to EEC is queried via ethtool
> >> >> >> >
> >> >> >> > Yep - that will be part of the EEC (DPLL) subsystem
> >> >> >>
> >> >> >> This model avoids all the problems I pointed out in the current
> >> >> >> proposal.
> >> >> >
> >> >> > That's the go-to model, but first we need control over the
> >> >> > source as well :)
> >> >>
> >> >> Why is that? Can you illustrate a case that breaks with the above
> >> >> model?
> >> >
> >> > If you have 32 port switch chip with 2 recovered clock outputs how
> >> > will you tell the chip to get the 18th port to pin 0 and from port
> >> > 20 to pin 1? That's the part those patches addresses. The further
> >> > side of "which clock should the EEC use" belongs to the DPLL
> >> > subsystem and I agree with that.
> >>
> >> So the claim is that in some cases the owner of the EEC does not know
> >> about the netdevices?
> >>
> >> If that is the case, how do netdevices know about the EEC, like the
> >> netdev-centric model assumes?
> >>
> >> Anyway, to answer the question, something like the following would
> >> happen:
> >>
> >> - Ask EEC to enumerate all input pins it knows about
> >> - Find the one that references swp18
> >> - Ask EEC to forward that input pin to output pin 0
> >> - Repeat for swp20 and output pin 1
> >>
> >> The switch driver (or multi-port NIC driver) just instantiates all of
> >> netdevices, the EEC object, and pin objects, and therefore can set up
> >> arbitrary linking between the three.
> >
> > This will end up with a model in which pin X of the EEC will link to
> >dozens ports - userspace tool would need to find out the relation
> >between them and EECs somehow.
> 
> Indeed. If you have EEC connected to a bunch of ports, the EEC object is
> related to a bunch of netdevices. The UAPI needs to have tools to dump
> these objects so that it is possible to discover what is connected
> where.
> 
> This configuration will also not change during the lifetime of the EEC
> object, so tools can cache it.
> 
> > It's far more convenient if a given netdev knows where it is connected
> > to and which pin can it drive.
> 
> Yeah, it is of course possible to add references from the netdevice to
> the EEC object directly, so that the tool just needs to ask a netdevice
> what EEC / RCLK source ID it maps to.
> 
> This has mostly nothing to do with the model itself.
> 
> > I.e. send the netdev swp20 ETHTOOL_MSG_RCLK_GET and get the pin
> > indexes of the EEC and send the future message to find which EEC that
> > is (or even return EEC index in RCLK_GET?).
> 
> Since the pin index on its own is useless, it would make sense to return
> both pieces of information at the same time.
> 
> > Set the recovered clock on that pin with the ETHTOOL_MSG_RCLK_SET.
> 
> Nope.
> 
> > Then go to the given EEC and configure it to use the pin that was
> > returned before as a frequency source and monitor the EEC state.
> 
> Yep.
> 
> EEC will invoke a callback to set up the tracking. If something special
> needs to be done to "set the recovered clock on that pin", the handler
> of that callback will do it.
> 
> > Additionally, the EEC device may be instantiated by a totally
> > different driver, in which case the relation between its pins and
> > netdevs may not even be known.
> 
> Like an EEC, some PHYs, but the MAC driver does not know about both
> pieces? Who sets up the connection between the two? The box admin
> through some cabling? SoC designer?
> 
> Also, what does the external EEC actually do with the signal from the
> PHY? Tune to it and forward to the other PHYs in the complex?
Yes - it can also apply HW filters to it.

The EEC model will not work when you have the following system:
SoC with some ethernet ports with driver A
Switch chip with N ports with driver B
EEC/DPLL with driver C
Both SoC and Switch ASIC can recover clock and use the cleaned
clock from the DPLL.

In that case you can't create any relation between EEC and recover
clock pins that would enable the EEC subsystem to control
recovered clocks, because you have 3 independent drivers.

The model you proposed assumes that the MAC/Switch is in
charge of the DPLL, but that's not always true. The model where
recovered clock outputs are controlled independently can support
both models and is more flexible. It can also address the mode where
you want to use the recovered clock as a source for RF part of your
system and don't have any EEC to control from the netdev side.
