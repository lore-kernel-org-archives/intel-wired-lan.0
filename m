From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Wed, 27 Oct 2021 12:08:27 +0000
Subject: [Intel-wired-lan] [PATCH net-next 2/7] ice: Remove string
 printing for ice_status
In-Reply-To: <20211007220127.70514-3-anthony.l.nguyen@intel.com>
References: <20211007220127.70514-1-anthony.l.nguyen@intel.com>
 <20211007220127.70514-3-anthony.l.nguyen@intel.com>
Message-ID: <BYAPR11MB3367561E57B4EE820BE6B7ECFC859@BYAPR11MB3367.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH net-next 2/7] ice: Remove string printing for
> ice_status
> 
> Remove the ice_stat_str() function which prints the string representation of the
> ice_status error code. With upcoming changes moving away from ice_status,
> there will be no need for this function.
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |   1 -
>  drivers/net/ethernet/intel/ice/ice_base.c     |   8 +-
>  drivers/net/ethernet/intel/ice/ice_devlink.c  |  24 +--
> drivers/net/ethernet/intel/ice/ice_ethtool.c  |  28 +--
>  .../net/ethernet/intel/ice/ice_flex_pipe.c    |   8 +-
>  .../net/ethernet/intel/ice/ice_fw_update.c    |  24 +--
>  drivers/net/ethernet/intel/ice/ice_lib.c      |  96 +++++------
>  drivers/net/ethernet/intel/ice/ice_main.c     | 162 +++++-------------
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  |  48 +++---
>  9 files changed, 163 insertions(+), 236 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
