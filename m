From: Lu, Nannan <nannan.lu@intel.com>
Date: Fri, 10 Jul 2020 03:17:41 +0000
Subject: [Intel-wired-lan] [net-next,
 v8 3/5] ice: support to get the VSI mapping
In-Reply-To: <20200710015421.92122-4-haiyue.wang@intel.com>
References: <20200619045711.16055-1-haiyue.wang@intel.com>
 <20200710015421.92122-1-haiyue.wang@intel.com>
 <20200710015421.92122-4-haiyue.wang@intel.com>
Message-ID: <DM6PR11MB39003E65C8ACDFDA3222B8CEF8650@DM6PR11MB3900.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Haiyue Wang
> Sent: Friday, July 10, 2020 9:54 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Xing, Beilei <beilei.xing@intel.com>
> Subject: [Intel-wired-lan] [net-next, v8 3/5] ice: support to get the VSI mapping
> 
> The DCF needs the mapping information of the VF ID to logical hardware VSI ID,
> so that it can create the switch flow rules for other VFs.
> 
> Signed-off-by: Beilei Xing <beilei.xing@intel.com>
> Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 61 +++++++++++++++++++
>  include/linux/avf/virtchnl.h                  | 21 +++++++
>  2 files changed, 82 insertions(+)
> 

Tested-by: Nannan Lu <nannan.lu@intel.com>

> --
> 2.27.0
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
