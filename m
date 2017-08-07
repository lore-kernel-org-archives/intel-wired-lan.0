From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Mon, 7 Aug 2017 10:18:49 -0700
Subject: [Intel-wired-lan] [next PATCH S78-V4 02/12] i40e: Fix reporting
 of supported link modes
In-Reply-To: <20170804135222.46684-2-alice.michael@intel.com>
References: <20170804135222.46684-1-alice.michael@intel.com>
 <20170804135222.46684-2-alice.michael@intel.com>
Message-ID: <d035a7b9-742d-cd78-e1a8-22b7c8ba5f42@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 8/4/2017 6:52 AM, Alice Michael wrote:
> From: Filip Sadowski <filip.sadowski@intel.com>
> 
> This patch fixes incorrect reporting of supported link modes on some NICs.
> 
> Signed-off-by: Filip Sadowski <filip.sadowski@intel.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h   | 20 ++++++++++++++++++--
>   drivers/net/ethernet/intel/i40e/i40e_common.c       |  8 +++++++-
>   drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h | 20 ++++++++++++++++++--
>   3 files changed, 43 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
> index e2a9ec8..5d0291c 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
> @@ -1734,6 +1734,8 @@ enum i40e_aq_phy_type {
>   	I40E_PHY_TYPE_10GBASE_CR1_CU		= 0xB,
>   	I40E_PHY_TYPE_10GBASE_AOC		= 0xC,
>   	I40E_PHY_TYPE_40GBASE_AOC		= 0xD,
> +	I40E_PHY_TYPE_UNRECOGNIZED		= 0xE,
> +	I40E_PHY_TYPE_UNSUPPORTED		= 0xF,
>   	I40E_PHY_TYPE_100BASE_TX		= 0x11,
>   	I40E_PHY_TYPE_1000BASE_T		= 0x12,
>   	I40E_PHY_TYPE_10GBASE_T			= 0x13,
> @@ -1752,6 +1754,8 @@ enum i40e_aq_phy_type {
>   	I40E_PHY_TYPE_25GBASE_CR		= 0x20,
>   	I40E_PHY_TYPE_25GBASE_SR		= 0x21,
>   	I40E_PHY_TYPE_25GBASE_LR		= 0x22,
> +	I40E_PHY_TYPE_EMPTY			= 0xFE,
> +	I40E_PHY_TYPE_DEFAULT			= 0xFF,
>   	I40E_PHY_TYPE_MAX
>   };
>   
> @@ -1942,19 +1946,31 @@ struct i40e_aqc_get_link_status {
>   #define I40E_AQ_25G_SERDES_UCODE_ERR	0X04
>   #define I40E_AQ_25G_NIMB_UCODE_ERR	0X05
>   	u8	loopback; /* use defines from i40e_aqc_set_lb_mode */
> +/* Since firmware API 1.7 loopback field keeps power class info as well */
> +#define I40E_AQ_LOOPBACK_MASK		0x07
> +#define I40E_AQ_PWR_CLASS_SHIFT_LB	6
> +#define I40E_AQ_PWR_CLASS_MASK_LB	(0x03 << I40E_AQ_PWR_CLASS_SHIFT_LB)
>   	__le16	max_frame_size;
>   	u8	config;
>   #define I40E_AQ_CONFIG_FEC_KR_ENA	0x01
>   #define I40E_AQ_CONFIG_FEC_RS_ENA	0x02
>   #define I40E_AQ_CONFIG_CRC_ENA		0x04
>   #define I40E_AQ_CONFIG_PACING_MASK	0x78
> -	u8	power_desc;
> +	union {
> +		struct {
> +			u8	power_desc;
>   #define I40E_AQ_LINK_POWER_CLASS_1	0x00
>   #define I40E_AQ_LINK_POWER_CLASS_2	0x01
>   #define I40E_AQ_LINK_POWER_CLASS_3	0x02
>   #define I40E_AQ_LINK_POWER_CLASS_4	0x03
>   #define I40E_AQ_PWR_CLASS_MASK		0x03
> -	u8	reserved[4];
> +			u8	reserved[4];
> +		};
> +		struct {
> +			u8	link_type[4];

Wait, is this a 32-bit value on an odd-byte alignment?  No, no, no... we 
worked hard early on to not let the HW folks do this.

> +			u8	link_type_ext;
> +		};
> +	};
>   };
>   
>   I40E_CHECK_CMD_LENGTH(i40e_aqc_get_link_status);
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
> index e9f30b8..c0aeda7 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_common.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
> @@ -1826,7 +1826,7 @@ i40e_status i40e_aq_get_link_info(struct i40e_hw *hw,
>   	hw_link_info->fec_info = resp->config & (I40E_AQ_CONFIG_FEC_KR_ENA |
>   						 I40E_AQ_CONFIG_FEC_RS_ENA);
>   	hw_link_info->ext_info = resp->ext_info;
> -	hw_link_info->loopback = resp->loopback;
> +	hw_link_info->loopback = resp->loopback & I40E_AQ_LOOPBACK_MASK;
>   	hw_link_info->max_frame_size = le16_to_cpu(resp->max_frame_size);
>   	hw_link_info->pacing = resp->config & I40E_AQ_CONFIG_PACING_MASK;
>   
> @@ -1857,6 +1857,12 @@ i40e_status i40e_aq_get_link_info(struct i40e_hw *hw,
>   	     hw->aq.fw_min_ver < 40)) && hw_link_info->phy_type == 0xE)
>   		hw_link_info->phy_type = I40E_PHY_TYPE_10GBASE_SFPP_CU;
>   
> +	if (hw->aq.api_maj_ver == I40E_FW_API_VERSION_MAJOR &&
> +	    hw->aq.api_min_ver >= 7) {
> +		hw->phy.phy_types = le32_to_cpu(*(__le32 *)resp->link_type);

Reading a 32-bit word from an odd byte boundary will cause a non-x86 
machine (e.g. SPARC) a bit of heartburn, kernel log messages, and 
possibly a few customer complaints.  You're going to need a memcpy() to 
get it out of the funky memory address, then you can add in the byteswap.

		u32 tmp;
		memcpy(&tmp, &resp->link_type, sizeof(tmp));
		hw->phy.phy_types = le32_to_cpu(tmp);


> +		hw->phy.phy_types |= ((u64)resp->link_type_ext << 32);
> +	}
> +
>   	/* save link status information */
>   	if (link)
>   		*link = *hw_link_info;
> diff --git a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
> index f9f48d1..709d114 100644
> --- a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
> +++ b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
> @@ -1730,6 +1730,8 @@ enum i40e_aq_phy_type {
>   	I40E_PHY_TYPE_10GBASE_CR1_CU		= 0xB,
>   	I40E_PHY_TYPE_10GBASE_AOC		= 0xC,
>   	I40E_PHY_TYPE_40GBASE_AOC		= 0xD,
> +	I40E_PHY_TYPE_UNRECOGNIZED		= 0xE,
> +	I40E_PHY_TYPE_UNSUPPORTED		= 0xF,
>   	I40E_PHY_TYPE_100BASE_TX		= 0x11,
>   	I40E_PHY_TYPE_1000BASE_T		= 0x12,
>   	I40E_PHY_TYPE_10GBASE_T			= 0x13,
> @@ -1748,6 +1750,8 @@ enum i40e_aq_phy_type {
>   	I40E_PHY_TYPE_25GBASE_CR		= 0x20,
>   	I40E_PHY_TYPE_25GBASE_SR		= 0x21,
>   	I40E_PHY_TYPE_25GBASE_LR		= 0x22,
> +	I40E_PHY_TYPE_EMPTY			= 0xFE,
> +	I40E_PHY_TYPE_DEFAULT			= 0xFF,
>   	I40E_PHY_TYPE_MAX
>   };
>   
> @@ -1938,19 +1942,31 @@ struct i40e_aqc_get_link_status {
>   #define I40E_AQ_25G_SERDES_UCODE_ERR	0X04
>   #define I40E_AQ_25G_NIMB_UCODE_ERR	0X05
>   	u8	loopback; /* use defines from i40e_aqc_set_lb_mode */
> +/* Since firmware API 1.7 loopback field keeps power class info as well */
> +#define I40E_AQ_LOOPBACK_MASK		0x07
> +#define I40E_AQ_PWR_CLASS_SHIFT_LB	6
> +#define I40E_AQ_PWR_CLASS_MASK_LB	(0x03 << I40E_AQ_PWR_CLASS_SHIFT_LB)
>   	__le16	max_frame_size;
>   	u8	config;
>   #define I40E_AQ_CONFIG_FEC_KR_ENA	0x01
>   #define I40E_AQ_CONFIG_FEC_RS_ENA	0x02
>   #define I40E_AQ_CONFIG_CRC_ENA		0x04
>   #define I40E_AQ_CONFIG_PACING_MASK	0x78
> -	u8	power_desc;
> +	union {
> +		struct {
> +			u8	power_desc;
>   #define I40E_AQ_LINK_POWER_CLASS_1	0x00
>   #define I40E_AQ_LINK_POWER_CLASS_2	0x01
>   #define I40E_AQ_LINK_POWER_CLASS_3	0x02
>   #define I40E_AQ_LINK_POWER_CLASS_4	0x03
>   #define I40E_AQ_PWR_CLASS_MASK		0x03
> -	u8	reserved[4];
> +			u8	reserved[4];
> +		};
> +		struct {
> +			u8	link_type[4];
> +			u8	link_type_ext;
> +		};
> +	};
>   };
>   
>   I40E_CHECK_CMD_LENGTH(i40e_aqc_get_link_status);
> 
