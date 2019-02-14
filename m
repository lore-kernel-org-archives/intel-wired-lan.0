From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 14 Feb 2019 22:52:24 +0000
Subject: [Intel-wired-lan] [PATCH S11 05/16] ice: fix stack hogs from
 struct ice_vsi_ctx structures
In-Reply-To: <20190208205043.11975-6-anirudh.venkataramanan@intel.com>
References: <20190208205043.11975-1-anirudh.venkataramanan@intel.com>
 <20190208205043.11975-6-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D366202@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Friday, February 8, 2019 12:51 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S11 05/16] ice: fix stack hogs from struct
> ice_vsi_ctx structures
> 
> From: Bruce Allan <bruce.w.allan@intel.com>
> 
> struct ice_vsi_ctx has gotten large enough that function local declarations of
> it on the stack are causing stack hogs.  Fix that by allocating the structs on
> heap.  Cleanup some formatting issues in the code around these changes
> and fix incorrect data type uses of returned functions in a couple places.
> 
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c         | 98 +++++++++++++++---------
>  drivers/net/ethernet/intel/ice/ice_main.c        | 27 ++++---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 59 ++++++++------
>  3 files changed, 117 insertions(+), 67 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


