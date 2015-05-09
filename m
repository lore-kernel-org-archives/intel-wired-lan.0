From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 08 May 2015 18:07:06 -0700
Subject: [Intel-wired-lan] [PATCH 2/3] net: igb: add phy read/write
 functions that accept phy addr
In-Reply-To: <1430417955-28252-3-git-send-email-tharvey@gateworks.com>
References: <1430417955-28252-1-git-send-email-tharvey@gateworks.com>
 <1430417955-28252-3-git-send-email-tharvey@gateworks.com>
Message-ID: <554D5DBA.9070109@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 04/30/2015 11:19 AM, Tim Harvey wrote:
> Add igb_write_reg_gs40g/igb_read_reg_gs40g that can be passed a phy address.
> The existing igb_write_phy_reg_gs40g/igb_read_phy_reg_gs40g become wrappers
> to this function.
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

I'm pretty sure this isn't useful as well.  You really should not be 
doing any phy address/MDICNFG manipulation in these calls.

> ---
>   drivers/net/ethernet/intel/igb/e1000_82575.c |  4 +-
>   drivers/net/ethernet/intel/igb/e1000_phy.c   | 70 ++++++++++++++++++++--------
>   drivers/net/ethernet/intel/igb/e1000_phy.h   |  6 ++-
>   3 files changed, 56 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/igb/e1000_82575.c b/drivers/net/ethernet/intel/igb/e1000_82575.c
> index 0f69ef8..d2afd7b 100644
> --- a/drivers/net/ethernet/intel/igb/e1000_82575.c
> +++ b/drivers/net/ethernet/intel/igb/e1000_82575.c
> @@ -2129,7 +2129,7 @@ static s32 igb_read_phy_reg_82580(struct e1000_hw *hw, u32 offset, u16 *data)
>   	if (ret_val)
>   		goto out;
>   
> -	ret_val = igb_read_phy_reg_mdic(hw, offset, data);
> +	ret_val = igb_read_phy_reg_mdic(hw, hw->phy.addr, offset, data);
>   
>   	hw->phy.ops.release(hw);
>   
> @@ -2154,7 +2154,7 @@ static s32 igb_write_phy_reg_82580(struct e1000_hw *hw, u32 offset, u16 data)
>   	if (ret_val)
>   		goto out;
>   
> -	ret_val = igb_write_phy_reg_mdic(hw, offset, data);
> +	ret_val = igb_write_phy_reg_mdic(hw, hw->phy.addr, offset, data);
>   
>   	hw->phy.ops.release(hw);
>   
> diff --git a/drivers/net/ethernet/intel/igb/e1000_phy.c b/drivers/net/ethernet/intel/igb/e1000_phy.c
> index 2307ac6..66c2a09 100644
> --- a/drivers/net/ethernet/intel/igb/e1000_phy.c
> +++ b/drivers/net/ethernet/intel/igb/e1000_phy.c
> @@ -132,9 +132,8 @@ out:
>    *  Reads the MDI control regsiter in the PHY at offset and stores the
>    *  information read to data.
>    **/
> -s32 igb_read_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 *data)
> +s32 igb_read_phy_reg_mdic(struct e1000_hw *hw, u8 addr, u32 offset, u16 *data)
>   {
> -	struct e1000_phy_info *phy = &hw->phy;
>   	u32 i, mdicnfg, mdic = 0;
>   	s32 ret_val = 0;
>   
> @@ -153,14 +152,14 @@ s32 igb_read_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 *data)
>   	case e1000_i211:
>   		mdicnfg = rd32(E1000_MDICNFG);
>   		mdicnfg &= ~(E1000_MDICNFG_PHY_MASK);
> -		mdicnfg |= (phy->addr << E1000_MDICNFG_PHY_SHIFT);
> +		mdicnfg |= (addr << E1000_MDICNFG_PHY_SHIFT);
>   		wr32(E1000_MDICNFG, mdicnfg);
>   		mdic = ((offset << E1000_MDIC_REG_SHIFT) |
>   			(E1000_MDIC_OP_READ));
>   		break;
>   	default:
>   		mdic = ((offset << E1000_MDIC_REG_SHIFT) |
> -			(phy->addr << E1000_MDIC_PHY_SHIFT) |
> +			(addr << E1000_MDIC_PHY_SHIFT) |
>   			(E1000_MDIC_OP_READ));
>   		break;
>   	}
> @@ -214,9 +213,8 @@ out:
>    *
>    *  Writes data to MDI control register in the PHY at offset.
>    **/
> -s32 igb_write_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 data)
> +s32 igb_write_phy_reg_mdic(struct e1000_hw *hw, u8 addr, u32 offset, u16 data)
>   {
> -	struct e1000_phy_info *phy = &hw->phy;
>   	u32 i, mdicnfg, mdic = 0;
>   	s32 ret_val = 0;
>   
> @@ -464,7 +462,7 @@ s32 igb_read_phy_reg_igp(struct e1000_hw *hw, u32 offset, u16 *data)
>   		goto out;
>   
>   	if (offset > MAX_PHY_MULTI_PAGE_REG) {
> -		ret_val = igb_write_phy_reg_mdic(hw,
> +		ret_val = igb_write_phy_reg_mdic(hw, hw->phy.addr,
>   						 IGP01E1000_PHY_PAGE_SELECT,
>   						 (u16)offset);
>   		if (ret_val) {
> @@ -473,8 +471,8 @@ s32 igb_read_phy_reg_igp(struct e1000_hw *hw, u32 offset, u16 *data)
>   		}
>   	}
>   
> -	ret_val = igb_read_phy_reg_mdic(hw, MAX_PHY_REG_ADDRESS & offset,
> -					data);
> +	ret_val = igb_read_phy_reg_mdic(hw, hw->phy.addr,
> +					MAX_PHY_REG_ADDRESS & offset, data);
>   
>   	hw->phy.ops.release(hw);
>   
> @@ -503,7 +501,7 @@ s32 igb_write_phy_reg_igp(struct e1000_hw *hw, u32 offset, u16 data)
>   		goto out;
>   
>   	if (offset > MAX_PHY_MULTI_PAGE_REG) {
> -		ret_val = igb_write_phy_reg_mdic(hw,
> +		ret_val = igb_write_phy_reg_mdic(hw, hw->phy.addr,
>   						 IGP01E1000_PHY_PAGE_SELECT,
>   						 (u16)offset);
>   		if (ret_val) {
> @@ -512,8 +510,8 @@ s32 igb_write_phy_reg_igp(struct e1000_hw *hw, u32 offset, u16 data)
>   		}
>   	}
>   
> -	ret_val = igb_write_phy_reg_mdic(hw, MAX_PHY_REG_ADDRESS & offset,
> -					 data);
> +	ret_val = igb_write_phy_reg_mdic(hw, hw->phy.addr,
> +					 MAX_PHY_REG_ADDRESS & offset, data);
>   
>   	hw->phy.ops.release(hw);
>   
> @@ -2464,8 +2462,9 @@ out:
>   }
>   
>   /**
> - *  igb_write_phy_reg_gs40g - Write GS40G PHY register
> + *  igb_write_reg_gs40g - Write GS40G PHY register
>    *  @hw: pointer to the HW structure
> + *  @addr: phy address to write to
>    *  @offset: lower half is register offset to write to
>    *     upper half is page to use.
>    *  @data: data to write at register offset
> @@ -2473,7 +2472,7 @@ out:
>    *  Acquires semaphore, if necessary, then writes the data to PHY register
>    *  at the offset.  Release any acquired semaphores before exiting.
>    **/
> -s32 igb_write_phy_reg_gs40g(struct e1000_hw *hw, u32 offset, u16 data)
> +s32 igb_write_reg_gs40g(struct e1000_hw *hw, u8 addr, u32 offset, u16 data)
>   {
>   	s32 ret_val;
>   	u16 page = offset >> GS40G_PAGE_SHIFT;
> @@ -2483,10 +2482,10 @@ s32 igb_write_phy_reg_gs40g(struct e1000_hw *hw, u32 offset, u16 data)
>   	if (ret_val)
>   		return ret_val;
>   
> -	ret_val = igb_write_phy_reg_mdic(hw, GS40G_PAGE_SELECT, page);
> +	ret_val = igb_write_phy_reg_mdic(hw, addr, GS40G_PAGE_SELECT, page);
>   	if (ret_val)
>   		goto release;
> -	ret_val = igb_write_phy_reg_mdic(hw, offset, data);
> +	ret_val = igb_write_phy_reg_mdic(hw, addr, offset, data);
>   
>   release:
>   	hw->phy.ops.release(hw);
> @@ -2494,8 +2493,24 @@ release:
>   }
>   
>   /**
> - *  igb_read_phy_reg_gs40g - Read GS40G  PHY register
> + *  igb_write_phy_reg_gs40g - Write GS40G PHY register
> + *  @hw: pointer to the HW structure
> + *  @offset: lower half is register offset to write to
> + *     upper half is page to use.
> + *  @data: data to write at register offset
> + *
> + *  Acquires semaphore, if necessary, then writes the data to PHY register
> + *  at the offset.  Release any acquired semaphores before exiting.
> + **/
> +s32 igb_write_phy_reg_gs40g(struct e1000_hw *hw, u32 offset, u16 data)
> +{
> +	return igb_write_reg_gs40g(hw, hw->phy.addr, offset, data);
> +}
> +
> +/**
> + *  igb_read_reg_gs40g - Read GS40G  PHY register
>    *  @hw: pointer to the HW structure
> + *  @addr: phy address to read from
>    *  @offset: lower half is register offset to read to
>    *     upper half is page to use.
>    *  @data: data to read at register offset
> @@ -2503,7 +2518,7 @@ release:
>    *  Acquires semaphore, if necessary, then reads the data in the PHY register
>    *  at the offset.  Release any acquired semaphores before exiting.
>    **/
> -s32 igb_read_phy_reg_gs40g(struct e1000_hw *hw, u32 offset, u16 *data)
> +s32 igb_read_reg_gs40g(struct e1000_hw *hw, u8 addr, u32 offset, u16 *data)
>   {
>   	s32 ret_val;
>   	u16 page = offset >> GS40G_PAGE_SHIFT;
> @@ -2513,10 +2528,10 @@ s32 igb_read_phy_reg_gs40g(struct e1000_hw *hw, u32 offset, u16 *data)
>   	if (ret_val)
>   		return ret_val;
>   
> -	ret_val = igb_write_phy_reg_mdic(hw, GS40G_PAGE_SELECT, page);
> +	ret_val = igb_write_phy_reg_mdic(hw, addr, GS40G_PAGE_SELECT, page);
>   	if (ret_val)
>   		goto release;
> -	ret_val = igb_read_phy_reg_mdic(hw, offset, data);
> +	ret_val = igb_read_phy_reg_mdic(hw, addr, offset, data);
>   
>   release:
>   	hw->phy.ops.release(hw);
> @@ -2524,6 +2539,21 @@ release:
>   }
>   
>   /**
> + *  igb_read_phy_reg_gs40g - Read GS40G  PHY register
> + *  @hw: pointer to the HW structure
> + *  @offset: lower half is register offset to read to
> + *     upper half is page to use.
> + *  @data: data to read at register offset
> + *
> + *  Acquires semaphore, if necessary, then reads the data in the PHY register
> + *  at the offset.  Release any acquired semaphores before exiting.
> + **/
> +s32 igb_read_phy_reg_gs40g(struct e1000_hw *hw, u32 offset, u16 *data)
> +{
> +	return igb_read_reg_gs40g(hw, hw->phy.addr, offset, data);
> +}
> +
> +/**
>    *  igb_set_master_slave_mode - Setup PHY for Master/slave mode
>    *  @hw: pointer to the HW structure
>    *
> diff --git a/drivers/net/ethernet/intel/igb/e1000_phy.h b/drivers/net/ethernet/intel/igb/e1000_phy.h
> index 7af4ffa..6256e76 100644
> --- a/drivers/net/ethernet/intel/igb/e1000_phy.h
> +++ b/drivers/net/ethernet/intel/igb/e1000_phy.h
> @@ -61,8 +61,8 @@ s32  igb_phy_has_link(struct e1000_hw *hw, u32 iterations,
>   void igb_power_up_phy_copper(struct e1000_hw *hw);
>   void igb_power_down_phy_copper(struct e1000_hw *hw);
>   s32  igb_phy_init_script_igp3(struct e1000_hw *hw);
> -s32  igb_read_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 *data);
> -s32  igb_write_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 data);
> +s32  igb_read_phy_reg_mdic(struct e1000_hw *hw, u8 addr, u32 offset, u16 *data);
> +s32  igb_write_phy_reg_mdic(struct e1000_hw *hw, u8 addr, u32 offset, u16 data);
>   s32  igb_read_phy_reg_i2c(struct e1000_hw *hw, u32 offset, u16 *data);
>   s32  igb_write_phy_reg_i2c(struct e1000_hw *hw, u32 offset, u16 data);
>   s32  igb_read_sfp_data_byte(struct e1000_hw *hw, u16 offset, u8 *data);
> @@ -72,6 +72,8 @@ s32  igb_phy_force_speed_duplex_82580(struct e1000_hw *hw);
>   s32  igb_get_cable_length_82580(struct e1000_hw *hw);
>   s32  igb_read_phy_reg_gs40g(struct e1000_hw *hw, u32 offset, u16 *data);
>   s32  igb_write_phy_reg_gs40g(struct e1000_hw *hw, u32 offset, u16 data);
> +s32  igb_read_reg_gs40g(struct e1000_hw *hw, u8 addr, u32 offset, u16 *data);
> +s32  igb_write_reg_gs40g(struct e1000_hw *hw, u8 addr, u32 offset, u16 data);
>   s32  igb_check_polarity_m88(struct e1000_hw *hw);
>   
>   /* IGP01E1000 Specific Registers */

