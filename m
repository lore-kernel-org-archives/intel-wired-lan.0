From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Fri, 24 Dec 2021 18:33:47 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 08/14] ice: Add
 outer_vlan_ops and VSI specific VLAN ops implementations
In-Reply-To: <20211202163852.36436-8-anthony.l.nguyen@intel.com>
References: <20211202163852.36436-1-anthony.l.nguyen@intel.com>
 <20211202163852.36436-8-anthony.l.nguyen@intel.com>
Message-ID: <BYAPR11MB33675D6D44105A244A17F5B4FC7F9@BYAPR11MB3367.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH net-next v3 08/14] ice: Add outer_vlan_ops
> and VSI specific VLAN ops implementations
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Add a new outer_vlan_ops member to the ice_vsi structure as outer VLAN
> ops are only available when the device is in Double VLAN Mode (DVM).
> Depending on the VSI type, the requirements for what operations to
> use/allow differ.
> 
> By default all VSI's have unsupported inner and outer VSI VLAN ops. This
> implementation was chosen to prevent unexpected crashes due to null
> pointer dereferences. Instead, if a VSI calls an unsupported op, it will
> just return -EOPNOTSUPP.
> 
> Add implementations to support modifying outer VLAN fields for VSI
> context. This includes the ability to modify VLAN stripping, insertion,
> and the port VLAN based on the outer VLAN handling fields of the VSI
> context.
> 
> These functions should only ever be used if DVM is enabled because that
> means the firmware supports the outer VLAN fields in the VSI context. If
> the device is in DVM, then always use the outer_vlan_ops, else use the
> vlan_ops since the device is in Single VLAN Mode (SVM).
> 
> Also, move adding the untagged VLAN 0 filter from ice_vsi_setup() to
> ice_vsi_vlan_setup() as the latter function is specific to the PF and
> all other VSI types that need an untagged VLAN 0 filter already do this
> in their specific flows. Without this change, Flow Director is failing
> to initialize because it does not implement any VSI VLAN ops.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/Makefile       |   3 +-
>  drivers/net/ethernet/intel/ice/ice.h          |   3 +-
>  drivers/net/ethernet/intel/ice/ice_eswitch.c  |   5 +-
>  drivers/net/ethernet/intel/ice/ice_lib.c      | 111 +++++-
>  drivers/net/ethernet/intel/ice/ice_lib.h      |   3 +
>  drivers/net/ethernet/intel/ice/ice_main.c     |  60 +--
>  .../ethernet/intel/ice/ice_pf_vsi_vlan_ops.c  |  37 ++
>  .../ethernet/intel/ice/ice_pf_vsi_vlan_ops.h  |  13 +
>  .../ethernet/intel/ice/ice_vf_vsi_vlan_ops.c  |  72 ++++
>  .../ethernet/intel/ice/ice_vf_vsi_vlan_ops.h  |  16 +
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 101 +++--
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.h  |   6 +
>  .../net/ethernet/intel/ice/ice_vsi_vlan_lib.c | 344 +++++++++++++++++-
>  .../net/ethernet/intel/ice/ice_vsi_vlan_lib.h |   6 +
>  .../net/ethernet/intel/ice/ice_vsi_vlan_ops.c | 107 +++++-
>  .../net/ethernet/intel/ice/ice_vsi_vlan_ops.h |   6 +
>  16 files changed, 808 insertions(+), 85 deletions(-)
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_pf_vsi_vlan_ops.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_pf_vsi_vlan_ops.h
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.h
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
