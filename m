From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 24 Oct 2017 09:12:17 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: advertise highest capable link
	speed
In-Reply-To: <1508772169-4606-1-git-send-email-paul.greenwalt@intel.com>
References: <1508772169-4606-1-git-send-email-paul.greenwalt@intel.com>
Message-ID: <CAKgT0UesaJnFue4J7aiyzk45NCd9KxTuQ+WCZhmCR=Lbqn_65Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Oct 23, 2017 at 8:22 AM, Paul Greenwalt
<paul.greenwalt@intel.com> wrote:
> On module insert advertise highest capable link speed. If module is
> capable of 10G, then advertise 10G. If autoneg is enabled, then
> advertise modules capable link speeds. If module is capable of
> single-rate 1G, then advertise 1G.
>
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 901ab12..2bd132c 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -7648,7 +7648,8 @@ static void ixgbe_sfp_detection_subtask(struct ixgbe_adapter *adapter)
>  static void ixgbe_sfp_link_config_subtask(struct ixgbe_adapter *adapter)
>  {
>         struct ixgbe_hw *hw = &adapter->hw;
> -       u32 speed;
> +       u32 cap_speed;
> +       u32 speed = 0;
>         bool autoneg = false;
>
>         if (!(adapter->flags & IXGBE_FLAG_NEED_LINK_CONFIG))
> @@ -7660,15 +7661,16 @@ static void ixgbe_sfp_link_config_subtask(struct ixgbe_adapter *adapter)
>
>         adapter->flags &= ~IXGBE_FLAG_NEED_LINK_CONFIG;
>
> -       speed = hw->phy.autoneg_advertised;
> -       if ((!speed) && (hw->mac.ops.get_link_capabilities)) {
> -               hw->mac.ops.get_link_capabilities(hw, &speed, &autoneg);
> +       hw->mac.ops.get_link_capabilities(hw, &cap_speed, &autoneg);
>
> -               /* setup the highest link when no autoneg */
> -               if (!autoneg) {
> -                       if (speed & IXGBE_LINK_SPEED_10GB_FULL)
> -                               speed = IXGBE_LINK_SPEED_10GB_FULL;
> -               }
> +       /* advertise highest capable link speed */
> +       if (cap_speed & IXGBE_LINK_SPEED_10GB_FULL) {
> +               if (!autoneg)
> +                       speed = IXGBE_LINK_SPEED_10GB_FULL;
> +               else
> +                       speed = cap_speed;
> +       } else if (cap_speed == IXGBE_LINK_SPEED_1GB_FULL) {
> +               speed = IXGBE_LINK_SPEED_1GB_FULL;
>         }
>

It seems like you could simplify this as follows:
if (!autoneg && (cap_speed & IXGBE_LINK_SPEED_10GB_FULL))
         speed = IXGBE_LINK_SPEED_10GB_FULL;
else
         speed = cap_speed & (IXGBE_LINK_SPEED_10GB_FULL |
IXGBE_LINK_SPEED_1GB_FULL);

>         if (hw->mac.ops.setup_link)
> --
> 2.7.4
>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
