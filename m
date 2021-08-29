From: Machnikowski, Maciej <maciej.machnikowski@intel.com>
Date: Sun, 29 Aug 2021 16:42:55 +0000
Subject: [Intel-wired-lan] [RFC v2 net-next 1/2] rtnetlink: Add new
 RTM_GETSYNCESTATE message to get SyncE status
In-Reply-To: <20210829151017.GA6016@hoboy.vegasvil.org>
References: <20210829080512.3573627-1-maciej.machnikowski@intel.com>
 <20210829080512.3573627-2-maciej.machnikowski@intel.com>
 <20210829151017.GA6016@hoboy.vegasvil.org>
Message-ID: <PH0PR11MB495126A63998DABA5B5DE184EACA9@PH0PR11MB4951.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Richard Cochran <richardcochran@gmail.com>
> Sent: Sunday, August 29, 2021 5:10 PM
> Subject: Re: [RFC v2 net-next 1/2] rtnetlink: Add new RTM_GETSYNCESTATE
> message to get SyncE status
> 
> On Sun, Aug 29, 2021 at 10:05:11AM +0200, Maciej Machnikowski wrote:
> >
> > This patch is SyncE-oriented. Future implementation can add additional
> > functionality for reading different DPLL states using the same structure.
> 
> I would call this more "ice oriented" than SyncE oriented.  I'm not sure there is
> even such a thing as "SyncE DPLL".  Does that term come from 802.3?  To my
> understanding, that is one just way of implementing it that works on super-
> Gigabit speed devices.
> 
Hi,
This interface is ITU-T G.8264 SyncE-oriented. It is meant to monitor the state
of Ethernet Equipment Clock.

ITU-T G.8264 recommendation defines Synchronous Ethernet equipment
as a device  equipped with a system clock (e.g., a synchronous Ethernet
equipment clock). SyncE interfaces are able to extract the received clock
and pass it to a system clock.

Please take a look at the 10.2 Operation modes of the G.8264 and at the Figure A.1
which depicts the EEC. This interface is to report the status of the EEC.

If you prefer EEC over DPLL I'm fine with the name change. I think it will be less confusing.

> I have nothing against exposing the DPLL if you need to, however I'd like to have
> an interface that support plain Gigabit as well.  This could be done in a generic
> way by offering Control Register 9 as described in 802.3.

This part of Gigabit interface is a different part of SyncE device. It controls Master/Slave
operation of auto-negotiation. 
You would use it in slave mode if you want your EEC to tune to the frequency recovered
from network and to master if you use external source for your EEC and want to send it
as a reference for another devices. The decision can be made based on the EEC state
read by the interface proposed in this RFC.

This is a functionality that belongs to a different interface mentioned in the next steps.

Regards
Maciek
