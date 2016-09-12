From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 12 Sep 2016 16:07:47 -0700
Subject: [Intel-wired-lan] [net-next PATCH v3 2/3] e1000: add initial
	XDP support
In-Reply-To: <1473720399.18970.91.camel@edumazet-glaptop3.roam.corp.google.com>
References: <20160912220312.5610.77528.stgit@john-Precision-Tower-5810>
 <20160912221351.5610.29043.stgit@john-Precision-Tower-5810>
 <1473720399.18970.91.camel@edumazet-glaptop3.roam.corp.google.com>
Message-ID: <20160912230745.GA24171@ast-mbp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Sep 12, 2016 at 03:46:39PM -0700, Eric Dumazet wrote:
> On Mon, 2016-09-12 at 15:13 -0700, John Fastabend wrote:
> > From: Alexei Starovoitov <ast@fb.com>
> 
> > +static void e1000_xmit_raw_frame(struct e1000_rx_buffer *rx_buffer_info,
> > +				 u32 len,
> > +				 struct net_device *netdev,
> > +				 struct e1000_adapter *adapter)
> > +{
> > +	struct netdev_queue *txq = netdev_get_tx_queue(netdev, 0);
> > +	struct e1000_hw *hw = &adapter->hw;
> > +	struct e1000_tx_ring *tx_ring;
> > +
> > +	if (len > E1000_MAX_DATA_PER_TXD)
> > +		return;
> > +
> > +	/* e1000 only support a single txq at the moment so the queue is being
> > +	 * shared with stack. To support this requires locking to ensure the
> > +	 * stack and XDP are not running at the same time. Devices with
> > +	 * multiple queues should allocate a separate queue space.
> > +	 */
> > +	HARD_TX_LOCK(netdev, txq, smp_processor_id());
> > +
> > +	tx_ring = adapter->tx_ring;
> > +
> > +	if (E1000_DESC_UNUSED(tx_ring) < 2) {
> > +		HARD_TX_UNLOCK(netdev, txq);
> > +		return;
> > +	}
> > +
> > +	if (netif_xmit_frozen_or_stopped(txq))
> > +		return;
> > +
> > +	e1000_tx_map_rxpage(tx_ring, rx_buffer_info, len);
> > +	netdev_sent_queue(netdev, len);
> > +	e1000_tx_queue(adapter, tx_ring, 0/*tx_flags*/, 1);
> > +
> > +	writel(tx_ring->next_to_use, hw->hw_addr + tx_ring->tdt);
> > +	mmiowb();
> > +
> > +	HARD_TX_UNLOCK(netdev, txq);
> > +}
> 
> 
> e1000_tx_map() is full of workarounds.
> 
> Have a look at last_tx_tso for example.
> 
>                /* Workaround for Controller erratum --
>                  * descriptor for non-tso packet in a linear SKB that follows a
>                  * tso gets written back prematurely before the data is fully
>                  * DMA'd to the controller
>                  */
>                 if (!skb->data_len && tx_ring->last_tx_tso &&
>                     !skb_is_gso(skb)) {
>                         tx_ring->last_tx_tso = false;
>                         size -= 4;
>                 }
> 
> Look, this XDP_TX thing is hard to properly implement and test on
> various NIC revisions.

my reading of these e1k workarounds are for old versions of the nic that
don't even exist anymore. I believe none of them apply to qemu e1k.

> Without proper queue management, high prio packets in qdisc wont be sent
> if NIC is under RX -> XDP_TX flood.

yep. there are various ways to shoot yourself in the foot with xdp.
The simplest program that drops all the packets will make the box unpingable.

> Sounds a horrible feature to me.

yep. not pretty by any means.
This whole thing is only to test xdp programs under qemu which
realistically emulates only e1k.
I simply don't see any other options to test xdp under kvm.

