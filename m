From: Machnikowski, Maciej <maciej.machnikowski@intel.com>
Date: Tue, 31 Aug 2021 11:33:25 +0000
Subject: [Intel-wired-lan] [RFC v3 net-next 1/2] rtnetlink: Add new
 RTM_GETEECSTATE message to get SyncE status
In-Reply-To: <20210830111416.34a8362d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20210829173934.3683561-1-maciej.machnikowski@intel.com>
 <20210829173934.3683561-2-maciej.machnikowski@intel.com>
 <20210830111416.34a8362d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <SJ0PR11MB495871A89632732B0028404EEACC9@SJ0PR11MB4958.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Monday, August 30, 2021 8:14 PM
> To: Machnikowski, Maciej <maciej.machnikowski@intel.com>
> Subject: Re: [RFC v3 net-next 1/2] rtnetlink: Add new RTM_GETEECSTATE

> > +#define IF_EEC_PIN_UNKNOWN	0xFF
> > +
> > +struct if_eec_state_msg {
> > +	__u32 ifindex;
> > +	__u8 state;
> > +	__u8 src;
> > +	__u8 pin;
> > +	__u8 pad;
> > +};
> 
> Please break this structure up into individual attributes.
> 
> This way you won't have to expose the special PIN_UNKNOWN value to user
> space (skip the invalid attrs instead).

Addressed all other comments. 
For this one - I'll add flags which will indicate validity of all values. Since 
this structure is self-contained and addresses the generic need for state 
report.

Will resubmit as a patch.

Thanks!
Maciek

