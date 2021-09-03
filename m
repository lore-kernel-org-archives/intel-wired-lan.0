From: Machnikowski, Maciej <maciej.machnikowski@intel.com>
Date: Fri, 3 Sep 2021 22:20:36 +0000
Subject: [Intel-wired-lan] [PATCH net-next 1/2] rtnetlink: Add new
 RTM_GETEECSTATE message to get SyncE status
In-Reply-To: <20210903091857.70bdf57a@hermes.local>
References: <20210903151436.529478-1-maciej.machnikowski@intel.com>
 <20210903151436.529478-2-maciej.machnikowski@intel.com>
 <20210903091857.70bdf57a@hermes.local>
Message-ID: <PH0PR11MB495197890322A371FDA59F3FEACF9@PH0PR11MB4951.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Friday, September 3, 2021 6:19 PM
> Subject: Re: [PATCH net-next 1/2] rtnetlink: Add new RTM_GETEECSTATE
> message to get SyncE status
> 
> On Fri,  3 Sep 2021 17:14:35 +0200
> Maciej Machnikowski <maciej.machnikowski@intel.com> wrote:
> 
> > This patch series introduces basic interface for reading the Ethernet
> > Equipment Clock (EEC) state on a SyncE capable device. This state gives
> > information about the state of EEC. This interface is required to
> > implement Synchronization Status Messaging on upper layers.
> >
> > Initial implementation returns SyncE EEC state and flags attributes.
> > The only flag currently implemented is the EEC_SRC_PORT. When it's set
> > the EEC is synchronized to the recovered clock recovered from the
> > current port.
> >
> > SyncE EEC state read needs to be implemented as a ndo_get_eec_state
> > function.
> >
> > Signed-off-by: Maciej Machnikowski <maciej.machnikowski@intel.com>
> 
> Is there a simpler way to do this? Seems like you are adding
> a lot for a use case specific to a small class of devices.
> For example adding a new network device operation adds small
> amount of bloat to every other network device in the kernel.

Hi!

I couldn't find any simpler way. Do you have something specific in mind?
A function pointer is only U64. I can hardly think of anything smaller.

Regards
Maciek

