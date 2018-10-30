From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 30 Oct 2018 21:58:09 +0000
Subject: [Intel-wired-lan] [PATCH S8 08/16] ice: Fix napi delete calls
 for remove
In-Reply-To: <20181026174105.11628-9-anirudh.venkataramanan@intel.com>
References: <20181026174105.11628-1-anirudh.venkataramanan@intel.com>
 <20181026174105.11628-9-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D328CF9@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Friday, October 26, 2018 10:41 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S8 08/16] ice: Fix napi delete calls for
> remove
> 
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> In the remove path, the vsi->netdev is being set to NULL before the call to
> free vectors. This is causing the netif_napi_del call to never be made.
> 
> Add a call to ice_napi_del to the same location as the calls to
> unregister_netdev and just prior to them. This will use the reverse flow as
> the register and netif_napi_add calls.
> 
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h      | 1 +
>  drivers/net/ethernet/intel/ice/ice_lib.c  | 1 +
> drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
>  3 files changed, 3 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


