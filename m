From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 10 Aug 2020 15:56:31 -0700
Subject: [Intel-wired-lan] [PATCH 3/3] igc: Fix SRRCTL register setup
In-Reply-To: <20200810210832.34699-3-andre.guedes@intel.com>
References: <20200810210832.34699-1-andre.guedes@intel.com>
 <20200810210832.34699-3-andre.guedes@intel.com>
Message-ID: <CAKgT0UdvyU+xkESA5HaqS2acbXQMJDUGdchRM2J6QExEcjiSkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Aug 10, 2020 at 2:08 PM Andre Guedes <andre.guedes@intel.com> wrote:
>
> SRRCTL register is set with 'one buffer descriptor' option (see DESCTYPE
> setting a few lines below) so setting BSIZEHEADER bits is pointless.
> They should be zero. Also, since there is no header buffer we should set
> the header buffer address field from the receive descriptor to zero for
> the sake of consistency.
>
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 0c481dc906ad..a5d825d44002 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -531,14 +531,11 @@ static void igc_configure_rx_ring(struct igc_adapter *adapter,
>         ring->next_to_clean = 0;
>         ring->next_to_use = 0;
>
> -       /* set descriptor configuration */
> -       srrctl = IGC_RX_HDR_LEN << IGC_SRRCTL_BSIZEHDRSIZE_SHIFT;
>         if (ring_uses_large_buffer(ring))
>                 srrctl |= IGC_RXBUFFER_3072 >> IGC_SRRCTL_BSIZEPKT_SHIFT;
>         else
>                 srrctl |= IGC_RXBUFFER_2048 >> IGC_SRRCTL_BSIZEPKT_SHIFT;
>         srrctl |= IGC_SRRCTL_DESCTYPE_ADV_ONEBUF;
> -
>         wr32(IGC_SRRCTL(reg_idx), srrctl);
>
>         rxdctl |= IGC_RX_PTHRESH;

Some of this was left in place to leave parity with the ixgbe driver
which was required to populate that field in order to enable RSC/LRO.

> @@ -1869,6 +1866,7 @@ static void igc_alloc_rx_buffers(struct igc_ring *rx_ring, u16 cleaned_count)
>                  * because each write-back erases this info.
>                  */
>                 rx_desc->read.pkt_addr = cpu_to_le64(bi->dma + bi->page_offset);
> +               rx_desc->read.hdr_addr = 0;
>
>                 rx_desc++;
>                 bi++;

If you are going to do this it would be better to replace the line
that is setting the length to zero instead of just adding this line.
That way you can avoid having to rewrite it. I only had bothered with
clearing the length field as it was a 32b field, however if you are
wanting to flush the full 64b then I would recommend doing it there
rather than here.
