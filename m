From: Wang, Haiyue <haiyue.wang@intel.com>
Date: Mon, 15 Mar 2021 08:18:11 +0000
Subject: [Intel-wired-lan] [Patch v5 06/18] ice: Add support for per VF
 ctrl VSI enabling
In-Reply-To: <20210309030815.5299-7-haiyue.wang@intel.com>
References: <20210309030815.5299-1-haiyue.wang@intel.com>
 <20210309030815.5299-7-haiyue.wang@intel.com>
Message-ID: <BN8PR11MB379511C9ACA9E6FDA41D0597F76C9@BN8PR11MB3795.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Haiyue Wang
> Sent: Tuesday, March 9, 2021 11:08
> To: intel-wired-lan at lists.osuosl.org
> Cc: Liang, Cunming <cunming.liang@intel.com>; Li, Xiaoyun <xiaoyun.li@intel.com>; Cao, Yahui
> <yahui.cao@intel.com>; Zhang, Qi Z <qi.z.zhang@intel.com>
> Subject: [Intel-wired-lan] [Patch v5 06/18] ice: Add support for per VF ctrl VSI enabling
> 
> From: Qi Zhang <qi.z.zhang@intel.com>
> 
> We are going to enable FDIR configure for AVF through virtual channel.
> The first step is to add helper functions to support control VSI setup.
> A control VSI will be allocated for a VF when AVF creates its
> first FDIR rule through ice_vf_ctrl_vsi_setup().
> The patch will also allocate FDIR rule space for VF's control VSI.
> If a VF asks for flow director rules, then those should come entirely
> from the best effort pool and not from the guaranteed pool. The patch
> allow a VF VSI to have only space in the best effort rules.
> 
> Signed-off-by: Xiaoyun Li <xiaoyun.li@intel.com>
> Signed-off-by: Yahui Cao <yahui.cao@intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |  4 +-
>  drivers/net/ethernet/intel/ice/ice_lib.c      | 64 ++++++++++++++++---
>  drivers/net/ethernet/intel/ice/ice_main.c     |  9 ++-
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 62 ++++++++++++++++++
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.h  |  2 +
>  5 files changed, 130 insertions(+), 11 deletions(-)
> 

Re-send to Bo, as a new member.

> --
> 2.30.1
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
