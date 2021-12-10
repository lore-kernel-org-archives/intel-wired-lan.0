From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Fri, 10 Dec 2021 06:26:53 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 04/14] ice: Introduce
 ice_vlan struct
In-Reply-To: <20211202163852.36436-4-anthony.l.nguyen@intel.com>
References: <20211202163852.36436-1-anthony.l.nguyen@intel.com>
 <20211202163852.36436-4-anthony.l.nguyen@intel.com>
Message-ID: <BYAPR11MB33677DD083BA5676DF469445FC719@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Tony
> Nguyen
> Sent: Thursday, December 2, 2021 10:09 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next v3 04/14] ice: Introduce ice_vlan
> struct
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Add a new struct for VLAN related information. Currently this holds VLAN ID
> and priority values, but will be expanded to hold TPID value.
> This reduces the changes necessary if any other values are added in future.
> Remove the action argument from these calls as it's always ICE_FWD_VSI.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_fltr.c     | 35 +++++++------------
>  drivers/net/ethernet/intel/ice/ice_fltr.h     | 10 +++---
>  drivers/net/ethernet/intel/ice/ice_lib.c      |  5 ++-
>  drivers/net/ethernet/intel/ice/ice_lib.h      |  1 +
>  drivers/net/ethernet/intel/ice/ice_main.c     |  8 +++--
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 19 ++++++----
>  drivers/net/ethernet/intel/ice/ice_vlan.h     | 17 +++++++++
>  .../net/ethernet/intel/ice/ice_vsi_vlan_lib.c | 31 +++++++++-------
> .../net/ethernet/intel/ice/ice_vsi_vlan_lib.h |  9 +++--
> .../net/ethernet/intel/ice/ice_vsi_vlan_ops.h |  6 ++--
>  10 files changed, 82 insertions(+), 59 deletions(-)  create mode 100644
> drivers/net/ethernet/intel/ice/ice_vlan.h
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
