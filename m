From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 26 Jan 2018 09:03:00 -0800
Subject: [Intel-wired-lan] [PATCH 2/3] Revert "e1000e: Separate
 signaling for link check/link up"
In-Reply-To: <20180126091236.13044-3-bpoirier@suse.com>
References: <20180126091236.13044-1-bpoirier@suse.com>
 <20180126091236.13044-3-bpoirier@suse.com>
Message-ID: <CAKgT0UegBcVf5vzc7Vq4E1RpeeR7gqCAD=1+wn1Yq_tL48+LaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Jan 26, 2018 at 1:12 AM, Benjamin Poirier <bpoirier@suse.com> wrote:
> This reverts commit 19110cfbb34d4af0cdfe14cd243f3b09dc95b013.
> This reverts commit 4110e02eb45ea447ec6f5459c9934de0a273fb91.
>
> ... because they cause an extra 2s delay for the link to come up when
> autoneg is off.
>
> After reverting, the race condition described in the log of commit
> 19110cfbb34d ("e1000e: Separate signaling for link check/link up") is
> reintroduced. It may still be triggered by LSC events but this should not
> result in link flap. It may no longer be triggered by RXO events because
> commit 4aea7a5c5e94 ("e1000e: Avoid receiver overrun interrupt bursts")
> restored reading icr in the Other handler.

With the RXO events removed the only cause for us to transition the
bit should be LSC. I'm not sure if the race condition in that state is
a valid concern or not as the LSC should only get triggered if the
link state toggled, even briefly.

The bigger concern I would have would be the opposite of the original
race that was pointed out:
    \ e1000_watchdog_task
        \ e1000e_has_link
            \ hw->mac.ops.check_for_link() === e1000e_check_for_copper_link
                /* link is up */
                mac->get_link_status = false;

                                /* interrupt */
                                \ e1000_msix_other
                                    hw->mac.get_link_status = true;

            link_active = !hw->mac.get_link_status
            /* link_active is false, wrongly */

So the question I would have is what if we see the LSC for a link down
just after the check_for_copper_link call completes? It may not be
anything seen in the real world since I don't know if we have any link
flapping issues on e1000e or not without this patch. It is something
to keep in mind for the future though.


> As discussed, the driver should be in "maintenance mode". In the interest
> of stability, revert to the original code as much as possible instead of a
> half-baked solution.

If nothing else we may want to do a follow-up on this patch as we
probably shouldn't be returning the error values to trigger link up.
There are definitely issues to be found here. If nothing else we may
want to explore just returning 1 if auto-neg is disabled instead of
returning an error code.

> Link: https://www.spinics.net/lists/netdev/msg479923.html
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
> ---
>  drivers/net/ethernet/intel/e1000e/ich8lan.c | 11 +++--------
>  drivers/net/ethernet/intel/e1000e/mac.c     | 11 +++--------
>  drivers/net/ethernet/intel/e1000e/netdev.c  |  2 +-
>  3 files changed, 7 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> index 31277d3bb7dc..d6d4ed7acf03 100644
> --- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
> +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> @@ -1367,9 +1367,6 @@ static s32 e1000_disable_ulp_lpt_lp(struct e1000_hw *hw, bool force)
>   *  Checks to see of the link status of the hardware has changed.  If a
>   *  change in link status has been detected, then we read the PHY registers
>   *  to get the current speed/duplex if link exists.
> - *
> - *  Returns a negative error code (-E1000_ERR_*) or 0 (link down) or 1 (link
> - *  up).
>   **/
>  static s32 e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
>  {
> @@ -1385,7 +1382,7 @@ static s32 e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
>          * Change or Rx Sequence Error interrupt.
>          */
>         if (!mac->get_link_status)
> -               return 1;
> +               return 0;
>
>         /* First we want to see if the MII Status Register reports
>          * link.  If so, then we want to get the current speed/duplex
> @@ -1616,12 +1613,10 @@ static s32 e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
>          * different link partner.
>          */
>         ret_val = e1000e_config_fc_after_link_up(hw);
> -       if (ret_val) {
> +       if (ret_val)
>                 e_dbg("Error configuring flow control\n");
> -               return ret_val;
> -       }
>
> -       return 1;
> +       return ret_val;
>  }
>
>  static s32 e1000_get_variants_ich8lan(struct e1000_adapter *adapter)
> diff --git a/drivers/net/ethernet/intel/e1000e/mac.c b/drivers/net/ethernet/intel/e1000e/mac.c
> index f457c5703d0c..b322011ec282 100644
> --- a/drivers/net/ethernet/intel/e1000e/mac.c
> +++ b/drivers/net/ethernet/intel/e1000e/mac.c
> @@ -410,9 +410,6 @@ void e1000e_clear_hw_cntrs_base(struct e1000_hw *hw)
>   *  Checks to see of the link status of the hardware has changed.  If a
>   *  change in link status has been detected, then we read the PHY registers
>   *  to get the current speed/duplex if link exists.
> - *
> - *  Returns a negative error code (-E1000_ERR_*) or 0 (link down) or 1 (link
> - *  up).
>   **/
>  s32 e1000e_check_for_copper_link(struct e1000_hw *hw)
>  {
> @@ -426,7 +423,7 @@ s32 e1000e_check_for_copper_link(struct e1000_hw *hw)
>          * Change or Rx Sequence Error interrupt.
>          */
>         if (!mac->get_link_status)
> -               return 1;
> +               return 0;
>
>         /* First we want to see if the MII Status Register reports
>          * link.  If so, then we want to get the current speed/duplex
> @@ -464,12 +461,10 @@ s32 e1000e_check_for_copper_link(struct e1000_hw *hw)
>          * different link partner.
>          */
>         ret_val = e1000e_config_fc_after_link_up(hw);
> -       if (ret_val) {
> +       if (ret_val)
>                 e_dbg("Error configuring flow control\n");
> -               return ret_val;
> -       }
>
> -       return 1;
> +       return ret_val;
>  }
>
>  /**
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 398e940436f8..ed103b9a8d3a 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -5091,7 +5091,7 @@ static bool e1000e_has_link(struct e1000_adapter *adapter)
>         case e1000_media_type_copper:
>                 if (hw->mac.get_link_status) {
>                         ret_val = hw->mac.ops.check_for_link(hw);
> -                       link_active = ret_val > 0;
> +                       link_active = !hw->mac.get_link_status;
>                 } else {
>                         link_active = true;
>                 }
> --
> 2.15.1
>
