From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 24 Jul 2020 23:57:00 +0000
Subject: [Intel-wired-lan] [PATCH S48 v6 08/16] ice: Support RSS
 configure removal for AVF
In-Reply-To: <20200716133938.46921-9-qi.z.zhang@intel.com>
References: <20200716133938.46921-1-qi.z.zhang@intel.com>
 <20200716133938.46921-9-qi.z.zhang@intel.com>
Message-ID: <BN6PR1101MB2145C1E9B02C90FAC084C83D8C770@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Qi
> Zhang
> Sent: Thursday, July 16, 2020 6:40 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Zhang, Qi Z <qi.z.zhang@intel.com>
> Subject: [Intel-wired-lan] [PATCH S48 v6 08/16] ice: Support RSS configure
> removal for AVF
> 
> Add ice_add_rss_cfg's reverse operation ice_rem_rss_cfg.
> It is invoked when handle VIRTCHNL_OP_DEL_RSS_CFG.
> 
> Signed-off-by: Vignesh Sridhar <vignesh.sridhar@intel.com>
> Signed-off-by: Jia Guo <jia.guo@intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_flow.c        | 90
> ++++++++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_flow.h        |  5 ++
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 17 ++++-
>  3 files changed, 110 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


