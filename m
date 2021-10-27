From: Ido Schimmel <idosch@idosch.org>
Date: Wed, 27 Oct 2021 18:05:01 +0300
Subject: [Intel-wired-lan] [RFC v5 net-next 0/5] Add RTNL interface for
 SyncE
In-Reply-To: <PH0PR11MB4951A17040D860D8AC6975C1EA859@PH0PR11MB4951.namprd11.prod.outlook.com>
References: <20211026173146.1031412-1-maciej.machnikowski@intel.com>
 <YXj2oKjjobd0ZgBi@shredder>
 <PH0PR11MB4951A17040D860D8AC6975C1EA859@PH0PR11MB4951.namprd11.prod.outlook.com>
Message-ID: <YXlqnXRw2iL7bGrh@shredder>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Oct 27, 2021 at 01:21:58PM +0000, Machnikowski, Maciej wrote:
> 
> 
> > -----Original Message-----
> > From: Ido Schimmel <idosch@idosch.org>
> > Sent: Wednesday, October 27, 2021 8:50 AM
> > To: Machnikowski, Maciej <maciej.machnikowski@intel.com>
> > Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org;
> > richardcochran at gmail.com; abyagowi at fb.com; Nguyen, Anthony L
> > <anthony.l.nguyen@intel.com>; davem at davemloft.net; kuba at kernel.org;
> > linux-kselftest at vger.kernel.org; mkubecek at suse.cz; saeed at kernel.org;
> > michael.chan at broadcom.com
> > Subject: Re: [RFC v5 net-next 0/5] Add RTNL interface for SyncE
> > 
> > On Tue, Oct 26, 2021 at 07:31:41PM +0200, Maciej Machnikowski wrote:
> > > Synchronous Ethernet networks use a physical layer clock to syntonize
> > > the frequency across different network elements.
> > >
> > > Basic SyncE node defined in the ITU-T G.8264 consist of an Ethernet
> > > Equipment Clock (EEC) and have the ability to recover synchronization
> > > from the synchronization inputs - either traffic interfaces or external
> > > frequency sources.
> > > The EEC can synchronize its frequency (syntonize) to any of those sources.
> > > It is also able to select synchronization source through priority tables
> > > and synchronization status messaging. It also provides neccessary
> > > filtering and holdover capabilities
> > >
> > > This patch series introduces basic interface for reading the Ethernet
> > > Equipment Clock (EEC) state on a SyncE capable device. This state gives
> > > information about the source of the syntonization signal (ether my port,
> > > or any external one) and the state of EEC. This interface is required\
> > > to implement Synchronization Status Messaging on upper layers.
> > >
> > > v2:
> > > - removed whitespace changes
> > > - fix issues reported by test robot
> > > v3:
> > > - Changed naming from SyncE to EEC
> > > - Clarify cover letter and commit message for patch 1
> > > v4:
> > > - Removed sync_source and pin_idx info
> > > - Changed one structure to attributes
> > > - Added EEC_SRC_PORT flag to indicate that the EEC is synchronized
> > >   to the recovered clock of a port that returns the state
> > > v5:
> > > - add EEC source as an optiona attribute
> > > - implement support for recovered clocks
> > > - align states returned by EEC to ITU-T G.781
> > 
> > Hi,
> > 
> > Thanks for continuing to work on this.
> > 
> > I was under the impression (might be wrong) that the consensus last time
> > was to add a new ethtool message to query the mapping between the port
> > and the EEC clock (similar to TSINFO_GET) and then use a new generic
> > netlink family to perform operations on the clock itself.
> 
> Hi!
> 
> I believe we finally agreed to continue with this implementations (for a
> simplified devices) and when the DPLL subsystem is ready, plug it into this
> API as well using the discovery mechanism. As there may be some simplified
> solutions that would not use the controllable DPLL and only provide the
> status (i.e. using physical signals)

By "simplified solutions" you are referring to simple NEs that only
synchronize their frequency according to what they extract from the
physical layer as opposed to an external source such as in the PRC case?

> 
> > At least in the case of RTM_GETEECSTATE and a multi-port adapter, you
> > would actually query the same state via each netdev, but without
> > realizing it's the same clock.
> 
> True, yet for a given port we need info whether we are locked or not,
> so the interdependency wouldn't break anything.

But if two ports are using the same EEC, then it's not possible for them
to report a different EEC state, right? The only difference is that one
port can be the source and the other isn't, but this is also an
attribute of the EEC.

Basically, I'm saying that it seems that we report attributes of a
single object (the EEC) via multiple objects using it (the netdevs)
without making the relation clear to user space.

I'm not strictly against it, but rather wondering why.

>  
> > I think another reason to move to ethtool was that this stuff is
> > completely specific to Ethernet and not applicable to all logical
> > netdevs.
> 
> That was an open in previous discussion. Wanted to first show the
> full API to discuss where it fits. I believe all other networks (like SONET)
> may also benefit from having it in the netdev, but am open for discussion.

OK, didn't think about SONET. There is include/uapi/linux/sonet.h with a
few SONET specific ioctls and a couple of drivers implementing them. The
whole thing looks quite dead...

ethtool still seems like a better option for something that has
"Ethernet" in its name :)
