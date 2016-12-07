From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Tue, 6 Dec 2016 21:02:02 -0800
Subject: [Intel-wired-lan] [PATCH] net: return value of skb_linearize
 should be handled in Linux kernel
In-Reply-To: <1481008233-16777-1-git-send-email-zhouzhouyi@gmail.com>
References: <1481008233-16777-1-git-send-email-zhouzhouyi@gmail.com>
Message-ID: <CAM_iQpX0nA10tCzfZr_q5i6V2hWqfMUkvXdfo+Ro1TWHOEVi_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Dec 5, 2016 at 11:10 PM, Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
> index 2a653ec..ab787cb 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
> @@ -490,7 +490,11 @@ int ixgbe_fcoe_ddp(struct ixgbe_adapter *adapter,
>          */
>         if ((fh->fh_r_ctl == FC_RCTL_DD_SOL_DATA) &&
>             (fctl & FC_FC_END_SEQ)) {
> -               skb_linearize(skb);
> +               int err = 0;
> +
> +               err = skb_linearize(skb);
> +               if (err)
> +                       return err;


You can reuse 'rc' instead of adding 'err'.



>                 crc = (struct fcoe_crc_eof *)skb_put(skb, sizeof(*crc));
>                 crc->fcoe_eof = FC_EOF_T;
>         }
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index fee1f29..4926d48 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -2173,8 +2173,7 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
>                                 total_rx_bytes += ddp_bytes;
>                                 total_rx_packets += DIV_ROUND_UP(ddp_bytes,
>                                                                  mss);
> -                       }
> -                       if (!ddp_bytes) {
> +                       } else {
>                                 dev_kfree_skb_any(skb);
>                                 continue;
>                         }


This piece doesn't seem to be related.
