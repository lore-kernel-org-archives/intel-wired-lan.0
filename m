From: Andre Guedes <andre.guedes@intel.com>
Date: Wed, 23 Dec 2020 11:27:04 -0800
Subject: [Intel-wired-lan] [PATCH 09/10] igc: Enable RX via AF_XDP
 zero-copy
In-Reply-To: <20201222205925.GA10157@ranger.igk.intel.com>
References: <20201217202415.77891-1-andre.guedes@intel.com>
 <20201217202415.77891-10-andre.guedes@intel.com>
 <20201222131428.GG2943@ranger.igk.intel.com>
 <160865901948.65485.17595669491129234170@ticela-az-003.amr.corp.intel.com>
 <20201222205925.GA10157@ranger.igk.intel.com>
Message-ID: <160875162462.73444.8887896326456165945@gstoner1-mobl1.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Quoting Maciej Fijalkowski (2020-12-22 12:59:25)
> > > > +static int igc_xdp_enable_pool(struct igc_adapter *adapter,
> > > > +                            struct xsk_buff_pool *pool, u16 queue_id)
> > > > +{
> > > > +     struct net_device *ndev = adapter->netdev;
> > > > +     struct device *dev = &adapter->pdev->dev;
> > > > +     struct igc_ring *rx_ring;
> > > > +     struct napi_struct *napi;
> > > > +     bool needs_reset;
> > > > +     u32 frame_size;
> > > > +     int err;
> > > > +
> > > > +     if (queue_id >= adapter->num_rx_queues)
> > > > +             return -EINVAL;
> > > > +
> > > > +     frame_size = xsk_pool_get_rx_frame_size(pool);
> > > > +     if (frame_size < ETH_FRAME_LEN + VLAN_HLEN * 2) {
> > > > +             /* For now, when XDP is enabled, the driver doesn't support
> > > > +              * frames that span over multiple buffers. The max frame size
> > > > +              * considered here is the ethernet frame size + vlan double
> > > > +              * tagging.
> > > > +              */
> > > 
> > > I don't really follow that. You check if chunk size is less than
> > > ETH_FRAME_LEN + VLAN_HLEN * 2. chunk size will be at least 2k if I recall
> > > correctly. How is that related to fragmented buffers?
> > 
> > Note that the code above checks the xsk frame size, not chunk size.
> > 
> > Yes, the chunk mim size is 2k indeed. However, if I'm reading the code
> > correctly, the umem headroom can have an arbitrary value defined by the user
> > (see xdp_umem_reg()). In this case, the xsk frame size could potentially be
> > less than the ethernet frame size.
> 
> Ok I see. So you actually meant that for lower frame size given to HW we
> would start to fragment the frames?

Yes.

> Comment was a bit unclear, hence my confusion.

I'll try to make that comment more clear in the v2.

> Anyway, I feel like this is something generic that should be checked
> earlier at xsk code? Meaning, when we actually create the umem with user
> provided config at setsockopt?

Yeah, that might be a good idea. For now, I'll keep the check in the driver
since it doesn't work properly with smaller sizes. In the future, if we have
that check in xsk layer, we can remove it from the driver.
