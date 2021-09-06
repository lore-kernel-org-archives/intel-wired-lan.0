From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 6 Sep 2021 11:39:25 -0700
Subject: [Intel-wired-lan] [PATCH net-next 1/2] rtnetlink: Add new
 RTM_GETEECSTATE message to get SyncE status
In-Reply-To: <PH0PR11MB4951623918C9BA8769C10E50EAD29@PH0PR11MB4951.namprd11.prod.outlook.com>
References: <20210903151436.529478-1-maciej.machnikowski@intel.com>
 <20210903151436.529478-2-maciej.machnikowski@intel.com>
 <20210903151425.0bea0ce7@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <PH0PR11MB4951623918C9BA8769C10E50EAD29@PH0PR11MB4951.namprd11.prod.outlook.com>
Message-ID: <20210906113925.1ce63ac7@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 6 Sep 2021 18:30:40 +0000 Machnikowski, Maciej wrote:
> > -----Original Message-----
> > From: Jakub Kicinski <kuba@kernel.org>
> > Sent: Saturday, September 4, 2021 12:14 AM
> > Subject: Re: [PATCH net-next 1/2] rtnetlink: Add new RTM_GETEECSTATE
> > message to get SyncE status
> > 
> > On Fri,  3 Sep 2021 17:14:35 +0200 Maciej Machnikowski wrote:  
> > > This patch series introduces basic interface for reading the Ethernet
> > > Equipment Clock (EEC) state on a SyncE capable device. This state gives
> > > information about the state of EEC. This interface is required to
> > > implement Synchronization Status Messaging on upper layers.
> > >
> > > Initial implementation returns SyncE EEC state and flags attributes.
> > > The only flag currently implemented is the EEC_SRC_PORT. When it's set
> > > the EEC is synchronized to the recovered clock recovered from the
> > > current port.
> > >
> > > SyncE EEC state read needs to be implemented as a ndo_get_eec_state
> > > function.
> > >
> > > Signed-off-by: Maciej Machnikowski <maciej.machnikowski@intel.com>  
> > 
> > Since we're talking SyncE-only now my intuition would be to put this
> > op in ethtool. Was there a reason ethtool was not chosen? If not what
> > do others think / if yes can the reason be included in the commit
> > message?  
> 
> Hmm. Main reason for netlink is that linuxptp already supports it,
> and it was suggested by Richard.
> Having an NDO would also make it easier to add a SyncE-related
> files to the sysfs for easier operation (following the ideas from the ptp
> pins subsystem).
> But I'm open for suggestions. 

I think linuxptp will need support for ethtool netlink sockets sooner
rather than later. Moving this to ethtool makes sense to me since it's
very much a Ethernet-oriented API at this point.

> > > +#define EEC_SRC_PORT		(1 << 0) /* recovered clock from the  
> > port is  
> > > +					  * currently the source for the EEC
> > > +					  */  
> > 
> > Why include it then? Just leave the value out and if the attr is not
> > present user space should assume the source is port.  
> 
> This bit has a different meaning. If it's set the port in question
> is a frequency source for the multiport device, if it's cleared - some other
> source is used as a source. This is needed to prevent setting invalid 
> configurations in the PHY (like setting the frequency source as a Master
> in AN) or sending invalid messages. If the port is a frequency source
> it must always send back QL-DNU messages to prevent synchronization
> loops.

Ah! I see. Is being the "source" negotiated somehow? Don't we need to
give the user / linuxptp to select the source based on whatever info 
it has about topology?

> > or don't check the ifindex at all and let dev_get_by.. fail.
> > 
> > 
> > Thanks for pushing this API forward!  
> 
> Addressed all other comments - and thanks for giving a lot of helpful
> suggestions!

Thanks, BTW I think I forgot to ask for documentation, dumping info
about the API and context under Documentation/ would be great!
