From: Machnikowski, Maciej <maciej.machnikowski@intel.com>
Date: Thu, 9 Sep 2021 08:26:51 +0000
Subject: [Intel-wired-lan] [PATCH net-next 1/2] rtnetlink: Add new
 RTM_GETEECSTATE message to get SyncE status
In-Reply-To: <20210908165802.1d5c952d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <PH0PR11MB49511F2017F48BBAAB2A065CEAD29@PH0PR11MB4951.namprd11.prod.outlook.com>
 <20210906180124.33ff49ef@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <PH0PR11MB495152B03F32A5A17EDB2F6CEAD39@PH0PR11MB4951.namprd11.prod.outlook.com>
 <20210907075509.0b3cb353@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <PH0PR11MB49512C265E090FC8741D8510EAD39@PH0PR11MB4951.namprd11.prod.outlook.com>
 <20210907124730.33852895@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <PH0PR11MB495169997552152891A69B57EAD49@PH0PR11MB4951.namprd11.prod.outlook.com>
 <20210908092115.191fdc28@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <PH0PR11MB4951AA3C65DD8E7612F5F396EAD49@PH0PR11MB4951.namprd11.prod.outlook.com>
 <20210908151852.7ad8a0f1@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <YTlD3Gok7w/MF+g2@lunn.ch>
 <20210908165802.1d5c952d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <PH0PR11MB49516BE62562735F017470A4EAD59@PH0PR11MB4951.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Thursday, September 9, 2021 1:58 AM
> To: Andrew Lunn <andrew@lunn.ch>
> Cc: Machnikowski, Maciej <maciej.machnikowski@intel.com>;
> netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org;
> richardcochran at gmail.com; abyagowi at fb.com; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; davem at davemloft.net; linux-
> kselftest at vger.kernel.org; Michal Kubecek <mkubecek@suse.cz>; Saeed
> Mahameed <saeed@kernel.org>; Michael Chan
> <michael.chan@broadcom.com>
> Subject: Re: [PATCH net-next 1/2] rtnetlink: Add new RTM_GETEECSTATE
> message to get SyncE status
> 
> On Thu, 9 Sep 2021 01:14:36 +0200 Andrew Lunn wrote:
> > > As you said, pin -> ref mapping is board specific, so the API should
> > > not assume knowledge of routing between Port and ECC.
> >
> > That information will probably end up in device tree. And X different
> > implementations of ACPI, unless somebody puts there foot down and
> > stops the snow flakes.
> >
> > > Imagine a system with two cascaded switch ASICs and a bunch of PHYs.
> > > How do you express that by pure extensions to the proposed API?
> >
> > Device tree is good at that. ACPI might eventually catch up.
> 
> I could well be wrong but some of those connectors could well be just
> SMAs on the back plate, no? User could cable those up to their heart
> content.
> 
> https://engineering.fb.com/2021/08/11/open-source/time-appliance/

Yep! We should base on the abstract indexes, rather than the device tree.
The user needs to make sense of the indexes, just like with PTP pins.
 
> > How complex a setup do we actually expect? Can there be multiple
> > disjoint SyncE trees within an Ethernet switch cluster? Or would it be
> > reasonable to say all you need to configure is the clock source, and
> > all other ports of the switches are slaves if SyncE is enabled for the
> > port? I've never see any SOHO switch hardware which allows you to have
> > disjoint PTP trees, so it does not sound too unreasonable to only
> > allow a single SyncE tree per switch cluster.
> 
> Not sure. I get the (perhaps unfounded) feeling that just forwarding
> the clock from one port to the rest is simpler. Maciej cares primarily
> about exposing the clock to other non-Ethernet things, the device would
> be an endpoint here, using the clock for LTE or whatnot.

Also multiple PTP domain switches starts appearing on the market.
I know Cisco makes them:
https://www.cisco.com/c/en/us/td/docs/switches/datacenter/nexus3548/sw/system_mgmt/602/b_N3548_System_Management_Config_602A11/b_N3548_Sysetm_Management_Config_602A11_chapter_011.html
Disjoint SyncE trees will be harder to implement due to the physical nature
of it.

> > Also, if you are cascading switches, you generally don't put PHYs in
> > the middle, you just connect the SERDES lanes together.
> 
> My concern was a case where PHY connected to one switch exposes the
> refclock on an aux pin which is then muxed to more than one switch ASIC.
> IOW the "source port" is not actually under the same switch.
> 
> Again, IDK if that's realistic.

It can be done, but the userspace app should make sense out of this config.
Coding all scenarios in kernel would make 1000000 different possible
configurations in the driver - which probably no one wants to keep/maintain.
We can return info about hardwired pins (like GNSS, PHY recovered clks,
PTP clock and so on) but should also give some generic ones.
