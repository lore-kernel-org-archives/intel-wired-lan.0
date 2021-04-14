From: Chen, BoX C <box.c.chen@intel.com>
Date: Wed, 14 Apr 2021 01:49:06 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 2/6] ice: Support RSS
 configure removal for AVF
In-Reply-To: <20210413004844.32462-3-haiyue.wang@intel.com>
References: <20210413004844.32462-1-haiyue.wang@intel.com>
 <20210413004844.32462-3-haiyue.wang@intel.com>
Message-ID: <DM6PR11MB3099F2EA4EDB87D15CF22B42D94E9@DM6PR11MB3099.namprd11.prod.outlook.com>
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
> Cc: Guo, Jia <jia.guo@intel.com>; Sridhar, Vignesh
> <vignesh.sridhar@intel.com>; Zhang, Qi Z <qi.z.zhang@intel.com>
> Subject: [Intel-wired-lan] [PATCH net-next v3 2/6] ice: Support RSS configure
> removal for AVF
> 
> From: Qi Zhang <qi.z.zhang@intel.com>
> 
> Add the handler for virtchnl message VIRTCHNL_OP_DEL_RSS_CFG to
> remove an existing RSS configuration with matching hashed fields.
> 
> Signed-off-by: Vignesh Sridhar <vignesh.sridhar@intel.com>
> Co-developed-by: Jia Guo <jia.guo@intel.com>
> Signed-off-by: Jia Guo <jia.guo@intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_flow.c     | 88 +++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_flow.h     |  3 +
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 16 +++-
>  3 files changed, 105 insertions(+), 2 deletions(-)
> 

Tested-by: Bo Chen <BoX.C.Chen@intel.com>

Regards,
Chen Bo
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
