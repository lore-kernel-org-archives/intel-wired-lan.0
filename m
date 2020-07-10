From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 10 Jul 2020 21:29:38 +0000
Subject: [Intel-wired-lan] [PATCH S48 v5 08/16] ice: Support RSS
 configure removal for AVF
In-Reply-To: <20200710010644.33817-9-qi.z.zhang@intel.com>
References: <20200710010644.33817-1-qi.z.zhang@intel.com>
 <20200710010644.33817-9-qi.z.zhang@intel.com>
Message-ID: <BN6PR1101MB21450B428FE217DDA51B23D88C650@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Qi
> Zhang
> Sent: Thursday, July 9, 2020 6:07 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Zhang, Qi Z <qi.z.zhang@intel.com>
> Subject: [Intel-wired-lan] [PATCH S48 v5 08/16] ice: Support RSS configure
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


