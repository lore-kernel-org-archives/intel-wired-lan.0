From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Thu, 11 Mar 2021 22:53:21 +0000
Subject: [Intel-wired-lan] [PATCH S55 11/14] ice: correct memory
 allocation call
In-Reply-To: <20210302181213.51718-11-anthony.l.nguyen@intel.com>
References: <20210302181213.51718-1-anthony.l.nguyen@intel.com>
 <20210302181213.51718-11-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB510529BCFD50B3A0C6AB3999FA909@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Tuesday, March 2, 2021 10:12 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S55 11/14] ice: correct memory allocation
> call
> 
> From: Bruce Allan <bruce.w.allan@intel.com>
> 
> Use *malloc() instead of *calloc() when allocating only a single object as
> opposed to an array of objects.
> 
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_switch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


