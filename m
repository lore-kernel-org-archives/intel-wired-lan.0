From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 3 Jun 2016 13:25:55 -0700
Subject: [Intel-wired-lan] [PATCH] net: igb: Only dma sync frame length
In-Reply-To: <1464975932-13301-1-git-send-email-andrew@lunn.ch>
References: <1464975932-13301-1-git-send-email-andrew@lunn.ch>
Message-ID: <CAKgT0Uey1yT2p2T921K4EQ2w3NxUBOcRmwg66NHnQ2FHXGUWGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Jun 3, 2016 at 10:45 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> On some platforms, syncing a buffer for DMA is expensive. Rather than
> sync the whole 2K receive buffer, only synchronise the length of the
> frame, which will typically be the MTU, or a much smaller TCP ACK.
>
> For an IMX6Q, this gives around 6% increased TCP receive performance,
> which is cache operations bound and reduces CPU load for TCP transmit.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index 0a289dda604a..670e3d612283 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -6915,6 +6915,7 @@ static struct sk_buff *igb_fetch_rx_buffer(struct igb_ring *rx_ring,
>  {
>         struct igb_rx_buffer *rx_buffer;
>         struct page *page;
> +       unsigned int size = le16_to_cpu(rx_desc->wb.upper.length);
>

You should probably place this variable at the top of the declaration
list.  The preference for the netdev tree is to have variables in a
reverse xmas tree order where the longest declarations are at the top
and the shortest are at the bottom.

>         rx_buffer = &rx_ring->rx_buffer_info[rx_ring->next_to_clean];
>         page = rx_buffer->page;
> @@ -6948,7 +6949,7 @@ static struct sk_buff *igb_fetch_rx_buffer(struct igb_ring *rx_ring,
>         dma_sync_single_range_for_cpu(rx_ring->dev,
>                                       rx_buffer->dma,
>                                       rx_buffer->page_offset,
> -                                     IGB_RX_BUFSZ,
> +                                     size,
>                                       DMA_FROM_DEVICE);
>
>         /* pull page into skb */

You might also want to consider adding size as a variable to
igb_add_rx_frag.  That way you don't have to worry about it being read
and byte-swapped a second time.

- Alex
