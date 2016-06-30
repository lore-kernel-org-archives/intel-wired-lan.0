From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 30 Jun 2016 11:17:46 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbevf: Correct parameter sent to
	LED function
In-Reply-To: <1466197813-17401-1-git-send-email-donald.c.skidmore@intel.com>
References: <1466197813-17401-1-git-send-email-donald.c.skidmore@intel.com>
Message-ID: <CAKgT0Ufy4Rqz0yi2cZWAaOik_6pQZiUnWKczV2bm9ba0s=_oLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Jun 17, 2016 at 2:10 PM, Donald C Skidmore
<donald.c.skidmore@intel.com> wrote:
> The second parameter of these functions is the index to the led we
> are interested in affecting.  However we were mistakingly passing
> the offset in the register.  This patch corrects that and adds some
> bonds checking which would hopefully make bugs like this more noticeable
> in the future.
>
> Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_common.c  | 12 ++++++++++++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |  4 ++--
>  2 files changed, 14 insertions(+), 2 deletions(-)

So the patch description says ixgbevf, but this looks like it is an
ixgbe patch.  You might want to get the title updated.

- Alex

> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
> index f8defc7..ce881a7 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
> @@ -763,6 +763,9 @@ s32 ixgbe_led_on_generic(struct ixgbe_hw *hw, u32 index)
>  {
>         u32 led_reg = IXGBE_READ_REG(hw, IXGBE_LEDCTL);
>
> +       if (index > 3)
> +               return IXGBE_ERR_PARAM;
> +
>         /* To turn on the LED, set mode to ON. */
>         led_reg &= ~IXGBE_LED_MODE_MASK(index);
>         led_reg |= IXGBE_LED_ON << IXGBE_LED_MODE_SHIFT(index);
> @@ -781,6 +784,9 @@ s32 ixgbe_led_off_generic(struct ixgbe_hw *hw, u32 index)
>  {
>         u32 led_reg = IXGBE_READ_REG(hw, IXGBE_LEDCTL);
>
> +       if (index > 3)
> +               return IXGBE_ERR_PARAM;
> +
>         /* To turn off the LED, set mode to OFF. */
>         led_reg &= ~IXGBE_LED_MODE_MASK(index);
>         led_reg |= IXGBE_LED_OFF << IXGBE_LED_MODE_SHIFT(index);
> @@ -2698,6 +2704,9 @@ s32 ixgbe_blink_led_start_generic(struct ixgbe_hw *hw, u32 index)
>         bool locked = false;
>         s32 ret_val;
>
> +       if (index > 3)
> +               return IXGBE_ERR_PARAM;
> +
>         /*
>          * Link must be up to auto-blink the LEDs;
>          * Force it if link is down.
> @@ -2741,6 +2750,9 @@ s32 ixgbe_blink_led_stop_generic(struct ixgbe_hw *hw, u32 index)
>         bool locked = false;
>         s32 ret_val;
>
> +       if (index > 3)
> +               return IXGBE_ERR_PARAM;
> +
>         ret_val = hw->mac.ops.prot_autoc_read(hw, &locked, &autoc_reg);
>         if (ret_val)
>                 return ret_val;
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> index 716e643..9547191 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> @@ -2206,11 +2206,11 @@ static int ixgbe_set_phys_id(struct net_device *netdev,
>                 return 2;
>
>         case ETHTOOL_ID_ON:
> -               hw->mac.ops.led_on(hw, IXGBE_LED_ON);
> +               hw->mac.ops.led_on(hw, hw->bus.func);
>                 break;
>
>         case ETHTOOL_ID_OFF:
> -               hw->mac.ops.led_off(hw, IXGBE_LED_ON);
> +               hw->mac.ops.led_off(hw, hw->bus.func);
>                 break;
>
>         case ETHTOOL_ID_INACTIVE:
> --
> 2.4.3
>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
