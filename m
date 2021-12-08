From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Wed, 8 Dec 2021 08:06:41 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2 3/6] iavf: Add support
 VIRTCHNL_VF_OFFLOAD_VLAN_V2 during netdev config
In-Reply-To: <20211130001604.22112-4-anthony.l.nguyen@intel.com>
References: <20211130001604.22112-1-anthony.l.nguyen@intel.com>
 <20211130001604.22112-4-anthony.l.nguyen@intel.com>
Message-ID: <DM8PR11MB56218F18B6C3AF7206B6E429AB6F9@DM8PR11MB5621.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH net-next v2 3/6] iavf: Add support
> VIRTCHNL_VF_OFFLOAD_VLAN_V2 during netdev config
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Based on VIRTCHNL_VF_OFFLOAD_VLAN_V2, the VF can now support more
> VLAN capabilities (i.e. 802.1AD offloads and filtering). In order to
> communicate these capabilities to the netdev layer, the VF needs to parse its
> VLAN capabilities based on whether it was able to negotiation
> VIRTCHNL_VF_OFFLOAD_VLAN or VIRTCHNL_VF_OFFLOAD_VLAN_V2 or
> neither of these.
> 
> In order to support this, add the following functionality:
> 
> iavf_get_netdev_vlan_hw_features() - This is used to determine the VLAN
> features that the underlying hardware supports and that can be toggled
> off/on based on the negotiated capabiltiies. For example, if
> VIRTCHNL_VF_OFFLOAD_VLAN_V2 was negotiated, then any capability
> marked with VIRTCHNL_VLAN_TOGGLE can be toggled on/off by the VF. If
> VIRTCHNL_VF_OFFLOAD_VLAN was negotiated, then only VLAN insertion
> and/or stripping can be toggled on/off.
> 
> iavf_get_netdev_vlan_features() - This is used to determine the VLAN
> features that the underlying hardware supports and that should be enabled
> by default. For example, if VIRTHCNL_VF_OFFLOAD_VLAN_V2 was
> negotiated, then any supported capability that has its ethertype_init filed set
> should be enabled by default. If VIRTCHNL_VF_OFFLOAD_VLAN was
> negotiated, then filtering, stripping, and insertion should be enabled by
> default.
> 
> Also, refactor iavf_fix_features() to take into account the new capabilities. To
> do this, query all the supported features (enabled by default and toggleable)
> and make sure the requested change is supported.
> If VIRTCHNL_VF_OFFLOAD_VLAN_V2 is successfully negotiated, there is no
> need to check VIRTCHNL_VLAN_TOGGLE here because the driver already
> told the netdev layer which features can be toggled via netdev-
> >hw_features during iavf_process_config(), so only those features will be
> requested to change.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf.h        |  17 +-
>  drivers/net/ethernet/intel/iavf/iavf_main.c   | 279 ++++++++++++++++--
>  .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 251 +++++++++++-----
>  3 files changed, 453 insertions(+), 94 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf.h
> b/drivers/net/ethernet/intel/iavf/iavf.h
> index edb139834437..5fb6ebf9a760 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf.h
> +++ b/drivers/net/ethernet/intel/iavf/iavf.h
> @@ -55,7 +55,8 @@ enum iavf_vsi_state_t {  struct iavf_vsi {

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
