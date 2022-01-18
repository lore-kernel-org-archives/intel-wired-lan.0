From: Corinna Vinschen <vinschen@redhat.com>
Date: Tue, 18 Jan 2022 09:26:01 +0100
Subject: [Intel-wired-lan] [PATCH 3/3 net-next v5] igb/igc: RX queues:
 fix DMA leak in error case
In-Reply-To: <YeZXuoRa/39zzoEY@wantstofly.org>
References: <20220117182915.1283151-1-vinschen@redhat.com>
 <20220117182915.1283151-4-vinschen@redhat.com>
 <YeZXuoRa/39zzoEY@wantstofly.org>
Message-ID: <YeZ5mVY/SpThBi/O@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Jan 18 08:01, Lennert Buytenhek wrote:
> On Mon, Jan 17, 2022 at 07:29:15PM +0100, Corinna Vinschen wrote:
> 
> > When setting up the rx queues, igb and igc neglect to free DMA memory
> > in error case.  Add matching dma_free_coherent calls.
> > 
> > Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
> > ---
> >  drivers/net/ethernet/intel/igb/igb_main.c | 1 +
> >  drivers/net/ethernet/intel/igc/igc_main.c | 1 +
> >  2 files changed, 2 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> > index cea89d301bfd..343568d4ff7f 100644
> > --- a/drivers/net/ethernet/intel/igb/igb_main.c
> > +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> > @@ -4389,6 +4389,7 @@ int igb_setup_rx_resources(struct igb_ring *rx_ring)
> >  	return 0;
> >  
> >  err:
> > +	dma_free_coherent(dev, rx_ring->size, rx_ring->desc, rx_ring->dma);
> >  	vfree(rx_ring->rx_buffer_info);
> >  	rx_ring->rx_buffer_info = NULL;
> >  	dev_err(dev, "Unable to allocate memory for the Rx descriptor ring\n");
> > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> > index 56ed0f1463e5..f323cec0b74f 100644
> > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> > @@ -540,6 +540,7 @@ int igc_setup_rx_resources(struct igc_ring *rx_ring)
> >  	return 0;
> >  
> >  err:
> > +	dma_free_coherent(dev, rx_ring->size, rx_ring->desc, rx_ring->dma);
> >  	vfree(rx_ring->rx_buffer_info);
> >  	rx_ring->rx_buffer_info = NULL;
> >  	netdev_err(ndev, "Unable to allocate memory for Rx descriptor ring\n");
> 
> If the vzalloc() call in igc_setup_rx_resources() fails, and we jump
> to 'err' before dma_alloc_coherent() was reached, won't dma_free_coherent()
> be called inadvertently here?

These calls all check for a NULL pointer themselves.

Corinna

