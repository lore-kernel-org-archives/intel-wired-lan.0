From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 16 Nov 2017 22:20:17 +0000
Subject: [Intel-wired-lan] [next PATCH S82-V4 3/9] i40evf: Drop
 i40evf_fire_sw_int as it is prone to races
In-Reply-To: <20171114120052.86665-3-alice.michael@intel.com>
References: <20171114120052.86665-1-alice.michael@intel.com>
 <20171114120052.86665-3-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAEEB4@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, November 14, 2017 4:01 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S82-V4 3/9] i40evf: Drop
> i40evf_fire_sw_int as it is prone to races
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> Having the interrupts firing while we are polling causes extra overhead and
> isn't needed for most systems out there. If an interrupt is lost us
> experiencing a 2s latency spike before recovering is still not acceptable and
> masks the issue. We are better off just identifying systems that lose
> interrupts and instead enable workarounds for those systems.
> 
> To that end I am dropping the code that was strobing the interrupts as there
> is a narrow window where having them enabled can actually cause race
> issues anyway where a few stray packets might get misses if the interrupt is
> re-enabled and fires before we call napi_complete.
> 
> Also replace one line where we were using bit 31 instead of the define for
> the bit to represent masking the interrupt enable bit.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 34 -------------------------
>  1 file changed, 34 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


