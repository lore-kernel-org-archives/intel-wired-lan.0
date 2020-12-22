From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Tue, 22 Dec 2020 13:32:05 +0100
Subject: [Intel-wired-lan] [PATCH 04/10] igc: Refactor XDP rxq info
 registration
In-Reply-To: <160859961079.45139.12880409788363593695@bgdudka-mobl.amr.corp.intel.com>
References: <20201217202415.77891-1-andre.guedes@intel.com>
 <20201217202415.77891-5-andre.guedes@intel.com>
 <20201221225345.GB2943@ranger.igk.intel.com>
 <160859961079.45139.12880409788363593695@bgdudka-mobl.amr.corp.intel.com>
Message-ID: <20201222123205.GE2943@ranger.igk.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Dec 21, 2020 at 05:13:30PM -0800, Andre Guedes wrote:
> Quoting Maciej Fijalkowski (2020-12-21 14:53:45)
> > > @@ -460,9 +460,12 @@ int igc_setup_rx_resources(struct igc_ring *rx_ring)
> > >       struct device *dev = rx_ring->dev;
> > >       int size, desc_len, res;
> > >  
> > > -     res = igc_xdp_register_rxq_info(rx_ring);
> > > -     if (res < 0)
> > > +     res = xdp_rxq_info_reg(&rx_ring->xdp_rxq, ndev, rx_ring->queue_index,
> > > +                            0);
> > > +     if (res < 0) {
> > > +             netdev_err(ndev, "Failed to register xdp rxq info\n");
> > 
> > Maybe print out q idx?
> 
> I'll add that.
> 
> > > @@ -536,6 +539,9 @@ static void igc_configure_rx_ring(struct igc_adapter *adapter,
> > >       u32 srrctl = 0, rxdctl = 0;
> > >       u64 rdba = ring->dma;
> > >  
> > > +     WARN_ON(xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
> > > +                                        MEM_TYPE_PAGE_SHARED, NULL));
> > 
> > You should do the unroll in case it fails just like it was done in
> > igc_xdp_register_rxq_info.
> 
> This was inspired in ixgbe driver.
> 
> The only reason xdp_rxq_info_reg_mem_model() could fail here is if xdp_rxq
> wasn't registered. However, this is very unlikely to happen since it is
> registered in igc_setup_rx_resources() which is always called before
> igc_configure_rx_ring(). The WARN_ON() macro is used just in case.

Agreed on that but let's not disregard the other failure cases that can
happen by saying that it can only fail when xdp_rxq wasn't registered.

I believe that functions returning statuses have been written in such way
for some reason, so I feel that ignoring error statuses is a wrong
attitude.

For example, igc_setup_all_rx_resources return value is ignored in
igc_request_irq, but in __igc_open it is checked. Why?

One last thing is that all other drivers besides igb/ixgbe do the error
handling.

> 
> If we really want to unroll, we should propagate the error back in the call
> chain, changing the returning type of igc_configure_rx_ring() as well as the
> other functions in the call chain, so the unrolling is done in the proper
> place.
> 
> IMO, such change isn't worth it. It seems like a lot of change to cover a case
> that is never expected. WARN_ON() sound more suitable in those cases. Also,
> ixgbe is around for quite some time and this doesn't seem to be an issue.

Well, although I don't like it, I agree :P

The uncomfortable question would be what will happen if we fail to
register that mem model but due to the fact that driver is written in a
way that it is not profitable to do unrolling?
