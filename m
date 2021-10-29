From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Fri, 29 Oct 2021 08:40:38 +0000
Subject: [Intel-wired-lan] [PATCH net-next 5/7] ice: Cleanup after
 ice_status removal
In-Reply-To: <20211007220127.70514-6-anthony.l.nguyen@intel.com>
References: <20211007220127.70514-1-anthony.l.nguyen@intel.com>
 <20211007220127.70514-6-anthony.l.nguyen@intel.com>
Message-ID: <BYAPR11MB336776F515CED44F0FEF59ACFC879@BYAPR11MB3367.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH net-next 5/7] ice: Cleanup after ice_status
> removal
> 
> Clean up code after changing ice_status to int. Rearrange to fix reverse
> Christmas tree and pull lines up where applicable.
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c   | 44 ++++++-------
>  drivers/net/ethernet/intel/ice/ice_controlq.c | 12 ++--
>  drivers/net/ethernet/intel/ice/ice_dcb.c      | 16 ++---
>  drivers/net/ethernet/intel/ice/ice_devlink.c  |  9 ++-
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  | 35 +++++-----
>  .../net/ethernet/intel/ice/ice_ethtool_fdir.c |  4 +-
>  .../net/ethernet/intel/ice/ice_flex_pipe.c    | 38 +++++------
>  drivers/net/ethernet/intel/ice/ice_flow.c     |  8 +--
>  drivers/net/ethernet/intel/ice/ice_flow.h     |  6 +-
>  drivers/net/ethernet/intel/ice/ice_fltr.c     | 10 +--
>  .../net/ethernet/intel/ice/ice_fw_update.c    | 17 ++---
>  drivers/net/ethernet/intel/ice/ice_lib.c      | 27 ++++----
>  drivers/net/ethernet/intel/ice/ice_main.c     | 60 ++++++++---------
>  drivers/net/ethernet/intel/ice/ice_nvm.c      | 20 +++---
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  2 +-
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  3 +-
>  drivers/net/ethernet/intel/ice/ice_sched.c    | 48 +++++++-------
>  drivers/net/ethernet/intel/ice/ice_switch.c   | 64 +++++++++----------
>  drivers/net/ethernet/intel/ice/ice_switch.h   | 18 ++----
>  drivers/net/ethernet/intel/ice/ice_tc_lib.c   |  2 +-
>  .../ethernet/intel/ice/ice_virtchnl_fdir.c    |  4 +-
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 22 +++----
>  22 files changed, 214 insertions(+), 255 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
