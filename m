From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Mon, 13 Dec 2021 12:43:37 +0100
Subject: [Intel-wired-lan] [PATCH intel-net 3/5] ice: xsk: do not clear
 status_error0 for ntu + nb_buffs descriptor
In-Reply-To: <YbcvbjeMFLTMhYaO@boxer>
References: <20211210145941.5865-1-maciej.fijalkowski@intel.com>
 <20211210145941.5865-4-maciej.fijalkowski@intel.com>
 <20211210223746.2711444-1-alexandr.lobakin@intel.com>
 <YbcqjdVw8RfkX62Y@boxer> <20211213112634.37312-1-alexandr.lobakin@intel.com>
 <YbcvbjeMFLTMhYaO@boxer>
Message-ID: <20211213114337.37999-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Mon, 13 Dec 2021 12:33:02 +0100

> On Mon, Dec 13, 2021 at 12:26:34PM +0100, Alexander Lobakin wrote:
> > From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > Date: Mon, 13 Dec 2021 12:12:13 +0100
> > 
> > > On Fri, Dec 10, 2021 at 11:37:46PM +0100, Alexander Lobakin wrote:
> > > > From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > > > Date: Fri, 10 Dec 2021 15:59:39 +0100
> > > > 
> > > > > The descriptor that ntu is pointing at when we exit
> > > > > ice_alloc_rx_bufs_zc() should not have its corresponding DD bit cleared
> > > > > as descriptor is not allocated in there and it is not valid for HW
> > > > > usage.
> > > > > 
> > > > > The allocation routine at the entry will fill the descriptor that ntu
> > > > > points to after it was set to ntu + nb_buffs on previous call.
> > > > > 
> > > > > Even the spec says:
> > > > > "The tail pointer should be set to one descriptor beyond the last empty
> > > > > descriptor in host descriptor ring."
> > > > > 
> > > > > Therefore, step away from clearing the status_error0 on ntu + nb_buffs
> > > > > descriptor.
> > > > > 
> > > > > Fixes: db804cfc21e9 ("ice: Use the xsk batched rx allocation interface")
> > > > > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > > > > ---
> > > > >  drivers/net/ethernet/intel/ice/ice_xsk.c | 7 +------
> > > > >  1 file changed, 1 insertion(+), 6 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > > > > index 5cb61955c1f3..874fce9fa1c3 100644
> > > > > --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> > > > > +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > > > > @@ -394,14 +394,9 @@ bool ice_alloc_rx_bufs_zc(struct ice_rx_ring *rx_ring, u16 count)
> > > > >  	}
> > > > >  
> > > > >  	ntu += nb_buffs;
> > > > > -	if (ntu == rx_ring->count) {
> > > > > -		rx_desc = ICE_RX_DESC(rx_ring, 0);
> > > > > -		xdp = rx_ring->xdp_buf;
> > > > > +	if (ntu == rx_ring->count)
> > > > 
> > > > Maybe use unlikely() here while at it? 1/512 (depending on ring
> > > > size) chance is low enough.
> > > 
> > > This would make sense to me if we would have this check inside some loop
> > > going over the buffers that we received from xsk pool.
> > > 
> > > I tried such approach probably on Tx side and Magnus said that unlikely
> > > will move this code to the cold section at the end of the text section.
> > > 
> > > > 
> > > > >  		ntu = 0;
> > > > > -	}
> > > > >  
> > > > > -	/* clear the status bits for the next_to_use descriptor */
> > > > > -	rx_desc->wb.status_error0 = 0;
> > > > >  	ice_release_rx_desc(rx_ring, ntu);
> > > > 
> > > > This interferes with my patch in next-queue ([0]) (well, supersedes
> > > > it to be precise).
> > > > Tony, what would be better to do with it, just drop mine or correct
> > > > this one (it would become an oneliner removing status_error0
> > > > assignment then)?
> > > 
> > > Oops, sorry. This set should go to net though, not net-next, but I can
> > > base it on top of your patch.
> > 
> > Ah, it's for -net, my bad. Let's leave it as it is then, my series
> > for -next has patches for both i40e and ice, so the latter will be
> > just merged when netdev mains pull net to net-next.
> 
> But we remove the same line in these patches. Your patch has a fixes tag,
> so what was the reason for directing it to -next? Maybe I can include your
> patch onto my set?

My reasoning was that those dead stores don't hurt, so they're
fixes, but mostly cosmetic -> such usually goes to next.
But I think it should be fine to include mines into your series,
thanks!

> 
> > 
> > > 
> > > > 
> > > > >  
> > > > >  	return count == nb_buffs;
> > > > > -- 
> > > > > 2.33.1
> > > > 
> > > > [0] https://lore.kernel.org/netdev/20211130183649.1166842-2-alexandr.lobakin at intel.com
> > > > 
> > > > Al
> > 
> > Al

Al
