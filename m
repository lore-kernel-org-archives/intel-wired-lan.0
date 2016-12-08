From: David Laight <David.Laight@ACULAB.COM>
Date: Thu, 8 Dec 2016 10:31:21 +0000
Subject: [Intel-wired-lan] [RFC PATCH] i40e: enable PCIe relax ordering
 for SPARC
In-Reply-To: <CAKgT0UcyRSub0NCi7oHX2Vf+N4vQxzwdWmcc+V+jOX_J=RYgfg@mail.gmail.com>
References: <1480957627-16825-1-git-send-email-tushar.n.dave@oracle.com>
 <CAKgT0UcyRSub0NCi7oHX2Vf+N4vQxzwdWmcc+V+jOX_J=RYgfg@mail.gmail.com>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DB02382B2@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck
> Sent: 05 December 2016 21:55
...
> > @@ -1010,6 +1018,11 @@ int i40e_setup_tx_descriptors(struct i40e_ring *tx_ring)
> >          */
> >         tx_ring->size += sizeof(u32);
> >         tx_ring->size = ALIGN(tx_ring->size, 4096);
> > +#ifdef CONFIG_SPARC
> > +       tx_ring->dma_attrs = DMA_ATTR_WEAK_ORDERING;
> > +#else
> > +       tx_ring->dma_attrs = 0;
> > +#endif
> >         tx_ring->desc = dma_alloc_coherent(dev, tx_ring->size,
> >                                            &tx_ring->dma, GFP_KERNEL);
> >         if (!tx_ring->desc) {
> 
> Also not a fan of adding yet ring attribute.  Is there any reason why
> you couldn't simply add a set of inline functions at the start of
> i40e_txrx.c that could replace the DMA map/unmap operations in this
> code but pass either 0 or DMA_ATTR_WEAK_ORDERING as needed for the
> drivers?  Then the x86 code doesn't have to change while the SPARC
> code will be able to be passed the attribute.

Or use something like:
#ifdef CONFIG_SPARC
       #define RING_DMA_ATTR DMA_ATTR_WEAK_ORDERING
#else
       #define RING_DMA_ATTR 0
#endif
and pass the constant to the function calls.

Is there actually ever a problem passing DMA_ATTR_WEAK_ORDERING?
I'd guess that it will be ignored if it can't be implemented (or isn't needed).

	David

