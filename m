From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 5 Aug 2019 21:33:28 +0000
Subject: [Intel-wired-lan] [PATCH S26 02/15] ice: add support for
 virtchnl_queue_select.[tx|rx]_queues bitmap
In-Reply-To: <20190802082533.23083-2-anthony.l.nguyen@intel.com>
References: <20190802082533.23083-1-anthony.l.nguyen@intel.com>
 <20190802082533.23083-2-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40F077@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, August 2, 2019 1:25 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S26 02/15] ice: add support for
> virtchnl_queue_select.[tx|rx]_queues bitmap
> 
> From: Paul Greenwalt <paul.greenwalt@intel.com>
> 
> The VF driver can call VIRTCHNL_OP_[ENABLE|DISABLE]_QUEUES separately
> for each queue. Add support for virtchnl_queue_select.[tx|rx]_queues
> bitmap which is used to indicate which queues to enable and disable.
> 
> Add tracing of VF Tx/Rx per queue enable state to avoid enabling enabled
> queues and disabling disabled queues. Add total queues enabled count and
> clear ICE_VF_STATE_QS_ENA when count is zero.
> 
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> Signed-off-by: Peng Huang <peng.huang@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c      |  15 +-
>  drivers/net/ethernet/intel/ice/ice_lib.h      |  10 +
>  drivers/net/ethernet/intel/ice/ice_main.c     |   2 +-
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 243 +++++++++++++-----
> .../net/ethernet/intel/ice/ice_virtchnl_pf.h  |  12 +-
>  5 files changed, 207 insertions(+), 75 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


