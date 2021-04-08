From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Thu, 8 Apr 2021 21:35:30 +0000
Subject: [Intel-wired-lan] [PATCH S58 06/13] ice: print name in
 /proc/iomem
In-Reply-To: <20210331211708.55205-6-anthony.l.nguyen@intel.com>
References: <20210331211708.55205-1-anthony.l.nguyen@intel.com>
 <20210331211708.55205-6-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB510590E43BF7518178FEEED6FA749@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Wednesday, March 31, 2021 2:17 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S58 06/13] ice: print name in /proc/iomem
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> The driver previously printed it's PCI address in the name field for the pci
> resource, which when displayed via /proc/iomem, would print the same
> thing twice.
> 
> It's more useful for debugging to see the driver name, as most other
> modules do.
> 
> Here's a diff of before and after this change:
>      99100000-991fffff : 0000:3b:00.1
>    9a000000-a04fffff : PCI Bus 0000:3b
>      9a000000-9bffffff : 0000:3b:00.1
> -      9a000000-9bffffff : 0000:3b:00.1
> +      9a000000-9bffffff : ice
>      9c000000-9dffffff : 0000:3b:00.0
> -      9c000000-9dffffff : 0000:3b:00.0
> +      9c000000-9dffffff : ice
>      9e000000-9effffff : 0000:3b:00.1
>      9f000000-9fffffff : 0000:3b:00.0
>      a0000000-a000ffff : 0000:3b:00.1
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


