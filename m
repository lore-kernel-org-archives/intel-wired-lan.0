From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 8 Mar 2019 00:26:33 +0000
Subject: [Intel-wired-lan] [PATCH S17 02/17] ice: Create framework for
 VSI queue context
In-Reply-To: <20190228232603.32156-3-anirudh.venkataramanan@intel.com>
References: <20190228232603.32156-1-anirudh.venkataramanan@intel.com>
 <20190228232603.32156-3-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D368E49@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Thursday, February 28, 2019 3:26 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S17 02/17] ice: Create framework for VSI
> queue context
> 
> This patch introduces a framework to store queue specific information in VSI
> queue contexts. Currently VSI queue context (represented by struct
> ice_q_ctx) only has q_handle as a member. In future patches, this structure
> will be updated to hold queue specific information.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c      | 62 +++++++++++++--
>  drivers/net/ethernet/intel/ice/ice_common.h      | 11 +--
>  drivers/net/ethernet/intel/ice/ice_lib.c         | 99 ++++++++++++++----------
>  drivers/net/ethernet/intel/ice/ice_sched.c       | 54 +++++++++++--
>  drivers/net/ethernet/intel/ice/ice_switch.c      | 22 ++++++
>  drivers/net/ethernet/intel/ice/ice_switch.h      |  9 +++
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c |  4 +-
>  7 files changed, 205 insertions(+), 56 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


