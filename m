From: Andre Guedes <andre.guedes@intel.com>
Date: Wed, 21 Oct 2020 15:17:04 -0700
Subject: [Intel-wired-lan] [PATCH 7/9] igc: Add support for XDP_TX action
In-Reply-To: <20201021145742.GC58344@ranger.igk.intel.com>
References: <20201009025349.4037-1-andre.guedes@intel.com>
 <20201009025349.4037-8-andre.guedes@intel.com>
 <20201021145742.GC58344@ranger.igk.intel.com>
Message-ID: <160331862448.64680.18381150586195546148@lsachorn-mobl.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Maciej,

Quoting Maciej Fijalkowski (2020-10-21 07:57:42)
> On Thu, Oct 08, 2020 at 07:53:47PM -0700, Andre Guedes wrote:
> > This patch adds support for XDP_TX action which enables XDP programs to
> > transmit back receiving frames.
> > 
> > The main changes in igc_xdp.c are related to the transmission of the
> > packet (e.g. select the transmission queue, prepare buffer, prepare
> > descriptor) while the changes in igc_main.c are related to tx_buffer
> > management and XDP resources setup required to perform the XDP_TX
> > action.
> > 
> > By default, the driver uses rx buffers with 2 KB size. When XDP is
> > enabled, it uses larger buffers so we have enough space to accommodate
> > the headroom and tailroom required by XDP infrastructure. While the
> > driver had already code to handle larger buffers (IGC_RING_FLAG_RX_3K_
> > BUFFER flag), it was missing the set/clear helpers that enable/disable
> > that feature so this patch also introduces these missing helpers.
> 
> Ugh. This belongs to the previous patch.

Hope the reply on the previous patch clarifies why this is done in this patch
instead.

> > +/* This function requires __netif_tx_lock is held by the caller. */
> > +static int igc_xdp_init_tx_descriptor(struct igc_ring *ring,
> > +                                   struct xdp_frame *xdpf)
> > +{
> > +     struct igc_tx_buffer *buffer;
> > +     union igc_adv_tx_desc *desc;
> > +     u32 cmd_type, olinfo_status;
> > +     int err;
> > +
> > +     if (!igc_desc_unused(ring))
> > +             return -EBUSY;
> > +
> > +     buffer = &ring->tx_buffer_info[ring->next_to_use];
> > +     err = igc_xdp_init_tx_buffer(buffer, xdpf, ring);
> > +     if (err)
> > +             return err;
> > +
> > +     cmd_type = IGC_ADVTXD_DTYP_DATA | IGC_ADVTXD_DCMD_DEXT |
> > +                IGC_ADVTXD_DCMD_IFCS | IGC_TXD_DCMD |
> > +                buffer->bytecount;
> > +     olinfo_status = buffer->bytecount << IGC_ADVTXD_PAYLEN_SHIFT;
> > +
> > +     desc = IGC_TX_DESC(ring, ring->next_to_use);
> > +     desc->read.cmd_type_len = cpu_to_le32(cmd_type);
> > +     desc->read.olinfo_status = cpu_to_le32(olinfo_status);
> > +     desc->read.buffer_addr = cpu_to_le64(dma_unmap_addr(buffer, dma));
> > +
> > +     netdev_tx_sent_queue(txring_txq(ring), buffer->bytecount);
> 
> So you're letting stack know that you sent a frame but that's not what is
> happening because you wait with bumping the tail until you are done with
> napi rx loop.
> 
> this probably should be called during the tx irq cleanup.

I see your point, and I think calling it during tx irq cleanup should work too.

The rationale to put it here was to keep it similar to ndo_start_xmit's flow
i.e. the stack is notified before packets are actually transmitted by
hardware. Also, if we do it in tx irq cleanup, we probably need to acquire
__netif_tx_lock to ensure we don't have a race conditions with ndo_start_xmit.

Let me know your thoughts here.

> > +
> > +     buffer->next_to_watch = desc;
> > +
> > +     ring->next_to_use = (ring->next_to_use + 1) % ring->count;
> 
> Please avoid modulos.

Sure, I'll do it. Just out of curiosity, why modulo operation should be
avoided?

> > +void igc_xdp_unregister_rxq_info(struct igc_ring *ring)
> > +{
> > +     xdp_rxq_info_unreg_mem_model(&ring->xdp_rxq);
> 
> xdp_rxq_info_unreg will call internally the xdp_rxq_info_unreg_mem_model
> so I think the call above is redundant.

Yep, you're right, this is redundant. I'll remove it.

Thanks,
Andre
