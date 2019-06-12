From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 12 Jun 2019 11:21:14 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbevf: add control of skipping PF
 link-status check
In-Reply-To: <B6CB929FEBC10D4FAC4BCA7EF2298E259DD2F265@FMSMSX110.amr.corp.intel.com>
References: <B6CB929FEBC10D4FAC4BCA7EF2298E259DD2F265@FMSMSX110.amr.corp.intel.com>
Message-ID: <CAKgT0UdRcMr6Lsm4cf3rGUt9a2SutU=VGO3miAOKiYbikQsL7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Jun 12, 2019 at 9:28 AM Wang, Liang-min
<liang-min.wang@intel.com> wrote:
>
> ixgbevf: add control of skipping PF link-status check
>
>
>
> The ixgbevf link status check always triggers an interrupt on Physical Function (PF) driver because
>
> it uses mailbox read to check PF link-status. For any Virtual Network Function (VNF) implementation
>
> where periodical link-status check is needed, this interrupt per request becomes a significant
>
> performance overhead. Therefore, this change uses the input parameter, autoneg_wait_to_complete, to
>
> conditionally skip the PF link-status check. For scenarios where only quick Virtual Function (VF)
>
> link status check is required, application could skip the PF interrupt by setting autoneg_wait_to_complete
>
> to "0". For cases where deep link status check (include both PF and VF link status check) is required,
>
> the application can set the autoneg_wait_to_complete to "1".
>
>
>
> Signed-off-by: Liang-Min Wang<liang-min.wang@intel.com>
>
> Reviewed-by: Jeffrey T Kirsher<jeffrey.t.kirsher@intel.com>
>
> ---
>
> drivers/net/ethernet/intel/ixgbevf/vf.c | 10 ++++++++++
>
> 1 file changed, 10 insertions(+)
>
>
>
> diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.c b/drivers/net/ethernet/intel/ixgbevf/vf.c
>
> index d5ce496..951d8aa 100644
>
> --- a/drivers/net/ethernet/intel/ixgbevf/vf.c
>
> +++ b/drivers/net/ethernet/intel/ixgbevf/vf.c
>
> @@ -694,8 +694,18 @@ static s32 ixgbevf_check_mac_link_vf(struct ixgbe_hw *hw,
>
>       case IXGBE_LINKS_SPEED_100_82599:
>
>              *speed = IXGBE_LINK_SPEED_100_FULL;
>
>              break;
>
> +      default:
>
> +             *speed = IXGBE_LINK_SPEED_UNKNOWN;
>
>       }
>
> +      if (!autoneg_wait_to_complete) {
>
> +             if (*speed == IXGBE_LINK_SPEED_UNKNOWN)
>
> +                    mac->get_link_status = true;
>
> +             else
>
> +                    mac->get_link_status = false;
>
> +
>
> +             goto out;
>
> +      }
>
>       /* if the read failed it could just be a mailbox collision, best wait
>
>        * until we are called again and don't report an error
>
>        */
>
> --
>
> 2.4.11

NAK.

This seems completely wrong to me. I am pretty sure it will result in
false link up messages and result in the VF reporting Tx hangs under
several possible circumstances.

The only thing that should trigger a link status check request is
ether resetting the interface, or if a mailbox message comes in. In
either case we should be reading the mailbox anyway since we have to
wait for the PF to say it is okay for us to proceed.

I think a better fix would be to look at removing the lines that are
setting get_link_status and calling check link from
ixgbevf_get_link_ksettings if that is the issue. It doesn't make any
sense to be calling down into the PF to get the status in that case.
It should already be stored in the adapter struct in adapter->link_up
and adapter->link_speed.

- Alex
