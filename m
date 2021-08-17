From: Machnikowski, Maciej <maciej.machnikowski@intel.com>
Date: Tue, 17 Aug 2021 09:41:49 +0000
Subject: [Intel-wired-lan] [RFC net-next 1/7] ptp: Add interface for
 acquiring DPLL state
In-Reply-To: <20210816235400.GA24680@hoboy.vegasvil.org>
References: <20210816160717.31285-1-arkadiusz.kubalewski@intel.com>
 <20210816160717.31285-2-arkadiusz.kubalewski@intel.com>
 <20210816235400.GA24680@hoboy.vegasvil.org>
Message-ID: <PH0PR11MB4951762ECB04D90D634E905DEAFE9@PH0PR11MB4951.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> > Previously there was no common interface for monitoring
> > synchronization state of Digital Phase Locked Loop.
> >
> > Add interface through PTP ioctl subsystem for tools, as well as sysfs
> > human-friendly part of the interface.
> >
> > enum dpll_state moved to uapi definition, it is required to have
> > common definition of DPLL states in uapi.
> 
> This has nothing to do with PTP, right?
> 
> So why isn't it a RTNL feature instead?
> 
> Thanks,
> Richard


The logic behind adding the DPLL state to the PTP subsystem is that SyncE DPLL on Network adapters, in most cases, drive the PTP timer.
Having access to it in the PTP subsystem is beneficial, as Telco standards, like G.8275.1/2, require a different behavior depending on the SyncE availability and state.
Multiport adapters use a single PLL to drive all ports. If we add the PLL interface to the PTP device - a tool that would implement support for Telco standards would have a single source of information about the presence and state of physical sync.

Moreover, it'll open the path for implementing PLL state-aware ext_ts that would generate events only when the PLL device is locked to the incoming signals improving the quality of external TS events. I.e. an external PLL can be used to monitor incoming 1PPS signal and disable event generation when its frequency drifts off 1Hz by preset margins.
 
If we bind it to the Network port, a tool would need to find the port that owns the PLL and read the state from a different place, which sounds suboptimal. Additionally we'll lose ability to rely on external HW to monitor external TS events.
 
Regards
Maciek
