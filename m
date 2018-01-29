From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Mon, 29 Jan 2018 10:42:59 -0800
Subject: [Intel-wired-lan] [PATCH] i40e: i40e_open() should fail if
 forcing link state returned error
In-Reply-To: <20180129075551.85917-1-alice.michael@intel.com>
References: <20180129075551.85917-1-alice.michael@intel.com>
Message-ID: <20180129104259.0000251c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 29 Jan 2018 02:55:51 -0500
Alice Michael <alice.michael@intel.com> wrote:

> From: Mariusz Stachura <mariusz.stachura@intel.com>
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
> index a852775..58ed695 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
> @@ -1914,6 +1914,43 @@ enum i40e_aq_phy_type {
>  	I40E_PHY_TYPE_DEFAULT			= 0xFF,
>  };
>  
> +#define I40E_PHY_TYPES_BITMASK ((1ULL << I40E_PHY_TYPE_SGMII) | \
> +				(1ULL << I40E_PHY_TYPE_1000BASE_KX) | \

These should all be like BIT_ULL(I40E_PHY_TYPE_SGMII) | \

Rest looks ok.

> +				(1ULL << I40E_PHY_TYPE_10GBASE_KX4) | \
> +				(1ULL << I40E_PHY_TYPE_10GBASE_KR) | \
> +				(1ULL << I40E_PHY_TYPE_40GBASE_KR4) | \
> +				(1ULL << I40E_PHY_TYPE_XAUI) | \
> +				(1ULL << I40E_PHY_TYPE_XFI) | \
> +				(1ULL << I40E_PHY_TYPE_SFI) | \
> +				(1ULL << I40E_PHY_TYPE_XLAUI) | \
> +				(1ULL << I40E_PHY_TYPE_XLPPI) | \
> +				(1ULL << I40E_PHY_TYPE_40GBASE_CR4_CU) | \
> +				(1ULL << I40E_PHY_TYPE_10GBASE_CR1_CU) | \
> +				(1ULL << I40E_PHY_TYPE_10GBASE_AOC) | \
> +				(1ULL << I40E_PHY_TYPE_40GBASE_AOC) | \
> +				(1ULL << I40E_PHY_TYPE_UNRECOGNIZED) | \
> +				(1ULL << I40E_PHY_TYPE_UNSUPPORTED) | \
> +				(1ULL << I40E_PHY_TYPE_100BASE_TX) | \
> +				(1ULL << I40E_PHY_TYPE_1000BASE_T) | \
> +				(1ULL << I40E_PHY_TYPE_10GBASE_T) | \
> +				(1ULL << I40E_PHY_TYPE_10GBASE_SR) | \
> +				(1ULL << I40E_PHY_TYPE_10GBASE_LR) | \
> +				(1ULL << I40E_PHY_TYPE_10GBASE_SFPP_CU) | \
> +				(1ULL << I40E_PHY_TYPE_10GBASE_CR1) | \
> +				(1ULL << I40E_PHY_TYPE_40GBASE_CR4) | \
> +				(1ULL << I40E_PHY_TYPE_40GBASE_SR4) | \
> +				(1ULL << I40E_PHY_TYPE_40GBASE_LR4) | \
> +				(1ULL << I40E_PHY_TYPE_1000BASE_SX) | \
> +				(1ULL << I40E_PHY_TYPE_1000BASE_LX) | \
> +				(1ULL << I40E_PHY_TYPE_1000BASE_T_OPTICAL) | \
> +				(1ULL << I40E_PHY_TYPE_20GBASE_KR2) | \
> +				(1ULL << I40E_PHY_TYPE_25GBASE_KR) | \
> +				(1ULL << I40E_PHY_TYPE_25GBASE_CR) | \
> +				(1ULL << I40E_PHY_TYPE_25GBASE_SR) | \
> +				(1ULL << I40E_PHY_TYPE_25GBASE_LR) | \
> +				(1ULL << I40E_PHY_TYPE_25GBASE_AOC) | \
> +				(1ULL << I40E_PHY_TYPE_25GBASE_ACC))
> +
>  #define I40E_LINK_SPEED_100MB_SHIFT	0x1
>  #define I40E_LINK_SPEED_1000MB_SHIFT	0x2
>  #define I40E_LINK_SPEED_10GB_SHIFT	0x3
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 4725353..2398673 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -6551,37 +6551,36 @@ int i40e_up(struct i40e_vsi *vsi)
>   * @pf: board private structure
>   * @is_up: whether the link state should be forced up or down
>   **/
> -static void i40e_force_link_state(struct i40e_pf *pf, bool is_up)
> +static i40e_status i40e_force_link_state(struct i40e_pf *pf, bool is_up)
>  {
>  	struct i40e_aq_get_phy_abilities_resp abilities;
>  	struct i40e_aq_set_phy_config config = {0};
>  	struct i40e_hw *hw = &pf->hw;
> -	enum i40e_aq_phy_type cnt;
> -	u64 mask = 0;
>  	i40e_status err;
> +	u64 mask;
>  
>  	/* Get the current phy config */
>  	err = i40e_aq_get_phy_capabilities(hw, false, false, &abilities,
>  					   NULL);
> -	if (err)
> -		dev_dbg(&pf->pdev->dev,
> +	if (err) {
> +		dev_err(&pf->pdev->dev,
>  			"failed to get phy cap., ret =  %s last_status =  %s\n",
>  			i40e_stat_str(hw, err),
>  			i40e_aq_str(hw, hw->aq.asq_last_status));
> +		return err;
> +	}
>  
>  	/* If link needs to go up, but was not forced to go down,
>  	 * no need for a flap
>  	 */
>  	if (is_up && abilities.phy_type != 0)
> -		return;
> +		return I40E_SUCCESS;
>  
>  	/* To force link we need to set bits for all supported PHY types,
>  	 * but there are now more than 32, so we need to split the bitmap
>  	 * across two fields.
>  	 */
> -	for (cnt = I40E_PHY_TYPE_SGMII; cnt < I40E_PHY_TYPE_MAX; cnt++)
> -		mask |= (1ULL << cnt);
> -
> +	mask = I40E_PHY_TYPES_BITMASK;
>  	config.phy_type = is_up ? cpu_to_le32((u32)(mask & 0xffffffff)) : 0;
>  	config.phy_type_ext = is_up ? (u8)((mask >> 32) & 0xff) : 0;
>  	/* Copy the old settings, except of phy_type */
> @@ -6592,11 +6591,13 @@ static void i40e_force_link_state(struct i40e_pf *pf, bool is_up)
>  	config.low_power_ctrl = abilities.d3_lpan;
>  	err = i40e_aq_set_phy_config(hw, &config, NULL);
>  
> -	if (err)
> -		dev_dbg(&pf->pdev->dev,
> +	if (err) {
> +		dev_err(&pf->pdev->dev,
>  			"set phy config ret =  %s last_status =  %s\n",
>  			i40e_stat_str(&pf->hw, err),
>  			i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
> +		return err;
> +	}
>  
>  	/* Update the link info */
>  	err = i40e_update_link_info(hw);
> @@ -6610,6 +6611,8 @@ static void i40e_force_link_state(struct i40e_pf *pf, bool is_up)
>  	}
>  
>  	i40e_aq_set_link_restart_an(hw, true, NULL);
> +
> +	return I40E_SUCCESS;
>  }
>  
>  /**
> @@ -7593,7 +7596,8 @@ int i40e_open(struct net_device *netdev)
>  
>  	netif_carrier_off(netdev);
>  
> -	i40e_force_link_state(pf, true);
> +	if (i40e_force_link_state(pf, true))
> +		return -EAGAIN;
>  
>  	err = i40e_vsi_open(vsi);
>  	if (err)

