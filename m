From: Machnikowski, Maciej <maciej.machnikowski@intel.com>
Date: Tue, 31 Aug 2021 09:29:22 +0000
Subject: [Intel-wired-lan] [RFC net-next 1/7] ptp: Add interface for
 acquiring DPLL state
In-Reply-To: <20210830210610.GB26230@hoboy.vegasvil.org>
References: <20210816160717.31285-1-arkadiusz.kubalewski@intel.com>
 <20210816160717.31285-2-arkadiusz.kubalewski@intel.com>
 <20210816235400.GA24680@hoboy.vegasvil.org>
 <PH0PR11MB4951762ECB04D90D634E905DEAFE9@PH0PR11MB4951.namprd11.prod.outlook.com>
 <20210818170259.GD9992@hoboy.vegasvil.org>
 <PH0PR11MB495162EC9116F197D79589F5EAFF9@PH0PR11MB4951.namprd11.prod.outlook.com>
 <20210819153414.GC26242@hoboy.vegasvil.org>
 <PH0PR11MB4951F51CBA231DFD65806CDAEAC09@PH0PR11MB4951.namprd11.prod.outlook.com>
 <20210820155538.GB9604@hoboy.vegasvil.org>
 <PH0PR11MB49518ED9AAF8B543FD8324B9EAC19@PH0PR11MB4951.namprd11.prod.outlook.com>
 <20210830210610.GB26230@hoboy.vegasvil.org>
Message-ID: <SJ0PR11MB4958827821D5CFBC897E43B3EACC9@SJ0PR11MB4958.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Richard Cochran <richardcochran@gmail.com>
> Sent: Monday, August 30, 2021 11:06 PM
> To: Machnikowski, Maciej <maciej.machnikowski@intel.com>
> Subject: Re: [RFC net-next 1/7] ptp: Add interface for acquiring DPLL state
> 
> On Fri, Aug 20, 2021 at 06:30:02PM +0000, Machnikowski, Maciej wrote:
> 
> > So to be able to control SyncE we need 2 interfaces:
> > - Interface to enable the recovered clock output at the given pin
> > - interface to monitor the DPLL to see if the clock that we got is valid, or
> not.
> >
> > If it comes to ESMC (G.8264) messages, SyncE itself can run in 2 modes
> (slides 29/30 will give you more details):
> > - QL-Disabled - with no ESMC messages - it base on the local information
> from the PLL to make all decisions
> > - QL-Enabled - that adds ESMC and quality message transfer between the
> nodes.
> 
> How do you get the QL codes from this?
> 
> +enum if_eec_state {
> +       IF_EEC_STATE_INVALID = 0,
> +       IF_EEC_STATE_FREERUN,
> +       IF_EEC_STATE_LOCKACQ,
> +       IF_EEC_STATE_LOCKREC,
> +       IF_EEC_STATE_LOCKED,
> +       IF_EEC_STATE_HOLDOVER,
> +       IF_EEC_STATE_OPEN_LOOP,
> +       __IF_EEC_STATE_MAX,
> +};

This structure is for monitoring the lock state - or in other words - quality 
of incoming sync signal. 

The Locked state here means that the frequency used for transmitting the 
data is syntonized with the input one. If something goes wrong, like the 
frequency you recover from the link goes beyond the specified range or 
the external signal is lost, the QL level will change accordingly.

The application layer running on top of this API needs to get the proper
QL level from the config file (just like the clockClass in PTP) and broadcast
it when the state is locked and switch to QL-DNU when you get out of 
the lock state and expire preset hw-dependent holdover clock.

Also, if you are syntonizing to the SyncE clock you need to wait with
passing along QL-levels until the state reported by the EEC changes
to LOCKED.

Regards
Maciek

