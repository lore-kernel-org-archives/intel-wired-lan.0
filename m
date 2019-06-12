From: Guilherme Piccoli <gpiccoli@canonical.com>
Date: Wed, 12 Jun 2019 12:38:49 -0300
Subject: [Intel-wired-lan] [PATCH] ixgbevf: add control of skipping PF
 link-status check
In-Reply-To: <B6CB929FEBC10D4FAC4BCA7EF2298E259DD2F265@FMSMSX110.amr.corp.intel.com>
References: <B6CB929FEBC10D4FAC4BCA7EF2298E259DD2F265@FMSMSX110.amr.corp.intel.com>
Message-ID: <CAHD1Q_zp_F0CMp-Z72R774-tPm3Vs+96m5DvKtmZbCTz6wAVjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

CCing Jay Vosburgh

Also, I cannot see the patch in the Intel Wired-Lan mailing-list; not
sure if you're subscribed there Larry,
perhaps the email needs moderation, I don't know.

Thanks,


Guilherme

On Tue, Jun 11, 2019 at 9:55 PM Wang, Liang-min
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
>
>
>
>
