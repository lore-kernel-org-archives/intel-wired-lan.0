From: Machnikowski, Maciej <maciej.machnikowski@intel.com>
Date: Mon, 8 Nov 2021 09:03:58 +0000
Subject: [Intel-wired-lan] [PATCH net-next 4/6] rtnetlink: Add support
 for SyncE recovered clock configuration
In-Reply-To: <YYfg2Gty6dNmjp1E@shredder>
References: <20211104081231.1982753-1-maciej.machnikowski@intel.com>
 <20211104081231.1982753-5-maciej.machnikowski@intel.com>
 <2d379392-a381-e60a-7658-5ac695c30df1@nvidia.com>
 <MW5PR11MB5812F4FD090FCEA7CD83E984EA8E9@MW5PR11MB5812.namprd11.prod.outlook.com>
 <YYfg2Gty6dNmjp1E@shredder>
Message-ID: <MW5PR11MB5812A805FD73E435EF43E9CDEA919@MW5PR11MB5812.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Ido Schimmel <idosch@idosch.org>
> Sent: Sunday, November 7, 2021 3:21 PM
> To: Machnikowski, Maciej <maciej.machnikowski@intel.com>
> Subject: Re: [PATCH net-next 4/6] rtnetlink: Add support for SyncE recovered
> clock configuration
> 
> On Fri, Nov 05, 2021 at 12:17:19PM +0000, Machnikowski, Maciej wrote:
> >
> >
> > > -----Original Message-----
> > > From: Roopa Prabhu <roopa@nvidia.com>
> > > Sent: Thursday, November 4, 2021 7:25 PM
> > > To: Machnikowski, Maciej <maciej.machnikowski@intel.com>;
> > > netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org
> > > Cc: richardcochran at gmail.com; abyagowi at fb.com; Nguyen, Anthony L
> > > <anthony.l.nguyen@intel.com>; davem at davemloft.net;
> kuba at kernel.org;
> > > linux-kselftest at vger.kernel.org; idosch at idosch.org; mkubecek at suse.cz;
> > > saeed at kernel.org; michael.chan at broadcom.com
> > > Subject: Re: [PATCH net-next 4/6] rtnetlink: Add support for SyncE
> recovered
> > > clock configuration
> > >
> > >
> > > On 11/4/21 1:12 AM, Maciej Machnikowski wrote:
> > > > Add support for RTNL messages for reading/configuring SyncE
> recovered
> > > > clocks.
> > > > The messages are:
> > > > RTM_GETRCLKRANGE: Reads the allowed pin index range for the
> > > recovered
> > > > 		  clock outputs. This can be aligned to PHY outputs or
> > > > 		  to EEC inputs, whichever is better for a given
> > > > 		  application
> > > >
> > > > RTM_GETRCLKSTATE: Read the state of recovered pins that output
> > > recovered
> > > > 		  clock from a given port. The message will contain the
> > > > 		  number of assigned clocks (IFLA_RCLK_STATE_COUNT) and
> > > > 		  a N pin inexes in IFLA_RCLK_STATE_OUT_IDX
> > > >
> > > > RTM_SETRCLKSTATE: Sets the redirection of the recovered clock for
> > > > 		  a given pin
> > > >
> > > > Signed-off-by: Maciej Machnikowski
> <maciej.machnikowski@intel.com>
> > > > ---
> > >
> > >
> > > Can't we just use a single RTM msg with nested attributes ?
> > >
> > > With separate RTM msgtype for each syncE attribute we will end up
> > > bloating the RTM msg namespace.
> > >
> > > (these api's could also be in ethtool given its directly querying the
> > > drivers)
> >
> > I'm not a fan of merging those messages. The mergeable ones are
> > GETRCLKRANGE and GETCLKSTATE, but the get range function may be
> > result in a significantly longer call if the information about the underlying
> > HW require any HW calls.
> > They are currently grouped in 3 categories:
> > - reading the boundaries in GetRclkRange (we can later add more to it, like
> > 	configurable frequency limits)
> > - Reading current configuration
> > - setting the required configuration
> >
> > I don't plan adding any additional RTM msg types for those (and that's
> > the reason why I pulled them before EEC state which may have more
> > messages in the future)
> >
> > We also discussed ethtool way in the past RFCs, but this concept
> > is applicable to any transport layer so I'd rather not limit it to ethernet
> > devices (i.e. SONET, infiniband and others).
> 
> I'm still not convinced that this doesn't belong in ethtool. I find it
> very weird to have a message called "Get Ethernet Equipment Clock State"
> in rtnetlink and not in ethtool. I also believe it was a mistake to add
> DCB to rtnetlink (for example, why PAUSE is configured via ethtool, but
> PFC via rtnetlink?)

We can use:
- SEC - Synchronous Equipment Clock
- EC - Equipment Clock

SyncE is a specific implementation of a more generic concept. I'd rather not limit
it to Ethernet only, as there are more network types that already use this concept,
like Sonet/SDH or PDH as well as GPON/EPON networks and given the recent
growth in timing applications - I expect more to follow.
