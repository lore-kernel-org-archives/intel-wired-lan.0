From: Machnikowski, Maciej <maciej.machnikowski@intel.com>
Date: Mon, 23 Aug 2021 08:29:14 +0000
Subject: [Intel-wired-lan] [RFC net-next 1/7] ptp: Add interface for
 acquiring DPLL state
In-Reply-To: <20210822023057.GA6481@hoboy.vegasvil.org>
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
 <20210822023057.GA6481@hoboy.vegasvil.org>
Message-ID: <PH0PR11MB4951C8C972C5123E7FC5DAFEEAC49@PH0PR11MB4951.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Richard Cochran <richardcochran@gmail.com>
> Sent: Sunday, August 22, 2021 4:31 AM
> Subject: Re: [RFC net-next 1/7] ptp: Add interface for acquiring DPLL state
> 
> On Fri, Aug 20, 2021 at 06:30:02PM +0000, Machnikowski, Maciej wrote:
> 
> > Since the 40.5.2 is not applicable to higher-speed ethernet which
> > don't use auto-negotiation, but rather the link training sequence
> > where the RX side always syncs its clock to the TX side.
> 
> By "the RX side always syncs its clock to the TX side" do you mean the RX
> channel synchronizes to the link partner's TX channel?
> 
> Wow, that brings back the 100 megabit scheme I guess.  That's cool, because
> the same basic idea applies to the PHYTER then.
> 

Yes! Sounds very similar! :)

> Still we are doing to need a way for user space to query the HW topology to
> discover whether a given ports may be syntonized from a second port.  I
> don't think your pin selection thing works unless user space can tell what the
> pins are connected to.
> 
> Thanks,
> Richard

And a good catch! I'll update the RFC to add the query functionality and move the SyncE logic/pins to the netdev subsystem.

Thanks 
