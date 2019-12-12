From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Thu, 12 Dec 2019 12:33:47 +0100
Subject: [Intel-wired-lan] [PATCH v1] igc: Add PHY power management
 control
In-Reply-To: <20191212112941.10923-1-sasha.neftin@intel.com>
References: <20191212112941.10923-1-sasha.neftin@intel.com>
Message-ID: <e2b09135-7910-2290-297f-f8e690caa214@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Sasha,


On 2019-12-12 12:29, Sasha Neftin wrote:
> PHY power management control should provide a reliable and accurate
> indication of PHY reset completion and decrease the delay time
> after a PHY reset
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_defines.h | 1 +
>  drivers/net/ethernet/intel/igc/igc_phy.c     | 9 +++++++++
>  drivers/net/ethernet/intel/igc/igc_regs.h    | 1 +
>  3 files changed, 11 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
> index 2121fc34e300..71a4b0281c03 100644
> --- a/drivers/net/ethernet/intel/igc/igc_defines.h
> +++ b/drivers/net/ethernet/intel/igc/igc_defines.h
> @@ -460,6 +460,7 @@
>  /* PHY Status Register */
>  #define MII_SR_LINK_STATUS	0x0004 /* Link Status 1 = link */
>  #define MII_SR_AUTONEG_COMPLETE	0x0020 /* Auto Neg Complete */
> +#define IGC_PHY_RST_COMP	0x0100 /* Internal PHY reset completion */
>  
>  /* PHY 1000 MII Register/Bit Definitions */
>  /* PHY Registers defined by IEEE */
> diff --git a/drivers/net/ethernet/intel/igc/igc_phy.c b/drivers/net/ethernet/intel/igc/igc_phy.c
> index f4b05af0dd2f..e19e861df719 100644
> --- a/drivers/net/ethernet/intel/igc/igc_phy.c
> +++ b/drivers/net/ethernet/intel/igc/igc_phy.c
> @@ -173,6 +173,7 @@ s32 igc_check_downshift(struct igc_hw *hw)
>  s32 igc_phy_hw_reset(struct igc_hw *hw)
>  {
>  	struct igc_phy_info *phy = &hw->phy;
> +	u32 phpm = 0, timeout = 10000;

Just use `unsigned int` for `timeout`?

phpm does not need to be initialized to 0?

>  	s32  ret_val;
>  	u32 ctrl;
>  
> @@ -186,6 +187,8 @@ s32 igc_phy_hw_reset(struct igc_hw *hw)
>  	if (ret_val)
>  		goto out;
>  
> +	phpm = rd32(IGC_I225_PHPM);
> +
>  	ctrl = rd32(IGC_CTRL);
>  	wr32(IGC_CTRL, ctrl | IGC_CTRL_PHY_RST);
>  	wrfl();
> @@ -195,6 +198,12 @@ s32 igc_phy_hw_reset(struct igc_hw *hw)
>  	wr32(IGC_CTRL, ctrl);
>  	wrfl();
>  
> +	do {
> +		phpm = rd32(IGC_I225_PHPM);
> +		timeout--;
> +		udelay(1);
> +	} while (!(phpm & IGC_PHY_RST_COMP) && timeout);

Print an error, when the timeout is reached?

> +
>  	usleep_range(1500, 2000);
>  
>  	phy->ops.release(hw);
> diff --git a/drivers/net/ethernet/intel/igc/igc_regs.h b/drivers/net/ethernet/intel/igc/igc_regs.h
> index c82111051898..164c42b39dfa 100644
> --- a/drivers/net/ethernet/intel/igc/igc_regs.h
> +++ b/drivers/net/ethernet/intel/igc/igc_regs.h
> @@ -12,6 +12,7 @@
>  #define IGC_MDIC		0x00020  /* MDI Control - RW */
>  #define IGC_MDICNFG		0x00E04  /* MDC/MDIO Configuration - RW */
>  #define IGC_CONNSW		0x00034  /* Copper/Fiber switch control - RW */
> +#define IGC_I225_PHPM		0x00E14	 /* I225 PHY Power Management */
>  
>  /* Internal Packet Buffer Size Registers */
>  #define IGC_RXPBS		0x02404  /* Rx Packet Buffer Size - RW */
> 

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 5174 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20191212/7d592b74/attachment.p7s>
