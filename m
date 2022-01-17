From: Corinna Vinschen <vinschen@redhat.com>
Date: Mon, 17 Jan 2022 16:57:29 +0100
Subject: [Intel-wired-lan] [PATCH 1/2 net-next v4] igc: avoid kernel
 warning when changing RX ring parameters
In-Reply-To: <YeWD4OG+eYr5B8Sd@wantstofly.org>
References: <20220114194520.1092894-1-vinschen@redhat.com>
 <20220114194520.1092894-2-vinschen@redhat.com>
 <YeWD4OG+eYr5B8Sd@wantstofly.org>
Message-ID: <YeWR6Q6stSFqIghS@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Jan 17 16:57, Lennert Buytenhek wrote:
> On Fri, Jan 14, 2022 at 08:45:19PM +0100, Corinna Vinschen wrote:
> 
> > Calling ethtool changing the RX ring parameters like this:
> > 
> >   $ ethtool -G eth0 rx 1024
> > 
> > on igc triggers kernel warnings like this:
> > 
> > [  225.198467] ------------[ cut here ]------------
> > [  225.198473] Missing unregister, handled but fix driver
> > [  225.198485] WARNING: CPU: 7 PID: 959 at net/core/xdp.c:168
> > xdp_rxq_info_reg+0x79/0xd0
> > [...]
> > @@ -534,10 +526,20 @@ int igc_setup_rx_resources(struct igc_ring *rx_ring)
> >  	rx_ring->next_to_clean = 0;
> >  	rx_ring->next_to_use = 0;
> >  
> > +	/* XDP RX-queue info */
> > +	if (xdp_rxq_info_is_reg(&rx_ring->xdp_rxq))
> > +		xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
> > +	res = xdp_rxq_info_reg(&rx_ring->xdp_rxq, ndev, index,
> > +			       rx_ring->q_vector->napi.napi_id);
> > +	if (res < 0) {
> > +		netdev_err(ndev, "Failed to register xdp_rxq index %u\n",
> > +			   index);
> > +		goto err;
> > +	}
> > +
> >  	return 0;
> >  
> >  err:
> > -	xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
> >  	vfree(rx_ring->rx_buffer_info);
> >  	rx_ring->rx_buffer_info = NULL;
> >  	netdev_err(ndev, "Unable to allocate memory for Rx descriptor ring\n");
> 
> This patch fixes the warning...
> 
> Tested-by: Lennert Buytenhek <buytenh@arista.com>
> 
> ...but doesn't it now forget to free rx_ring->desc if xdp_rxq_info_reg()
> fails?

Uhm... I see what you mean.  But then again, the same error was already
present in igb.  Looks like a call to dma_free_coherent is missing there,
too.

I'll prepare YA patch.

Thanks,
Corinna

