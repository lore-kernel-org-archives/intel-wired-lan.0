From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 10 Jul 2020 21:27:49 +0000
Subject: [Intel-wired-lan] [PATCH S48 v5 05/16] ice: Support to separate
 GTP-U uplink and downlink
In-Reply-To: <20200710010644.33817-6-qi.z.zhang@intel.com>
References: <20200710010644.33817-1-qi.z.zhang@intel.com>
 <20200710010644.33817-6-qi.z.zhang@intel.com>
Message-ID: <BN6PR1101MB21452293B7BB4D6412E5D3D98C650@BN6PR1101MB2145.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S48 v5 05/16] ice: Support to separate GTP-
> U uplink and downlink
> 
> To apply different input set for GTP-U packet with or without extend header
> as well as GTP-U uplink and downlink, we need to add TCAM mask matching
> capability. This allows comprehending different PTYPE attributes by
> examining flags from the parser. Using this method, different profiles can be
> used by examining flag values from the parser.
> 
> Signed-off-by: Dan Nowlin <dan.nowlin@intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_flex_pipe.c | 102
> ++++++++++++++++++++++---
>  drivers/net/ethernet/intel/ice/ice_flex_pipe.h |   1 +
>  drivers/net/ethernet/intel/ice/ice_flex_type.h |  61 +++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_flow.c      |  88 ++++++++++++++++++++-
>  4 files changed, 242 insertions(+), 10 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


