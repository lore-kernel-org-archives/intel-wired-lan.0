From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Fri, 29 Oct 2021 08:42:31 +0000
Subject: [Intel-wired-lan] [PATCH net-next 6/7] ice: Remove excess error
 variables
In-Reply-To: <20211007220127.70514-7-anthony.l.nguyen@intel.com>
References: <20211007220127.70514-1-anthony.l.nguyen@intel.com>
 <20211007220127.70514-7-anthony.l.nguyen@intel.com>
Message-ID: <BYAPR11MB3367556668CC7AC6A233FA20FC879@BYAPR11MB3367.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH net-next 6/7] ice: Remove excess error
> variables
> 
> ice_status previously had a variable to contain these values where other error
> codes had a variable as well. With ice_status now being an int, there is no need
> for two variables to hold error values. In cases where this occurs, remove one
> of the excess variables and use a single one.
> Some initialization of variables are no longer needed and have been removed.
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c   |   9 +-
>  drivers/net/ethernet/intel/ice/ice_devlink.c  |  32 +++--
> drivers/net/ethernet/intel/ice/ice_ethtool.c  |  79 ++++++------
> .../net/ethernet/intel/ice/ice_ethtool_fdir.c |  44 +++----
>  .../net/ethernet/intel/ice/ice_fw_update.c    |  31 ++---
>  drivers/net/ethernet/intel/ice/ice_gnss.c     |  28 ++--
>  drivers/net/ethernet/intel/ice/ice_lib.c      |  66 +++++-----
>  drivers/net/ethernet/intel/ice/ice_main.c     | 120 ++++++++----------
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |   5 +-
>  drivers/net/ethernet/intel/ice/ice_tc_lib.c   |   9 +-
>  .../ethernet/intel/ice/ice_virtchnl_fdir.c    |  24 ++--
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  |  44 +++----
>  12 files changed, 210 insertions(+), 281 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
