From: Machnikowski, Maciej <maciej.machnikowski@intel.com>
Date: Sun, 29 Aug 2021 08:19:54 +0000
Subject: [Intel-wired-lan] [RFC net-next 1/2] rtnetlink: Add new
 RTM_GETSYNCESTATE message to get SyncE status
In-Reply-To: <YSqw6aJRrWbxRaas@lunn.ch>
References: <20210828211248.3337476-1-maciej.machnikowski@intel.com>
 <20210828211248.3337476-2-maciej.machnikowski@intel.com>
 <YSqw6aJRrWbxRaas@lunn.ch>
Message-ID: <PH0PR11MB49514899CD7CE514E792CE40EACA9@PH0PR11MB4951.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Saturday, August 28, 2021 11:56 PM
> To: Machnikowski, Maciej <maciej.machnikowski@intel.com>
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org;
> richardcochran at gmail.com; abyagowi at fb.com; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; davem at davemloft.net; kuba at kernel.org;
> linux-kselftest at vger.kernel.org
> Subject: Re: [RFC net-next 1/2] rtnetlink: Add new RTM_GETSYNCESTATE
> message to get SyncE status
> 
> On Sat, Aug 28, 2021 at 11:12:47PM +0200, Maciej Machnikowski wrote:
> > This patch adds the new RTM_GETSYNCESTATE message to query the
> status
> > of SyncE syntonization on the device.
> 
> Hi Maciej
> 
> You use syntonization a few times. Is this a miss spelling for synchronisation,
> or a SyncE terms?

Hi! Thanks for your comments!

Syntonization is a specific term for frequency synchronization.


> >
> >  struct prefixmsg {
> > @@ -569,7 +572,7 @@ struct prefixmsg {
> >  	unsigned char	prefix_pad3;
> >  };
> >
> > -enum
> > +enum
> >  {
> >  	PREFIX_UNSPEC,
> >  	PREFIX_ADDRESS,
> 
> You appear to have a number of white space changes here. Please put them
> into a separate patch, or drop them.

Will fix and resubmit along with the fix for issues found by the robot

Thanks!
Maciek

> 
>      Andrew
