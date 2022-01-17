From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Mon, 17 Jan 2022 20:32:16 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 10/14] ice: Add support
 for VIRTCHNL_VF_OFFLOAD_VLAN_V2
In-Reply-To: <20211202163852.36436-10-anthony.l.nguyen@intel.com>
References: <20211202163852.36436-1-anthony.l.nguyen@intel.com>
 <20211202163852.36436-10-anthony.l.nguyen@intel.com>
Message-ID: <DM8PR11MB5621AE179E3C15F9C5DE829DAB579@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: czwartek, 2 grudnia 2021 17:39
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next v3 10/14] ice: Add support for
> VIRTCHNL_VF_OFFLOAD_VLAN_V2
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Add support for the VF driver to be able to request
> VIRTCHNL_VF_OFFLOAD_VLAN_V2, negotiate its VLAN capabilities via
> VIRTCHNL_OP_GET_OFFLOAD_VLAN_V2_CAPS, add/delete VLAN filters,
> and
> enable/disable VLAN offloads.
> 
> VFs supporting VIRTCHNL_OFFLOAD_VLAN_V2 will be able to use the
> following virtchnl opcodes:
> 
> VIRTCHNL_OP_GET_OFFLOAD_VLAN_V2_CAPS
> VIRTCHNL_OP_ADD_VLAN_V2
> VIRTCHNL_OP_DEL_VLAN_V2
> VIRTCHNL_OP_ENABLE_VLAN_STRIPPING_V2
> VIRTCHNL_OP_DISABLE_VLAN_STRIPPING_V2
> VIRTCHNL_OP_ENABLE_VLAN_INSERTION_V2
> VIRTCHNL_OP_DISABLE_VLAN_INSERTION_V2
> 
> Legacy VF drivers may expect the initial VLAN stripping settings to be
> configured by the PF, so the PF initializes VLAN stripping based on the
> VIRTCHNL_OP_GET_VF_RESOURCES opcode. However, with VLAN support
> via
> VIRTCHNL_VF_OFFLOAD_VLAN_V2, this function is only expected to be used
> for VFs that only support VIRTCHNL_VF_OFFLOAD_VLAN, which will only
> be supported when a port VLAN is configured. Update the function
> based on the new expectations. Also, change the message when the PF
> can't enable/disable VLAN stripping to a dev_dbg() as this isn't fatal.
> 
> When a VF isn't in a port VLAN and it only supports
> VIRTCHNL_VF_OFFLOAD_VLAN when Double VLAN Mode (DVM) is enabled,
> then
> the PF needs to reject the VIRTCHNL_VF_OFFLOAD_VLAN capability and
> configure the VF in software only VLAN mode. To do this add the new
> function ice_vf_vsi_cfg_legacy_vlan_mode(), which updates the VF's
> inner and outer ice_vsi_vlan_ops functions and sets up software only
> VLAN mode.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_base.c     |    1 +
>  .../ethernet/intel/ice/ice_vf_vsi_vlan_ops.c  |  115 ++
>  .../ethernet/intel/ice/ice_vf_vsi_vlan_ops.h  |    3 +
>  .../intel/ice/ice_virtchnl_allowlist.c        |   10 +
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 1132 ++++++++++++++++-
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.h  |    8 +
>  6 files changed, 1226 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_base.c
> b/drivers/net/ethernet/intel/ice/ice_base.c
> index 9ca0ae2bb1dc..0dec7c5463eb 100644
> --- a/drivers/net/ethernet/intel/ice/ice_base.c
> +++ b/drivers/net/ethernet/intel/ice/ice_base.c
> @@ -5,6 +5,7 @@

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
