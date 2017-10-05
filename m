From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Thu, 5 Oct 2017 13:24:00 -0700
Subject: [Intel-wired-lan] [PATCH v2 10/13 net-next] i40e: convert
 i40e_phy_type_to_ethtool to new API
In-Reply-To: <20171005184234.21288-11-alan.brady@intel.com>
References: <20171005184234.21288-1-alan.brady@intel.com>
 <20171005184234.21288-11-alan.brady@intel.com>
Message-ID: <bb7e715f-3f3d-38ae-d813-b95085be6ecb@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10/5/2017 11:42 AM, Alan Brady wrote:
> We are still largely using the old ethtool API macros.  This is
> problematic because eventually they will be removed and they only
> support 32 bits of PHY types.
> 
> This overhauls i40e_phy_type_to_ethtool to use only the new API.  Doing
> this also allows us to provide much better support for newer 25G and 10G
> PHY types which is included here as well.
> 
> This also adds a needed new function to ethtool,
> ethtool_intersect_link_masks which takes two link masks and gives their
> intersection.  We use this to figure out what is supported by both the
> current PHY type and the NVM.


I would guess that DaveM would rather see this new ethtool function as a 
separate patch.

sln


> 
> The remaining usages of the old ethtool API will be addressed in other
> patches in the series.
> 
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 204 +++++++++++++++++--------
>   include/linux/ethtool.h                        |  10 ++
>   net/core/ethtool.c                             |  16 ++
>   3 files changed, 166 insertions(+), 64 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> index 6ac5c7f232c6..77022ab6dc7e 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> @@ -254,95 +254,180 @@ static void i40e_partition_setting_complaint(struct i40e_pf *pf)
>   /**
>    * i40e_phy_type_to_ethtool - convert the phy_types to ethtool link modes
>    * @pf: PF struct with phy_types
> - * @supported: pointer to the ethtool supported variable to fill in
> - * @advertising: pointer to the ethtool advertising variable to fill in
> + * @ks: ethtool link ksettings struct to fill out
>    *
>    **/
> -static void i40e_phy_type_to_ethtool(struct i40e_pf *pf, u32 *supported,
> -				     u32 *advertising)
> +static void i40e_phy_type_to_ethtool(struct i40e_pf *pf,
> +				     struct ethtool_link_ksettings *ks)
>   {
>   	struct i40e_link_status *hw_link_info = &pf->hw.phy.link_info;
>   	u64 phy_types = pf->hw.phy.phy_types;
>   
> -	*supported = 0x0;
> -	*advertising = 0x0;
> +	ethtool_link_ksettings_zero_link_mode(ks, supported);
> +	ethtool_link_ksettings_zero_link_mode(ks, advertising);
>   
>   	if (phy_types & I40E_CAP_PHY_TYPE_SGMII) {
> -		*supported |= SUPPORTED_1000baseT_Full;
> +		ethtool_link_ksettings_add_link_mode(ks, supported,
> +						     1000baseT_Full);
>   		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_1GB)
> -			*advertising |= ADVERTISED_1000baseT_Full;
> +			ethtool_link_ksettings_add_link_mode(ks, advertising,
> +							     1000baseT_Full);
>   		if (pf->hw_features & I40E_HW_100M_SGMII_CAPABLE) {
> -			*supported |= SUPPORTED_100baseT_Full;
> -			*advertising |= ADVERTISED_100baseT_Full;
> +			ethtool_link_ksettings_add_link_mode(ks, supported,
> +							     100baseT_Full);
> +			ethtool_link_ksettings_add_link_mode(ks, advertising,
> +							     100baseT_Full);
>   		}
>   	}
>   	if (phy_types & I40E_CAP_PHY_TYPE_XAUI ||
>   	    phy_types & I40E_CAP_PHY_TYPE_XFI ||
>   	    phy_types & I40E_CAP_PHY_TYPE_SFI ||
>   	    phy_types & I40E_CAP_PHY_TYPE_10GBASE_SFPP_CU ||
> -	    phy_types & I40E_CAP_PHY_TYPE_10GBASE_AOC)
> -		*supported |= SUPPORTED_10000baseT_Full;
> -	if (phy_types & I40E_CAP_PHY_TYPE_10GBASE_CR1_CU ||
> -	    phy_types & I40E_CAP_PHY_TYPE_10GBASE_CR1 ||
> -	    phy_types & I40E_CAP_PHY_TYPE_10GBASE_T ||
> -	    phy_types & I40E_CAP_PHY_TYPE_10GBASE_SR ||
> -	    phy_types & I40E_CAP_PHY_TYPE_10GBASE_LR) {
> -		*supported |= SUPPORTED_10000baseT_Full;
> +	    phy_types & I40E_CAP_PHY_TYPE_10GBASE_AOC) {
> +		ethtool_link_ksettings_add_link_mode(ks, supported,
> +						     10000baseT_Full);
>   		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_10GB)
> -			*advertising |= ADVERTISED_10000baseT_Full;
> +			ethtool_link_ksettings_add_link_mode(ks, advertising,
> +							     10000baseT_Full);
> +	}
> +	if (phy_types & I40E_CAP_PHY_TYPE_10GBASE_T) {
> +		ethtool_link_ksettings_add_link_mode(ks, supported,
> +						     10000baseT_Full);
> +		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_10GB)
> +			ethtool_link_ksettings_add_link_mode(ks, advertising,
> +							     10000baseT_Full);
>   	}
>   	if (phy_types & I40E_CAP_PHY_TYPE_XLAUI ||
>   	    phy_types & I40E_CAP_PHY_TYPE_XLPPI ||
>   	    phy_types & I40E_CAP_PHY_TYPE_40GBASE_AOC)
> -		*supported |= SUPPORTED_40000baseCR4_Full;
> +		ethtool_link_ksettings_add_link_mode(ks, supported,
> +						     40000baseCR4_Full);
>   	if (phy_types & I40E_CAP_PHY_TYPE_40GBASE_CR4_CU ||
>   	    phy_types & I40E_CAP_PHY_TYPE_40GBASE_CR4) {
> -		*supported |= SUPPORTED_40000baseCR4_Full;
> +		ethtool_link_ksettings_add_link_mode(ks, supported,
> +						     40000baseCR4_Full);
>   		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_40GB)
> -			*advertising |= ADVERTISED_40000baseCR4_Full;
> +			ethtool_link_ksettings_add_link_mode(ks, advertising,
> +							     40000baseCR4_Full);
>   	}
>   	if (phy_types & I40E_CAP_PHY_TYPE_100BASE_TX) {
> -		*supported |= SUPPORTED_100baseT_Full;
> +		ethtool_link_ksettings_add_link_mode(ks, supported,
> +						     100baseT_Full);
>   		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_100MB)
> -			*advertising |= ADVERTISED_100baseT_Full;
> +			ethtool_link_ksettings_add_link_mode(ks, advertising,
> +							     100baseT_Full);
>   	}
> -	if (phy_types & I40E_CAP_PHY_TYPE_1000BASE_T ||
> -	    phy_types & I40E_CAP_PHY_TYPE_1000BASE_SX ||
> -	    phy_types & I40E_CAP_PHY_TYPE_1000BASE_LX ||
> -	    phy_types & I40E_CAP_PHY_TYPE_1000BASE_T_OPTICAL) {
> -		*supported |= SUPPORTED_1000baseT_Full;
> +	if (phy_types & I40E_CAP_PHY_TYPE_1000BASE_T) {
> +		ethtool_link_ksettings_add_link_mode(ks, supported,
> +						     1000baseT_Full);
>   		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_1GB)
> -			*advertising |= ADVERTISED_1000baseT_Full;
> +			ethtool_link_ksettings_add_link_mode(ks, advertising,
> +							     1000baseT_Full);
>   	}
>   	if (phy_types & I40E_CAP_PHY_TYPE_40GBASE_SR4)
> -		*supported |= SUPPORTED_40000baseSR4_Full;
> +		ethtool_link_ksettings_add_link_mode(ks, supported,
> +						     40000baseSR4_Full);
>   	if (phy_types & I40E_CAP_PHY_TYPE_40GBASE_LR4)
> -		*supported |= SUPPORTED_40000baseLR4_Full;
> +		ethtool_link_ksettings_add_link_mode(ks, supported,
> +						     40000baseLR4_Full);
>   	if (phy_types & I40E_CAP_PHY_TYPE_40GBASE_KR4) {
> -		*supported |= SUPPORTED_40000baseKR4_Full;
> -		*advertising |= ADVERTISED_40000baseKR4_Full;
> +		ethtool_link_ksettings_add_link_mode(ks, supported,
> +						     40000baseLR4_Full);
> +		ethtool_link_ksettings_add_link_mode(ks, advertising,
> +						     40000baseLR4_Full);
>   	}
>   	if (phy_types & I40E_CAP_PHY_TYPE_20GBASE_KR2) {
> -		*supported |= SUPPORTED_20000baseKR2_Full;
> +		ethtool_link_ksettings_add_link_mode(ks, supported,
> +						     20000baseKR2_Full);
>   		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_20GB)
> -			*advertising |= ADVERTISED_20000baseKR2_Full;
> +			ethtool_link_ksettings_add_link_mode(ks, advertising,
> +							     20000baseKR2_Full);
>   	}
>   	if (phy_types & I40E_CAP_PHY_TYPE_10GBASE_KX4) {
> -		*supported |= SUPPORTED_10000baseKX4_Full;
> +		ethtool_link_ksettings_add_link_mode(ks, supported,
> +						     10000baseKX4_Full);
>   		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_10GB)
> -			*advertising |= ADVERTISED_10000baseKX4_Full;
> +			ethtool_link_ksettings_add_link_mode(ks, advertising,
> +							     10000baseKX4_Full);
>   	}
>   	if (phy_types & I40E_CAP_PHY_TYPE_10GBASE_KR &&
>   	    !(pf->hw_features & I40E_HW_HAVE_CRT_RETIMER)) {
> -		*supported |= SUPPORTED_10000baseKR_Full;
> +		ethtool_link_ksettings_add_link_mode(ks, supported,
> +						     10000baseKR_Full);
>   		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_10GB)
> -			*advertising |= ADVERTISED_10000baseKR_Full;
> +			ethtool_link_ksettings_add_link_mode(ks, advertising,
> +							     10000baseKR_Full);
>   	}
>   	if (phy_types & I40E_CAP_PHY_TYPE_1000BASE_KX &&
>   	    !(pf->hw_features & I40E_HW_HAVE_CRT_RETIMER)) {
> -		*supported |= SUPPORTED_1000baseKX_Full;
> +		ethtool_link_ksettings_add_link_mode(ks, supported,
> +						     1000baseKX_Full);
>   		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_1GB)
> -			*advertising |= ADVERTISED_1000baseKX_Full;
> +			ethtool_link_ksettings_add_link_mode(ks, advertising,
> +							     1000baseKX_Full);
> +	}
> +	/* need to add 25G PHY types */
> +	if (phy_types & I40E_CAP_PHY_TYPE_25GBASE_KR) {
> +		ethtool_link_ksettings_add_link_mode(ks, supported,
> +						     25000baseKR_Full);
> +		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_25GB)
> +			ethtool_link_ksettings_add_link_mode(ks, advertising,
> +							     25000baseKR_Full);
> +	}
> +	if (phy_types & I40E_CAP_PHY_TYPE_25GBASE_CR) {
> +		ethtool_link_ksettings_add_link_mode(ks, supported,
> +						     25000baseCR_Full);
> +		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_25GB)
> +			ethtool_link_ksettings_add_link_mode(ks, advertising,
> +							     25000baseCR_Full);
> +	}
> +	if (phy_types & I40E_CAP_PHY_TYPE_25GBASE_SR ||
> +	    phy_types & I40E_CAP_PHY_TYPE_25GBASE_LR) {
> +		ethtool_link_ksettings_add_link_mode(ks, supported,
> +						     25000baseSR_Full);
> +		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_25GB)
> +			ethtool_link_ksettings_add_link_mode(ks, advertising,
> +							     25000baseSR_Full);
> +	}
> +	if (phy_types & I40E_CAP_PHY_TYPE_25GBASE_AOC ||
> +	    phy_types & I40E_CAP_PHY_TYPE_25GBASE_ACC) {
> +		ethtool_link_ksettings_add_link_mode(ks, supported,
> +						     25000baseCR_Full);
> +		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_25GB)
> +			ethtool_link_ksettings_add_link_mode(ks, advertising,
> +							     25000baseCR_Full);
> +	}
> +	/* need to add new 10G PHY types */
> +	if (phy_types & I40E_CAP_PHY_TYPE_10GBASE_CR1 ||
> +	    phy_types & I40E_CAP_PHY_TYPE_10GBASE_CR1_CU) {
> +		ethtool_link_ksettings_add_link_mode(ks, supported,
> +						     10000baseCR_Full);
> +		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_10GB)
> +			ethtool_link_ksettings_add_link_mode(ks, advertising,
> +							     10000baseCR_Full);
> +	}
> +	if (phy_types & I40E_CAP_PHY_TYPE_10GBASE_SR) {
> +		ethtool_link_ksettings_add_link_mode(ks, supported,
> +						     10000baseSR_Full);
> +		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_10GB)
> +			ethtool_link_ksettings_add_link_mode(ks, advertising,
> +							     10000baseSR_Full);
> +	}
> +	if (phy_types & I40E_CAP_PHY_TYPE_10GBASE_LR) {
> +		ethtool_link_ksettings_add_link_mode(ks, supported,
> +						     10000baseLR_Full);
> +		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_10GB)
> +			ethtool_link_ksettings_add_link_mode(ks, advertising,
> +							     10000baseLR_Full);
> +	}
> +	if (phy_types & I40E_CAP_PHY_TYPE_1000BASE_SX ||
> +	    phy_types & I40E_CAP_PHY_TYPE_1000BASE_LX ||
> +	    phy_types & I40E_CAP_PHY_TYPE_1000BASE_T_OPTICAL) {
> +		ethtool_link_ksettings_add_link_mode(ks, supported,
> +						     1000baseX_Full);
> +		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_1GB)
> +			ethtool_link_ksettings_add_link_mode(ks, advertising,
> +							     1000baseX_Full);
>   	}
>   	/* Autoneg PHY types */
>   	if (phy_types & I40E_CAP_PHY_TYPE_SGMII ||
> @@ -367,8 +452,10 @@ static void i40e_phy_type_to_ethtool(struct i40e_pf *pf, u32 *supported,
>   	    phy_types & I40E_CAP_PHY_TYPE_1000BASE_LX ||
>   	    phy_types & I40E_CAP_PHY_TYPE_1000BASE_KX ||
>   	    phy_types & I40E_CAP_PHY_TYPE_100BASE_TX) {
> -		*supported |= SUPPORTED_Autoneg;
> -		*advertising |= ADVERTISED_Autoneg;
> +		ethtool_link_ksettings_add_link_mode(ks, supported,
> +						     Autoneg);
> +		ethtool_link_ksettings_add_link_mode(ks, advertising,
> +						     Autoneg);
>   	}
>   }
>   
> @@ -385,9 +472,8 @@ static void i40e_get_settings_link_up(struct i40e_hw *hw,
>   				      struct i40e_pf *pf)
>   {
>   	struct i40e_link_status *hw_link_info = &hw->phy.link_info;
> +	struct ethtool_link_ksettings cap_ksettings;
>   	u32 link_speed = hw_link_info->link_speed;
> -	u32 e_advertising = 0x0;
> -	u32 e_supported = 0x0;
>   	u32 supported, advertising;
>   
>   	ethtool_convert_link_mode_to_legacy_u32(&supported,
> @@ -519,11 +605,13 @@ static void i40e_get_settings_link_up(struct i40e_hw *hw,
>   	 * current PHY type, get what is supported by the NVM and intersect
>   	 * them to get what is truly supported
>   	 */
> -	i40e_phy_type_to_ethtool(pf, &e_supported,
> -				 &e_advertising);
> -
> -	supported = supported & e_supported;
> -	advertising = advertising & e_advertising;
> +	ethtool_convert_legacy_u32_to_link_mode(ks->link_modes.supported,
> +						supported);
> +	ethtool_convert_legacy_u32_to_link_mode(ks->link_modes.advertising,
> +						advertising);
> +	memset(&cap_ksettings, 0, sizeof(struct ethtool_link_ksettings));
> +	i40e_phy_type_to_ethtool(pf, &cap_ksettings);
> +	ethtool_intersect_link_masks(ks, &cap_ksettings);
>   
>   	/* Set speed and duplex */
>   	switch (link_speed) {
> @@ -549,11 +637,6 @@ static void i40e_get_settings_link_up(struct i40e_hw *hw,
>   		break;
>   	}
>   	ks->base.duplex = DUPLEX_FULL;
> -
> -	ethtool_convert_legacy_u32_to_link_mode(ks->link_modes.supported,
> -						supported);
> -	ethtool_convert_legacy_u32_to_link_mode(ks->link_modes.advertising,
> -						advertising);
>   }
>   
>   /**
> @@ -568,17 +651,10 @@ static void i40e_get_settings_link_down(struct i40e_hw *hw,
>   					struct ethtool_link_ksettings *ks,
>   					struct i40e_pf *pf)
>   {
> -	u32 supported, advertising;
> -
>   	/* link is down and the driver needs to fall back on
>   	 * supported phy types to figure out what info to display
>   	 */
> -	i40e_phy_type_to_ethtool(pf, &supported, &advertising);
> -
> -	ethtool_convert_legacy_u32_to_link_mode(ks->link_modes.supported,
> -						supported);
> -	ethtool_convert_legacy_u32_to_link_mode(ks->link_modes.advertising,
> -						advertising);
> +	i40e_phy_type_to_ethtool(pf, ks);
>   
>   	/* With no link speed and duplex are unknown */
>   	ks->base.speed = SPEED_UNKNOWN;
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index 4587a4c36923..533786745e6c 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -159,6 +159,16 @@ struct ethtool_link_ksettings {
>   #define ethtool_link_ksettings_test_link_mode(ptr, name, mode)		\
>   	test_bit(ETHTOOL_LINK_MODE_ ## mode ## _BIT, (ptr)->link_modes.name)
>   
> +/**
> + * ethtool_intersect_link_masks - Given two link masks, AND them together
> + * @dst: first mask and where result is stored
> + * @src: second mask to intersect with
> + *
> + * Given two link mode masks, AND them together and save the result in dst.
> + */
> +void ethtool_intersect_link_masks(struct ethtool_link_ksettings *dst,
> +				  struct ethtool_link_ksettings *src);
> +
>   extern int
>   __ethtool_get_link_ksettings(struct net_device *dev,
>   			     struct ethtool_link_ksettings *link_ksettings);
> diff --git a/net/core/ethtool.c b/net/core/ethtool.c
> index 3228411ada0f..63ffa46fd646 100644
> --- a/net/core/ethtool.c
> +++ b/net/core/ethtool.c
> @@ -435,6 +435,22 @@ bool ethtool_convert_link_mode_to_legacy_u32(u32 *legacy_u32,
>   }
>   EXPORT_SYMBOL(ethtool_convert_link_mode_to_legacy_u32);
>   
> +/* Given two link masks, AND them together and save the result in dst. */
> +void ethtool_intersect_link_masks(struct ethtool_link_ksettings *dst,
> +				  struct ethtool_link_ksettings, *src)
> +{
> +	unsigned int size = BITS_TO_LONGS(__ETHTOOL_LINK_MODE_MASK_NBITS);
> +	unsigned int idx = 0;
> +
> +	for (; idx < size; idx++) {
> +		dst->link_modes.supported[idx] &=
> +			src->link_modes.supported[idx];
> +		dst->link_modes.advertising[idx] &=
> +			src->link_modes.advertising[idx];
> +	}
> +}
> +EXPORT_SYMBOL(ethtool_intersect_link_masks);
> +
>   /* return false if legacy contained non-0 deprecated fields
>    * transceiver/maxtxpkt/maxrxpkt. rest of ksettings always updated
>    */
> 
