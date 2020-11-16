From: Michael S. Tsirkin <mst@redhat.com>
Date: Mon, 16 Nov 2020 07:42:34 -0500
Subject: [Intel-wired-lan] [PATCH bpf-next v2 06/10] xsk: propagate
 napi_id to XDP socket Rx path
In-Reply-To: <614a7ce4-2b6b-129b-de7d-71428f7a71f6@intel.com>
References: <20201116110416.10719-1-bjorn.topel@gmail.com>
 <20201116110416.10719-7-bjorn.topel@gmail.com>
 <20201116064953-mutt-send-email-mst@kernel.org>
 <614a7ce4-2b6b-129b-de7d-71428f7a71f6@intel.com>
Message-ID: <20201116073848-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Nov 16, 2020 at 01:01:40PM +0100, Bj??rn T??pel wrote:
> 
> On 2020-11-16 12:55, Michael S. Tsirkin wrote:
> > On Mon, Nov 16, 2020 at 12:04:12PM +0100, Bj????rn T????pel wrote:
> > > From: Bj????rn T????pel <bjorn.topel@intel.com>
> > > 
> > > Add napi_id to the xdp_rxq_info structure, and make sure the XDP
> > > socket pick up the napi_id in the Rx path. The napi_id is used to find
> > > the corresponding NAPI structure for socket busy polling.
> > > 
> > > Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > Signed-off-by: Bj????rn T????pel <bjorn.topel@intel.com>
> > 
> > A bunch of drivers just pass in 0. could you explain when
> > is that ok? how bad is it if the wrong id is used?
> > 
> 
> If zero is passed, which is a non-valid NAPI_ID, busy-polling will never
> be performed.
> 
> Depending on the structure of the driver, napi might or might not be
> initialized (napi_id != 0) or even available. When it wasn't obvious, I
> simply set it to zero.
> 
> So, short; No harm if zero, but busy-polling cannot be used in an XDP
> context.
> 
> 
> [...]
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 21b71148c532..d71fe41595b7 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -1485,7 +1485,7 @@ static int virtnet_open(struct net_device *dev)
> > >   			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> > >   				schedule_delayed_work(&vi->refill, 0);
> > > -		err = xdp_rxq_info_reg(&vi->rq[i].xdp_rxq, dev, i);
> > > +		err = xdp_rxq_info_reg(&vi->rq[i].xdp_rxq, dev, i, 0);
> > >   		if (err < 0)
> > >   			return err;
> > 
> > Should this be rq.napi.napi_id ?
> > 
> 
> Yes, if rq.napi.napi_id is valid here! Is it?

What initializes it? netif_napi_add? Then I think yes, it's
initialized for all queues ...
Needs to be tested naturally.

> 
> Cheers,
> Bj??rn

