From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Tue, 26 Jun 2018 18:37:18 +0200
Subject: [Intel-wired-lan] [PATCH 2/3] i40e: split XDP_TX tail and
 XDP_REDIRECT map flushing
In-Reply-To: <153002759360.15389.18278323388927454181.stgit@firesoul>
References: <153002741940.15389.10466368482771753300.stgit@firesoul>
 <153002759360.15389.18278323388927454181.stgit@firesoul>
Message-ID: <CAJ+HfNjtWpXY=DeQdmgB8UMKvz1iwHB_s__a6fnz1LZsPCiTcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Den tis 26 juni 2018 kl 18:08 skrev Jesper Dangaard Brouer <brouer@redhat.com>:
>
> The driver was combining the XDP_TX tail flush and XDP_REDIRECT
> map flushing (xdp_do_flush_map).  This is suboptimal, these two
> flush operations should be kept separate.
>
> It looks like the mistake was copy-pasted from ixgbe.
>
> Fixes: d9314c474d4f ("i40e: add support for XDP_REDIRECT")
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c |   24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> index 8ffb7454e67c..c1c027743159 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> @@ -2200,9 +2200,10 @@ static bool i40e_is_non_eop(struct i40e_ring *rx_ring,
>         return true;
>  }
>
> -#define I40E_XDP_PASS 0
> -#define I40E_XDP_CONSUMED 1
> -#define I40E_XDP_TX 2
> +#define I40E_XDP_PASS          0
> +#define I40E_XDP_CONSUMED      BIT(0)
> +#define I40E_XDP_TX            BIT(1)
> +#define I40E_XDP_REDIR         BIT(2)
>
>  static int i40e_xmit_xdp_ring(struct xdp_frame *xdpf,
>                               struct i40e_ring *xdp_ring);
> @@ -2249,7 +2250,7 @@ static struct sk_buff *i40e_run_xdp(struct i40e_ring *rx_ring,
>                 break;
>         case XDP_REDIRECT:
>                 err = xdp_do_redirect(rx_ring->netdev, xdp, xdp_prog);
> -               result = !err ? I40E_XDP_TX : I40E_XDP_CONSUMED;
> +               result = !err ? I40E_XDP_REDIR : I40E_XDP_CONSUMED;
>                 break;
>         default:
>                 bpf_warn_invalid_xdp_action(act);
> @@ -2312,7 +2313,8 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
>         unsigned int total_rx_bytes = 0, total_rx_packets = 0;
>         struct sk_buff *skb = rx_ring->skb;
>         u16 cleaned_count = I40E_DESC_UNUSED(rx_ring);
> -       bool failure = false, xdp_xmit = false;
> +       unsigned int xdp_xmit = 0;
> +       bool failure = false;
>         struct xdp_buff xdp;
>
>         xdp.rxq = &rx_ring->xdp_rxq;
> @@ -2373,8 +2375,10 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
>                 }
>
>                 if (IS_ERR(skb)) {
> -                       if (PTR_ERR(skb) == -I40E_XDP_TX) {
> -                               xdp_xmit = true;
> +                       unsigned int xdp_res = -PTR_ERR(skb);
> +
> +                       if (xdp_res & (I40E_XDP_TX | I40E_XDP_REDIR)) {
> +                               xdp_xmit |= xdp_res;
>                                 i40e_rx_buffer_flip(rx_ring, rx_buffer, size);
>                         } else {
>                                 rx_buffer->pagecnt_bias++;
> @@ -2428,12 +2432,14 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
>                 total_rx_packets++;
>         }
>
> -       if (xdp_xmit) {
> +       if (xdp_xmit & I40E_XDP_REDIR)
> +               xdp_do_flush_map();
> +
> +       if (xdp_xmit & I40E_XDP_TX) {
>                 struct i40e_ring *xdp_ring =
>                         rx_ring->vsi->xdp_rings[rx_ring->queue_index];
>
>                 i40e_xdp_ring_update_tail(xdp_ring);
> -               xdp_do_flush_map();
>         }
>
>         rx_ring->skb = skb;
>

Nice! Added intel-wired-lan to Cc.

Acked-by: Bj?rn T?pel <bjorn.topel@intel.com>
