From: Machnikowski, Maciej <maciej.machnikowski@intel.com>
Date: Tue, 7 Sep 2021 15:47:05 +0000
Subject: [Intel-wired-lan] [PATCH net-next 1/2] rtnetlink: Add new
 RTM_GETEECSTATE message to get SyncE status
In-Reply-To: <20210907075509.0b3cb353@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20210903151436.529478-1-maciej.machnikowski@intel.com>
 <20210903151436.529478-2-maciej.machnikowski@intel.com>
 <20210903151425.0bea0ce7@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <PH0PR11MB4951623918C9BA8769C10E50EAD29@PH0PR11MB4951.namprd11.prod.outlook.com>
 <20210906113925.1ce63ac7@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <PH0PR11MB49511F2017F48BBAAB2A065CEAD29@PH0PR11MB4951.namprd11.prod.outlook.com>
 <20210906180124.33ff49ef@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <PH0PR11MB495152B03F32A5A17EDB2F6CEAD39@PH0PR11MB4951.namprd11.prod.outlook.com>
 <20210907075509.0b3cb353@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <PH0PR11MB49512C265E090FC8741D8510EAD39@PH0PR11MB4951.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Tuesday, September 7, 2021 4:55 PM
> To: Machnikowski, Maciej <maciej.machnikowski@intel.com>
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org;
> richardcochran at gmail.com; abyagowi at fb.com; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; davem at davemloft.net; linux-
> kselftest at vger.kernel.org; Andrew Lunn <andrew@lunn.ch>; Michal
> Kubecek <mkubecek@suse.cz>; Saeed Mahameed <saeed@kernel.org>;
> Michael Chan <michael.chan@broadcom.com>
> Subject: Re: [PATCH net-next 1/2] rtnetlink: Add new RTM_GETEECSTATE
> message to get SyncE status
> 
> On Tue, 7 Sep 2021 08:50:55 +0000 Machnikowski, Maciej wrote:
> > > > The frequency source can be either pre-set statically, negotiated using
> > > > ESMC QL-levels (if working in QL-Enabled mode), or follow automatic
> > > > fallback inside the device. This  flag gives feedback about the validity
> > > > of recovered clock coming from a given port and is useful when you
> > > > enable multiple recovered clocks on more than one port in
> > > > active-passive model. In that case the "driving" port may change
> > > > dynamically, so it's a good idea to have some interface to reflect that.
> > >
> > > The ESMC messages are handled by Linux or some form of firmware?
> > > I don't see how you can implement any selection policy with a read-only
> > > API.
> >
> > It can be either in FW or in Linux - depending on the deployment.
> > We try to define the API that would enable Linux to manage that.
> 
> We should implement the API for Linux to manage things from the get go.

Yep! Yet let's go one step at a time. I believe once we have the basics (EEC 
monitoring and recovered clock configuration) we'll be able to implement
a basic functionality - and add bells and whistles later on, as there are more
capabilities that we could support in SW.
 
> > EEC state will be read-only, but the recovered clock management part
> > will allow changes for QL-disabled SyncE deployments that only need
> > to see if the clock they receive on a given port is valid or not.
> >
> > > In general it would be more natural to place a "source id" at the
> > > DPLL/clock, the "source" flag seems to mark the wrong end of the
> > > relationship. If there ever are multiple consumers we won't be able
> > > to tell which "target" the "source" is referring to. Hard to judge
> > > how much of a problem that could be by looking at a small slice of
> > > the system.
> >
> > The DPLL will operate on pins, so it will have a pin connected from the
> > MAC/PHY that will have the recovered clock, but the recovered clock
> > can be enabled from any port/lane. That information is kept in the
> > MAC/PHY and the DPLL side will not be aware who it belongs to.
> 
> So the clock outputs are muxed to a single pin at the Ethernet IP
> level, in your design. I wonder if this is the common implementation
> and therefore if it's safe to bake that into the API. Input from other
> vendors would be great...

I believe this is the state-of-art: here's the Broadcom public one
https://docs.broadcom.com/doc/1211168567832, I believe Marvel
has similar solution. But would also be happy to hear others.

> Also do I understand correctly that the output of the Ethernet IP
> is just the raw Rx clock once receiver is locked and the DPLL which
> enum if_synce_state refers to is in the time IP, that DPLL could be
> driven by GNSS etc?

Ethernet IP/PHY usually outputs a divided clock signal (since it's 
easier to route) derived from the RX clock.
The DPLL connectivity is vendor-specific, as you can use it to connect 
some external signals, but you can as well just care about relying 
the SyncE clock and only allow recovering it and passing along 
the QL info when your EEC is locked. That's why I backed up from
a full DPLL implementation in favor of a more generic EEC clock.
The Time IP is again relative and vendor-specific. If SyncE is deployed 
alongside PTP it will most likely be tightly coupled, but if you only
care about having a frequency source - it's not mandatory and it can be
as well in the PHY IP.

Also I think I will strip the reported states to the bare minimum defined
in the ITU-T G.781 instead of reusing the states that were already defined 
for a specific DPLL.
 
> > We can come up with a better name,  but think of it like:
> > You have multiport device (switch/NIC). One port is recovering
> > the clock, the PHY/MAC outputs that clock through the pin
> > to the EEC (DPLL). The DPLL knows if it locked to the signal coming
> > from the multiport PHY/MAC, but it doesn't know which port is the one
> > that generates that clock signal. All other ports can also present the
> > "locked" state, but they are following the clock that was received
> > in the chosen port. If we drop this flag we won't be able to easily tell
> > which port/lane drives the recovered clock.
> > In short: the port with that flag on is following the network clock
> > and leading clock of other ports of the multiport device.
> >
> > In the most basic SyncE deployment you can put the passive DPLL that
> > will only give you the lock/holdover/unlocked info and just use this flag
> > to know who currently drives the DPLL.
> >
> > > > That's where sysfs file be useful. When I add the implementation for
> > > > recovered clock configuration, the sysfs may be used as standalone
> > > > interface for configuring them when no dynamic change is needed.
> > >
> > > I didn't get that. Do you mean using a sysfs file to configure
> > > the parameters of the DPLL?
> >
> > Only the PHY/MAC side of thing which is recovered clock configuration
> > and the ECC state.
> >
> > > If the DPLL has its own set of concerns we should go ahead and create
> > > explicit object / configuration channel for it.
> > >
> > > Somehow I got it into my head that you care mostly about transmitting
> > > the clock, IOW recovering it from one port and using on another but
> > > that's probably not even a strong use case for you or NICs in general :S
> >
> > This is the right thinking. The DPLL can also have different external sources,
> > like the GNSS, and can also drive different output clocks. But for the most
> > basic SyncE implementation, which only runs on a recovered clock, we
> won't
> > need the DPLL subsystem.
> 
> The GNSS pulse would come in over an external pin, tho, right? Your
> earlier version of the patchset had GNSS as an enum value, how would
> the driver / FW know that a given pin means GNSS?

The GNSS 1PPS will more likely go directly to the "full" DPLL. 
The pin topology can be derived from FW or any vendor-specific way of mapping
pins to their sources. And, in "worst" case can just be hardcoded for a specific
device.
 
> > > > Could you suggest where to add that? Grepping for ndo_ don't give
> much.
> > > > I can add a new synce.rst file if it makes sense.
> > >
> > > New networking/synce.rst file makes perfect sense to me. And perhaps
> > > link to it from driver-api/ptp.rst.
> >
> > OK will try to come up with something there
