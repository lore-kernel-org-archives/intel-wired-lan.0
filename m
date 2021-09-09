From: Machnikowski, Maciej <maciej.machnikowski@intel.com>
Date: Thu, 9 Sep 2021 08:11:51 +0000
Subject: [Intel-wired-lan] [PATCH net-next 1/2] rtnetlink: Add new
 RTM_GETEECSTATE message to get SyncE status
In-Reply-To: <20210908151852.7ad8a0f1@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20210903151436.529478-1-maciej.machnikowski@intel.com>
 <PH0PR11MB4951623918C9BA8769C10E50EAD29@PH0PR11MB4951.namprd11.prod.outlook.com>
 <20210906113925.1ce63ac7@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <PH0PR11MB49511F2017F48BBAAB2A065CEAD29@PH0PR11MB4951.namprd11.prod.outlook.com>
 <20210906180124.33ff49ef@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <PH0PR11MB495152B03F32A5A17EDB2F6CEAD39@PH0PR11MB4951.namprd11.prod.outlook.com>
 <20210907075509.0b3cb353@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <PH0PR11MB49512C265E090FC8741D8510EAD39@PH0PR11MB4951.namprd11.prod.outlook.com>
 <20210907124730.33852895@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <PH0PR11MB495169997552152891A69B57EAD49@PH0PR11MB4951.namprd11.prod.outlook.com>
 <20210908092115.191fdc28@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <PH0PR11MB4951AA3C65DD8E7612F5F396EAD49@PH0PR11MB4951.namprd11.prod.outlook.com>
 <20210908151852.7ad8a0f1@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <PH0PR11MB4951205B0D078D94ADBAFCACEAD59@PH0PR11MB4951.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Thursday, September 9, 2021 12:19 AM
> To: Machnikowski, Maciej <maciej.machnikowski@intel.com>
> Subject: Re: [PATCH net-next 1/2] rtnetlink: Add new RTM_GETEECSTATE
> message to get SyncE status
> 
> On Wed, 8 Sep 2021 17:30:24 +0000 Machnikowski, Maciej wrote:
> > Lane0
> > ------------- |\  Pin0        RefN ____
> > ------------- | |-----------------|     |      synced clk
> >               | |-----------------| EEC |------------------
> > ------------- |/ PinN         RefM|____ |
> > Lane N      MUX
> >
> > To get the full info a port needs to know the EEC state and which lane is
> used
> > as a source (or rather - my lane or any other).
> 
> EEC here is what the PHY documentation calls "Cleanup PLL" right?

It's a generic term for an internal or external PLL that takes the reference
frequency from the certain port/lane and drives its TX part. In a specific 
case it can be the internal cleanup PLL.

> > The lane -> Pin mapping is buried in the PHY/MAC, but the source of
> frequency
> > is in the EEC.
> 
> Not sure what "source of frequency" means here. There's a lot of
> frequencies here.

It's the source lane/port that drives the DPLL reference. In other words,
the DPLL will tune its frequency to match the one recovered from 
a certain PHY lane/port.

> > What's even more - the Pin->Ref mapping is board specific.
> 
> Breaking down the system into components we have:
> 
> Port
>   A.1 Rx lanes
>   A.2 Rx pins (outputs)
>   A.3 Rx clk divider
>   B.1 Tx lanes
>   B.2 Tx pins (inputs)
> 
> ECC
>   C.1 Inputs
>   C.2 Outputs
>   C.3 PLL state
> 
> In the most general case we want to be able to:
>  map recovered clocks to PHY output pins (A.1 <> A.2)
>  set freq div on the recovered clock (A.2 <> A.3)

Technically the pin (if exists) will be the last thing, so a better way would 
be to map lane to the divider (A.1<>A.3) and then a divider to pin (A.3<>A.2), 
but the idea is the same

>  set the priorities of inputs on ECC (C.1)
>  read the ECC state (C.3)
>  control outputs of the ECC (C.2)

Yes!

>  select the clock source for port Tx (B.2 <> B.1)

And here we usually don't allow control over this. The DPLL is preconfigured to 
output the frequency that's expected on the PHY/MAC clock input and we
shouldn't mess with it in runtime.

> As you said, pin -> ref mapping is board specific, so the API should
> not assume knowledge of routing between Port and ECC. If it does just
> give the pins matching names.

I believe referring to a board user guide is enough to cover that one, just like
with PTP pins. There may be 1000 different ways of connecting those signals.

> We don't have to implement the entire design but the pieces we do create
> must be right for the larger context. With the current code the
> ECC/Cleanup PLL is not represented as a separate entity, and mapping of
> what source means is on the wrong "end" of the A.3 <> C.1 relationship.

That's why I initially started with the EEC state + pin idx of the driving source.
I believe it's a cleaner solution, as then we can implement the same pin
indexes in the recovered clock part of the interface and the user will be
able to see the state and driving pin from the EEC_STATE (both belongs to
the DPLL) and use the PHY pins subsystem to see if the driving pin index
matches the index that I drive. In that case we keep all C-thingies in the C
subsystem and A stuff in A subsystem. The only "mix" is in the pin indexes
that would use numbering from C.
If it's an attribute - it can as well be optional for the deployments that
don't need/support it.

> > The viable solutions are:
> > - Limit to the proposed "I drive the clock" vs "Someone drives it" and
> assume the
> >    Driver returns all info
> > - return the EEC Ref index, figure out which pin is connected to it and then
> check
> >   which MAC/PHY lane that drives it.
> >
> > I assume option one is easy to implement and keep in the future even if
> we
> > finally move to option 2 once we define EEC/DPLL subsystem.
> >
> > In future #1 can take the lock information from the DPLL subsystem, but
> > will also enable simple deployments that won't expose the whole DPLL,
> > like a filter PLL embedded in a multiport PHY that will only work for
> > SyncE in which case this API will only touch a single component.
> 
> Imagine a system with two cascaded switch ASICs and a bunch of PHYs.
> How do you express that by pure extensions to the proposed API?
> Here either the cleanup PLLs would be cascaded (subordinate one needs
> to express that its "source" is another PLL) or single lane can be
> designated as a source for both PLLs (but then there is only one
> "source" bit and multiple "enum if_eec_state"s).

In that case - once we have pins- we'll see that the leader DPLL is synced
to the pin that comes from the PHY/MAC and be able to find the corresponding
lane, and on the follower side we'll see that it's locked to the pin that
corresponds to the master DPLL. The logic to "do something" with
that knowledge needs to be in the userspace app, as there may be
some external connections needed that are unknown at the board level
(think of 2 separate adapters connected with an external cable).

> I think we can't avoid having a separate object for ECC/Cleanup PLL.
> You can add it as a subobject to devlink but new genetlink family seems
> much preferable given the devlink instances themselves have unclear
> semantics at this point. Or you can try to convince Richard that ECC
> belongs as part of PTP :)

> In fact I don't think you care about any of the PHY / port stuff
> currently. All you need is the ECC side of the API. IIUC you have
> relatively simple setup where there is only one pin per port, and
> you don't care about syncing the Tx clock.

I actually do. There's (almost) always less recovered clock resources
(aka pins) than ports/lanes in the system. The TX clock will be
synchronized once the EEC reports the lock state, as it's the part that
generates clocks for the TX part of the PHY.
