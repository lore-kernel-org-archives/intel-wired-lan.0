From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Fri, 29 Oct 2021 08:27:47 +0000
Subject: [Intel-wired-lan] [PATCH net-next 3/7] ice: Use int for
 ice_status
In-Reply-To: <20211007220127.70514-4-anthony.l.nguyen@intel.com>
References: <20211007220127.70514-1-anthony.l.nguyen@intel.com>
 <20211007220127.70514-4-anthony.l.nguyen@intel.com>
Message-ID: <BYAPR11MB3367909B8B92EC2CC060DE6EFC879@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Tony
> Nguyen
> Sent: Friday, October 8, 2021 3:31 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next 3/7] ice: Use int for ice_status
> 
> To prepare for removal of ice_status, change the variables from
> ice_status to int. This eases the transition when values are changed to
> return standard int error codes over enum ice_status.
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_base.c     |   4 +-
>  drivers/net/ethernet/intel/ice/ice_common.c   | 209 +++++++++--------
>  drivers/net/ethernet/intel/ice/ice_common.h   | 102 ++++----
>  drivers/net/ethernet/intel/ice/ice_controlq.c |  54 ++---
>  drivers/net/ethernet/intel/ice/ice_dcb.c      |  58 ++---
>  drivers/net/ethernet/intel/ice/ice_dcb.h      |  26 +--
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |   2 +-
>  drivers/net/ethernet/intel/ice/ice_devlink.c  |  12 +-
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  |  24 +-
>  .../net/ethernet/intel/ice/ice_ethtool_fdir.c |   4 +-
>  drivers/net/ethernet/intel/ice/ice_fdir.c     |  10 +-
>  drivers/net/ethernet/intel/ice/ice_fdir.h     |  10 +-
>  .../net/ethernet/intel/ice/ice_flex_pipe.c    | 194 +++++++--------
>  .../net/ethernet/intel/ice/ice_flex_pipe.h    |  16 +-
>  drivers/net/ethernet/intel/ice/ice_flow.c     |  84 +++----
>  drivers/net/ethernet/intel/ice/ice_flow.h     |  18 +-
>  drivers/net/ethernet/intel/ice/ice_fltr.c     |  79 +++----
>  drivers/net/ethernet/intel/ice/ice_fltr.h     |  34 +--
>  .../net/ethernet/intel/ice/ice_fw_update.c    |  14 +-
>  drivers/net/ethernet/intel/ice/ice_gnss.c     |   6 +-
>  drivers/net/ethernet/intel/ice/ice_lib.c      |  38 +--
>  drivers/net/ethernet/intel/ice/ice_lib.h      |   2 +-
>  drivers/net/ethernet/intel/ice/ice_main.c     |  50 ++--
>  drivers/net/ethernet/intel/ice/ice_nvm.c      |  98 ++++----
>  drivers/net/ethernet/intel/ice/ice_nvm.h      |  32 +--
>  drivers/net/ethernet/intel/ice/ice_ptp.c      |   4 +-
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |   2 +-
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |   2 +-
>  drivers/net/ethernet/intel/ice/ice_sched.c    | 220 +++++++++---------
>  drivers/net/ethernet/intel/ice/ice_sched.h    |  36 +--
>  drivers/net/ethernet/intel/ice/ice_sriov.c    |  14 +-
>  drivers/net/ethernet/intel/ice/ice_sriov.h    |  12 +-
>  drivers/net/ethernet/intel/ice/ice_switch.c   | 208 ++++++++---------
>  drivers/net/ethernet/intel/ice/ice_switch.h   |  48 ++--
>  drivers/net/ethernet/intel/ice/ice_tc_lib.c   |   2 +-
>  .../ethernet/intel/ice/ice_virtchnl_fdir.c    |   4 +-
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  |  28 +--
>  37 files changed, 882 insertions(+), 878 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
