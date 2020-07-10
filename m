From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 10 Jul 2020 21:30:31 +0000
Subject: [Intel-wired-lan] [PATCH S48 v5 01/16] ice: Enable flexible
 descriptor RXDID querying and configuration
In-Reply-To: <20200710010644.33817-2-qi.z.zhang@intel.com>
References: <20200710010644.33817-1-qi.z.zhang@intel.com>
 <20200710010644.33817-2-qi.z.zhang@intel.com>
Message-ID: <BN6PR1101MB2145F5DBE0A1569999767AAF8C650@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Qi
> Zhang
> Sent: Thursday, July 9, 2020 6:06 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Zhang, Qi Z <qi.z.zhang@intel.com>
> Subject: [Intel-wired-lan] [PATCH S48 v5 01/16] ice: Enable flexible descriptor
> RXDID querying and configuration
> 
> Add support to allow VF to query flexible descriptor RXDIDs supported by
> DDP package and configure Rx queues with selected RXDID for IAVF.
> 
> Signed-off-by: Xu Ting <ting.xu@intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h             |   1 +
>  drivers/net/ethernet/intel/ice/ice_hw_autogen.h  |   3 +
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 108
> ++++++++++++++++++++++-
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h |   3 +
>  include/linux/avf/virtchnl.h                     |  15 +++-
>  5 files changed, 127 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


