From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 13 Mar 2017 10:18:16 -0700
Subject: [Intel-wired-lan] [RFC PATCH] ixgbe: delay tail write to every
	'n' packets
In-Reply-To: <20170313161624.7987.91951.stgit@john-Precision-Tower-5810>
References: <20170313161624.7987.91951.stgit@john-Precision-Tower-5810>
Message-ID: <CAKgT0Ufz6W0+1Y4vsKYqcZ_sn+kCie28wKdECbThOeDO_51zKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Mar 13, 2017 at 9:16 AM, John Fastabend
<john.fastabend@gmail.com> wrote:
> Current XDP implementation hits the tail on every XDP_TX return
> code. This patch changes driver behavior to only hit the tail after
> packet processing is complete.
>
> RFC for now as I test this, it looks promising on my dev box but
> want to do some more tests before official submission.
>
> Signed-off-by: John Fastabend <john.r.fastabend@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index bef4e24..2c244b6 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -2282,6 +2282,7 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
>         unsigned int mss = 0;
>  #endif /* IXGBE_FCOE */
>         u16 cleaned_count = ixgbe_desc_unused(rx_ring);
> +       bool xdp_xmit = false;
>
>         while (likely(total_rx_packets < budget)) {
>                 union ixgbe_adv_rx_desc *rx_desc;
> @@ -2321,10 +2322,12 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
>                 }
>
>                 if (IS_ERR(skb)) {
> -                       if (PTR_ERR(skb) == -IXGBE_XDP_TX)
> +                       if (PTR_ERR(skb) == -IXGBE_XDP_TX) {
> +                               xdp_xmit = true;
>                                 ixgbe_rx_buffer_flip(rx_ring, rx_buffer, size);
> -                       else
> +                       } else {
>                                 rx_buffer->pagecnt_bias++;
> +                       }
>                         total_rx_packets++;
>                         total_rx_bytes += size;
>                 } else if (skb) {
> @@ -2392,6 +2395,12 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
>                 total_rx_packets++;
>         }
>
> +       if (xdp_xmit) {
> +               struct ixgbe_ring *ring = adapter->xdp_ring[smp_processor_id()];
> +
> +               writel(ring->next_to_use, ring->tail);
> +       }
> +

We will need a wmb here.

>         u64_stats_update_begin(&rx_ring->syncp);
>         rx_ring->stats.packets += total_rx_packets;
>         rx_ring->stats.bytes += total_rx_bytes;
> @@ -8251,7 +8260,6 @@ static int ixgbe_xmit_xdp_ring(struct ixgbe_adapter *adapter,
>         tx_buffer->next_to_watch = tx_desc;
>         ring->next_to_use = i;
>
> -       writel(i, ring->tail);

So you might want to change the barrier setup for all this to use
smp_wmb instead.  We need the wmb to be paired with the writel.  That
should give you a slight performance boost since smp_wmb breaks down
to just a barrier on x86 systems.

>         return IXGBE_XDP_TX;
>  }
>
>
