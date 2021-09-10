From: Richard Cochran <richardcochran@gmail.com>
Date: Fri, 10 Sep 2021 07:14:23 -0700
Subject: [Intel-wired-lan] [PATCH net-next 1/2] rtnetlink: Add new
 RTM_GETEECSTATE message to get SyncE status
In-Reply-To: <PH0PR11MB49515C4ACE9BAD7BD9172825EAD59@PH0PR11MB4951.namprd11.prod.outlook.com>
References: <PH0PR11MB49512C265E090FC8741D8510EAD39@PH0PR11MB4951.namprd11.prod.outlook.com>
 <20210907124730.33852895@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <PH0PR11MB495169997552152891A69B57EAD49@PH0PR11MB4951.namprd11.prod.outlook.com>
 <20210908092115.191fdc28@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <PH0PR11MB4951AA3C65DD8E7612F5F396EAD49@PH0PR11MB4951.namprd11.prod.outlook.com>
 <YTkQTQM6Is4Hqmxh@lunn.ch>
 <20210908152027.313d7168@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <YTlAT+1wkazy3Uge@lunn.ch>
 <20210909020915.GA30747@hoboy.vegasvil.org>
 <PH0PR11MB49515C4ACE9BAD7BD9172825EAD59@PH0PR11MB4951.namprd11.prod.outlook.com>
Message-ID: <20210910141423.GA21865@hoboy.vegasvil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Sep 09, 2021 at 08:18:10AM +0000, Machnikowski, Maciej wrote:

> Controlling the clock that actually drives any components (PHY/MAC) in
> runtime can be a good way to brick the part.

I didn't say that.

> I feel that, while the reuse 
> of structures may be a good idea, the userspace API for clocks is not. 
> They are usually set up once at the board init level and stay like that "forever".
> 
> The outputs we need to control are only a subset of all of them and they
> rather fall in the PTP pins level of details, rather than clock ones.

clk-gate.c
clk-mux.c

Making that available for user space to twiddle is a better way that
tacking on to the PTP stuff.

You can model your device as having a multiplexer in front of it.

Thanks,
Richard
