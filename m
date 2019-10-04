From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 4 Oct 2019 19:05:50 +0000
Subject: [Intel-wired-lan] [PATCH 2/2] ice: Implement peer communications
In-Reply-To: <20191003141739.56446-2-anthony.l.nguyen@intel.com>
References: <20191003141739.56446-1-anthony.l.nguyen@intel.com>
 <20191003141739.56446-2-anthony.l.nguyen@intel.com>
Message-ID: <0762892933e247458639ee9772c6f73b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, October 3, 2019 7:18 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 2/2] ice: Implement peer communications
> 
> Set and implement operations for the peer device and peer driver to
> communicate with each other, via ice_ops and ice_peer_ops, to request
> resources and manage event notification.
> 
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |   2 +
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  32 +
>  drivers/net/ethernet/intel/ice/ice_common.c   | 188 ++++
>  drivers/net/ethernet/intel/ice/ice_common.h   |   9 +
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |  34 +
>  drivers/net/ethernet/intel/ice/ice_idc.c      | 884 ++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_idc_int.h  |  38 +
>  drivers/net/ethernet/intel/ice/ice_lib.c      |  34 +-
>  drivers/net/ethernet/intel/ice/ice_lib.h      |   2 +
>  drivers/net/ethernet/intel/ice/ice_main.c     |  63 +-
>  drivers/net/ethernet/intel/ice/ice_sched.c    |  69 +-
>  drivers/net/ethernet/intel/ice/ice_switch.c   |  27 +
>  drivers/net/ethernet/intel/ice/ice_switch.h   |   4 +
>  drivers/net/ethernet/intel/ice/ice_type.h     |   3 +
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  |  25 -
>  15 files changed, 1381 insertions(+), 33 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


