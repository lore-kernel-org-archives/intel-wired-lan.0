From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 10 Aug 2020 18:25:12 -0700
Subject: [Intel-wired-lan] [PATCH 2/3] igc: Check descriptor's DD bit in
 igc_clean_rx_irq()
In-Reply-To: <20200810210832.34699-2-andre.guedes@intel.com>
References: <20200810210832.34699-1-andre.guedes@intel.com>
 <20200810210832.34699-2-andre.guedes@intel.com>
Message-ID: <CAKgT0Uf-nQ105jbAK-Ag0M=mn254YJX=A7DJ9PMWZFPAFunNUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Aug 10, 2020 at 2:08 PM Andre Guedes <andre.guedes@intel.com> wrote:
>
> I225 advanced receive descriptor provides the Descriptor Done (DD) bit
> which indicates hardware is done with that receive descriptor and
> software should handle it.
>
> This patch fixes igc_clean_rx_irq() so we check that bit to determine if
> we are done handling incoming packets instead of checking the packet
> length information. It also gets rid of rx_desc->wb.upper.length
> assignments spread through the code required to make the previous
> approach to work.
>
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>

I do not agree with this patch. The patch itself will break a number of things.

> ---
>  drivers/net/ethernet/intel/igc/igc_defines.h |  1 +
>  drivers/net/ethernet/intel/igc/igc_main.c    | 14 ++++++++------
>  2 files changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
> index 21695476b8a5..43a7c7944804 100644
> --- a/drivers/net/ethernet/intel/igc/igc_defines.h
> +++ b/drivers/net/ethernet/intel/igc/igc_defines.h
> @@ -316,6 +316,7 @@
>  #define IGC_SRRCTL_TIMER0SEL(timer)    (((timer) & 0x3) << 17)
>
>  /* Receive Descriptor bit definitions */
> +#define IGC_RXD_STAT_DD                0x01    /* Descriptor Done */
>  #define IGC_RXD_STAT_EOP       0x02    /* End of Packet */
>  #define IGC_RXD_STAT_IXSM      0x04    /* Ignore checksum */
>  #define IGC_RXD_STAT_UDPCS     0x10    /* UDP xsum calculated */
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 298f408519f4..0c481dc906ad 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -551,7 +551,6 @@ static void igc_configure_rx_ring(struct igc_adapter *adapter,
>
>         /* initialize Rx descriptor 0 */
>         rx_desc = IGC_RX_DESC(ring, 0);
> -       rx_desc->wb.upper.length = 0;
>
>         /* enable receive descriptor fetching */
>         rxdctl |= IGC_RXDCTL_QUEUE_ENABLE;

This is initializing the ring for the first descriptor to 0. Without
this line you break the driver. Without this you need to memset the
entire descriptor ring to 0.

> @@ -1880,9 +1879,6 @@ static void igc_alloc_rx_buffers(struct igc_ring *rx_ring, u16 cleaned_count)
>                         i -= rx_ring->count;
>                 }
>
> -               /* clear the length for the next_to_use descriptor */
> -               rx_desc->wb.upper.length = 0;
> -
>                 cleaned_count--;
>         } while (cleaned_count);
>

Same here. Without doing this you can potentially hang as you need to
make sure the status bits are cleared before releasing a descriptor to
the device.

> @@ -1924,8 +1920,12 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
>                 }
>
>                 rx_desc = IGC_RX_DESC(rx_ring, rx_ring->next_to_clean);
> -               size = le16_to_cpu(rx_desc->wb.upper.length);
> -               if (!size)
> +
> +               /* If we reached a descriptor with 'Descriptor Done' bit not
> +                * set, it means we have handled all descriptors owned by
> +                * software already so we should prematurely break the loop.
> +                */
> +               if (!igc_test_staterr(rx_desc, IGC_RXD_STAT_DD))
>                         break;
>
>                 /* This memory barrier is needed to keep us from reading

Why add an extra check when you don't need to? This doesn't make
sense. The DD bit tells you that the descriptor was written back but
you can do the same thing by reading the size field.

> @@ -1934,6 +1934,8 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
>                  */
>                 dma_rmb();
>
> +               size = le16_to_cpu(rx_desc->wb.upper.length);
> +
>                 rx_buffer = igc_get_rx_buffer(rx_ring, size);
>
>                 /* retrieve a buffer from the ring */

This should be fine since the dma_rmb() will prevent the reads from
being reordered. However it is really redundant. For a bit of history
the reason for reading the size as the first field is because
previously we had bugs on PowerPC where the length field was being
read first, and then the DD bit. As such if the length is 0 before the
writeback, and non-zero after then you can spare yourself some cycles
by reading the size first and if it is non-zero then you know the
descriptor has valid data to be read.
