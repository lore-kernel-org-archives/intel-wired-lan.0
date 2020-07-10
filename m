From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 10 Jul 2020 21:30:14 +0000
Subject: [Intel-wired-lan] [PATCH S48 v5 03/16] ice: Support non word
 aligned input set field
In-Reply-To: <20200710010644.33817-4-qi.z.zhang@intel.com>
References: <20200710010644.33817-1-qi.z.zhang@intel.com>
 <20200710010644.33817-4-qi.z.zhang@intel.com>
Message-ID: <BN6PR1101MB2145BCAFC14EE6DCB38714D28C650@BN6PR1101MB2145.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S48 v5 03/16] ice: Support non word
> aligned input set field
> 
> To support FDIR / RSS input set with protocol field like DSCP, TTL, PROT, etc.
> which is not word aligned, we need to enable field vector masking.
> 
> Signed-off-by: Dan Nowlin <dan.nowlin@intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_flex_pipe.c  | 419
> +++++++++++++++++++++++-
>  drivers/net/ethernet/intel/ice/ice_flex_pipe.h  |   2 +-
>  drivers/net/ethernet/intel/ice/ice_flex_type.h  |  17 +
>  drivers/net/ethernet/intel/ice/ice_flow.c       | 122 ++++++-
>  drivers/net/ethernet/intel/ice/ice_flow.h       |   7 +
>  drivers/net/ethernet/intel/ice/ice_hw_autogen.h |  16 +
>  6 files changed, 557 insertions(+), 26 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


