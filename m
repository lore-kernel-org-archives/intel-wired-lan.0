From: Corinna Vinschen <vinschen@redhat.com>
Date: Fri, 14 Jan 2022 20:44:36 +0100
Subject: [Intel-wired-lan] [PATCH 1/2 net-next v3] igc: avoid kernel
 warning when changing RX ring parameters
In-Reply-To: <YeHOHp2vztm1Oi5V@calimero.vinschen.de>
References: <20220114165106.1085474-1-vinschen@redhat.com>
 <20220114165106.1085474-2-vinschen@redhat.com>
 <87czku6sm2.fsf@intel.com> <YeHOHp2vztm1Oi5V@calimero.vinschen.de>
Message-ID: <YeHSpMX4H950NV8K@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Jan 14 20:25, Corinna Vinschen wrote:
> On Jan 14 11:10, Vinicius Costa Gomes wrote:
> > Corinna Vinschen <vinschen@redhat.com> writes:
> > 
> > > Calling ethtool changing the RX ring parameters like this:
> > >
> > >   $ ethtool -G eth0 rx 1024
> > >
> > > on igc triggers the "Missing unregister, handled but fix driver" warning in
> > > xdp_rxq_info_reg().
> > >
> > > igc_ethtool_set_ringparam() copies the igc_ring structure but neglects to
> > > reset the xdp_rxq_info member before calling igc_setup_rx_resources().
> > > This in turn calls xdp_rxq_info_reg() with an already registered xdp_rxq_info.
> > >
> > > Make sure to unregister the xdp_rxq_info structure first in
> > > igc_setup_rx_resources.  Move xdp_rxq_info handling down to bethe last
> > > action, thus allowing to remove the xdp_rxq_info_unreg call in the error path.
> > >
> > > Fixes: 73f1071c1d29 ("igc: Add support for XDP_TX action")
> > > Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
> > > ---
> > >  drivers/net/ethernet/intel/igc/igc_main.c | 20 +++++++++++---------
> > >  1 file changed, 11 insertions(+), 9 deletions(-)
> > > [...]
> > > @@ -534,10 +526,20 @@ int igc_setup_rx_resources(struct igc_ring *rx_ring)
> > >  	rx_ring->next_to_clean = 0;
> > >  	rx_ring->next_to_use = 0;
> > >  
> > > +	/* XDP RX-queue info */
> > > +	if (xdp_rxq_info_is_reg(&rx_ring->xdp_rxq))
> > > +		xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
> > > +	res = xdp_rxq_info_reg(&rx_ring->xdp_rxq, ndev, index,
> > > +			       rx_ring->q_vector->napi.napi_id);
> > > +	if (res < 0) {
> > > +		netdev_err(ndev, "Failed to register xdp_rxq index %u\n",
> > > +			   index);
> > > +		return res;
> > 
> > Here and in the igb patch, it should be 'goto err', no?
> 
> D'oh, of course.  Soory and thanks for catching.  I'll prepare a v4.
> 
> > Another suggestion is to add the warning that Lennert reported in the
> > commit message (the comment from Maciej in that other thread).
> 
> The current commit message already mentiones the "Missing unregister,
> handled but fix driver" warning.  Do you mean the entire warning
> snippet including call stack?  If so, no problem.  I'll add it to v4,
> too.
> 
> Shall I also add "Reported-by: Lennert ..."?  Funny enough we
> encountered the problem independently at almost the same time, so when I
> sent my v1 of the patch I wasn't even aware of the thread started by
> Lennert and only saw it afterwards :}

Never mind, I just send a v4 with all of that.


Corinna

