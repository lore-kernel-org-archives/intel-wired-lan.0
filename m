From: Machnikowski, Maciej <maciej.machnikowski@intel.com>
Date: Sat, 6 Nov 2021 00:01:02 +0000
Subject: [Intel-wired-lan] [PATCH net-next 6/6] docs: net: Add
 description of SyncE interfaces
In-Reply-To: <20211105143013.2cded2f3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20211104081231.1982753-1-maciej.machnikowski@intel.com>
 <20211104081231.1982753-7-maciej.machnikowski@intel.com>
 <20211104110855.3ead1642@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <MW5PR11MB5812FA6647FF189D368C75A5EA8E9@MW5PR11MB5812.namprd11.prod.outlook.com>
 <20211105143013.2cded2f3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <MW5PR11MB58126A63061BFACB81A98194EA8F9@MW5PR11MB5812.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Friday, November 5, 2021 10:30 PM
> To: Machnikowski, Maciej <maciej.machnikowski@intel.com>
> Subject: Re: [PATCH net-next 6/6] docs: net: Add description of SyncE
> interfaces
> 
> On Fri, 5 Nov 2021 11:51:48 +0000 Machnikowski, Maciej wrote:
> > > I'm still struggling to understand your reasoning around not making
> > > EEC its own object. "We can do this later" seems like trading
> > > relatively little effort now for extra work for driver and application
> > > developers for ever.
> >
> > That's not the case. We need EEC and the other subsystem we wanted
> > to make is the DPLL subsystem. While EEC can be a DPLL - it doesn't have
> > to, and it's also the other way round - the DPLL can have numerous
> different
> > usages.
> 
> We wanted to create a DPLL object to the extent that as a SW guy
> I don't understand the difference between that and an EEC. Whatever
> category of *PLL etc. objects EEC is, that's what we want to model.

The DPLL has more uses than just EEC. I.e. Timing card uses one to generate
different frequencies synchronized to 1PPS coming from the GNSS receiver.

Implementing the whole DPLL subsystem may be an overkill for some
basic solutions that are embedded inside the PHY and only handle the
syntonization of TX frequency to the RX one. In this case all they would
report is the current state.

> > When we add the DPLL subsystem support the future work will be as
> simple
> > as routing the EEC state read function to the DPLL subsystem. But if
> someone
> > decides to use a different HW implementation he will still be able to
> > implement his own version of API to handle it without a bigger DPLL block
> 
> All we want is something that's not a port to hang whatever attributes
> exist in RTM_GETEECSTATE.

Routing to the DPLL object will be a specific use-case required only
if we support advanced cases with external sources of frequency
(like an atomic clock).
 
