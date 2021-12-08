From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Wed, 8 Dec 2021 08:07:30 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2 2/6] iavf: Add support for
 VIRTCHNL_VF_OFFLOAD_VLAN_V2 negotiation
In-Reply-To: <20211130001604.22112-3-anthony.l.nguyen@intel.com>
References: <20211130001604.22112-1-anthony.l.nguyen@intel.com>
 <20211130001604.22112-3-anthony.l.nguyen@intel.com>
Message-ID: <DM8PR11MB56215ADA254276256B16172CAB6F9@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: wtorek, 30 listopada 2021 01:16
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next v2 2/6] iavf: Add support for
> VIRTCHNL_VF_OFFLOAD_VLAN_V2 negotiation
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> In order to support the new VIRTCHNL_VF_OFFLOAD_VLAN_V2 capability
> the VF driver needs to rework it's initialization state machine and reset flow.
> This has to be done because successful negotiation of
> VIRTCHNL_VF_OFFLOAD_VLAN_V2 requires the VF driver to perform a
> second capability request via VIRTCHNL_OP_GET_OFFLOAD_VLAN_V2_CAPS
> before configuring the adapter and its netdev.
> 
> Add the VIRTCHNL_VF_OFFLOAD_VLAN_V2 bit when sending the
> VIRTHCNL_OP_GET_VF_RESOURECES message. The underlying PF will either
> support VIRTCHNL_VF_OFFLOAD_VLAN or
> VIRTCHNL_VF_OFFLOAD_VLAN_V2 or neither. Both of these offloads should
> never be supported together.
> 
> Based on this, add 2 new states to the initialization state machine:
> 
> __IAVF_INIT_GET_OFFLOAD_VLAN_V2_CAPS
> __IAVF_INIT_CONFIG_ADAPTER
> 
> The __IAVF_INIT_GET_OFFLOAD_VLAN_V2_CAPS state is used to
> request/store the new VLAN capabilities if and only if
> VIRTCHNL_VLAN_OFFLOAD_VLAN_V2 was successfully negotiated in the
> __IAVF_INIT_GET_RESOURCES state.
> 
> The __IAVF_INIT_CONFIG_ADAPTER state is used to configure the
> adapter/netdev after the resource requests have finished. The VF will move
> into this state regardless of whether it successfully negotiated
> VIRTCHNL_VF_OFFLOAD_VLAN or VIRTCHNL_VF_OFFLOAD_VLAN_V2.
> 
> Also, add a the new flag IAVF_FLAG_AQ_GET_OFFLOAD_VLAN_V2_CAPS
> and set it during VF reset. If VIRTCHNL_VF_OFFLOAD_VLAN_V2 was
> successfully negotiated then the VF will request its VLAN capabilities via
> VIRTCHNL_OP_GET_OFFLOAD_VLAN_V2_CAPS during the reset. This is
> needed because the PF may change/modify the VF's configuration during VF
> reset (i.e. modifying the VF's port VLAN configuration).
> 
> This also, required the VF to call netdev_update_features() since its VLAN
> features may change during VF reset. Make sure to call this under rtnl_lock().
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf.h        |   9 +
>  drivers/net/ethernet/intel/iavf/iavf_main.c   | 205 +++++++++++++-----
>  .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  78 ++++++-
>  3 files changed, 240 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf.h
> b/drivers/net/ethernet/intel/iavf/iavf.h
> index b5728bdbcf33..edb139834437 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf.h
> +++ b/drivers/net/ethernet/intel/iavf/iavf.h
> @@ -181,6 +181,8 @@ enum iavf_state_t {

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
