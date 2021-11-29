From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Mon, 29 Nov 2021 19:03:15 +0000
Subject: [Intel-wired-lan] [PATCH net-next 2/2] igc: enable XDP metadata
 in driver
In-Reply-To: <20211129181320.579477-1-alexandr.lobakin@intel.com>
References: <163700856423.565980.10162564921347693758.stgit@firesoul>
 <163700859087.565980.3578855072170209153.stgit@firesoul>
 <20211126161649.151100-1-alexandr.lobakin@intel.com>
 <6de05aea-9cf4-c938-eff2-9e3b138512a4@redhat.com>
 <20211129145303.10507-1-alexandr.lobakin@intel.com>
 <20211129181320.579477-1-alexandr.lobakin@intel.com>
Message-ID: <9948428f33d013105108872d51f7e6ebec21203c.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2021-11-29 at 19:13 +0100, Alexander Lobakin wrote:
> From: Alexander Lobakin <alexandr.lobakin@intel.com>
> Date: Mon, 29 Nov 2021 15:53:03 +0100
> 
> > From: Jesper Dangaard Brouer <jbrouer@redhat.com>
> > Date: Mon, 29 Nov 2021 15:39:04 +0100
> > 
> > > On 26/11/2021 17.16, Alexander Lobakin wrote:
> > > > From: Jesper Dangaard Brouer <brouer@redhat.com>
> > > > Date: Mon, 15 Nov 2021 21:36:30 +0100
> > > > 
> > > > > Enabling the XDP bpf_prog access to data_meta area is a very
> > > > > small
> > > > > change. Hint passing 'true' to xdp_prepare_buff().
> 
> [ snip ]
> 
> > > Prefetch works for "full" cachelines. Intel CPUs often prefect
> > > two 
> > > cache-lines, when doing this, thus I guess we still get xdp-
> > > >data.
> > 
> > Sure. I mean, net_prefetch() prefetches 128 bytes in a row.
> > xdp->data is usually aligned to XDP_PACKET_HEADROOM (or two bytes
> > to the right). If our CL is 64 and the meta is present, then... ah
> > right, 64 to the left and 64 starting from data to the right.
> > 
> > > I don't mind prefetching xdp->data_meta, but (1) I tried to keep
> > > the 
> > > xdp->data starts on a cacheline and we know NIC hardware have
> > > touched 
> > > that, it is not a full-cache-miss due to DDIO/DCA it is known to
> > > be in 
> > > L3 cache (gain is around 2-3 ns in my machine for data prefetch).
> > > Given this is only a 2.5 Gbit/s driver/HW I doubt this make any
> > > difference.
> > 
> > Code constistency at least. On 10+ Gbps we prefetch meta, and I
> > plan
> > to continue doing this in my series.
> > 
> > > Tony is it worth resending a V2 of this patch?
> > 
> > Tony, you can take it as it is if you want, I'll correct it later
> > in
> > mine. Up to you.
> 
> My "fixup" looks like (in case of v2 needed or so):

Thanks Al. If Jesper is ok with this, I'll incorporate it in before
sending the pull request to netdev. Otherwise, you can do it as follow
on in the other series you previously referenced.

Thanks,
Tony

> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c
> b/drivers/net/ethernet/intel/igc/igc_main.c
> index b516f1b301b4..142c57b7a451 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -1726,7 +1726,7 @@ static struct sk_buff *igc_build_skb(struct
> igc_ring *rx_ring,
> ????????struct sk_buff *skb;
> ?
> ????????/* prefetch first cache line of first page */
> -???????net_prefetch(xdp->data);
> +???????net_prefetch(xdp->data_meta);
> ?
> ????????/* build an skb around the page buffer */
> ????????skb = build_skb(xdp->data_hard_start, truesize);
> @@ -1756,10 +1756,11 @@ static struct sk_buff
> *igc_construct_skb(struct igc_ring *rx_ring,
> ????????struct sk_buff *skb;
> ?
> ????????/* prefetch first cache line of first page */
> -???????net_prefetch(va);
> +???????net_prefetch(xdp->data_meta);
> ?
> ????????/* allocate a skb to store the frags */
> -???????skb = napi_alloc_skb(&rx_ring->q_vector->napi, IGC_RX_HDR_LEN
> + metasize);
> +???????skb = napi_alloc_skb(&rx_ring->q_vector->napi,
> +??????????????????????????? IGC_RX_HDR_LEN + metasize);
> ????????if (unlikely(!skb))
> ????????????????return NULL;
> ?
> @@ -2363,7 +2364,8 @@ static int igc_clean_rx_irq(struct igc_q_vector
> *q_vector, const int budget)
> ????????????????if (!skb) {
> ????????????????????????xdp_init_buff(&xdp, truesize, &rx_ring-
> >xdp_rxq);
> ????????????????????????xdp_prepare_buff(&xdp, pktbuf -
> igc_rx_offset(rx_ring),
> -??????????????????????????????????????? igc_rx_offset(rx_ring) +
> pkt_offset, size, true);
> +??????????????????????????????????????? igc_rx_offset(rx_ring) +
> pkt_offset,
> +??????????????????????????????????????? size, true);
> ?
> ????????????????????????skb = igc_xdp_run_prog(adapter, &xdp);
> ????????????????}

