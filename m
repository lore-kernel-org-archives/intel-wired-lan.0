From: Florian Fainelli <f.fainelli@gmail.com>
Date: Mon, 2 Nov 2020 17:15:41 -0800
Subject: [Intel-wired-lan] [PATCH 1/2] ethernet: igb: Support PHY
 BCM5461S
In-Reply-To: <20201102231307.13021-2-pmenzel@molgen.mpg.de>
References: <20201102231307.13021-1-pmenzel@molgen.mpg.de>
 <20201102231307.13021-2-pmenzel@molgen.mpg.de>
Message-ID: <cdcaf9fa-4983-934f-0d9c-09588fe07901@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 11/2/2020 3:13 PM, Paul Menzel wrote:
> From: Jeffrey Townsend <jeffrey.townsend@bigswitch.com>
> 
> The BCM5461S PHY is used in switches.
> 
> The patch is taken from Open Network Linux, and it was added there as
> patch
> 
>     packages/base/any/kernels/3.16+deb8/patches/driver-support-intel-igb-bcm5461X-phy.patch
> 
> in ONL commit f32316c63c (Support the BCM54616 and BCM5461S.) [1]. Part
> of this commit was already upstreamed in Linux commit eeb0149660 (igb:
> support BCM54616 PHY) in 2017.
> 
> I applied the forward-ported
> 
>     packages/base/any/kernels/5.4-lts/patches/0002-driver-support-intel-igb-bcm5461S-phy.patch
> 
> added in ONL commit 5ace6bcdb3 (Add 5.4 LTS kernel build.) [2].
> 
> [1]: https://github.com/opencomputeproject/OpenNetworkLinux/commit/f32316c63ce3a64de125b7429115c6d45e942bd1
> [2]: https://github.com/opencomputeproject/OpenNetworkLinux/commit/5ace6bcdb37cb8065dcd1d4404b3dcb6424f6331
> 
> Cc: Jeffrey Townsend <jeffrey.townsend@bigswitch.com>
> Cc: John W Linville <linville@tuxdriver.com>
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---

[snip]

> +
> +/**
> + *  igb_phy_init_script_5461s - Inits the BCM5461S PHY
> + *  @hw: pointer to the HW structure
> + *
> + *  Initializes a Broadcom Gigabit PHY.
> + **/
> +s32 igb_phy_init_script_5461s(struct e1000_hw *hw)
> +{
> +	u16 mii_reg_led = 0;
> +
> +	/* 1. Speed LED (Set the Link LED mode), Shadow 00010, 0x1C.bit2=1 */
> +	hw->phy.ops.write_reg(hw, 0x1C, 0x0800);
> +	hw->phy.ops.read_reg(hw, 0x1C, &mii_reg_led);
> +	mii_reg_led |= 0x0004;
> +	hw->phy.ops.write_reg(hw, 0x1C, mii_reg_led | 0x8000);
> +
> +	/* 2. Active LED (Set the Link LED mode), Shadow 01001, 0x1C.bit4=1, 0x10.bit5=0 */
> +	hw->phy.ops.write_reg(hw, 0x1C, 0x2400);
> +	hw->phy.ops.read_reg(hw, 0x1C, &mii_reg_led);
> +	mii_reg_led |= 0x0010;
> +	hw->phy.ops.write_reg(hw, 0x1C, mii_reg_led | 0x8000);
> +	hw->phy.ops.read_reg(hw, 0x10, &mii_reg_led);
> +	mii_reg_led &= 0xffdf;
> +	hw->phy.ops.write_reg(hw, 0x10, mii_reg_led);

Please try at least to re-use the definitions from
include/linux/brcmphy.h and add new ones where appropriate.

It is already painful enough to see that Intel does not use the PHY
library, there is no need to add insult to the injury by open coding all
of these register addresses and values.

Thanks
-- 
Florian
