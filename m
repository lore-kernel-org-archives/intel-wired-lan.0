From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Tue, 21 Aug 2018 21:14:55 +0000
Subject: [Intel-wired-lan] [PATCH v4 07/13] ice: Use order_base_2 to
 calculate higher power of 2
In-Reply-To: <20180809132903.22819-8-anirudh.venkataramanan@intel.com>
References: <20180809132903.22819-1-anirudh.venkataramanan@intel.com>
 <20180809132903.22819-8-anirudh.venkataramanan@intel.com>
Message-ID: <C25D919FD1849B409D8D987DDC7FCD261954596D@ORSMSX109.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Thursday, August 9, 2018 6:29 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v4 07/13] ice: Use order_base_2 to
> calculate higher power of 2
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Currently, we use a combination of ilog2 and is_power_of_2() to calculate
> the next power of 2 for the qcount. This appears to be causing a warning on
> some combinations of GCC and the Linux kernel:
> 
> MODPOST 1 modules
> WARNING: "____ilog2_NaN" [ice.ko] undefined!
> 
> This appears to because because GCC realizes that qcount could be zero in
> some circumstances and thus attempts to link against the intentionally
> undefined ___ilog2_NaN function.
> 
> The order_base_2 function is intentionally defined to return 0 when passed 0
> as an argument, and thus will be safe to use here.
> 
> This not only fixes the warning but makes the resulting code slightly cleaner,
> and is really what we should have used originally.
> 
> Also update the comment to make it more clear that we are rounding up, not
> just incrementing the ilog2 of qcount unconditionally.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> minor
> cleanup for upstream submission]
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>


