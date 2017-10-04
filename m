From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Wed, 4 Oct 2017 16:47:10 -0700
Subject: [Intel-wired-lan] [PATCH 09/13 net-next] i40e: Add new phy
 types for 25G AOC and ACC support.
In-Reply-To: <20171004175839.28364-10-alan.brady@intel.com>
References: <20171004175839.28364-1-alan.brady@intel.com>
 <20171004175839.28364-10-alan.brady@intel.com>
Message-ID: <07eb074d-7eb9-977e-47f7-6eced86285a3@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10/4/2017 10:58 AM, Alan Brady wrote:
> From: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
> 
> This patch adds support for 25G Active Optical Cables (AOC) and Active
> Copper Cables (ACC) phy types.
> 
> Signed-off-by: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
> Signed-off-by: Krzysztof Malek <krzysztof.malek@intel.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h   | 5 +++++
>   drivers/net/ethernet/intel/i40e/i40e_common.c       | 2 ++
>   drivers/net/ethernet/intel/i40e/i40e_ethtool.c      | 2 ++
>   drivers/net/ethernet/intel/i40e/i40e_type.h         | 4 ++++
>   drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h | 4 ++++
>   5 files changed, 17 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
> index a8f65aed5421..ad73f6d08352 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
> @@ -1771,10 +1771,13 @@ enum i40e_aq_phy_type {
>   	I40E_PHY_TYPE_25GBASE_CR		= 0x20,
>   	I40E_PHY_TYPE_25GBASE_SR		= 0x21,
>   	I40E_PHY_TYPE_25GBASE_LR		= 0x22,
> +	I40E_PHY_TYPE_25GBASE_AOC		= 0x23,
> +	I40E_PHY_TYPE_25GBASE_ACC		= 0x24,
>   	I40E_PHY_TYPE_MAX,
>   	I40E_PHY_TYPE_NOT_SUPPORTED_HIGH_TEMP	= 0xFD,
>   	I40E_PHY_TYPE_EMPTY			= 0xFE,
>   	I40E_PHY_TYPE_DEFAULT			= 0xFF,
> +

Unnecessary new whitespace

sln

>   };
>   
>   #define I40E_LINK_SPEED_100MB_SHIFT	0x1
> @@ -1831,6 +1834,8 @@ struct i40e_aq_get_phy_abilities_resp {
>   #define I40E_AQ_PHY_TYPE_EXT_25G_CR	0X02
>   #define I40E_AQ_PHY_TYPE_EXT_25G_SR	0x04
>   #define I40E_AQ_PHY_TYPE_EXT_25G_LR	0x08
> +#define I40E_AQ_PHY_TYPE_EXT_25G_AOC	0x10
> +#define I40E_AQ_PHY_TYPE_EXT_25G_ACC	0x20
>   	u8	fec_cfg_curr_mod_ext_info;
>   #define I40E_AQ_ENABLE_FEC_KR		0x01
>   #define I40E_AQ_ENABLE_FEC_RS		0x02
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
> index 53aad378d49c..1b85eb3e6443 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_common.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
> @@ -1180,6 +1180,8 @@ static enum i40e_media_type i40e_get_media_type(struct i40e_hw *hw)
>   	case I40E_PHY_TYPE_40GBASE_AOC:
>   	case I40E_PHY_TYPE_10GBASE_AOC:
>   	case I40E_PHY_TYPE_25GBASE_CR:
> +	case I40E_PHY_TYPE_25GBASE_AOC:
> +	case I40E_PHY_TYPE_25GBASE_ACC:
>   		media = I40E_MEDIA_TYPE_DA;
>   		break;
>   	case I40E_PHY_TYPE_1000BASE_KX:
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> index 08288b0a8cad..6ac5c7f232c6 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> @@ -502,6 +502,8 @@ static void i40e_get_settings_link_up(struct i40e_hw *hw,
>   	case I40E_PHY_TYPE_25GBASE_CR:
>   	case I40E_PHY_TYPE_25GBASE_SR:
>   	case I40E_PHY_TYPE_25GBASE_LR:
> +	case I40E_PHY_TYPE_25GBASE_AOC:
> +	case I40E_PHY_TYPE_25GBASE_ACC:
>   		supported = SUPPORTED_Autoneg;
>   		advertising = ADVERTISED_Autoneg;
>   		/* TODO: add speeds when ethtool is ready to support*/
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
> index 0410fcbdbb94..17a99b53acd9 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_type.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
> @@ -271,6 +271,10 @@ struct i40e_phy_info {
>   					     I40E_PHY_TYPE_OFFSET)
>   #define I40E_CAP_PHY_TYPE_25GBASE_LR BIT_ULL(I40E_PHY_TYPE_25GBASE_LR + \
>   					     I40E_PHY_TYPE_OFFSET)
> +#define I40E_CAP_PHY_TYPE_25GBASE_AOC BIT_ULL(I40E_PHY_TYPE_25GBASE_AOC + \
> +					     I40E_PHY_TYPE_OFFSET)
> +#define I40E_CAP_PHY_TYPE_25GBASE_ACC BIT_ULL(I40E_PHY_TYPE_25GBASE_ACC + \
> +					     I40E_PHY_TYPE_OFFSET)
>   #define I40E_HW_CAP_MAX_GPIO			30
>   /* Capabilities of a PF or a VF or the whole device */
>   struct i40e_hw_capabilities {
> diff --git a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
> index 60c892f559b9..463e331a70a9 100644
> --- a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
> +++ b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
> @@ -1767,6 +1767,8 @@ enum i40e_aq_phy_type {
>   	I40E_PHY_TYPE_25GBASE_CR		= 0x20,
>   	I40E_PHY_TYPE_25GBASE_SR		= 0x21,
>   	I40E_PHY_TYPE_25GBASE_LR		= 0x22,
> +	I40E_PHY_TYPE_25GBASE_AOC		= 0x23,
> +	I40E_PHY_TYPE_25GBASE_ACC		= 0x24,
>   	I40E_PHY_TYPE_MAX,
>   	I40E_PHY_TYPE_NOT_SUPPORTED_HIGH_TEMP	= 0xFD,
>   	I40E_PHY_TYPE_EMPTY			= 0xFE,
> @@ -1827,6 +1829,8 @@ struct i40e_aq_get_phy_abilities_resp {
>   #define I40E_AQ_PHY_TYPE_EXT_25G_CR	0X02
>   #define I40E_AQ_PHY_TYPE_EXT_25G_SR	0x04
>   #define I40E_AQ_PHY_TYPE_EXT_25G_LR	0x08
> +#define I40E_AQ_PHY_TYPE_EXT_25G_AOC	0x10
> +#define I40E_AQ_PHY_TYPE_EXT_25G_ACC	0x20
>   	u8	fec_cfg_curr_mod_ext_info;
>   #define I40E_AQ_ENABLE_FEC_KR		0x01
>   #define I40E_AQ_ENABLE_FEC_RS		0x02
> 
