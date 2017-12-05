From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 5 Dec 2017 09:40:05 -0800
Subject: [Intel-wired-lan] [next-queue 07/10] ixgbe: process the Rx
 ipsec offload
In-Reply-To: <1512452116-14795-8-git-send-email-shannon.nelson@oracle.com>
References: <1512452116-14795-1-git-send-email-shannon.nelson@oracle.com>
 <1512452116-14795-8-git-send-email-shannon.nelson@oracle.com>
Message-ID: <CAKgT0UdJxfXZoHifkUFtnwwhuV9WLgEFO3ccqfTnS-nX5a7wHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Dec 4, 2017 at 9:35 PM, Shannon Nelson
<shannon.nelson@oracle.com> wrote:
> If the chip sees and decrypts an ipsec offload, set up the skb
> sp pointer with the ralated SA info.  Since the chip is rude
> enough to keep to itself the table index it used for the
> decryption, we have to do our own table lookup, using the
> hash for speed.
>
> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h       |  6 ++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 89 ++++++++++++++++++++++++++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |  3 +
>  3 files changed, 98 insertions(+)
>
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> index 7e8bca7..77f07dc 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> @@ -1009,9 +1009,15 @@ s32 ixgbe_negotiate_fc(struct ixgbe_hw *hw, u32 adv_reg, u32 lp_reg,
>                        u32 adv_sym, u32 adv_asm, u32 lp_sym, u32 lp_asm);
>  #ifdef CONFIG_XFRM_OFFLOAD
>  void ixgbe_init_ipsec_offload(struct ixgbe_adapter *adapter);
> +void ixgbe_ipsec_rx(struct ixgbe_ring *rx_ring,
> +                   union ixgbe_adv_rx_desc *rx_desc,
> +                   struct sk_buff *skb);
>  void ixgbe_ipsec_restore(struct ixgbe_adapter *adapter);
>  #else
>  static inline void ixgbe_init_ipsec_offload(struct ixgbe_adapter *adapter) { };
> +static inline void ixgbe_ipsec_rx(struct ixgbe_ring *rx_ring,
> +                                 union ixgbe_adv_rx_desc *rx_desc,
> +                                 struct sk_buff *skb) { };
>  static inline void ixgbe_ipsec_restore(struct ixgbe_adapter *adapter) { };
>  #endif /* CONFIG_XFRM_OFFLOAD */
>  #endif /* _IXGBE_H_ */
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> index b93ee7f..fd06d9b 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> @@ -379,6 +379,35 @@ static int ixgbe_ipsec_find_empty_idx(struct ixgbe_ipsec *ipsec, bool rxtable)
>  }
>
>  /**
> + * ixgbe_ipsec_find_rx_state - find the state that matches
> + * @ipsec: pointer to ipsec struct
> + * @daddr: inbound address to match
> + * @proto: protocol to match
> + * @spi: SPI to match
> + *
> + * Returns a pointer to the matching SA state information
> + **/
> +static struct xfrm_state *ixgbe_ipsec_find_rx_state(struct ixgbe_ipsec *ipsec,
> +                                                   __be32 daddr, u8 proto,
> +                                                   __be32 spi)
> +{
> +       struct rx_sa *rsa;
> +       struct xfrm_state *ret = NULL;
> +
> +       rcu_read_lock();
> +       hash_for_each_possible_rcu(ipsec->rx_sa_list, rsa, hlist, spi)
> +               if (spi == rsa->xs->id.spi &&
> +                   daddr == rsa->xs->id.daddr.a4 &&
> +                   proto == rsa->xs->id.proto) {
> +                       ret = rsa->xs;
> +                       xfrm_state_hold(ret);
> +                       break;
> +               }
> +       rcu_read_unlock();
> +       return ret;
> +}
> +

You need to choose a bucket, not just walk through all buckets.
Otherwise you might as well have just used a linked list. You might
look at using something like jhash_3words to generate a hash which you
then use to choose the bucket.

