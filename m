From: Machnikowski, Maciej <maciej.machnikowski@intel.com>
Date: Fri, 5 Nov 2021 11:51:48 +0000
Subject: [Intel-wired-lan] [PATCH net-next 6/6] docs: net: Add
 description of SyncE interfaces
In-Reply-To: <20211104110855.3ead1642@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20211104081231.1982753-1-maciej.machnikowski@intel.com>
 <20211104081231.1982753-7-maciej.machnikowski@intel.com>
 <20211104110855.3ead1642@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <MW5PR11MB5812FA6647FF189D368C75A5EA8E9@MW5PR11MB5812.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Thursday, November 4, 2021 7:09 PM
> To: Machnikowski, Maciej <maciej.machnikowski@intel.com>
> Subject: Re: [PATCH net-next 6/6] docs: net: Add description of SyncE
> interfaces
> 
> On Thu,  4 Nov 2021 09:12:31 +0100 Maciej Machnikowski wrote:
> > +Synchronous Ethernet networks use a physical layer clock to syntonize
> > +the frequency across different network elements.
> > +
> > +Basic SyncE node defined in the ITU-T G.8264 consist of an Ethernet
> > +Equipment Clock (EEC) and can recover synchronization
> > +from the synchronization inputs - either traffic interfaces or external
> > +frequency sources.
> > +The EEC can synchronize its frequency (syntonize) to any of those
> sources.
> > +It is also able to select a synchronization source through priority tables
> > +and synchronization status messaging. It also provides necessary
> > +filtering and holdover capabilities.
> > +
> > +The following interface can be applicable to diffferent packet network
> types
> > +following ITU-T G.8261/G.8262 recommendations.
> 
> Can we get a diagram in here in terms of how the port feeds its
> recovered Rx freq into EEC and that feeds freq of Tx on other ports?

Will try - yet my ASCII art skills are not very well developed :)

> I'm still struggling to understand your reasoning around not making
> EEC its own object. "We can do this later" seems like trading
> relatively little effort now for extra work for driver and application
> developers for ever.

That's not the case. We need EEC and the other subsystem we wanted
to make is the DPLL subsystem. While EEC can be a DPLL - it doesn't have
to, and it's also the other way round - the DPLL can have numerous different
usages.
When we add the DPLL subsystem support the future work will be as simple 
as routing the EEC state read function to the DPLL subsystem. But if someone
decides to use a different HW implementation he will still be able to
implement his own version of API to handle it without a bigger DPLL block

> Also patch 3 still has a kdoc warning.
Will fix.
