From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 30 Oct 2018 22:22:32 +0000
Subject: [Intel-wired-lan] [PATCH S9 08/15] ice: Pass the return value
 of ice_init_def_sw_recp().
In-Reply-To: <20181026184447.13547-9-anirudh.venkataramanan@intel.com>
References: <20181026184447.13547-1-anirudh.venkataramanan@intel.com>
 <20181026184447.13547-9-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D328E09@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Friday, October 26, 2018 11:45 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S9 08/15] ice: Pass the return value of
> ice_init_def_sw_recp().
> 
> From: Jaroslaw Ilgiewicz <jaroslaw.ilgiewicz@intel.com>
> 
> Added check of return value for ice_init_def_sw_recp().
> Now we know if memory was correctly allocated.
> 
> Signed-off-by: Jaroslaw Ilgiewicz <jaroslaw.ilgiewicz@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


