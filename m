From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 26 Nov 2019 19:42:14 +0000
Subject: [Intel-wired-lan] [PATCH S34 v2 2/2] ice: Implement peer
 communications
In-Reply-To: <20191120095417.15124-2-anthony.l.nguyen@intel.com>
References: <20191120095417.15124-1-anthony.l.nguyen@intel.com>
 <20191120095417.15124-2-anthony.l.nguyen@intel.com>
Message-ID: <853b870bbb2f404fb576c77581d8a327@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, November 20, 2019 1:54 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S34 v2 2/2] ice: Implement peer
> communications
> 
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> Set and implement operations for the peer device and peer driver to
> communicate with each other, via iidc_ops and iidc_peer_ops, to request
> resources and manage event notification.
> 
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
> v2:
> - Change usage from MFD to virtual bus
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |   1 +
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  32 +
>  drivers/net/ethernet/intel/ice/ice_common.c   | 188 ++++
>  drivers/net/ethernet/intel/ice/ice_common.h   |   9 +
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |  34 +
>  drivers/net/ethernet/intel/ice/ice_idc.c      | 879 ++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_idc_int.h  |  45 +
>  drivers/net/ethernet/intel/ice/ice_lib.c      |  39 +
>  drivers/net/ethernet/intel/ice/ice_lib.h      |   2 +
>  drivers/net/ethernet/intel/ice/ice_main.c     |  45 +-
>  drivers/net/ethernet/intel/ice/ice_sched.c    |  69 +-
>  drivers/net/ethernet/intel/ice/ice_switch.c   |  27 +
>  drivers/net/ethernet/intel/ice/ice_switch.h   |   4 +
>  drivers/net/ethernet/intel/ice/ice_type.h     |   3 +
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  |  25 -
>  15 files changed, 1364 insertions(+), 38 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


