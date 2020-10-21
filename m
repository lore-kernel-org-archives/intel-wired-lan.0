From: Andre Guedes <andre.guedes@intel.com>
Date: Wed, 21 Oct 2020 15:16:51 -0700
Subject: [Intel-wired-lan] [PATCH 6/9] igc: Add Initial XDP support
In-Reply-To: <20201021142349.GB58344@ranger.igk.intel.com>
References: <20201009025349.4037-1-andre.guedes@intel.com>
 <20201009025349.4037-7-andre.guedes@intel.com>
 <20201021142349.GB58344@ranger.igk.intel.com>
Message-ID: <160331861110.64680.5464177597166949008@lsachorn-mobl.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Maciej,

Thank you for your review.

Quoting Maciej Fijalkowski (2020-10-21 07:23:49)
> On Thu, Oct 08, 2020 at 07:53:46PM -0700, Andre Guedes wrote:
> > This patch adds the initial XDP support to the igc driver. For now,
> > only XDP_PASS, XDP_DROP, XDP_ABORT actions are supported. Upcoming
> 
> s/XDP_ABORT/XDP_ABORTED

Good catch, I'll fix it.

> > @@ -1592,11 +1593,11 @@ static struct sk_buff *igc_build_skb(struct igc_ring *rx_ring,
> >  
> >  static struct sk_buff *igc_construct_skb(struct igc_ring *rx_ring,
> >                                        struct igc_rx_buffer *rx_buffer,
> > -                                      unsigned int size, int pkt_offset,
> > +                                      struct xdp_buff *xdp,
> >                                        ktime_t timestamp)
> >  {
> > -     void *va = page_address(rx_buffer->page) + rx_buffer->page_offset +
> > -                pkt_offset;
> > +     void *va = xdp->data;
> > +     unsigned int size = xdp->data_end - xdp->data;
> >       unsigned int truesize = igc_get_rx_frame_truesize(rx_ring, size);
> >       unsigned int headlen;
> >       struct sk_buff *skb;
> 
> RCT

We can move 'va' declaration around, but note that 'size' is utilized to
calculate 'truesize' so the RCT won't be perfect still.

> > @@ -1932,24 +1939,37 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
> >  
> >               rx_buffer = igc_get_rx_buffer(rx_ring, size);
> >  
> > -             if (igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
> > -                     void *pktbuf = page_address(rx_buffer->page) +
> > -                                    rx_buffer->page_offset;
> > +             pktbuf = page_address(rx_buffer->page) + rx_buffer->page_offset;
> >  
> > +             if (igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
> >                       timestamp = igc_ptp_rx_pktstamp(q_vector->adapter,
> >                                                       pktbuf);
> >                       pkt_offset = IGC_TS_HDR_LEN;
> >                       size -= IGC_TS_HDR_LEN;
> >               }
> >  
> > -             /* retrieve a buffer from the ring */
> > -             if (skb)
> > +             if (!skb) {
> > +                     struct igc_adapter *adapter = q_vector->adapter;
> > +
> > +                     xdp.data = pktbuf + pkt_offset;
> > +                     xdp.data_end = xdp.data + size;
> > +                     xdp.data_hard_start = pktbuf - igc_rx_offset(rx_ring);
> 
> This needs some fixing. You're saying that build_skb() can't be currently
> used which means that the headroom given for XDP will always be zero.
> 
> You need to either teach igc_rx_offset to return XDP_PACKET_HEADROOM for
> case when ring is not using build_skb() or make build_skb() usable.

The xdp headroom doesn't seem to be required to support XDP_PASS, XDP_DROP and
XDP_ABORTED actions, which is the goal of this patch. That was the rationale to
not change igc_rx_offset() in this patch.

The igc_rx_offset() helper is updated in the next patch which adds support for
XDP_TX action since it requires xdp headroom.

> > +                     xdp_set_data_meta_invalid(&xdp);
> 
> What about xdp.frame_sz?

Same as above.

> > @@ -3881,6 +3901,11 @@ static int igc_change_mtu(struct net_device *netdev, int new_mtu)
> >       int max_frame = new_mtu + ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN;
> 
> I think I was mentioning it with igb xdp review, shouldn't we take double
> vlan header into account?

Good question. It seems like we should take it into consideration when updating
adapter->max_frame_size later in the igc_change_mtu(). However, note that in
the code added below, we check 'new_mtu', not 'max_frame', so with or without
double tagging it should do the right thing.

> > +     if (igc_xdp_is_enabled(adapter) && new_mtu > ETH_DATA_LEN) {
> > +             netdev_dbg(netdev, "Jumbo frames not supported with XDP");
> > +             return -EINVAL;
> > +     }
> > +

[...]

> > +struct sk_buff *igc_xdp_run_prog(struct igc_adapter *adapter,
> > +                              struct xdp_buff *xdp)
> > +{
> > +     struct bpf_prog *prog;
> > +     int res;
> > +     u32 act;
> > +
> > +     rcu_read_lock();
> > +
> > +     prog = READ_ONCE(adapter->xdp_prog);
> > +     if (!prog)
> > +             goto unlock;
> 
> res will be uninitialized if you hit this goto.

Good catch, I'll fix it.

Best,
Andre
