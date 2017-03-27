From: Duyck, Alexander H <alexander.h.duyck@intel.com>
Date: Mon, 27 Mar 2017 22:42:34 +0000
Subject: [Intel-wired-lan] [RFC PATCH] ixgbe: delay tail write to
	every	'n' packets
In-Reply-To: <D6BB30FE66EA894C9F13C9E3CDDF00F564FA94F9@fmsmsx115.amr.corp.intel.com>
References: <20170313161624.7987.91951.stgit@john-Precision-Tower-5810>
 <CAKgT0Ufz6W0+1Y4vsKYqcZ_sn+kCie28wKdECbThOeDO_51zKw@mail.gmail.com>
 <58C881D7.3010608@gmail.com>	,
 <CAKgT0UdgcKk0eOFCTZhjCigbQRVXLpmF=QvRRc7wByt5EdiMkQ@mail.gmail.com>
 <D6BB30FE66EA894C9F13C9E3CDDF00F564FA94F9@fmsmsx115.amr.corp.intel.com>
Message-ID: <1490654550.28895.26.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Sounds good. ?We can probably discuss it tomorrow at our 1pm meeting.

Thanks.

- Alex

On Mon, 2017-03-27 at 19:28 +0000, Fastabend, John R wrote:
> FWIW with a revised version of this patch I see 14.6Mpps on RX drop tests and 13.5Mpps on TX test case.
> 
> Alex, maybe we can sync up and squeeze the last mpps out of the design.
> 
> Thanks,
> John
> ________________________________________
> From: Intel-wired-lan [intel-wired-lan-bounces at lists.osuosl.org] on behalf of Alexander Duyck [alexander.duyck at gmail.com]
> Sent: Tuesday, March 14, 2017 6:14 PM
> To: John Fastabend
> Cc: intel-wired-lan; Alexei Starovoitov; Daniel Borkmann; William Tu
> Subject: Re: [Intel-wired-lan] [RFC PATCH] ixgbe: delay tail write to every     'n' packets
> 
> On Tue, Mar 14, 2017 at 4:50 PM, John Fastabend
> <john.fastabend@gmail.com> wrote:
> > 
> > On 17-03-13 10:18 AM, Alexander Duyck wrote:
> > > 
> > > On Mon, Mar 13, 2017 at 9:16 AM, John Fastabend
> > > <john.fastabend@gmail.com> wrote:
> > > > 
> > > > Current XDP implementation hits the tail on every XDP_TX return
> > > > code. This patch changes driver behavior to only hit the tail after
> > > > packet processing is complete.
> > > > 
> > > > RFC for now as I test this, it looks promising on my dev box but
> > > > want to do some more tests before official submission.
> > > > 
> > > > Signed-off-by: John Fastabend <john.r.fastabend@intel.com>
> > > > ---
> > > >  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   14 +++++++++++---
> > > >  1 file changed, 11 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> > > > index bef4e24..2c244b6 100644
> > > > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> > > > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> > > > @@ -2282,6 +2282,7 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
> > > >         unsigned int mss = 0;
> > > >  #endif /* IXGBE_FCOE */
> > > >         u16 cleaned_count = ixgbe_desc_unused(rx_ring);
> > > > +       bool xdp_xmit = false;
> > > > 
> > > >         while (likely(total_rx_packets < budget)) {
> > > >                 union ixgbe_adv_rx_desc *rx_desc;
> > > > @@ -2321,10 +2322,12 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
> > > >                 }
> > > > 
> > > >                 if (IS_ERR(skb)) {
> > > > -                       if (PTR_ERR(skb) == -IXGBE_XDP_TX)
> > > > +                       if (PTR_ERR(skb) == -IXGBE_XDP_TX) {
> > > > +                               xdp_xmit = true;
> > > >                                 ixgbe_rx_buffer_flip(rx_ring, rx_buffer, size);
> > > > -                       else
> > > > +                       } else {
> > > >                                 rx_buffer->pagecnt_bias++;
> > > > +                       }
> > > >                         total_rx_packets++;
> > > >                         total_rx_bytes += size;
> > > >                 } else if (skb) {
> > > > @@ -2392,6 +2395,12 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
> > > >                 total_rx_packets++;
> > > >         }
> > > > 
> > > > +       if (xdp_xmit) {
> > > > +               struct ixgbe_ring *ring = adapter->xdp_ring[smp_processor_id()];
> > > > +
> > > > +               writel(ring->next_to_use, ring->tail);
> > > > +       }
> > > > +
> > > 
> > > We will need a wmb here.
> > > 
> > > > 
> > > >         u64_stats_update_begin(&rx_ring->syncp);
> > > >         rx_ring->stats.packets += total_rx_packets;
> > > >         rx_ring->stats.bytes += total_rx_bytes;
> > > > @@ -8251,7 +8260,6 @@ static int ixgbe_xmit_xdp_ring(struct ixgbe_adapter *adapter,
> > > >         tx_buffer->next_to_watch = tx_desc;
> > > >         ring->next_to_use = i;
> > > > 
> > > > -       writel(i, ring->tail);
> > > 
> > > So you might want to change the barrier setup for all this to use
> > > smp_wmb instead.  We need the wmb to be paired with the writel.  That
> > > should give you a slight performance boost since smp_wmb breaks down
> > > to just a barrier on x86 systems.
> > > 
> > 
> > Not sure I grok this description entirely, but I think you are just saying
> > replace,
> > 
> >         if (xdp_xmit) {
> >                 ...
> >                 writel(...)
> >         }
> > 
> > with
> > 
> >         if (xdp_xmit) {
> >                 ...
> >                 smp_rmb()
> >                 writel()
> >         }
> > 
> > Correct? Did you have some other change in mind ... "for all this"?
> > 
> > Thanks,
> > John
> 
> 
> No.  Basically what it should be is find and replace wmb with
> smp_wmb() in ixgbe_xmit_xdp_ring.  That way you won't have to worry
> about a race between Tx and clean-up.
> 
> Then the if statement should be:
> if (xdp_xmit) {
>     ...
>     /* wmb required to flush writes to coherent memory before writing
> to non-coherent memory*/
>     wmb();
>     /* writel is a write to non-coherent memory mapped I/O */
>     writel();
> }
> 
> > 
> > > 
> > > > 
> > > >         return IXGBE_XDP_TX;
> > > >  }
> > > > 
> > > > 
> > 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
