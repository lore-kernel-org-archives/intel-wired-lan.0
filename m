From: Chen, BoX C <box.c.chen@intel.com>
Date: Wed, 14 Apr 2021 01:47:12 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 1/6] ice: Enable RSS
 configure for AVF
In-Reply-To: <20210413004844.32462-2-haiyue.wang@intel.com>
References: <20210413004844.32462-1-haiyue.wang@intel.com>
 <20210413004844.32462-2-haiyue.wang@intel.com>
Message-ID: <DM6PR11MB3099A9DD01D4458C89088260D94E9@DM6PR11MB3099.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Haiyue Wang
> Sent: April 13, 2021 8:49
> To: intel-wired-lan at lists.osuosl.org
> Cc: Guo, Jia <jia.guo@intel.com>; Zhang, Qi Z <qi.z.zhang@intel.com>
> Subject: [Intel-wired-lan] [PATCH net-next v3 1/6] ice: Enable RSS configure
> for AVF
> 
> From: Qi Zhang <qi.z.zhang@intel.com>
> 
> Currently, RSS hash input is not available to AVF by ethtool, it is set by the PF
> directly.
> 
> Add the RSS configure support for AVF through new virtchnl message, and
> define the capability flag VIRTCHNL_VF_OFFLOAD_ADV_RSS_PF to query
> this new RSS offload support.
> 
> Signed-off-by: Jia Guo <jia.guo@intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_flow.h     |   3 +
>  .../intel/ice/ice_virtchnl_allowlist.c        |   6 +
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 453 ++++++++++++++++++
>  include/linux/avf/virtchnl.h                  |  25 +-
>  4 files changed, 486 insertions(+), 1 deletion(-)
> 

Tested-by: Bo Chen <BoX.C.Chen@intel.com>

Regards,
Chen Bo
______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
