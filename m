From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 10 Jul 2020 19:22:52 +0000
Subject: [Intel-wired-lan] [net-next,
 v8 3/5] ice: support to get the VSI mapping
In-Reply-To: <20200710015421.92122-4-haiyue.wang@intel.com>
References: <20200619045711.16055-1-haiyue.wang@intel.com>
 <20200710015421.92122-1-haiyue.wang@intel.com>
 <20200710015421.92122-4-haiyue.wang@intel.com>
Message-ID: <BN6PR1101MB2145C868D39B7A4171F93B3B8C650@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Haiyue Wang
> Sent: Thursday, July 9, 2020 6:54 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Xing, Beilei <beilei.xing@intel.com>
> Subject: [Intel-wired-lan] [net-next, v8 3/5] ice: support to get the VSI
> mapping
> 
> The DCF needs the mapping information of the VF ID to logical hardware VSI
> ID, so that it can create the switch flow rules for other VFs.
> 
> Signed-off-by: Beilei Xing <beilei.xing@intel.com>
> Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 61 +++++++++++++++++++
>  include/linux/avf/virtchnl.h                  | 21 +++++++
>  2 files changed, 82 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


