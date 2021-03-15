From: Wang, Haiyue <haiyue.wang@intel.com>
Date: Mon, 15 Mar 2021 08:20:47 +0000
Subject: [Intel-wired-lan] [Patch v5 11/18] ice: Add GTPU FDIR filter
 for AVF
In-Reply-To: <20210309030815.5299-12-haiyue.wang@intel.com>
References: <20210309030815.5299-1-haiyue.wang@intel.com>
 <20210309030815.5299-12-haiyue.wang@intel.com>
Message-ID: <BN8PR11MB37952BED7D4C25BBC4D09A42F76C9@BN8PR11MB3795.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Haiyue Wang
> Sent: Tuesday, March 9, 2021 11:08
> To: intel-wired-lan at lists.osuosl.org
> Cc: Liang, Cunming <cunming.liang@intel.com>; Cao, Yahui <yahui.cao@intel.com>; Zhang, Qi Z
> <qi.z.zhang@intel.com>
> Subject: [Intel-wired-lan] [Patch v5 11/18] ice: Add GTPU FDIR filter for AVF
> 
> From: Qi Zhang <qi.z.zhang@intel.com>
> 
> Add new FDIR filter type to forward GTPU packets by matching TEID or QFI.
> The filter is only enabled when COMMS DDP package is downloaded.
> 
> Signed-off-by: Yahui Cao <yahui.cao@intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_fdir.c     | 117 ++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_fdir.h     |  25 +++-
>  drivers/net/ethernet/intel/ice/ice_type.h     |   4 +
>  .../ethernet/intel/ice/ice_virtchnl_fdir.c    |  74 +++++++++++
>  4 files changed, 219 insertions(+), 1 deletion(-)
> 

Re-send to Bo, as a new member.

> --
> 2.30.1
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
