From: Jesper Dangaard Brouer <brouer@redhat.com>
Date: Wed, 11 Nov 2020 11:15:56 +0100
Subject: [Intel-wired-lan] [PATCH net v3 3/6] igb: XDP extack message on
 error
In-Reply-To: <20201111093909.wukhqafy3khycks5@SvensMacbookPro.hq.voleatech.com>
References: <20201019080553.24353-1-sven.auhagen@voleatech.de>
 <20201019080553.24353-4-sven.auhagen@voleatech.de>
 <fc1f6aad-b587-25e2-0632-ea43f1032aad@molgen.mpg.de>
 <20201111093909.wukhqafy3khycks5@SvensMacbookPro.hq.voleatech.com>
Message-ID: <20201111111556.51d17e75@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 11 Nov 2020 10:39:09 +0100
Sven Auhagen <sven.auhagen@voleatech.de> wrote:

> On Wed, Nov 11, 2020 at 08:11:46AM +0100, Paul Menzel wrote:
> > Dear Sven,
> > 
> > 
> > Am 19.10.20 um 10:05 schrieb sven.auhagen at voleatech.de:  
> > > From: Sven Auhagen <sven.auhagen@voleatech.de>
> > > 
> > > Add an extack error message when the RX buffer size is too small
> > > for the frame size.
> > > 
> > > Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > > Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > > Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > > Signed-off-by: Sven Auhagen <sven.auhagen@voleatech.de>
> > > ---
> > >   drivers/net/ethernet/intel/igb/igb_main.c | 12 +++++++-----
> > >   1 file changed, 7 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> > > index 0a9198037b98..088f9ddb0093 100644
> > > --- a/drivers/net/ethernet/intel/igb/igb_main.c
> > > +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> > > @@ -2824,20 +2824,22 @@ static int igb_setup_tc(struct net_device *dev, enum tc_setup_type type,
> > >   	}
> > >   }
> > > -static int igb_xdp_setup(struct net_device *dev, struct bpf_prog *prog)
> > > +static int igb_xdp_setup(struct net_device *dev, struct netdev_bpf *bpf)
> > >   {
> > >   	int i, frame_size = dev->mtu + IGB_ETH_PKT_HDR_PAD;
> > >   	struct igb_adapter *adapter = netdev_priv(dev);
> > > +	struct bpf_prog *prog = bpf->prog, *old_prog;
> > >   	bool running = netif_running(dev);
> > > -	struct bpf_prog *old_prog;
> > >   	bool need_reset;
> > >   	/* verify igb ring attributes are sufficient for XDP */
> > >   	for (i = 0; i < adapter->num_rx_queues; i++) {
> > >   		struct igb_ring *ring = adapter->rx_ring[i];
> > > -		if (frame_size > igb_rx_bufsz(ring))
> > > +		if (frame_size > igb_rx_bufsz(ring)) {
> > > +			NL_SET_ERR_MSG_MOD(bpf->extack, "The RX buffer size is too small for the frame size");  
> > 
> > Could you please also add both size values to the error message?  
> 
> Dear Paul,
> 
> yes, sure.
> I will send a new series with that change.

I don't think it is possible to send this extra variable info via
extack (but the macro might have improved since last I checked).

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

