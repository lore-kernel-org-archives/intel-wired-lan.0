From: Andrew Lunn <andrew@lunn.ch>
Date: Wed, 8 Sep 2021 21:34:37 +0200
Subject: [Intel-wired-lan] [PATCH net-next 1/2] rtnetlink: Add new
 RTM_GETEECSTATE message to get SyncE status
In-Reply-To: <PH0PR11MB4951AA3C65DD8E7612F5F396EAD49@PH0PR11MB4951.namprd11.prod.outlook.com>
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
Message-ID: <YTkQTQM6Is4Hqmxh@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> > > The SyncE API considerations starts ~54:00, but basically we need API for:
> > > - Controlling the lane to pin mapping for clock recovery
> > > - Check the EEC/DPLL state and see what's the source of reference
> > frequency
> > > (in more advanced deployments)
> > > - control additional input and output pins (GNSS input, external inputs,
> > recovered
> > >   frequency reference)

Now that you have pointed to a datasheet...

> - Controlling the lane to pin mapping for clock recovery

So this is a PHY property. That could be Linux driving the PHY, via
phylib, drivers/net/phy, or there could be firmware in the MAC driver
which hides the PHY and gives you some sort of API to access it.

> Check the EEC/DPLL state and see what's the source of reference
> frequency

Where is the EEC/DPLL implemented? Is it typically also in the PHY? Or
some other hardware block?

I just want to make sure we have an API which we can easily delegate
to different subsystems, some of it in the PHY driver, maybe some of
it somewhere else.

Also, looking at the Marvell datasheet, it appears these registers are
in the MDIO_MMD_VEND2 range. Has any of this been specified? Can we
expect to be able to write a generic implementation sometime in the
future which PHY drivers can share?

I just looked at a 1G Marvell PHY. It uses RGMII or SGMII towards the
host. But there is no indication you can take the clock from the SGMII
SERDES, it is only the recovered clock from the line. And the
recovered clock always goes out the CLK125 pin, which can either be
125MHz or 25MHz.

So in this case, you have no need to control the lane to pin mapping,
it is fixed, but do we want to be able to control the divider?

Do we need a mechanism to actually enumerate what the hardware can do?

Since we are talking about clocks and dividers, and multiplexors,
should all this be using the common clock framework, which already
supports most of this? Do we actually need something new?

       Andrew
