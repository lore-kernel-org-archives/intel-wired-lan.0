From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Tue, 9 Mar 2021 23:51:37 +0000
Subject: [Intel-wired-lan] [PATCH net 13/13] ice: Cleanup fltr list in
 case of allocation issues
In-Reply-To: <20210226211932.46683-13-anthony.l.nguyen@intel.com>
References: <20210226211932.46683-1-anthony.l.nguyen@intel.com>
 <20210226211932.46683-13-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB510590BE2348A74B29D2BD2AFA929@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Friday, February 26, 2021 1:20 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net 13/13] ice: Cleanup fltr list in case of
> allocation issues
> 
> From: Robert Malz <robertx.malz@intel.com>
> 
> When ice_remove_vsi_lkup_fltr is called, by calling ice_add_to_vsi_fltr_list
> local copy of vsi filter list is created. If any issues during creation of vsi filter
> list occurs it up for the caller to free already allocated memory. This patch
> ensures proper memory deallocation in these cases.
> 
> Fixes: 80d144c9ac82 ("ice: Refactor switch rule management structures and
> functions")
> Signed-off-by: Robert Malz <robertx.malz@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_switch.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


