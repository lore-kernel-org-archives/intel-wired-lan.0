From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Wed, 4 Aug 2021 20:53:05 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2] ethernet/intel: fix
 PTP_1588_CLOCK dependencies
In-Reply-To: <20210803205455.GA3517@hoboy.vegasvil.org>
References: <20210802145937.1155571-1-arnd@kernel.org>
 <20210802164907.GA9832@hoboy.vegasvil.org>
 <bd631e36-1701-b120-a9b0-8825d14cc694@intel.com>
 <20210802230921.GA13623@hoboy.vegasvil.org>
 <CAK8P3a2XjgbEkYs6R7Q3RCZMV7v90gu_v82RVfFVs-VtUzw+_w@mail.gmail.com>
 <20210803155556.GD32663@hoboy.vegasvil.org>
 <20210803161434.GE32663@hoboy.vegasvil.org>
 <CAK8P3a2Wt9gnO4Ts_4Jw1+qpBj8HQc50jU2szjmR8MmZL9wrgQ@mail.gmail.com>
 <20210803205455.GA3517@hoboy.vegasvil.org>
Message-ID: <CO1PR11MB5089005017FE714B8A37F9B0D6F19@CO1PR11MB5089.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Richard Cochran <richardcochran@gmail.com>
> Sent: Tuesday, August 03, 2021 1:55 PM
> To: Arnd Bergmann <arnd@kernel.org>
> Cc: Nicolas Pitre <nico@fluxnic.net>; Keller, Jacob E <jacob.e.keller@intel.com>;
> Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; David S. Miller <davem@davemloft.net>; Jakub
> Kicinski <kuba@kernel.org>; Arnd Bergmann <arnd@arndb.de>; Kurt
> Kanzenbach <kurt@linutronix.de>; Saleem, Shiraz <shiraz.saleem@intel.com>;
> Ertman, David M <david.m.ertman@intel.com>; intel-wired-lan at lists.osuosl.org;
> netdev at vger.kernel.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH net-next v2] ethernet/intel: fix PTP_1588_CLOCK
> dependencies
> 
> 
> On Tue, Aug 03, 2021 at 07:00:49PM +0200, Arnd Bergmann wrote:
> 
> > If you turn all those 'select' lines into 'depends on', this will work, but it's
> > not actually much different from what I'm suggesting.
> 
> "depends" instead of "select" works for me.  I just want it simple and clear.
> 
> > Maybe we can do it
> > in two steps: first fix the build failure by replacing all the 'imply'
> > statements
> > with the correct dependencies, and then you send a patch on top that
> > turns PPS and PTP_1588_CLOCK into bool options.
> 
> Sounds good.
> 
> Thanks,
> Richard

Works for me too.

Thanks,
Jake
