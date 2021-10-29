From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Fri, 29 Oct 2021 08:49:36 +0000
Subject: [Intel-wired-lan] [PATCH net-next 7/7] ice: Propagate error
 codes
In-Reply-To: <20211007220127.70514-8-anthony.l.nguyen@intel.com>
References: <20211007220127.70514-1-anthony.l.nguyen@intel.com>
 <20211007220127.70514-8-anthony.l.nguyen@intel.com>
Message-ID: <BYAPR11MB336717299CEADCE2B8DD6EB4FC879@BYAPR11MB3367.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH net-next 7/7] ice: Propagate error codes
> 
> As all functions now return Linux error codes, propagate the values being
> returned instead of converting them to more generic values.
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_base.c     |  4 +-
>  drivers/net/ethernet/intel/ice/ice_devlink.c  | 13 ++--
> drivers/net/ethernet/intel/ice/ice_ethtool.c  | 37 ++++-------
>  drivers/net/ethernet/intel/ice/ice_lib.c      | 23 +++----
>  drivers/net/ethernet/intel/ice/ice_main.c     | 63 ++++++-------------
>  drivers/net/ethernet/intel/ice/ice_tc_lib.c   |  1 -
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  |  4 +-
>  7 files changed, 48 insertions(+), 97 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
