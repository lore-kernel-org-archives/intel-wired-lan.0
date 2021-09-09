From: Machnikowski, Maciej <maciej.machnikowski@intel.com>
Date: Thu, 9 Sep 2021 08:18:10 +0000
Subject: [Intel-wired-lan] [PATCH net-next 1/2] rtnetlink: Add new
 RTM_GETEECSTATE message to get SyncE status
In-Reply-To: <20210909020915.GA30747@hoboy.vegasvil.org>
References: <PH0PR11MB495152B03F32A5A17EDB2F6CEAD39@PH0PR11MB4951.namprd11.prod.outlook.com>
 <20210907075509.0b3cb353@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <PH0PR11MB49512C265E090FC8741D8510EAD39@PH0PR11MB4951.namprd11.prod.outlook.com>
 <20210907124730.33852895@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <PH0PR11MB495169997552152891A69B57EAD49@PH0PR11MB4951.namprd11.prod.outlook.com>
 <20210908092115.191fdc28@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <PH0PR11MB4951AA3C65DD8E7612F5F396EAD49@PH0PR11MB4951.namprd11.prod.outlook.com>
 <YTkQTQM6Is4Hqmxh@lunn.ch>
 <20210908152027.313d7168@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <YTlAT+1wkazy3Uge@lunn.ch> <20210909020915.GA30747@hoboy.vegasvil.org>
Message-ID: <PH0PR11MB49515C4ACE9BAD7BD9172825EAD59@PH0PR11MB4951.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Richard Cochran <richardcochran@gmail.com>
> Sent: Thursday, September 9, 2021 4:09 AM
> To: Andrew Lunn <andrew@lunn.ch>
> Subject: Re: [PATCH net-next 1/2] rtnetlink: Add new RTM_GETEECSTATE
> message to get SyncE status
> 
> On Thu, Sep 09, 2021 at 12:59:27AM +0200, Andrew Lunn wrote:
> > On Wed, Sep 08, 2021 at 03:20:27PM -0700, Jakub Kicinski wrote:
> > > On Wed, 8 Sep 2021 21:34:37 +0200 Andrew Lunn wrote:
> > > > Since we are talking about clocks and dividers, and multiplexors,
> > > > should all this be using the common clock framework, which already
> > > > supports most of this? Do we actually need something new?
> > >
> > > Does the common clock framework expose any user space API?
> >
> > Ah, good point. No, i don't think it does, apart from debugfs, which
> > is not really a user space API, and it contains read only descriptions
> > of the clock tree, current status, mux settings, dividers etc.
> 
> Wouldn't it make sense to develop some kind of user land API to
> manipulate the common clock framework at run time?
> 
> Just dreaming...
> 
> Richard

That may be dangerous. In SyncE world we control clocks that are only
references to the EEC block. The worst that can happen is that the DPLL
will ignore incoming clock as it has invalid frequency, or it will drift off to 
the edge of allowed range.
Controlling the clock that actually drives any components (PHY/MAC) in
runtime can be a good way to brick the part. I feel that, while the reuse 
of structures may be a good idea, the userspace API for clocks is not. 
They are usually set up once at the board init level and stay like that "forever".

The outputs we need to control are only a subset of all of them and they
rather fall in the PTP pins level of details, rather than clock ones.
