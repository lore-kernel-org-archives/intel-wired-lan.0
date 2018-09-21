From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 21 Sep 2018 11:17:30 -0700
Subject: [Intel-wired-lan] [PATCH v2 1/4] i40e: clean zero-copy XDP Tx
 ring on shutdown/reset
In-Reply-To: <CAJ+HfNgYwWo1Cmx81SGSRAPEtVzKvogaWSL17vPuorYpx-U-Lw@mail.gmail.com>
References: <20180907081848.5438-1-bjorn.topel@gmail.com>
 <20180907081848.5438-2-bjorn.topel@gmail.com>
 <CAJ+HfNgYwWo1Cmx81SGSRAPEtVzKvogaWSL17vPuorYpx-U-Lw@mail.gmail.com>
Message-ID: <36294f373ac94ec5858a54b55b98a5df49c7bffe.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2018-09-21 at 09:35 +0200, Bj?rn T?pel wrote:
> > --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > @@ -830,3 +830,33 @@ int i40e_xsk_async_xmit(struct net_device
> > *dev, u32 queue_id)
> > 
> >          return 0;
> >   }
> > +
> > +/**
> > + * i40e_xsk_clean_xdp_ring - Clean the XDP Tx ring on shutdown
> > + * @xdp_ring: XDP Tx ring
> > + **/
> > +void i40e_xsk_clean_tx_ring(struct i40e_ring *tx_ring)
> > +{
> > +       u16 ntc = tx_ring->next_to_clean, ntu = tx_ring-
> > >next_to_use;
> > +       struct xdp_umem *umem = tx_ring->xsk_umem;
> > +       struct i40e_tx_buffer *tx_bi;
> > +       u32 xsk_frames = 0;
> > +
> > +       while (ntc != ntu) {
> > +               tx_bi = &tx_ring->tx_bi[ntc];
> > +
> > +               if (tx_bi->xdpf)
> > +                       i40e_clean_xdp_tx_buffer(tx_ring, tx_bi);
> > +               else
> > +                       xsk_frames++;
> > +
> > +               tx_bi->xdpf = NULL;
> > +
> > +               ntc++;
> > +               if (ntc > tx_ring->count)
> 
> This is an off-by-one error, and should be:
> if (ntc == tx_ring->count)
> 
> Can you fix it up, or should I respin the patch?

I can fix it up.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180921/87ac4ab5/attachment-0001.asc>
