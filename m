From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Fri, 25 Jun 2021 22:38:42 +0000
Subject: [Intel-wired-lan] [PATCH net v1] igb: Fix position of
 assignment to *ring
In-Reply-To: <20210611224217.94872-1-jedrzej.jagielski@intel.com>
References: <20210611224217.94872-1-jedrzej.jagielski@intel.com>
Message-ID: <SJ0PR11MB5662B37094977888FBC3202DFA069@SJ0PR11MB5662.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jedrzej Jagielski
> Sent: Friday, June 11, 2021 3:42 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Jagielski, Jedrzej <jedrzej.jagielski@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v1] igb: Fix position of assignment to
> *ring
> 
> Assignment to *ring should be done after correctness check of the argument
> queue.
> 
> Fixes: 91db364236c8 ("igb: Refactor igb_configure_cbs()")
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> (A Contingent Worker at Intel)


