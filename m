From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Tue, 22 Dec 2020 13:33:14 +0100
Subject: [Intel-wired-lan] [PATCH 08/10] igc: Replace IGC_TX_FLAGS_XDP
 flag by an enum
In-Reply-To: <160859962833.45139.11189791470425967959@bgdudka-mobl.amr.corp.intel.com>
References: <20201217202415.77891-1-andre.guedes@intel.com>
 <20201217202415.77891-9-andre.guedes@intel.com>
 <20201221230905.GD2943@ranger.igk.intel.com>
 <160859962833.45139.11189791470425967959@bgdudka-mobl.amr.corp.intel.com>
Message-ID: <20201222123314.GF2943@ranger.igk.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Dec 21, 2020 at 05:13:48PM -0800, Andre Guedes wrote:
> Quoting Maciej Fijalkowski (2020-12-21 15:09:05)
> > > @@ -191,10 +191,18 @@ static void igc_clean_tx_ring(struct igc_ring *tx_ring)
> > >       while (i != tx_ring->next_to_use) {
> > >               union igc_adv_tx_desc *eop_desc, *tx_desc;
> > >  
> > > -             if (tx_buffer->tx_flags & IGC_TX_FLAGS_XDP)
> > > +             switch (tx_buffer->type) {
> > > +             case IGC_TX_BUFFER_TYPE_XDP:
> > >                       xdp_return_frame(tx_buffer->xdpf);
> > > -             else
> > > +                     break;
> > > +             case IGC_TX_BUFFER_TYPE_SKB:
> > >                       dev_kfree_skb_any(tx_buffer->skb);
> > > +                     break;
> > > +             default:
> > > +                     netdev_warn_once(tx_ring->netdev,
> > > +                                      "Unknown tx buffer type\n");
> > > +                     break;
> > > +             }
> > 
> > nit: you've been doing some effort in order to reduce the code duplication
> > as much as it's possible, yet here you introduce duplicated code for that
> > desc cleanup :p maybe add a little helper for that as well?
> 
> Note that the handling in IGC_TX_BUFFER_TYPE_SKB case is different in
> igc_clean_tx_irq(): dev_kfree_skb_any() vs napi_consume_skb().

Yikes! Sorry, it was late.
