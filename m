From: Machnikowski, Maciej <maciej.machnikowski@intel.com>
Date: Wed, 8 Sep 2021 08:03:35 +0000
Subject: [Intel-wired-lan] [PATCH net-next 1/2] rtnetlink: Add new
 RTM_GETEECSTATE message to get SyncE status
In-Reply-To: <20210907124730.33852895@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20210903151436.529478-1-maciej.machnikowski@intel.com>
 <20210903151436.529478-2-maciej.machnikowski@intel.com>
 <20210903151425.0bea0ce7@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <PH0PR11MB4951623918C9BA8769C10E50EAD29@PH0PR11MB4951.namprd11.prod.outlook.com>
 <20210906113925.1ce63ac7@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <PH0PR11MB49511F2017F48BBAAB2A065CEAD29@PH0PR11MB4951.namprd11.prod.outlook.com>
 <20210906180124.33ff49ef@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <PH0PR11MB495152B03F32A5A17EDB2F6CEAD39@PH0PR11MB4951.namprd11.prod.outlook.com>
 <20210907075509.0b3cb353@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <PH0PR11MB49512C265E090FC8741D8510EAD39@PH0PR11MB4951.namprd11.prod.outlook.com>
 <20210907124730.33852895@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <PH0PR11MB495169997552152891A69B57EAD49@PH0PR11MB4951.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Tuesday, September 7, 2021 9:48 PM
> Subject: Re: [PATCH net-next 1/2] rtnetlink: Add new RTM_GETEECSTATE
> message to get SyncE status
> 
> On Tue, 7 Sep 2021 15:47:05 +0000 Machnikowski, Maciej wrote:
> > > > It can be either in FW or in Linux - depending on the deployment.
> > > > We try to define the API that would enable Linux to manage that.
> > >
> > > We should implement the API for Linux to manage things from the get
> go.
> >
> > Yep! Yet let's go one step at a time. I believe once we have the basics (EEC
> > monitoring and recovered clock configuration) we'll be able to implement
> > a basic functionality - and add bells and whistles later on, as there are more
> > capabilities that we could support in SW.
> 
> The set API may shape how the get API looks. We need a minimal viable
> API where the whole control part of it is not "firmware or proprietary
> tools take care of that".
> 
> Do you have public docs on how the whole solution works?

The best reference would be my netdev 0x15 tutorial:
https://netdevconf.info/0x15/session.html?Introduction-to-time-synchronization-over-Ethernet
The SyncE API considerations starts ~54:00, but basically we need API for:
- Controlling the lane to pin mapping for clock recovery
- Check the EEC/DPLL state and see what's the source of reference frequency
(in more advanced deployments)
- control additional input and output pins (GNSS input, external inputs, recovered
  frequency reference)
 
> > > > The DPLL will operate on pins, so it will have a pin connected from the
> > > > MAC/PHY that will have the recovered clock, but the recovered clock
> > > > can be enabled from any port/lane. That information is kept in the
> > > > MAC/PHY and the DPLL side will not be aware who it belongs to.
> > >
> > > So the clock outputs are muxed to a single pin at the Ethernet IP
> > > level, in your design. I wonder if this is the common implementation
> > > and therefore if it's safe to bake that into the API. Input from other
> > > vendors would be great...
> >
> > I believe this is the state-of-art: here's the Broadcom public one
> > https://docs.broadcom.com/doc/1211168567832, I believe Marvel
> > has similar solution. But would also be happy to hear others.
> 
> Interesting. That reveals the need for also marking the backup
> (/secondary) clock.

That's optional, but useful. And here's where we need a feedback
on which port/lane is currently used, as the switch may be automatic

> Have you seen any docs on how systems with discreet PHY ASICs mux
> the clocks?

Yes - unfortunately they are not public :(

 
> > > Also do I understand correctly that the output of the Ethernet IP
> > > is just the raw Rx clock once receiver is locked and the DPLL which
> > > enum if_synce_state refers to is in the time IP, that DPLL could be
> > > driven by GNSS etc?
> >
> > Ethernet IP/PHY usually outputs a divided clock signal (since it's
> > easier to route) derived from the RX clock.
> > The DPLL connectivity is vendor-specific, as you can use it to connect
> > some external signals, but you can as well just care about relying
> > the SyncE clock and only allow recovering it and passing along
> > the QL info when your EEC is locked. That's why I backed up from
> > a full DPLL implementation in favor of a more generic EEC clock.
> 
> What is an ECC clock? To me the PLL state in the Ethernet port is the
> state of the recovered clock. enum if_eec_state has values like
> holdover which seem to be more applicable to the "system wide" PLL.

EEC is Ethernet Equipment Clock. In most cases this will be a DPLL, but that's
not mandatory and I believe it may be different is switches where
you only need to drive all ports TX from a single frequency source. In this
case the DPLL can be embedded in the multiport PHY,
 
> Let me ask this - if one port is training the link and the other one has
> the lock and is the source - what state will be reported for each port?

In this case the port that has the lock source will report the lock and 
the EEC_SRC_PORT flag. The port that trains the link will show the
lock without the flag and once it completes the training sequence it will
use the EEC's frequency to transmit the data so that the next hop is able
to synchronize its EEC to the incoming RX frequency

> > The Time IP is again relative and vendor-specific. If SyncE is deployed
> > alongside PTP it will most likely be tightly coupled, but if you only
> > care about having a frequency source - it's not mandatory and it can be
> > as well in the PHY IP.
> 
> I would not think having just the freq is very useful.

This depends on the deployment. There are couple popular frequencies
Most popular are 2,048 kHz, 10 MHz and 64 kHz. There are many 
deployments that only require frequency sync without the phase
and/or time. I.e. if you deploy frequency division duplex you only need the
frequency reference, and the higher frequency you have - the faster you can
lock to it.
 
> > Also I think I will strip the reported states to the bare minimum defined
> > in the ITU-T G.781 instead of reusing the states that were already defined
> > for a specific DPLL.
> >
> > > > This is the right thinking. The DPLL can also have different external
> sources,
> > > > like the GNSS, and can also drive different output clocks. But for the
> most
> > > > basic SyncE implementation, which only runs on a recovered clock, we
> won't
> > > > need the DPLL subsystem.
> > >
> > > The GNSS pulse would come in over an external pin, tho, right? Your
> > > earlier version of the patchset had GNSS as an enum value, how would
> > > the driver / FW know that a given pin means GNSS?
> >
> > The GNSS 1PPS will more likely go directly to the "full" DPLL.
> > The pin topology can be derived from FW or any vendor-specific way of
> mapping
> > pins to their sources. And, in "worst" case can just be hardcoded for a
> specific
> > device.
