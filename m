From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 31 Aug 2021 08:32:27 -0700
Subject: [Intel-wired-lan] [RFC v2 net-next 1/2] rtnetlink: Add new
 RTM_GETSYNCESTATE message to get SyncE status
In-Reply-To: <SJ0PR11MB4958304AA06A63DD6290D3DEEACC9@SJ0PR11MB4958.namprd11.prod.outlook.com>
References: <20210829080512.3573627-1-maciej.machnikowski@intel.com>
 <20210829080512.3573627-2-maciej.machnikowski@intel.com>
 <20210829151017.GA6016@hoboy.vegasvil.org>
 <PH0PR11MB495126A63998DABA5B5DE184EACA9@PH0PR11MB4951.namprd11.prod.outlook.com>
 <20210830205758.GA26230@hoboy.vegasvil.org>
 <20210830162909.110753ec@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <SJ0PR11MB4958029CF18F93846B29F685EACC9@SJ0PR11MB4958.namprd11.prod.outlook.com>
 <20210831063304.4bcacbe3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <SJ0PR11MB49583C74616AC7E715C6E3A9EACC9@SJ0PR11MB4958.namprd11.prod.outlook.com>
 <20210831071801.0535c0cf@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <SJ0PR11MB4958304AA06A63DD6290D3DEEACC9@SJ0PR11MB4958.namprd11.prod.outlook.com>
Message-ID: <20210831083227.3d9df78a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 31 Aug 2021 15:19:36 +0000 Machnikowski, Maciej wrote:
> > It's a reasonable SW design strategy to start simple. Unfortunately,
> > it doesn't apply to stable uAPI design. You're adding a RTNL op, which
> > will have to be supported for ever. If we add anything "later" it will
> > be a strict addition, and will have to be backward compatible. Which
> > I'm not sure how to do when the object we'd operate on would be
> > completely different (clock vs netdev).  
> 
> I agree - the point I'm trying to make here is that the existence of
> the PTP-specific interface will not invalidate the need of having 
> SyncE-specific one as well. Even if we report lock-states for the clock
> we will still need to report lock-states for devices that don't use PTP
> clocks, but support SyncE. (that's also a reason why RTNL is still required).
> 
> The RTNL interface will also address devices that only need the 
> frequency syntonization (especially in Radio Access Networks).
> 
> > 
> > As I said I can write the boilerplate code for you if you prefer, the
> > code implementing the command and the driver interface will be almost
> > identical.  
> 
> I think it's a great idea to start that in parallel to this patch. Then move
> the common structures to the generic layer and use them in both
> SyncE-specific RTNL implementation and PTP-specific part that will
> be added. This won't affect SyncE specific APIs. The "worst" that can
> happen is that the driver will put the same info for PTP part and
> SyncE part if that's the design someone follows.

I don't understand why we need the SyncE RTNL if we have clock API for
controlling the freq source. Are you saying that there are
implementations out there which use SyncE to recover Rx clock and use
it for Tx but the PTP ticker is in a different clock domain?