> +/**
>   * ixgbe_ipsec_parse_proto_keys - find the key and salt based on the protocol
>   * @xs: pointer to xfrm_state struct
>   * @mykey: pointer to key array to populate
> @@ -680,6 +709,66 @@ static const struct xfrmdev_ops ixgbe_xfrmdev_ops = {
>  };
>
>  /**
> + * ixgbe_ipsec_rx - decode ipsec bits from Rx descriptor
> + * @rx_ring: receiving ring
> + * @rx_desc: receive data descriptor
> + * @skb: current data packet
> + *
> + * Determine if there was an ipsec encapsulation noticed, and if so set up
> + * the resulting status for later in the receive stack.
> + **/
> +void ixgbe_ipsec_rx(struct ixgbe_ring *rx_ring,
> +                   union ixgbe_adv_rx_desc *rx_desc,
> +                   struct sk_buff *skb)
> +{
> +       struct ixgbe_adapter *adapter = netdev_priv(rx_ring->netdev);
> +       u16 pkt_info = le16_to_cpu(rx_desc->wb.lower.lo_dword.hs_rss.pkt_info);
> +       u16 ipsec_pkt_types = IXGBE_RXDADV_PKTTYPE_IPSEC_AH |
> +                               IXGBE_RXDADV_PKTTYPE_IPSEC_ESP;
> +       struct ixgbe_ipsec *ipsec = adapter->ipsec;
> +       struct xfrm_offload *xo = NULL;
> +       struct xfrm_state *xs = NULL;
> +       struct iphdr *iph;
> +       u8 *c_hdr;
> +       __be32 spi;
> +       u8 proto;
> +
> +       /* we can assume no vlan header in the way, b/c the
> +        * hw won't recognize the IPsec packet and anyway the
> +        * currently vlan device doesn't support xfrm offload.
> +        */
> +       /* TODO: not supporting IPv6 yet */
> +       iph = (struct iphdr *)(skb->data + ETH_HLEN);
> +       c_hdr = (u8 *)iph + iph->ihl * 4;
> +       switch (pkt_info & ipsec_pkt_types) {
> +       case IXGBE_RXDADV_PKTTYPE_IPSEC_AH:
> +               spi = ((struct ip_auth_hdr *)c_hdr)->spi;
> +               proto = IPPROTO_AH;
> +               break;
> +       case IXGBE_RXDADV_PKTTYPE_IPSEC_ESP:
> +               spi = ((struct ip_esp_hdr *)c_hdr)->spi;
> +               proto = IPPROTO_ESP;
> +               break;
> +       default:
> +               return;
> +       }
> +
> +       xs = ixgbe_ipsec_find_rx_state(ipsec, iph->daddr, proto, spi);
> +       if (unlikely(!xs))
> +               return;
> +
> +       skb->sp = secpath_dup(skb->sp);
> +       if (unlikely(!skb->sp))
> +               return;
> +
> +       skb->sp->xvec[skb->sp->len++] = xs;
> +       skb->sp->olen++;
> +       xo = xfrm_offload(skb);
> +       xo->flags = CRYPTO_DONE;
> +       xo->status = CRYPTO_SUCCESS;
> +}
> +
> +/**
>   * ixgbe_init_ipsec_offload - initialize security registers for IPSec operation
>   * @adapter: board private structure
>   **/
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 6eabf92..60f9f2d 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -1755,6 +1755,9 @@ static void ixgbe_process_skb_fields(struct ixgbe_ring *rx_ring,
>
>         skb_record_rx_queue(skb, rx_ring->queue_index);
>
> +       if (ixgbe_test_staterr(rx_desc, IXGBE_RXDADV_STAT_SECP))
> +               ixgbe_ipsec_rx(rx_ring, rx_desc, skb);
> +
>         skb->protocol = eth_type_trans(skb, dev);
>  }
>
> --
> 2.7.4
>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
