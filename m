From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 5 Dec 2017 10:13:41 -0800
Subject: [Intel-wired-lan] [next-queue 08/10] ixgbe: process the Tx
 ipsec offload
In-Reply-To: <1512452116-14795-9-git-send-email-shannon.nelson@oracle.com>
References: <1512452116-14795-1-git-send-email-shannon.nelson@oracle.com>
 <1512452116-14795-9-git-send-email-shannon.nelson@oracle.com>
Message-ID: <CAKgT0UdajKqTk+FCaQivtV=i7tZ1RC2cA8ifqzFMhLqQMspN7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Dec 4, 2017 at 9:35 PM, Shannon Nelson
<shannon.nelson@oracle.com> wrote:
> If the skb has a security association referenced in the skb, then
> set up the Tx descriptor with the ipsec offload bits.  While we're
> here, we fix an oddly named field in the context descriptor struct.
>
> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h       | 10 +++-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 77 ++++++++++++++++++++++++++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c   |  4 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  | 38 ++++++++++---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_type.h  |  2 +-
>  5 files changed, 118 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> index 77f07dc..68097fe 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> @@ -171,10 +171,11 @@ enum ixgbe_tx_flags {
>         IXGBE_TX_FLAGS_CC       = 0x08,
>         IXGBE_TX_FLAGS_IPV4     = 0x10,
>         IXGBE_TX_FLAGS_CSUM     = 0x20,
> +       IXGBE_TX_FLAGS_IPSEC    = 0x40,
>
>         /* software defined flags */
> -       IXGBE_TX_FLAGS_SW_VLAN  = 0x40,
> -       IXGBE_TX_FLAGS_FCOE     = 0x80,
> +       IXGBE_TX_FLAGS_SW_VLAN  = 0x80,
> +       IXGBE_TX_FLAGS_FCOE     = 0x100,
>  };
>
>  /* VLAN info */
> @@ -1012,12 +1013,17 @@ void ixgbe_init_ipsec_offload(struct ixgbe_adapter *adapter);
>  void ixgbe_ipsec_rx(struct ixgbe_ring *rx_ring,
>                     union ixgbe_adv_rx_desc *rx_desc,
>                     struct sk_buff *skb);
> +int ixgbe_ipsec_tx(struct ixgbe_ring *tx_ring, struct sk_buff *skb,
> +                  __be16 protocol, struct ixgbe_ipsec_tx_data *itd);
>  void ixgbe_ipsec_restore(struct ixgbe_adapter *adapter);
>  #else
>  static inline void ixgbe_init_ipsec_offload(struct ixgbe_adapter *adapter) { };
>  static inline void ixgbe_ipsec_rx(struct ixgbe_ring *rx_ring,
>                                   union ixgbe_adv_rx_desc *rx_desc,
>                                   struct sk_buff *skb) { };
> +static inline int ixgbe_ipsec_tx(struct ixgbe_ring *tx_ring,
> +                                struct sk_buff *skb, __be16 protocol,
> +                                struct ixgbe_ipsec_tx_data *itd) { return 0; };
>  static inline void ixgbe_ipsec_restore(struct ixgbe_adapter *adapter) { };
>  #endif /* CONFIG_XFRM_OFFLOAD */
>  #endif /* _IXGBE_H_ */
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> index fd06d9b..2a0dd7a 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> @@ -703,12 +703,89 @@ static void ixgbe_ipsec_del_sa(struct xfrm_state *xs)
>         }
>  }
>
> +/**
> + * ixgbe_ipsec_offload_ok - can this packet use the xfrm hw offload
> + * @skb: current data packet
> + * @xs: pointer to transformer state struct
> + **/
> +static bool ixgbe_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
> +{
> +       if (xs->props.family == AF_INET) {
> +               /* Offload with IPv4 options is not supported yet */
> +               if (ip_hdr(skb)->ihl > 5)

I would make this ihl != 5 instead of "> 5" since smaller values would
be invalid as well.

> +                       return false;
> +       } else {
> +               /* Offload with IPv6 extension headers is not support yet */
> +               if (ipv6_ext_hdr(ipv6_hdr(skb)->nexthdr))
> +                       return false;
> +       }
> +
> +       return true;
> +}
> +
>  static const struct xfrmdev_ops ixgbe_xfrmdev_ops = {
>         .xdo_dev_state_add = ixgbe_ipsec_add_sa,
>         .xdo_dev_state_delete = ixgbe_ipsec_del_sa,
> +       .xdo_dev_offload_ok = ixgbe_ipsec_offload_ok,
>  };
>
>  /**
> + * ixgbe_ipsec_tx - setup Tx flags for ipsec offload
> + * @tx_ring: outgoing context
> + * @skb: current data packet
> + * @protocol: network protocol
> + * @itd: ipsec Tx data for later use in building context descriptor
> + **/
> +int ixgbe_ipsec_tx(struct ixgbe_ring *tx_ring, struct sk_buff *skb,
> +                  __be16 protocol, struct ixgbe_ipsec_tx_data *itd)
> +{
> +       struct ixgbe_adapter *adapter = netdev_priv(tx_ring->netdev);
> +       struct ixgbe_ipsec *ipsec = adapter->ipsec;
> +       struct xfrm_state *xs;
> +       struct tx_sa *tsa;
> +
> +       if (!skb->sp->len) {
> +               netdev_err(tx_ring->netdev, "%s: no xfrm state len = %d\n",
> +                          __func__, skb->sp->len);
> +               return 0;
> +       }
> +
> +       xs = xfrm_input_state(skb);
> +       if (!xs) {
> +               netdev_err(tx_ring->netdev, "%s: no xfrm_input_state() xs = %p\n",
> +                          __func__, xs);
> +               return 0;
> +       }
> +
> +       itd->sa_idx = xs->xso.offload_handle - IXGBE_IPSEC_BASE_TX_INDEX;
> +       if (itd->sa_idx > IXGBE_IPSEC_MAX_SA_COUNT) {
> +               netdev_err(tx_ring->netdev, "%s: bad sa_idx=%d handle=%lu\n",
> +                          __func__, itd->sa_idx, xs->xso.offload_handle);
> +               return 0;
> +       }
> +
> +       tsa = &ipsec->tx_tbl[itd->sa_idx];
> +       if (!tsa->used) {
> +               netdev_err(tx_ring->netdev, "%s: unused sa_idx=%d\n",
> +                          __func__, itd->sa_idx);
> +               return 0;
> +       }
> +
> +       itd->flags = 0;
> +       if (xs->id.proto == IPPROTO_ESP) {
> +               itd->flags |= IXGBE_ADVTXD_TUCMD_IPSEC_TYPE_ESP |
> +                             IXGBE_ADVTXD_TUCMD_L4T_TCP;

Why is the TCP value being set here? This doesn't seem correct either.
This implies TCP a TCP offload. It seems like this should only be
setting ESP.

> +               if (protocol == htons(ETH_P_IP))
> +                       itd->flags |= IXGBE_ADVTXD_TUCMD_IPV4;

Does the IPsec offload need to know if the frame is v4 or v6? I'm just
wondering if it does or not. If not then this probably isn't needed.
One thought on this line is you might look at moving it into
ixgbe_tx_csum. If setting the bit is harmless without setting IXSM we
might look at moving it into the end of ixgbe_tx_csum and just make it
compare against first->protocol there.

> +               itd->trailer_len = xs->props.trailer_len;
> +       }
> +       if (tsa->encrypt)
> +               itd->flags |= IXGBE_ADVTXD_TUCMD_IPSEC_ENCRYPT_EN;
> +
> +       return 1;
> +}
> +
> +/**
>   * ixgbe_ipsec_rx - decode ipsec bits from Rx descriptor
>   * @rx_ring: receiving ring
>   * @rx_desc: receive data descriptor
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
> index f1bfae0..d7875b3 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
> @@ -1261,7 +1261,7 @@ void ixgbe_clear_interrupt_scheme(struct ixgbe_adapter *adapter)
>  }
>
>  void ixgbe_tx_ctxtdesc(struct ixgbe_ring *tx_ring, u32 vlan_macip_lens,
> -                      u32 fcoe_sof_eof, u32 type_tucmd, u32 mss_l4len_idx)
> +                      u32 fceof_saidx, u32 type_tucmd, u32 mss_l4len_idx)
>  {
>         struct ixgbe_adv_tx_context_desc *context_desc;
>         u16 i = tx_ring->next_to_use;
> @@ -1275,7 +1275,7 @@ void ixgbe_tx_ctxtdesc(struct ixgbe_ring *tx_ring, u32 vlan_macip_lens,
>         type_tucmd |= IXGBE_TXD_CMD_DEXT | IXGBE_ADVTXD_DTYP_CTXT;
>
>         context_desc->vlan_macip_lens   = cpu_to_le32(vlan_macip_lens);
> -       context_desc->seqnum_seed       = cpu_to_le32(fcoe_sof_eof);
> +       context_desc->fceof_saidx       = cpu_to_le32(fceof_saidx);
>         context_desc->type_tucmd_mlhl   = cpu_to_le32(type_tucmd);
>         context_desc->mss_l4len_idx     = cpu_to_le32(mss_l4len_idx);
>  }
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 60f9f2d..c857594 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -7659,9 +7659,10 @@ static void ixgbe_service_task(struct work_struct *work)
>
>  static int ixgbe_tso(struct ixgbe_ring *tx_ring,
>                      struct ixgbe_tx_buffer *first,
> -                    u8 *hdr_len)
> +                    u8 *hdr_len,
> +                    struct ixgbe_ipsec_tx_data *itd)
>  {
> -       u32 vlan_macip_lens, type_tucmd, mss_l4len_idx;
> +       u32 vlan_macip_lens, type_tucmd, mss_l4len_idx, fceof_saidx = 0;
>         struct sk_buff *skb = first->skb;
>         union {
>                 struct iphdr *v4;
> @@ -7740,7 +7741,12 @@ static int ixgbe_tso(struct ixgbe_ring *tx_ring,
>         vlan_macip_lens |= (ip.hdr - skb->data) << IXGBE_ADVTXD_MACLEN_SHIFT;
>         vlan_macip_lens |= first->tx_flags & IXGBE_TX_FLAGS_VLAN_MASK;
>
> -       ixgbe_tx_ctxtdesc(tx_ring, vlan_macip_lens, 0, type_tucmd,
> +       if (first->tx_flags & IXGBE_TX_FLAGS_IPSEC) {
> +               fceof_saidx |= itd->sa_idx;
> +               type_tucmd |= itd->flags | itd->trailer_len;
> +       }
> +
> +       ixgbe_tx_ctxtdesc(tx_ring, vlan_macip_lens, fceof_saidx, type_tucmd,
>                           mss_l4len_idx);
>
>         return 1;
> @@ -7756,10 +7762,12 @@ static inline bool ixgbe_ipv6_csum_is_sctp(struct sk_buff *skb)
>  }
>
>  static void ixgbe_tx_csum(struct ixgbe_ring *tx_ring,
> -                         struct ixgbe_tx_buffer *first)
> +                         struct ixgbe_tx_buffer *first,
> +                         struct ixgbe_ipsec_tx_data *itd)
>  {
>         struct sk_buff *skb = first->skb;
>         u32 vlan_macip_lens = 0;
> +       u32 fceof_saidx = 0;
>         u32 type_tucmd = 0;
>
>         if (skb->ip_summed != CHECKSUM_PARTIAL) {
> @@ -7800,7 +7808,12 @@ static void ixgbe_tx_csum(struct ixgbe_ring *tx_ring,
>         vlan_macip_lens |= skb_network_offset(skb) << IXGBE_ADVTXD_MACLEN_SHIFT;
>         vlan_macip_lens |= first->tx_flags & IXGBE_TX_FLAGS_VLAN_MASK;
>
> -       ixgbe_tx_ctxtdesc(tx_ring, vlan_macip_lens, 0, type_tucmd, 0);
> +       if (first->tx_flags & IXGBE_TX_FLAGS_IPSEC) {
> +               fceof_saidx |= itd->sa_idx;
> +               type_tucmd |= itd->flags | itd->trailer_len;
> +       }
> +
> +       ixgbe_tx_ctxtdesc(tx_ring, vlan_macip_lens, fceof_saidx, type_tucmd, 0);
>  }
>
>  #define IXGBE_SET_FLAG(_input, _flag, _result) \
> @@ -7843,11 +7856,16 @@ static void ixgbe_tx_olinfo_status(union ixgbe_adv_tx_desc *tx_desc,
>                                         IXGBE_TX_FLAGS_CSUM,
>                                         IXGBE_ADVTXD_POPTS_TXSM);
>
> -       /* enble IPv4 checksum for TSO */
> +       /* enable IPv4 checksum for TSO */
>         olinfo_status |= IXGBE_SET_FLAG(tx_flags,
>                                         IXGBE_TX_FLAGS_IPV4,
>                                         IXGBE_ADVTXD_POPTS_IXSM);
>
> +       /* enable IPsec */
> +       olinfo_status |= IXGBE_SET_FLAG(tx_flags,
> +                                       IXGBE_TX_FLAGS_IPSEC,
> +                                       IXGBE_ADVTXD_POPTS_IPSEC);
> +
>         /*
>          * Check Context must be set if Tx switch is enabled, which it
>          * always is for case where virtual functions are running
> @@ -8306,6 +8324,7 @@ netdev_tx_t ixgbe_xmit_frame_ring(struct sk_buff *skb,
>         u32 tx_flags = 0;
>         unsigned short f;
>         u16 count = TXD_USE_COUNT(skb_headlen(skb));
> +       struct ixgbe_ipsec_tx_data ipsec_tx = { 0 };
>         __be16 protocol = skb->protocol;
>         u8 hdr_len = 0;
>
> @@ -8394,6 +8413,9 @@ netdev_tx_t ixgbe_xmit_frame_ring(struct sk_buff *skb,
>                 }
>         }
>
> +       if (skb->sp && ixgbe_ipsec_tx(tx_ring, skb, protocol, &ipsec_tx))
> +               tx_flags |= IXGBE_TX_FLAGS_IPSEC | IXGBE_TX_FLAGS_CC;

You might just want to pull the skb->sp check into ixgbe_ipsec_tx and
could pass tx_flags as a part of the first buffer. It doesn't really
matter anyway as most of this will just be inlined so it will all end
up a part of the same function anyway.

Also I would move this down so that it is handled after the fields in
the first buffer_info structure are set. Then this can ll just fall
inline with the TSO block and get handled there.

> +
>         /* record initial flags and protocol */
>         first->tx_flags = tx_flags;
>         first->protocol = protocol;
> @@ -8410,11 +8432,11 @@ netdev_tx_t ixgbe_xmit_frame_ring(struct sk_buff *skb,
>         }
>
>  #endif /* IXGBE_FCOE */

So if you move the function down here it will help to avoid any other
complication. In addition you could follow the same logic that we do
for ixgbe_tso/fso so you could drop the frame instead of transmitting
it if it is requesting a bad offload.

> -       tso = ixgbe_tso(tx_ring, first, &hdr_len);
> +       tso = ixgbe_tso(tx_ring, first, &hdr_len, &ipsec_tx);
>         if (tso < 0)
>                 goto out_drop;
>         else if (!tso)
> -               ixgbe_tx_csum(tx_ring, first);
> +               ixgbe_tx_csum(tx_ring, first, &ipsec_tx);
>
>         /* add the ATR filter if ATR is on */
>         if (test_bit(__IXGBE_TX_FDIR_INIT_DONE, &tx_ring->state))
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> index 3df0763..0ac725fa 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> @@ -2856,7 +2856,7 @@ union ixgbe_adv_rx_desc {
>  /* Context descriptors */
>  struct ixgbe_adv_tx_context_desc {
>         __le32 vlan_macip_lens;
> -       __le32 seqnum_seed;
> +       __le32 fceof_saidx;
>         __le32 type_tucmd_mlhl;
>         __le32 mss_l4len_idx;
>  };
> --
> 2.7.4
>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
