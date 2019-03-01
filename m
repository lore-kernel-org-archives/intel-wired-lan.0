From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 1 Mar 2019 23:50:46 +0000
Subject: [Intel-wired-lan] [PATCH S15 07/14] ice: Remove unused function
 prototype
In-Reply-To: <20190219230414.25627-8-anirudh.venkataramanan@intel.com>
References: <20190219230414.25627-1-anirudh.venkataramanan@intel.com>
 <20190219230414.25627-8-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3675E1@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Tuesday, February 19, 2019 3:04 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S15 07/14] ice: Remove unused function
> prototype
> 
> Commit 37bb83901286 ("ice: Move common functions out of ice_main.c part
> 7/7") seems to have inadvertently introduced a function prototype for
> ice_vsi_cfg_tc without a corresponding function implementation. Remove it.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.h | 2 --
>  1 file changed, 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


