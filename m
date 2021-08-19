From: Machnikowski, Maciej <maciej.machnikowski@intel.com>
Date: Thu, 19 Aug 2021 15:40:22 +0000
Subject: [Intel-wired-lan] [RFC net-next 1/7] ptp: Add interface for
 acquiring DPLL state
In-Reply-To: <20210819153414.GC26242@hoboy.vegasvil.org>
References: <20210816160717.31285-1-arkadiusz.kubalewski@intel.com>
 <20210816160717.31285-2-arkadiusz.kubalewski@intel.com>
 <20210816235400.GA24680@hoboy.vegasvil.org>
 <PH0PR11MB4951762ECB04D90D634E905DEAFE9@PH0PR11MB4951.namprd11.prod.outlook.com>
 <20210818170259.GD9992@hoboy.vegasvil.org>
 <PH0PR11MB495162EC9116F197D79589F5EAFF9@PH0PR11MB4951.namprd11.prod.outlook.com>
 <20210819153414.GC26242@hoboy.vegasvil.org>
Message-ID: <PH0PR11MB4951F51CBA231DFD65806CDAEAC09@PH0PR11MB4951.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Richard Cochran <richardcochran@gmail.com>
> Sent: Thursday, August 19, 2021 5:34 PM
> To: Machnikowski, Maciej <maciej.machnikowski@intel.com>
> Cc: Kubalewski, Arkadiusz <arkadiusz.kubalewski@intel.com>; linux-
> kernel at vger.kernel.org; intel-wired-lan at lists.osuosl.org;
> netdev at vger.kernel.org; linux-kselftest at vger.kernel.org; Brandeburg,
> Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; davem at davemloft.net; kuba at kernel.org;
> shuah at kernel.org; arnd at arndb.de; nikolay at nvidia.com;
> cong.wang at bytedance.com; colin.king at canonical.com;
> gustavoars at kernel.org; Bross, Kevin <kevin.bross@intel.com>; Stanton,
> Kevin B <kevin.b.stanton@intel.com>; Ahmad Byagowi <abyagowi@fb.com>
> Subject: Re: [RFC net-next 1/7] ptp: Add interface for acquiring DPLL state
> 
> On Wed, Aug 18, 2021 at 10:36:03PM +0000, Machnikowski, Maciej wrote:
> 
> > OK, Let's take a step back and forget about SyncE.
> 
> Ahem, the title of this series is:
> 
>     [RFC net-next 0/7] Add basic SyncE interfaces
> 
> I'd be happy to see support for configuring SyncE.
> 
> But I guess this series is about something totally different.
> 
> 
> Thanks,
> Richard

If it helps we'd be happy to separate that in 2 separate RFCs.
This was squashed together under SyncE support umbrella to show one of the use cases, but PTP changes are more generic and cover all PTP clocks that use DPLL for the physical clock generation.

Regards
Maciek
