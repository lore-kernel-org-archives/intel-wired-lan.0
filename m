From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Fri, 10 Dec 2021 06:31:39 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 03/14] ice: Add new VSI
 VLAN ops
In-Reply-To: <20211202163852.36436-3-anthony.l.nguyen@intel.com>
References: <20211202163852.36436-1-anthony.l.nguyen@intel.com>
 <20211202163852.36436-3-anthony.l.nguyen@intel.com>
Message-ID: <BYAPR11MB3367EE1F0CF6F96F9A01D3D3FC719@BYAPR11MB3367.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH net-next v3 03/14] ice: Add new VSI VLAN ops
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Incoming changes to support 802.1Q and/or 802.1ad VLAN filtering and
> offloads require more flexibility when configuring VLANs. The VSI VLAN
> interface will allow flexibility for configuring VLANs for all VSI types. Add new
> files to separate the VSI VLAN ops and move functions to make the code more
> organized.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/Makefile       |   2 +
>  drivers/net/ethernet/intel/ice/ice.h          |   2 +
>  drivers/net/ethernet/intel/ice/ice_eswitch.c  |   2 +-
>  drivers/net/ethernet/intel/ice/ice_lib.c      | 207 +----------
>  drivers/net/ethernet/intel/ice/ice_lib.h      |  11 -
>  drivers/net/ethernet/intel/ice/ice_main.c     |  30 +-
>  drivers/net/ethernet/intel/ice/ice_osdep.h    |   1 +
>  drivers/net/ethernet/intel/ice/ice_switch.h   |   9 -
>  drivers/net/ethernet/intel/ice/ice_type.h     |   9 +
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 111 +-----
> .../net/ethernet/intel/ice/ice_vsi_vlan_lib.c | 326 ++++++++++++++++++
> .../net/ethernet/intel/ice/ice_vsi_vlan_lib.h |  27 ++
> .../net/ethernet/intel/ice/ice_vsi_vlan_ops.c |  20 ++
> .../net/ethernet/intel/ice/ice_vsi_vlan_ops.h |  28 ++
>  14 files changed, 450 insertions(+), 335 deletions(-)  create mode 100644
> drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.h
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_vsi_vlan_ops.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_vsi_vlan_ops.h
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
