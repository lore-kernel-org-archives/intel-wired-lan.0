From: Andre Guedes <andre.guedes@intel.com>
Date: Tue, 11 Aug 2020 09:59:57 -0700
Subject: [Intel-wired-lan] [PATCH 2/3] igc: Check descriptor's DD bit in
 igc_clean_rx_irq()
In-Reply-To: <CAKgT0Uf-nQ105jbAK-Ag0M=mn254YJX=A7DJ9PMWZFPAFunNUg@mail.gmail.com>
References: <20200810210832.34699-1-andre.guedes@intel.com>
 <20200810210832.34699-2-andre.guedes@intel.com>
 <CAKgT0Uf-nQ105jbAK-Ag0M=mn254YJX=A7DJ9PMWZFPAFunNUg@mail.gmail.com>
Message-ID: <159716519786.40621.1181546461816516018@awandler-mobl.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Alexander,

Quoting Alexander Duyck (2020-08-10 18:25:12)
> > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> > @@ -551,7 +551,6 @@ static void igc_configure_rx_ring(struct igc_adapter *adapter,
> >
> >         /* initialize Rx descriptor 0 */
> >         rx_desc = IGC_RX_DESC(ring, 0);
> > -       rx_desc->wb.upper.length = 0;
> >
> >         /* enable receive descriptor fetching */
> >         rxdctl |= IGC_RXDCTL_QUEUE_ENABLE;
> 
> This is initializing the ring for the first descriptor to 0. Without
> this line you break the driver. Without this you need to memset the
> entire descriptor ring to 0.
> 
> > @@ -1880,9 +1879,6 @@ static void igc_alloc_rx_buffers(struct igc_ring *rx_ring, u16 cleaned_count)
> >                         i -= rx_ring->count;
> >                 }
> >
> > -               /* clear the length for the next_to_use descriptor */
> > -               rx_desc->wb.upper.length = 0;
> > -
> >                 cleaned_count--;
> >         } while (cleaned_count);
> >
> 
> Same here. Without doing this you can potentially hang as you need to
> make sure the status bits are cleared before releasing a descriptor to
> the device.

Yes, after your first comment on patch 3/3 I realized this was bogus. Moving
the 'read.hdr_addr = 0' to this patch should fix it. That's why I thought you
were suggesting that.

> > @@ -1924,8 +1920,12 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
> >                 }
> >
> >                 rx_desc = IGC_RX_DESC(rx_ring, rx_ring->next_to_clean);
> > -               size = le16_to_cpu(rx_desc->wb.upper.length);
> > -               if (!size)
> > +
> > +               /* If we reached a descriptor with 'Descriptor Done' bit not
> > +                * set, it means we have handled all descriptors owned by
> > +                * software already so we should prematurely break the loop.
> > +                */
> > +               if (!igc_test_staterr(rx_desc, IGC_RXD_STAT_DD))
> >                         break;
> >
> >                 /* This memory barrier is needed to keep us from reading
> 
> Why add an extra check when you don't need to? This doesn't make
> sense. The DD bit tells you that the descriptor was written back but
> you can do the same thing by reading the size field.

I was using i40e and ice drivers as reference. If I'm reading it correctly,
they check the DD bit first (or similar) and then read the length information.
I don't see a strong reason besides making the code a bit more readable.

> > @@ -1934,6 +1934,8 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
> >                  */
> >                 dma_rmb();
> >
> > +               size = le16_to_cpu(rx_desc->wb.upper.length);
> > +
> >                 rx_buffer = igc_get_rx_buffer(rx_ring, size);
> >
> >                 /* retrieve a buffer from the ring */
> 
> This should be fine since the dma_rmb() will prevent the reads from
> being reordered. However it is really redundant. For a bit of history
> the reason for reading the size as the first field is because
> previously we had bugs on PowerPC where the length field was being
> read first, and then the DD bit. As such if the length is 0 before the
> writeback, and non-zero after then you can spare yourself some cycles
> by reading the size first and if it is non-zero then you know the
> descriptor has valid data to be read.

Thanks for the history context.

Cheers,
Andre
