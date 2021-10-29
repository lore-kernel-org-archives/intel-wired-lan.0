From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Fri, 29 Oct 2021 08:34:17 +0000
Subject: [Intel-wired-lan] [PATCH net-next 4/7] ice: Remove enum
 ice_status
In-Reply-To: <20211007220127.70514-5-anthony.l.nguyen@intel.com>
References: <20211007220127.70514-1-anthony.l.nguyen@intel.com>
 <20211007220127.70514-5-anthony.l.nguyen@intel.com>
Message-ID: <BYAPR11MB33678FF494E6B27A064F118CFC879@BYAPR11MB3367.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH net-next 4/7] ice: Remove enum ice_status
> 
> Replace uses of ice_status to, as equivalent as possible, error codes.
> Remove enum ice_status and its helper conversion function as they are no
> longer needed.
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_base.c     |   6 +-
>  drivers/net/ethernet/intel/ice/ice_common.c   | 192 +++++++-------
>  drivers/net/ethernet/intel/ice/ice_controlq.c |  62 ++---
>  drivers/net/ethernet/intel/ice/ice_dcb.c      |  31 ++-
>  .../net/ethernet/intel/ice/ice_ethtool_fdir.c |  10 +-
>  drivers/net/ethernet/intel/ice/ice_fdir.c     |   8 +-
>  .../net/ethernet/intel/ice/ice_flex_pipe.c    | 194 +++++++--------
>  drivers/net/ethernet/intel/ice/ice_flow.c     |  74 +++---
>  drivers/net/ethernet/intel/ice/ice_fltr.c     |  10 +-
>  drivers/net/ethernet/intel/ice/ice_gnss.c     |   4 +-
>  drivers/net/ethernet/intel/ice/ice_lib.c      |  37 +--
>  drivers/net/ethernet/intel/ice/ice_lib.h      |   3 -
>  drivers/net/ethernet/intel/ice/ice_main.c     |  12 +-
>  drivers/net/ethernet/intel/ice/ice_nvm.c      |  38 +--
>  drivers/net/ethernet/intel/ice/ice_ptp.c      |   6 +-
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |   8 +-
>  drivers/net/ethernet/intel/ice/ice_sched.c    | 186 +++++++-------
>  drivers/net/ethernet/intel/ice/ice_sriov.c    |  26 +-
>  drivers/net/ethernet/intel/ice/ice_status.h   |  44 ----
>  drivers/net/ethernet/intel/ice/ice_switch.c   | 234 +++++++++---------
>  drivers/net/ethernet/intel/ice/ice_tc_lib.c   |   4 +-
>  drivers/net/ethernet/intel/ice/ice_type.h     |   1 -
>  .../ethernet/intel/ice/ice_virtchnl_fdir.c    |   8 +-
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  |  24 +-
>  24 files changed, 568 insertions(+), 654 deletions(-)
>  delete mode 100644 drivers/net/ethernet/intel/ice/ice_status.h
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
