From: Richard Cochran <richardcochran@gmail.com>
Date: Wed, 18 Aug 2021 10:02:59 -0700
Subject: [Intel-wired-lan] [RFC net-next 1/7] ptp: Add interface for
 acquiring DPLL state
In-Reply-To: <PH0PR11MB4951762ECB04D90D634E905DEAFE9@PH0PR11MB4951.namprd11.prod.outlook.com>
References: <20210816160717.31285-1-arkadiusz.kubalewski@intel.com>
 <20210816160717.31285-2-arkadiusz.kubalewski@intel.com>
 <20210816235400.GA24680@hoboy.vegasvil.org>
 <PH0PR11MB4951762ECB04D90D634E905DEAFE9@PH0PR11MB4951.namprd11.prod.outlook.com>
Message-ID: <20210818170259.GD9992@hoboy.vegasvil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Aug 17, 2021 at 09:41:49AM +0000, Machnikowski, Maciej wrote:

> The logic behind adding the DPLL state to the PTP subsystem is that SyncE DPLL on Network adapters, in most cases, drive the PTP timer.

So what?  The logic in the HW has nothing to do with the proper user
space interfaces.  For example, we have SO_TIMESTAMPING and PHC as
separate APIs, even though HW devices often implement both.

> Having access to it in the PTP subsystem is beneficial, as Telco
> standards, like G.8275.1/2, require a different behavior depending
> on the SyncE availability and state.

Right, but this does say anything about the API.

> Multiport adapters use a single PLL to drive all ports. If we add
> the PLL interface to the PTP device - a tool that would implement
> support for Telco standards would have a single source of
> information about the presence and state of physical sync.

Not really.  Nothing guarantees a sane mapping from MAC to PHC.  In
many systems, there a many of each.

> Moreover, it'll open the path for implementing PLL state-aware
> ext_ts that would generate events only when the PLL device is locked
> to the incoming signals improving the quality of external TS
> events. I.e. an external PLL can be used to monitor incoming 1PPS
> signal and disable event generation when its frequency drifts off
> 1Hz by preset margins.

I don't see how this prevents using RTNL (or something else) as the
API for the SyncE configuration.

> If we bind it to the Network port, a tool would need to find the
> port that owns the PLL and read the state from a different place,
> which sounds suboptimal.

This is exactly how it works in ptpl4 today.  Some information comes
from the PHC, some from RTNL (link state), some from ethtool
(phc-interface mapping and time stamping abilities).

> Additionally we'll lose ability to rely on external HW to monitor
> external TS events.

Sorry, I can't see that at all.

Please do NOT tack this stuff onto the PHC subsystem just because you
can.

Thanks,
Richard
