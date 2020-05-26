From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 26 May 2020 20:26:19 +0000
Subject: [Intel-wired-lan] [PATCH S44 12/14] ice: fix potential double
 free in probe unrolling
In-Reply-To: <20200516004226.4795-12-anthony.l.nguyen@intel.com>
References: <20200516004226.4795-1-anthony.l.nguyen@intel.com>
 <20200516004226.4795-12-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB1659A44E7A7EC041719B444D8CB00@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Friday, May 15, 2020 5:42 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S44 12/14] ice: fix potential double free in
> probe unrolling
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> If ice_init_interrupt_scheme fails, ice_probe will jump to clearing up the
> interrupts. This can lead to some static analysis tools such as the compiler
> sanitizers complaining about double free problems.
> 
> Since ice_init_interrupt_scheme already unrolls internally on failure, there is
> no need to call ice_clear_interrupt_scheme when it fails. Add a new unroll
> label and use that instead.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


