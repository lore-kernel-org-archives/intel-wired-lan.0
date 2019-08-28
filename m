From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 28 Aug 2019 16:27:08 +0000
Subject: [Intel-wired-lan] [next PATCH S9 2/7] i40e: use
 ktime_get_real_ts64 instead of ktime_to_timespec64
In-Reply-To: <20190826181655.15106-2-alice.michael@intel.com>
References: <20190826181655.15106-1-alice.michael@intel.com>
 <20190826181655.15106-2-alice.michael@intel.com>
Message-ID: <6d134d1f6fea445da97745e6ea341357@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Monday, August 26, 2019 11:17 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S9 2/7] i40e: use ktime_get_real_ts64
> instead of ktime_to_timespec64
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Remove a call to ktime_to_timespec64 by calling ktime_get_real_ts64
> directly.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


