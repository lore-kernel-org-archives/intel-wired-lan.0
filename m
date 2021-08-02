From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Mon, 2 Aug 2021 23:45:09 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2] ethernet/intel: fix
 PTP_1588_CLOCK dependencies
In-Reply-To: <20210802230921.GA13623@hoboy.vegasvil.org>
References: <20210802145937.1155571-1-arnd@kernel.org>
 <20210802164907.GA9832@hoboy.vegasvil.org>
 <bd631e36-1701-b120-a9b0-8825d14cc694@intel.com>
 <20210802230921.GA13623@hoboy.vegasvil.org>
Message-ID: <CO1PR11MB508917A17F68DD927CD26A82D6EF9@CO1PR11MB5089.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Richard Cochran <richardcochran@gmail.com>
> Sent: Monday, August 02, 2021 4:09 PM
> To: Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: Arnd Bergmann <arnd@kernel.org>; Nicolas Pitre <nicolas.pitre@linaro.org>;
> Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; David S. Miller <davem@davemloft.net>; Jakub
> Kicinski <kuba@kernel.org>; Arnd Bergmann <arnd@arndb.de>; Kurt
> Kanzenbach <kurt@linutronix.de>; Saleem, Shiraz <shiraz.saleem@intel.com>;
> Ertman, David M <david.m.ertman@intel.com>; intel-wired-lan at lists.osuosl.org;
> netdev at vger.kernel.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH net-next v2] ethernet/intel: fix PTP_1588_CLOCK
> dependencies
> 
> On Mon, Aug 02, 2021 at 07:54:20PM +0000, Keller, Jacob E wrote:
> > So go back to "select"?
> 
> Why not keep it simple?
> 
> PTP core:
>    Boolean PTP_1588_CLOCK
> 
> drivers:
>    depends on PTP_1588_CLOCK
> 
> Also, make Posix timers always part of the core.  Tinification is a
> lost cause.
> 
> Thanks,
> Richard

Ok, so basically: if any driver that needs PTP core is on, PTP core is on, with no way to disable it.

Thanks,
Jake

