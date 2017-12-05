From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 5 Dec 2017 12:11:59 -0800
Subject: [Intel-wired-lan] [next-queue 10/10] ixgbe: register ipsec
 offload with the xfrm subsystem
In-Reply-To: <1512452116-14795-11-git-send-email-shannon.nelson@oracle.com>
References: <1512452116-14795-1-git-send-email-shannon.nelson@oracle.com>
 <1512452116-14795-11-git-send-email-shannon.nelson@oracle.com>
Message-ID: <CAKgT0Ue_PxNbqJL-7PprJ5V9M6gCd1ObJk+EXtJpwAJz-N+eew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Dec 4, 2017 at 9:35 PM, Shannon Nelson
<shannon.nelson@oracle.com> wrote:
> With all the support code in place we can now link in the ipsec
> offload operations and set the ESP feature flag for the XFRM
> subsystem to see.
>
> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 4 ++++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  | 4 ++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> index d1220bf..0d5497b 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> @@ -884,6 +884,10 @@ void ixgbe_init_ipsec_offload(struct ixgbe_adapter *adapter)
>         ixgbe_ipsec_clear_hw_tables(adapter);
>         ixgbe_ipsec_stop_engine(adapter);
>
> +       adapter->netdev->xfrmdev_ops = &ixgbe_xfrmdev_ops;
> +       adapter->netdev->features |= NETIF_F_HW_ESP;
> +       adapter->netdev->hw_enc_features |= NETIF_F_HW_ESP;
> +
>         return;
>  err:
>         if (ipsec) {
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index c857594..9231351 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -9799,6 +9799,10 @@ ixgbe_features_check(struct sk_buff *skb, struct net_device *dev,
>         if (skb->encapsulation && !(features & NETIF_F_TSO_MANGLEID))
>                 features &= ~NETIF_F_TSO;
>
> +       /* IPsec offload doesn't get along well with others *yet* */
> +       if (skb->sp)
> +               features &= ~(NETIF_F_TSO | NETIF_F_HW_CSUM_BIT);

I'm pretty sure the feature flag stripping here isn't correct. The
feature bits you want to strip would probably be consistent with the
network_hdr_len check bits included before the MANGLEID check.

We should do some digging into this as it may be a kernel issue. I'm
just wondering if ipsec updates any headers such as the transport
offset or skb checksum start. If either of those are updated that
would explain the issues with getting the offloads to work.

> +
>         return features;
>  }
>
> --
> 2.7.4
>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
