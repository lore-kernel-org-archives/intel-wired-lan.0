From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 18 Oct 2018 21:43:02 +0000
Subject: [Intel-wired-lan] [PATCH 1/7] ice: Make ice_msix_clean_rings
 static
In-Reply-To: <20181018153709.32664-2-anirudh.venkataramanan@intel.com>
References: <20181018153709.32664-1-anirudh.venkataramanan@intel.com>
 <20181018153709.32664-2-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D30F702@FMSMSX152.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Thursday, October 18, 2018 8:37 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 1/7] ice: Make ice_msix_clean_rings static
> 
> commit 158a08a694c4e ("ice: remove ndo_poll_controller") removed
> ice_netpoll and introduced a namespace warning for ice_msix_clean_rings.
> Fix the namespace warning by making ice_msix_clean_rings static.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 2 +-
> drivers/net/ethernet/intel/ice/ice_lib.h | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


