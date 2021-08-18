From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Wed, 18 Aug 2021 18:14:13 +0000
Subject: [Intel-wired-lan] [RFC net-next 1/7] ptp: Add interface for
 acquiring DPLL state
In-Reply-To: <20210818170259.GD9992@hoboy.vegasvil.org>
References: <20210816160717.31285-1-arkadiusz.kubalewski@intel.com>
 <20210816160717.31285-2-arkadiusz.kubalewski@intel.com>
 <20210816235400.GA24680@hoboy.vegasvil.org>
 <PH0PR11MB4951762ECB04D90D634E905DEAFE9@PH0PR11MB4951.namprd11.prod.outlook.com>
 <20210818170259.GD9992@hoboy.vegasvil.org>
Message-ID: <CO1PR11MB5089A30F5681B860B3F9F96CD6FF9@CO1PR11MB5089.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Richard Cochran
> Sent: Wednesday, August 18, 2021 10:03 AM
> To: Machnikowski, Maciej <maciej.machnikowski@intel.com>
> Cc: cong.wang at bytedance.com; arnd at arndb.de; gustavoars at kernel.org;
> netdev at vger.kernel.org; linux-kernel at vger.kernel.org;
> colin.king at canonical.com; intel-wired-lan at lists.osuosl.org; nikolay at nvidia.com;
> linux-kselftest at vger.kernel.org; kuba at kernel.org; shuah at kernel.org;
> davem at davemloft.net
> Subject: Re: [Intel-wired-lan] [RFC net-next 1/7] ptp: Add interface for acquiring
> DPLL state
> 
> On Tue, Aug 17, 2021 at 09:41:49AM +0000, Machnikowski, Maciej wrote:
> 
> > The logic behind adding the DPLL state to the PTP subsystem is that SyncE DPLL
> on Network adapters, in most cases, drive the PTP timer.
> 
> So what?  The logic in the HW has nothing to do with the proper user
> space interfaces.  For example, we have SO_TIMESTAMPING and PHC as
> separate APIs, even though HW devices often implement both.
> 
> > Having access to it in the PTP subsystem is beneficial, as Telco
> > standards, like G.8275.1/2, require a different behavior depending
> > on the SyncE availability and state.
> 
> Right, but this does say anything about the API.
> 
> > Multiport adapters use a single PLL to drive all ports. If we add
> > the PLL interface to the PTP device - a tool that would implement
> > support for Telco standards would have a single source of
> > information about the presence and state of physical sync.
> 
> Not really.  Nothing guarantees a sane mapping from MAC to PHC.  In
> many systems, there a many of each.
> 

Well, I think the point of placing it in the PTP subsystem is that there is a sane mapping between PHC <-> DPLL. There's only one DPLL for the PHC.

Thanks,
Jake
