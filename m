From: Lu, Nannan <nannan.lu@intel.com>
Date: Wed, 24 Jun 2020 07:30:17 +0000
Subject: [Intel-wired-lan] [PATCH v3 4/5] ice: enable DDP package info
 querying
In-Reply-To: <20200624020801.104003-5-haiyue.wang@intel.com>
References: <20200619045711.16055-1-haiyue.wang@intel.com>
 <20200624020801.104003-1-haiyue.wang@intel.com>
 <20200624020801.104003-5-haiyue.wang@intel.com>
Message-ID: <DM6PR11MB3900E05ADBFB870DC6277859F8950@DM6PR11MB3900.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Haiyue Wang
> Sent: Wednesday, June 24, 2020 10:08 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Xu, Ting <ting.xu@intel.com>; Rong, Leyi <leyi.rong@intel.com>
> Subject: [Intel-wired-lan] [PATCH v3 4/5] ice: enable DDP package info querying
> 
> Since the firmware doesn't support reading the DDP package data that PF is
> using. The DCF has to find the PF's DDP package file directly.
> 
> For searching the right DDP package that the PF uses, the DCF needs the DDP
> package characteristic information such as the PF's device serial number which is
> used to find the package loading path, and the exact DDP track ID, package
> name, version.
> 
> Only with the matched DDP package, the DCF can get the right metadata to
> create switch rules etc.
> 
> Signed-off-by: Leyi Rong <leyi.rong@intel.com>
> Signed-off-by: Ting Xu <ting.xu@intel.com>
> Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dcf.h      |  6 +++
>  drivers/net/ethernet/intel/ice/ice_main.c     |  2 +
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 52 +++++++++++++++++++
>  include/linux/avf/virtchnl.h                  | 23 ++++++++
>  4 files changed, 83 insertions(+)
> 

Tested-by: Nannan Lu <nannan.lu@intel.com>

> --
> 2.27.0
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
