From: Machnikowski, Maciej <maciej.machnikowski@intel.com>
Date: Thu, 28 Oct 2021 06:34:26 +0000
Subject: [Intel-wired-lan] [RFC v5 net-next 2/5] rtnetlink: Add new
 RTM_GETEECSTATE message to get SyncE status
In-Reply-To: <YXlr9jEZ6jrywpe9@shredder>
References: <20211026173146.1031412-1-maciej.machnikowski@intel.com>
 <20211026173146.1031412-3-maciej.machnikowski@intel.com>
 <YXj7WkEb0PagWfSw@shredder>
 <PH0PR11MB495191854BF5470E9BF223F5EA859@PH0PR11MB4951.namprd11.prod.outlook.com>
 <YXlr9jEZ6jrywpe9@shredder>
Message-ID: <MW5PR11MB581227D73C9FD010A50759AEEA869@MW5PR11MB5812.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Ido Schimmel <idosch@idosch.org>
> Sent: Wednesday, October 27, 2021 5:11 PM
> To: Machnikowski, Maciej <maciej.machnikowski@intel.com>
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org;
> richardcochran at gmail.com; abyagowi at fb.com; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; davem at davemloft.net; kuba at kernel.org;
> linux-kselftest at vger.kernel.org; mkubecek at suse.cz; saeed at kernel.org;
> michael.chan at broadcom.com
> Subject: Re: [RFC v5 net-next 2/5] rtnetlink: Add new RTM_GETEECSTATE
> message to get SyncE status
> 
> On Wed, Oct 27, 2021 at 01:16:22PM +0000, Machnikowski, Maciej wrote:
> >
> >
> > > -----Original Message-----
> > > From: Ido Schimmel <idosch@idosch.org>
> > > Sent: Wednesday, October 27, 2021 9:10 AM
> > > To: Machnikowski, Maciej <maciej.machnikowski@intel.com>
> > > Subject: Re: [RFC v5 net-next 2/5] rtnetlink: Add new RTM_GETEECSTATE
> > > message to get SyncE status
> > >
> > > On Tue, Oct 26, 2021 at 07:31:43PM +0200, Maciej Machnikowski wrote:
> > > > +/* SyncE section */
> > > > +
> > > > +enum if_eec_state {
> > > > +	IF_EEC_STATE_INVALID = 0,
> > > > +	IF_EEC_STATE_FREERUN,
> > > > +	IF_EEC_STATE_LOCKED,
> > > > +	IF_EEC_STATE_LOCKED_HO_ACQ,
> > >
> > > Is this referring to "Locked mode, acquiring holdover: This is a
> > > temporary mode, when coming from free-run, to acquire holdover
> > > memory."
> > > ?
> >
> > Locked HO ACQ means locked and holdover acquired. It's the state that
> > allows transferring to the holdover state. Locked means that we locked
> > our frequency and started acquiring the holdover memory.
> 
> So that's a transient state, right? FWIW, I find it weird to call such a
> state "LOCKED".
> 
> >
> > > It seems ice isn't using it, so maybe drop it? Can be added later in
> > > case we have a driver that can report it
> >
> > I'll update the driver in the next revision
> 
> You mean update it to use "IF_EEC_STATE_LOCKED_HO_ACQ" instead of
> "IF_EEC_STATE_LOCKED"?

Rather report them separately - as there's a value in having info about both 
of them. LOCKED_HO_ACQ can be forced into forced holdover, while the 
LOCKED will revert to freerun.

> Regardless, would be good to document these values.

Noted! :)

> >
> > > There is also "Locked mode, holdover acquired: This is a steady state
> > > mode, entered when holdover memory is acquired." But I assume that's
> > > "IF_EEC_STATE_LOCKED"
> > >
> > > > +	IF_EEC_STATE_HOLDOVER,
> > > > +};
