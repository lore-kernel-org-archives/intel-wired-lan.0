From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 5 Mar 2019 20:28:16 +0000
Subject: [Intel-wired-lan] [PATCH S16 03/11] ice: Add code for DCB
 initialization part 3/4
In-Reply-To: <20190228232432.31659-4-anirudh.venkataramanan@intel.com>
References: <20190228232432.31659-1-anirudh.venkataramanan@intel.com>
 <20190228232432.31659-4-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D368B10@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Thursday, February 28, 2019 3:24 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S16 03/11] ice: Add code for DCB
> initialization part 3/4
> 
> This patch adds a new function ice_pf_dcb_cfg (and related helpers) which
> applies the DCB configuration obtained from the firmware. As part of this,
> VSIs/netdevs are updated with traffic class information.
> 
> This patch requires a bit of a refactor of existing code.
> 
> 1. For a MIB change event, the associated VSI is closed and brought up
>    again. The gap between closing and opening the VSI can cause a race
>    condition. Fix this by grabbing the rtnl_lock prior to closing the
>    VSI and then only free it after re-opening the VSI during a MIB
>    change event.
> 
> 2. ice_sched_query_elem is used in ice_sched.c and with this patch, in
>    ice_dcb.c as well. However, ice_dcb.c is not built when CONFIG_DCB is
>    unset. This results in namespace warnings (ice_sched.o: Externally
>    defined symbols with no external references) when CONFIG_DCB is unset.
>    To avoid this move ice_sched_query_elem from ice_sched.c to
>    ice_common.c.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h            |  13 +-
>  drivers/net/ethernet/intel/ice/ice_adminq_cmd.h |  47 +++
>  drivers/net/ethernet/intel/ice/ice_common.c     |  25 ++
>  drivers/net/ethernet/intel/ice/ice_common.h     |   3 +
>  drivers/net/ethernet/intel/ice/ice_dcb.c        | 463
> ++++++++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_dcb.h        |  17 +
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c    | 204 ++++++++++-
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.h    |  13 +
>  drivers/net/ethernet/intel/ice/ice_lib.c        | 135 +++++++
>  drivers/net/ethernet/intel/ice/ice_lib.h        |   8 +
>  drivers/net/ethernet/intel/ice/ice_main.c       | 118 +++---
>  drivers/net/ethernet/intel/ice/ice_sched.c      |  27 +-
>  drivers/net/ethernet/intel/ice/ice_sched.h      |   4 +
>  drivers/net/ethernet/intel/ice/ice_type.h       |   2 +
>  14 files changed, 997 insertions(+), 82 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


