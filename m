From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 08 May 2015 18:06:57 -0700
Subject: [Intel-wired-lan] [PATCH 1/3] net: igb: add i210/i211 support
 for phy read/write
In-Reply-To: <1430417955-28252-2-git-send-email-tharvey@gateworks.com>
References: <1430417955-28252-1-git-send-email-tharvey@gateworks.com>
 <1430417955-28252-2-git-send-email-tharvey@gateworks.com>
Message-ID: <554D5DB1.2000607@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 04/30/2015 11:19 AM, Tim Harvey wrote:
> The i210/i211 uses the MDICNFG register for the phy address instead
> of the MDIC register.
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

This patch probably is not needed.  The existing functions should work 
as long as you have a separate means for updating the PHY addr which 
should only need to be updated while searching for the PHY, and since 
the PHY isn't pluggable it should probably be stored in the EEPROM.

> ---
>   drivers/net/ethernet/intel/igb/e1000_phy.c | 71 ++++++++++++++++++++++++++----
>   1 file changed, 62 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/igb/e1000_phy.c b/drivers/net/ethernet/intel/igb/e1000_phy.c
> index c1bb64d..2307ac6 100644
> --- a/drivers/net/ethernet/intel/igb/e1000_phy.c
> +++ b/drivers/net/ethernet/intel/igb/e1000_phy.c
> @@ -135,7 +135,7 @@ out:
>   s32 igb_read_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 *data)
>   {
>   	struct e1000_phy_info *phy = &hw->phy;
> -	u32 i, mdic = 0;
> +	u32 i, mdicnfg, mdic = 0;
>   	s32 ret_val = 0;
>
>   	if (offset > MAX_PHY_REG_ADDRESS) {
> @@ -148,11 +148,25 @@ s32 igb_read_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 *data)
>   	 * Control register.  The MAC will take care of interfacing with the
>   	 * PHY to retrieve the desired data.
>   	 */
> -	mdic = ((offset << E1000_MDIC_REG_SHIFT) |
> -		(phy->addr << E1000_MDIC_PHY_SHIFT) |
> -		(E1000_MDIC_OP_READ));
> +	switch (hw->mac.type) {
> +	case e1000_i210:
> +	case e1000_i211:
> +		mdicnfg = rd32(E1000_MDICNFG);
> +		mdicnfg &= ~(E1000_MDICNFG_PHY_MASK);
> +		mdicnfg |= (phy->addr << E1000_MDICNFG_PHY_SHIFT);
> +		wr32(E1000_MDICNFG, mdicnfg);
> +		mdic = ((offset << E1000_MDIC_REG_SHIFT) |
> +			(E1000_MDIC_OP_READ));
> +		break;
> +	default:
> +		mdic = ((offset << E1000_MDIC_REG_SHIFT) |
> +			(phy->addr << E1000_MDIC_PHY_SHIFT) |
> +			(E1000_MDIC_OP_READ));
> +		break;
> +	}
>
>   	wr32(E1000_MDIC, mdic);
> +	wrfl();
>
>   	/* Poll the ready bit to see if the MDI read completed
>   	 * Increasing the time out as testing showed failures with

I'm not really a fan of this section of code.  Why is it that you need 
to be able to change the phy address?  It should be something that is 
set once for the device once you have your PHY and stays that way.

> @@ -177,6 +191,18 @@ s32 igb_read_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 *data)
>   	*data = (u16) mdic;
>
>   out:
> +	switch (hw->mac.type) {
> +	/* restore MDICNFG to have phy's addr */
> +	case e1000_i210:
> +	case e1000_i211:
> +		mdicnfg = rd32(E1000_MDICNFG);
> +		mdicnfg &= ~(E1000_MDICNFG_PHY_MASK);
> +		mdicnfg |= (hw->phy.addr << E1000_MDICNFG_PHY_SHIFT);
> +		wr32(E1000_MDICNFG, mdicnfg);
> +		break;
> +	default:
> +		break;
> +	}
>   	return ret_val;
>   }
>
> @@ -191,7 +217,7 @@ out:
>   s32 igb_write_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 data)
>   {
>   	struct e1000_phy_info *phy = &hw->phy;
> -	u32 i, mdic = 0;
> +	u32 i, mdicnfg, mdic = 0;
>   	s32 ret_val = 0;
>
>   	if (offset > MAX_PHY_REG_ADDRESS) {
> @@ -204,12 +230,27 @@ s32 igb_write_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 data)
>   	 * Control register.  The MAC will take care of interfacing with the
>   	 * PHY to retrieve the desired data.
>   	 */
> -	mdic = (((u32)data) |
> -		(offset << E1000_MDIC_REG_SHIFT) |
> -		(phy->addr << E1000_MDIC_PHY_SHIFT) |
> -		(E1000_MDIC_OP_WRITE));
> +	switch (hw->mac.type) {
> +	case e1000_i210:
> +	case e1000_i211:
> +		mdicnfg = rd32(E1000_MDICNFG);
> +		mdicnfg &= ~(E1000_MDICNFG_PHY_MASK);
> +		mdicnfg |= (phy->addr << E1000_MDICNFG_PHY_SHIFT);
> +		wr32(E1000_MDICNFG, mdicnfg);
> +		mdic = (((u32)data) |
> +			(offset << E1000_MDIC_REG_SHIFT) |
> +			(E1000_MDIC_OP_WRITE));
> +		break;

You could just fall though.  The area covered by the PHY_SHIFT should be 
read/only and will not be impacted if any value is placed there.

> +	default:
> +		mdic = (((u32)data) |
> +			(offset << E1000_MDIC_REG_SHIFT) |
> +			(phy->addr << E1000_MDIC_PHY_SHIFT) |
> +			(E1000_MDIC_OP_WRITE));
> +		break;
> +	}
>
>   	wr32(E1000_MDIC, mdic);
> +	wrfl();
>
>   	/* Poll the ready bit to see if the MDI read completed
>   	 * Increasing the time out as testing showed failures with

Same thing for this one.  You shouldn't need to do anything fancy to 
write it.

> @@ -233,6 +274,18 @@ s32 igb_write_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 data)
>   	}
>
>   out:
> +	switch (hw->mac.type) {
> +	/* restore MDICNFG to have phy's addr */
> +	case e1000_i210:
> +	case e1000_i211:
> +		mdicnfg = rd32(E1000_MDICNFG);
> +		mdicnfg &= ~(E1000_MDICNFG_PHY_MASK);
> +		mdicnfg |= (hw->phy.addr << E1000_MDICNFG_PHY_SHIFT);
> +		wr32(E1000_MDICNFG, mdicnfg);
> +		break;
> +	default:
> +		break;
> +	}
>   	return ret_val;
>   }
>
>

This bit doesn't add any value.  You could definitely drop this.
