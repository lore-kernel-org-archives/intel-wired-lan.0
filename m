From: Machnikowski, Maciej <maciej.machnikowski@intel.com>
Date: Wed, 8 Sep 2021 20:27:43 +0000
Subject: [Intel-wired-lan] [PATCH net-next 1/2] rtnetlink: Add new
 RTM_GETEECSTATE message to get SyncE status
In-Reply-To: <YTkQTQM6Is4Hqmxh@lunn.ch>
References: <20210906113925.1ce63ac7@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <PH0PR11MB49511F2017F48BBAAB2A065CEAD29@PH0PR11MB4951.namprd11.prod.outlook.com>
 <20210906180124.33ff49ef@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <PH0PR11MB495152B03F32A5A17EDB2F6CEAD39@PH0PR11MB4951.namprd11.prod.outlook.com>
 <20210907075509.0b3cb353@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <PH0PR11MB49512C265E090FC8741D8510EAD39@PH0PR11MB4951.namprd11.prod.outlook.com>
 <20210907124730.33852895@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <PH0PR11MB495169997552152891A69B57EAD49@PH0PR11MB4951.namprd11.prod.outlook.com>
 <20210908092115.191fdc28@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <PH0PR11MB4951AA3C65DD8E7612F5F396EAD49@PH0PR11MB4951.namprd11.prod.outlook.com>
 <YTkQTQM6Is4Hqmxh@lunn.ch>
Message-ID: <PH0PR11MB4951B5756090C5A2F5A8DC84EAD49@PH0PR11MB4951.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Wednesday, September 8, 2021 9:35 PM
> To: Machnikowski, Maciej <maciej.machnikowski@intel.com>
> Subject: Re: [PATCH net-next 1/2] rtnetlink: Add new RTM_GETEECSTATE
> message to get SyncE status
> 
> > > > The SyncE API considerations starts ~54:00, but basically we need API
> for:
> > > > - Controlling the lane to pin mapping for clock recovery
> > > > - Check the EEC/DPLL state and see what's the source of reference
> > > frequency
> > > > (in more advanced deployments)
> > > > - control additional input and output pins (GNSS input, external inputs,
> > > recovered
> > > >   frequency reference)
> 
> Now that you have pointed to a datasheet...
> 
> > - Controlling the lane to pin mapping for clock recovery
> 
> So this is a PHY property. That could be Linux driving the PHY, via
> phylib, drivers/net/phy, or there could be firmware in the MAC driver
> which hides the PHY and gives you some sort of API to access it.

Yes, that's deployment dependent - in our case we use MAC driver that
proxies that.
 
> > Check the EEC/DPLL state and see what's the source of reference
> > frequency
> 
> Where is the EEC/DPLL implemented? Is it typically also in the PHY? Or
> some other hardware block?

In most cases it will be an external device, but there are implementations 
That have a PLL/DPLL inside the PHY (like a Broadcom example). And
I don't know how switches implements that.
 
> I just want to make sure we have an API which we can easily delegate
> to different subsystems, some of it in the PHY driver, maybe some of
> it somewhere else.

The reasoning behind putting it in the ndo subsystem is because ultimately
the netdev receives the ESMC message and is the entity that should
know how it is connected to the PHY. That's because it will be very
complex to move the mapping between netdevs and PHY lanes/ports
to the SW running in the userspace. I believe the right way is to let the
netdev driver manage that complexity and forward the request to the
PHY subsystem if needed.
The logic is:
- Receive ESMC message on a netdev
- send the message to enable recovered clock to the netdev that received it
- ask the netdev to give the status of EEC that drives it.

> Also, looking at the Marvell datasheet, it appears these registers are
> in the MDIO_MMD_VEND2 range. Has any of this been specified? Can we
> expect to be able to write a generic implementation sometime in the
> future which PHY drivers can share?

I believe it will be vendor-specific, as there are different implementations
of it. It can be an internal PLL that gets all inputs and syncs to a one of them
or it can be a MUX with divder(s)

> I just looked at a 1G Marvell PHY. It uses RGMII or SGMII towards the
> host. But there is no indication you can take the clock from the SGMII
> SERDES, it is only the recovered clock from the line. And the
> recovered clock always goes out the CLK125 pin, which can either be
> 125MHz or 25MHz.
> 
> So in this case, you have no need to control the lane to pin mapping,
> it is fixed, but do we want to be able to control the divider?

That's a complex question. Controlling the divider would make sense
when we have control over the DPLL, and it still needs to be optional,
as it's not always available. I assume that in the initial
implementation we can rely on MAC driver to set up the dividers
to output the expected frequency to the DPLL. On faster interfaces
the RCLK speed is also speed-dependent and differs across the link
speeds.

> Do we need a mechanism to actually enumerate what the hardware can do?

For recovered clocks I think we need to start with the number of
PHY outputs that go towards the DPLL. We can add additional attributes
like a frequency and others once we need them. I want to avoid creating
a swiss-knife with too many options here :)

> Since we are talking about clocks and dividers, and multiplexors,
> should all this be using the common clock framework, which already
> supports most of this? Do we actually need something new?

I believe that's a specific enough case that deserves a separate one
Regards
Maciek
