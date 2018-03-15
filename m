From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 15 Mar 2018 15:03:24 -0700
Subject: [Intel-wired-lan] [next-queue 4/4] ixgbe: enable tso with ipsec
 offload
In-Reply-To: <1521149003-1433-5-git-send-email-shannon.nelson@oracle.com>
References: <1521149003-1433-1-git-send-email-shannon.nelson@oracle.com>
 <1521149003-1433-5-git-send-email-shannon.nelson@oracle.com>
Message-ID: <CAKgT0UerqNMjbcjcsfY7ETnR=yoZ4YfhL=jh0RfOqoAiX6JD=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Mar 15, 2018 at 2:23 PM, Shannon Nelson
<shannon.nelson@oracle.com> wrote:
> Fix things up to support TSO offload in conjunction
> with IPsec hw offload.  This raises throughput with
> IPsec offload on to nearly line rate.
>
> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c |  7 +++++--
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  | 25 +++++++++++++++++++------
>  2 files changed, 24 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> index 5ddea43..bfbcfc2 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> @@ -896,6 +896,7 @@ void ixgbe_ipsec_rx(struct ixgbe_ring *rx_ring,
>  void ixgbe_init_ipsec_offload(struct ixgbe_adapter *adapter)
>  {
>         struct ixgbe_ipsec *ipsec;
> +       netdev_features_t features;
>         size_t size;
>
>         if (adapter->hw.mac.type == ixgbe_mac_82598EB)
> @@ -929,8 +930,10 @@ void ixgbe_init_ipsec_offload(struct ixgbe_adapter *adapter)
>         ixgbe_ipsec_clear_hw_tables(adapter);
>
>         adapter->netdev->xfrmdev_ops = &ixgbe_xfrmdev_ops;
> -       adapter->netdev->features |= NETIF_F_HW_ESP;
> -       adapter->netdev->hw_enc_features |= NETIF_F_HW_ESP;
> +
> +       features = NETIF_F_HW_ESP | NETIF_F_HW_ESP_TX_CSUM | NETIF_F_GSO_ESP;
> +       adapter->netdev->features |= features;
> +       adapter->netdev->hw_enc_features |= features;

Instead of adding the local variable you might just create a new
define that includes these 3 feature flags and then use that here. You
could use the way I did IXGBE_GSO_PARTIAL_FEATURES as an example.

>         return;
>
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index a54f3d8..6022666 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -7721,9 +7721,11 @@ static void ixgbe_service_task(struct work_struct *work)
>
>  static int ixgbe_tso(struct ixgbe_ring *tx_ring,
>                      struct ixgbe_tx_buffer *first,
> -                    u8 *hdr_len)
> +                    u8 *hdr_len,
> +                    struct ixgbe_ipsec_tx_data *itd)
>  {
>         u32 vlan_macip_lens, type_tucmd, mss_l4len_idx;
> +       u32 fceof_saidx = 0;
>         struct sk_buff *skb = first->skb;

Reverse xmas tree this. It should probably be moved down to just past
the declaration of paylen and l4_offset.

>         union {
>                 struct iphdr *v4;
> @@ -7762,9 +7764,13 @@ static int ixgbe_tso(struct ixgbe_ring *tx_ring,
>                 unsigned char *trans_start = ip.hdr + (ip.v4->ihl * 4);
>
>                 /* IP header will have to cancel out any data that
> -                * is not a part of the outer IP header
> +                * is not a part of the outer IP header, except for
> +                * IPsec where we want the IP+ESP header.
>                  */
> -               ip.v4->check = csum_fold(csum_partial(trans_start,
> +               if (first->tx_flags & IXGBE_TX_FLAGS_IPSEC)
> +                       ip.v4->check = 0;
> +               else
> +                       ip.v4->check = csum_fold(csum_partial(trans_start,
>                                                       csum_start - trans_start,
>                                                       0));
>                 type_tucmd |= IXGBE_ADVTXD_TUCMD_IPV4;

I would say this should be flipped like so:
ip.v4->check =  (skb_shinfo(skb)->gso_type & SKB_GSO_PARTIAL) ?
                         csum_fold(csum_partial(trans_start,
csum_start - trans_start, 0) : 0;

> @@ -7797,12 +7803,15 @@ static int ixgbe_tso(struct ixgbe_ring *tx_ring,
>         mss_l4len_idx = (*hdr_len - l4_offset) << IXGBE_ADVTXD_L4LEN_SHIFT;
>         mss_l4len_idx |= skb_shinfo(skb)->gso_size << IXGBE_ADVTXD_MSS_SHIFT;
>
> +       fceof_saidx |= itd->sa_idx;
> +       type_tucmd |= itd->flags | itd->trailer_len;
> +
>         /* vlan_macip_lens: HEADLEN, MACLEN, VLAN tag */
>         vlan_macip_lens = l4.hdr - ip.hdr;
>         vlan_macip_lens |= (ip.hdr - skb->data) << IXGBE_ADVTXD_MACLEN_SHIFT;
>         vlan_macip_lens |= first->tx_flags & IXGBE_TX_FLAGS_VLAN_MASK;
>
> -       ixgbe_tx_ctxtdesc(tx_ring, vlan_macip_lens, 0, type_tucmd,
> +       ixgbe_tx_ctxtdesc(tx_ring, vlan_macip_lens, fceof_saidx, type_tucmd,
>                           mss_l4len_idx);
>
>         return 1;
> @@ -8493,7 +8502,8 @@ netdev_tx_t ixgbe_xmit_frame_ring(struct sk_buff *skb,
>         if (skb->sp && !ixgbe_ipsec_tx(tx_ring, first, &ipsec_tx))
>                 goto out_drop;
>  #endif
> -       tso = ixgbe_tso(tx_ring, first, &hdr_len);
> +
> +       tso = ixgbe_tso(tx_ring, first, &hdr_len, &ipsec_tx);
>         if (tso < 0)
>                 goto out_drop;
>         else if (!tso)

No need for the extra blank line. I would say just leave it as is and
add your extra argument.

> @@ -9902,8 +9912,11 @@ ixgbe_features_check(struct sk_buff *skb, struct net_device *dev,
>
>         /* We can only support IPV4 TSO in tunnels if we can mangle the
>          * inner IP ID field, so strip TSO if MANGLEID is not supported.
> +        * IPsec offoad sets skb->encapsulation but still can handle
> +        * the TSO, so it's the exception.
>          */
> -       if (skb->encapsulation && !(features & NETIF_F_TSO_MANGLEID))
> +       if (skb->encapsulation && !(features & NETIF_F_TSO_MANGLEID) &&
> +           !skb->sp)
>                 features &= ~NETIF_F_TSO;
>
>         return features;
> --
> 2.7.4
>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
