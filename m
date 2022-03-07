From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Mon, 7 Mar 2022 16:20:34 +0000
Subject: [Intel-wired-lan] [PATCH net v2 1/3] ixgbe: add the ability for
 the PF to disable VF link state
In-Reply-To: <20220301114010.2676-1-slawomirx.mrozowicz@intel.com>
References: <20220301114010.2676-1-slawomirx.mrozowicz@intel.com>
Message-ID: <DM8PR11MB5621E59AF2135DDF13CEBC21AB089@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Slawomir Mrozowicz
> Sent: Tuesday, March 1, 2022 12:40 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Mrozowicz, SlawomirX <slawomirx.mrozowicz@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v2 1/3] ixgbe: add the ability for the PF
> to disable VF link state
> 
> Add support for ndo_set_vf_link_state the Network Device Option that
> allows the PF driver to control the virtual link state of the VF devices.
> Without this change a VF cannot be disabled/enabled by the administrator.
> In the implementation the auto state takes over PF link state to VF link
> setting, the enable state is not supported, the disable state shut off the VF
> link regardless of the PF setting.
> 
> Signed-off-by: Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   2 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  11 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h  |   2 +
>  .../net/ethernet/intel/ixgbe/ixgbe_sriov.c    | 207 ++++++++++++++----
>  .../net/ethernet/intel/ixgbe/ixgbe_sriov.h    |   4 +-
>  5 files changed, 182 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> index 4a69823e6abd..c9bf18086d9c 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> @@ -177,6 +177,8 @@ struct vf_data_storage {
>  	u16 pf_vlan; /* When set, guest VLAN config not allowed. */
>  	u16 pf_qos;
>  	u16 tx_rate;
> +	int link_enable;
> +	int link_state;
>  	u8 spoofchk_enabled;
>  	bool rss_query_enabled;
>  	u8 trusted;
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 89b467006291..e553b1c18ee7 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -5687,6 +5687,9 @@ static void ixgbe_up_complete(struct
> ixgbe_adapter *adapter)

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
