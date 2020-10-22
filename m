From: Andre Guedes <andre.guedes@intel.com>
Date: Thu, 22 Oct 2020 11:04:49 -0700
Subject: [Intel-wired-lan] [PATCH 6/9] igc: Add Initial XDP support
In-Reply-To: <20201022095310.GB61349@ranger.igk.intel.com>
References: <20201009025349.4037-1-andre.guedes@intel.com>
 <20201009025349.4037-7-andre.guedes@intel.com>
 <20201021142349.GB58344@ranger.igk.intel.com>
 <160331861110.64680.5464177597166949008@lsachorn-mobl.amr.corp.intel.com>
 <20201022095310.GB61349@ranger.igk.intel.com>
Message-ID: <160338988934.80318.13500288333733608305@skottana-mobl.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Maciej,

Quoting Maciej Fijalkowski (2020-10-22 02:53:10)
> > > > @@ -1932,24 +1939,37 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
> > > >  
> > > >               rx_buffer = igc_get_rx_buffer(rx_ring, size);
> > > >  
> > > > -             if (igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
> > > > -                     void *pktbuf = page_address(rx_buffer->page) +
> > > > -                                    rx_buffer->page_offset;
> > > > +             pktbuf = page_address(rx_buffer->page) + rx_buffer->page_offset;
> > > >  
> > > > +             if (igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
> > > >                       timestamp = igc_ptp_rx_pktstamp(q_vector->adapter,
> > > >                                                       pktbuf);
> > > >                       pkt_offset = IGC_TS_HDR_LEN;
> > > >                       size -= IGC_TS_HDR_LEN;
> > > >               }
> > > >  
> > > > -             /* retrieve a buffer from the ring */
> > > > -             if (skb)
> > > > +             if (!skb) {
> > > > +                     struct igc_adapter *adapter = q_vector->adapter;
> > > > +
> > > > +                     xdp.data = pktbuf + pkt_offset;
> > > > +                     xdp.data_end = xdp.data + size;
> > > > +                     xdp.data_hard_start = pktbuf - igc_rx_offset(rx_ring);
> > > 
> > > This needs some fixing. You're saying that build_skb() can't be currently
> > > used which means that the headroom given for XDP will always be zero.
> > > 
> > > You need to either teach igc_rx_offset to return XDP_PACKET_HEADROOM for
> > > case when ring is not using build_skb() or make build_skb() usable.
> > 
> > The xdp headroom doesn't seem to be required to support XDP_PASS, XDP_DROP and
> > XDP_ABORTED actions, which is the goal of this patch. That was the rationale to
> > not change igc_rx_offset() in this patch.
> > 
> > The igc_rx_offset() helper is updated in the next patch which adds support for
> > XDP_TX action since it requires xdp headroom.
> 
> Sorry when I wrote that I haven't looked at next patch.
> The thing is that you can have a bpf program that will do the
> encapsulation and return XDP_PASS for example. For encapsulation you need
> to provide a headroom.

Understood, thanks for the example. I was not aware of the encapsulation +
XDP_PASS case. I'll fix this in the v2.

> > > > @@ -3881,6 +3901,11 @@ static int igc_change_mtu(struct net_device *netdev, int new_mtu)
> > > >       int max_frame = new_mtu + ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN;
> > > 
> > > I think I was mentioning it with igb xdp review, shouldn't we take double
> > > vlan header into account?
> > 
> > Good question. It seems like we should take it into consideration when updating
> > adapter->max_frame_size later in the igc_change_mtu(). However, note that in
> > the code added below, we check 'new_mtu', not 'max_frame', so with or without
> > double tagging it should do the right thing.
> 
> Hm yeah but I think it should be fixed anyway even without xdp being in
> picture?

Agreed. I can provide a separate patch soon.

Cheers,
Andre
