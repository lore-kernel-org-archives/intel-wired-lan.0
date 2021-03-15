From: Wang, Haiyue <haiyue.wang@intel.com>
Date: Mon, 15 Mar 2021 08:20:19 +0000
Subject: [Intel-wired-lan] [Patch v5 10/18] ice: Add non-IP Layer2
 protocol FDIR filter for AVF
In-Reply-To: <20210309030815.5299-11-haiyue.wang@intel.com>
References: <20210309030815.5299-1-haiyue.wang@intel.com>
 <20210309030815.5299-11-haiyue.wang@intel.com>
Message-ID: <BN8PR11MB37957CA9B65D2897CB874027F76C9@BN8PR11MB3795.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [Patch v5 10/18] ice: Add non-IP Layer2 protocol FDIR filter for AVF
> 
> From: Qi Zhang <qi.z.zhang@intel.com>
> 
> Add new filter type that allow forward non-IP Ethernet packets base on its
> ethertype. The filter is only enabled when COMMS DDP package is loaded.
> 
> Signed-off-by: Yahui Cao <yahui.cao@intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_fdir.c     | 15 +++++++
>  drivers/net/ethernet/intel/ice/ice_fdir.h     |  2 +
>  drivers/net/ethernet/intel/ice/ice_flow.c     | 17 +++++++-
>  drivers/net/ethernet/intel/ice/ice_flow.h     |  1 +
>  drivers/net/ethernet/intel/ice/ice_type.h     |  1 +
>  .../ethernet/intel/ice/ice_virtchnl_fdir.c    | 41 +++++++++++++++++--
>  6 files changed, 73 insertions(+), 4 deletions(-)
> 

Re-send to Bo, as a new member.

> --
> 2.30.1
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
