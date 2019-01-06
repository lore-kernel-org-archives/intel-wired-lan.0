From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Sun, 6 Jan 2019 17:28:42 +0200
Subject: [Intel-wired-lan] [PATCH 2/3] e1000e: ignore status during
 auto-negotiation
In-Reply-To: <1546608667-25498-3-git-send-email-glogow@fbihome.de>
References: <e080046a-6630-ad07-ebbb-603e820766f4@fbihome.de>
 <1546608667-25498-1-git-send-email-glogow@fbihome.de>
 <1546608667-25498-3-git-send-email-glogow@fbihome.de>
Message-ID: <67d195a8-0b04-ee72-71fb-f194c009107e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 1/4/2019 15:31, Jan-Marek Glogowski wrote:
> My problem is the fallback of the hardware to 10 Mbps after a
> re-connect, which happens almost all times. In the broken case
> the status field has always the 0x40000000 bit set.
> 
> Still the naming for the status flag is just a guess. Ignoring
> the status, when this bit is set, solves my problem. But I just
> have one notebook hardware (I219-LM, rev 21), which exhibits the
> problem. It doesn't happen for my other notebook with I219-V
> (rev 21) hardware (or it's just much more unlikely).
> 
> Signed-off-by: Jan-Marek Glogowski <glogow@fbihome.de>
> ---
>   drivers/net/ethernet/intel/e1000e/defines.h | 1 +
>   drivers/net/ethernet/intel/e1000e/ich8lan.c | 3 ++-
>   drivers/net/ethernet/intel/e1000e/mac.c     | 2 ++
>   3 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/defines.h b/drivers/net/ethernet/intel/e1000e/defines.h
> index fd550de..3cd9f99 100644
> --- a/drivers/net/ethernet/intel/e1000e/defines.h
> +++ b/drivers/net/ethernet/intel/e1000e/defines.h
> @@ -221,6 +221,7 @@
>   #define E1000_STATUS_LAN_INIT_DONE 0x00000200   /* Lan Init Completion by NVM */
>   #define E1000_STATUS_PHYRA      0x00000400      /* PHY Reset Asserted */
>   #define E1000_STATUS_GIO_MASTER_ENABLE	0x00080000	/* Master Req status */
> +#define E1000_STATUS_AUTONEG    0x40000000      /* in auto-negotiation */
>   
There is no such indication. Should be removed.
>   #define HALF_DUPLEX 1
>   #define FULL_DUPLEX 2
> diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> index fd59970..8588eb7 100644
> --- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
> +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> @@ -1390,7 +1390,8 @@ static s32 e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
>   		u16 speed;
>   		u8 duplex;
>   
> -		e1000e_get_speed_and_duplex_copper(hw, &speed, &duplex);
> +		if (e1000e_get_speed_and_duplex_copper(hw, &speed, &duplex))
> +			goto out;
>   		tipg_reg = er32(TIPG);
>   		tipg_reg &= ~E1000_TIPG_IPGT_MASK;
>   
> diff --git a/drivers/net/ethernet/intel/e1000e/mac.c b/drivers/net/ethernet/intel/e1000e/mac.c
> index 19c816c..ada8fbb 100644
> --- a/drivers/net/ethernet/intel/e1000e/mac.c
> +++ b/drivers/net/ethernet/intel/e1000e/mac.c
> @@ -1310,6 +1310,8 @@ s32 e1000e_get_speed_and_duplex_copper(struct e1000_hw *hw, u16 *speed,
>   
>   	status = er32(STATUS);
>   
> +	if (status & E1000_STATUS_AUTONEG)
> +		return 1;
This is wrong. We have no AUTONEG indication in bit 30 of E1000_STATUS 
(0x0008) register. These code piece should be removed.
>   	if (!(status & E1000_STATUS_LU))
>   		return 1;
>   
> 
Hello Jan-Marek,
That's okay to use u8 size for a duplex indication and u16 size for a 
link indication, as you refer in previous patch. But use the 'autoneg 
status' is wrong. I wonder how this can solve the problem. Do you 
encountered with this problem on other platforms with our devices? (I 
meant different, no similar HW)
Anyway, 0x40000000 indication is not relevant to the auto-negotiation.
May I ask do your experiments with ME disable (via BIOS) and see if same 
problem still happen.
Thanks,
Sasha
