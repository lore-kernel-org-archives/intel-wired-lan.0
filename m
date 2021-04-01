From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Thu, 1 Apr 2021 17:35:56 +0000
Subject: [Intel-wired-lan] [PATCH net v2] i40e: Fix PHY type identifiers
 for 2.5G and 5G adapters
In-Reply-To: <20210331105701.2112-1-mateusz.palczewski@intel.com>
References: <20210331105701.2112-1-mateusz.palczewski@intel.com>
Message-ID: <e179078357fc93bfa0bd9c3de6a4f47a6a8fc379.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2021-03-31 at 10:57 +0000, Mateusz Palczewski wrote:
> Unlike other supported adapters, 2.5G and 5G use different
> PHY type identifiers for reading/writing PHY settings
> and for reading link status. Introduce separate PHY
> identifiers for these two operation types.
> 
> Fixes: 2e45d3f4677a("i40e: Add support for X710 B/P & SFP+ cards")

The Fixes formatting was correct on v1, but is wrong here.  

> Signed-off-by: Dawid Lukwinski <dawid.lukwinski@intel.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Michal Maloszewski <michal.maloszewski@intel.com>
> Reviewed-by: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
> ---
>  v2: Added missing changes in i40e_ethtool.c file
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h | 2 ++
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c    | 4 ++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
> b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
> index ce626ea..78ba6b0 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
> @@ -1568,6 +1568,8 @@ enum i40e_aq_phy_type {
>  	I40E_PHY_TYPE_25GBASE_ACC		= 0x24,
>  	I40E_PHY_TYPE_2_5GBASE_T		= 0x30,
>  	I40E_PHY_TYPE_5GBASE_T			= 0x31,
> +	I40E_PHY_TYPE_2_5GBASE_T_LINK_STATUS	= 0x30,
> +	I40E_PHY_TYPE_5GBASE_T_LINK_STATUS	= 0x31,
>  	I40E_PHY_TYPE_MAX,
>  	I40E_PHY_TYPE_NOT_SUPPORTED_HIGH_TEMP	= 0xFD,
>  	I40E_PHY_TYPE_EMPTY			= 0xFE,
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> index 96d5202..fe5befa 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> @@ -841,8 +841,8 @@ static void i40e_get_settings_link_up(struct
> i40e_hw *hw,
>  							     10000baseT
> _Full);
>  		break;
>  	case I40E_PHY_TYPE_10GBASE_T:
> -	case I40E_PHY_TYPE_5GBASE_T:
> -	case I40E_PHY_TYPE_2_5GBASE_T:
> +	case I40E_PHY_TYPE_5GBASE_T_LINK_STATUS:
> +	case I40E_PHY_TYPE_2_5GBASE_T_LINK_STATUS:

There's nothing changing here. You've added new PHY types, but their
values match the old ones. The net effect is no change.
