From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 30 Oct 2018 22:02:26 +0000
Subject: [Intel-wired-lan] [PATCH S8 14/16] ice: Calculate guaranteed
 VSIs per function and use it
In-Reply-To: <20181026174105.11628-15-anirudh.venkataramanan@intel.com>
References: <20181026174105.11628-1-anirudh.venkataramanan@intel.com>
 <20181026174105.11628-15-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D328D5B@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S8 14/16] ice: Calculate guaranteed VSIs
> per function and use it
> 
> Currently we are setting the guar_num_vsi to equal to ICE_MAX_VSI which is
> the device limit of 768. This is incorrect and could have unintended
> consequences. To fix this use the valid_function's 8-bit bitmap returned from
> discovering device capabilities to determine the guar_num_vsi per function.
> guar_num_vsi value is then passed on to
> pf->num_alloc_vsi.
> 
> Also shorten instances of "guaranteed" to "guar"
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h            |  1 -
>  drivers/net/ethernet/intel/ice/ice_adminq_cmd.h |  1 +
>  drivers/net/ethernet/intel/ice/ice_common.c     | 31
> +++++++++++++++++++++++--
>  drivers/net/ethernet/intel/ice/ice_main.c       |  3 +--
>  drivers/net/ethernet/intel/ice/ice_type.h       |  4 +++-
>  5 files changed, 34 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


