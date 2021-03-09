From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Tue, 9 Mar 2021 23:49:32 +0000
Subject: [Intel-wired-lan] [PATCH net 10/13] ice: Fix for dereference of
 NULL pointer
In-Reply-To: <20210226211932.46683-10-anthony.l.nguyen@intel.com>
References: <20210226211932.46683-1-anthony.l.nguyen@intel.com>
 <20210226211932.46683-10-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB51059383037E6B0CB0DA18D9FA929@CO1PR11MB5105.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH net 10/13] ice: Fix for dereference of NULL
> pointer
> 
> From: Jacek Bu?atek <jacekx.bulatek@intel.com>
> 
> Add handling of allocation fault for ice_vsi_list_map_info.
> 
> Also *fi should not be NULL pointer, it is a reference to raw data field, so
> remove this variable and use the reference directly.
> 
> Fixes: 9daf8208dd4d ("ice: Add support for switch filter programming")
> Signed-off-by: Jacek Bu?atek <jacekx.bulatek@intel.com>
> Co-developed-by: Haiyue Wang <haiyue.wang@intel.com>
> Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_switch.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


