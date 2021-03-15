From: Wang, Haiyue <haiyue.wang@intel.com>
Date: Mon, 15 Mar 2021 08:15:55 +0000
Subject: [Intel-wired-lan] [Patch v5 02/18] ice: Support non word
 aligned input set field
In-Reply-To: <20210309030815.5299-3-haiyue.wang@intel.com>
References: <20210309030815.5299-1-haiyue.wang@intel.com>
 <20210309030815.5299-3-haiyue.wang@intel.com>
Message-ID: <BN8PR11MB379515C5645DF10AF04363BCF76C9@BN8PR11MB3795.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Haiyue Wang
> Sent: Tuesday, March 9, 2021 11:08
> To: intel-wired-lan at lists.osuosl.org
> Cc: Nowlin, Dan <dan.nowlin@intel.com>; Liang, Cunming <cunming.liang@intel.com>; Zhang, Qi Z
> <qi.z.zhang@intel.com>
> Subject: [Intel-wired-lan] [Patch v5 02/18] ice: Support non word aligned input set field
> 
> From: Qi Zhang <qi.z.zhang@intel.com>
> 
> To support FDIR / RSS input set with protocol field like DSCP,
> TTL, PROT, etc. which is not word aligned, we need to enable field
> vector masking.
> 
> Signed-off-by: Dan Nowlin <dan.nowlin@intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_fdir.c     |  62 ++-
>  drivers/net/ethernet/intel/ice/ice_fdir.h     |   8 +
>  .../net/ethernet/intel/ice/ice_flex_pipe.c    | 422 +++++++++++++++++-
>  .../net/ethernet/intel/ice/ice_flex_pipe.h    |   2 +-
>  .../net/ethernet/intel/ice/ice_flex_type.h    |  17 +
>  drivers/net/ethernet/intel/ice/ice_flow.c     | 126 +++++-
>  drivers/net/ethernet/intel/ice/ice_flow.h     |   7 +
>  .../net/ethernet/intel/ice/ice_hw_autogen.h   |  16 +
>  8 files changed, 624 insertions(+), 36 deletions(-)
> 

Re-send to Bo, as a new member.

> 2.30.1
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan

