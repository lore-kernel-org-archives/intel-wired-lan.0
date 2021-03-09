From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Tue, 9 Mar 2021 23:47:38 +0000
Subject: [Intel-wired-lan] [PATCH net 08/13] ice: fix memory allocation
 call
In-Reply-To: <20210226211932.46683-8-anthony.l.nguyen@intel.com>
References: <20210226211932.46683-1-anthony.l.nguyen@intel.com>
 <20210226211932.46683-8-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB5105F6D775DA2332379FB3E9FA929@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Friday, February 26, 2021 1:19 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net 08/13] ice: fix memory allocation call
> 
> From: Bruce Allan <bruce.w.allan@intel.com>
> 
> Fix the order of number of array members and member size parameters in a
> *calloc() call.
> 
> Fixes: b3c3890489f6 ("ice: avoid unnecessary single-member variable-length
> structs")
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


