From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Thu,  3 Feb 2022 20:05:55 +0100
Subject: [Intel-wired-lan] [PATCH net-next 14/19] iecm: implement
 singleq napi_poll
In-Reply-To: <CO1PR11MB5186D038E0F5CCB0DE9D73CC8F289@CO1PR11MB5186.namprd11.prod.outlook.com>
References: <20220128001009.721392-1-alan.brady@intel.com>
 <20220128001009.721392-15-alan.brady@intel.com>
 <20220128175755.28750-1-alexandr.lobakin@intel.com>
 <CO1PR11MB5186D038E0F5CCB0DE9D73CC8F289@CO1PR11MB5186.namprd11.prod.outlook.com>
Message-ID: <20220203190555.18385-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alan Brady <alan.brady@intel.com>
Date: Thu, 3 Feb 2022 02:45:14 +0100

> > -----Original Message-----
> > From: Lobakin, Alexandr <alexandr.lobakin@intel.com>
> > Sent: Friday, January 28, 2022 9:58 AM
> > To: Brady, Alan <alan.brady@intel.com>
> > Cc: Lobakin, Alexandr <alexandr.lobakin@intel.com>; intel-wired-
> > lan at lists.osuosl.org; Burra, Phani R <phani.r.burra@intel.com>; Chittim,
> > Madhu <madhu.chittim@intel.com>; Linga, Pavan Kumar
> > <pavan.kumar.linga@intel.com>
> > Subject: [Intel-wired-lan] [PATCH net-next 14/19] iecm: implement singleq
> > napi_poll
> > 
> > > From: Alan Brady <alan.brady@intel.com>
> > > Date: Thu, 27 Jan 2022 16:10:04 -0800
> > >
> > > This adds everything we do the more traditional singleq model data path.
> > >
> > > Signed-off-by: Phani Burra <phani.r.burra@intel.com>
> > > Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
> > > Signed-off-by: Madhu Chittim <madhu.chittim@intel.com>
> > > Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> > > Signed-off-by: Alan Brady <alan.brady@intel.com>
> > > ---
> > >  drivers/net/ethernet/intel/iecm/iecm_lib.c    |    2 +-
> > >  .../ethernet/intel/iecm/iecm_singleq_txrx.c   | 1208
> > ++++++++++++++++-
> > >  drivers/net/ethernet/intel/include/iecm.h     |    1 +
> > >  .../net/ethernet/intel/include/iecm_txrx.h    |   31 +
> > >  4 files changed, 1237 insertions(+), 5 deletions(-)
> > >

--- 8< ---

> > > +		/* align size to end of page */
> > > +		max_data += -dma & (IECM_TX_MAX_READ_REQ_SIZE - 1);
> > 
> > Here applies the same I said for splitq before, this code is counter-intuitive.
> > 
> 
> I'm failing to find a matching comment for iecm_tx_splitq_map but I'm sure we're open to suggestion how to make it better.

As I said in my reply to 11/19, I don't get the logics here at all,
so I kindly asked to explain it to me.
Since I don't get it, I'm not able to provide any suggestions.

> 
> > > +		tx_desc->buf_addr = cpu_to_le64(dma);

--- 8< ---

> > > +	do {
> > > +		struct iecm_base_tx_desc *eop_desc =
> > > +			(struct iecm_base_tx_desc *)tx_buf-
> > >next_to_watch;
> > 
> > 		struct iecm_base_tx_desc *eop_desc;
> > 
> > 		eop_desc = (typeof(*eop_desc))tx_buf->next_to_watch;
> > 
> 
> Again not sure I see the benefit to prefer assigning it's own line over letting it wrap.  Suggestion as written is wrong also.

Declaration, then assignment is a normal practice.
Assignment with a line-wrap is an exception only for the lines which
can't be composed any other way. Here you have at least two:

		struct iecm_base_tx_desc *eop_desc;

		/* This is fixed variant from my initial reply, I apologize
		 * for the excessive '*'.
		 */
		eop_desc = (typeof(eop_desc))tx_buf->next_to_watch;

		/* More classic variant, fits into 79 as well */
		eop_desc = (struct iecm_base_tx_desc *)tx_buf->next_to_watch;

Breaking declaration and assignment into two separate lines is the
first choice when a line exceeds the char limit.

> 
> > > +
> > > +		/* if next_to_watch is not set then no work pending */

--- 8< ---

> > > +	status0 = rx_desc->flex_nic_wb.status_error0;
> > > +	if (status0 &
> > > +
> > 	cpu_to_le16(BIT(VIRTCHNL2_RX_FLEX_DESC_STATUS0_RSS_VALID_
> > S))) {
> > > +		u32 hash = le32_to_cpu(rx_desc->flex_nic_wb.rss_hash);
> > > +
> > > +		skb_set_hash(skb, hash, iecm_ptype_to_htype(decoded));
> > > +	}
> > 
> > 	if (!status)
> > 		return;
> > 
> > -1 indent level.
> > 
> 
> if (!(status0 & cpu_to_le16(BIT(VIRTCHNL2_RX_FLEX_DESC_STATUS0_RSS_VALID_S))))
>     return;
> 
> skb_set_hash(...);

hash = 
skb_set_hash()

There are two lines there.

> 
> vs.
> 
> if (status0 & cpu_to_le16(BIT(VIRTCHNL2_RX_FLEX_DESC_STATUS0_RSS_VALID_S)))
>     skb_set_hash(....);
> 
> Doesn't seem any better to me, in fact it seems worse.

Perhaps due to that train starting from cpu_to_le16 should be hidden
into a compact definition, like

#define IECM_RX_DESC_HASH_BIT						  \
	BIT(VIRTCHNL2_RX_FLEX_DESC_STATUS0_RSS_VALID_S)));

#define __iecm_rx_desc_hash_present(status0)				  \
	!!((status0) & cpu_to_le16(IECM_RX_DESC_HASH_BIT))

#define iecm_rx_desc_hash_present(rx_desc)				  \
	__iecm_rx_desc_hash_present((rx_desc)->flex_nic_wb.status_error0)

...

then either way (`if (hash)` or `if (!hash)`) starts working.

	if (!(rx_q->vport->netdev->features & NETIF_F_RXHASH))
		return;

	if (iecm_rx_desc_hash_present(rx_desc)) {
		u32 hash = le32_to_cpu(rx_desc->flex_nic_wb.rss_hash);

		skb_set_hash(skb, hash, iecm_ptype_to_htype(decoded));
	}

||

	if (!(rx_q->vport->netdev->features & NETIF_F_RXHASH) ||
	    !iecm_rx_desc_hash_present(rx_desc))
		return;

	hash = le32_to_cpu(rx_desc->flex_nic_wb.rss_hash);
	skb_set_hash(skb, hash, iecm_ptype_to_htype(decoded));

> 
> > > +}
> > > +
> > > +/**
> > > + * iecm_rx_singleq_process_skb_fields - Populate skb header fields

--- 8< ---

> > > +void
> > > +iecm_rx_singleq_process_skb_fields(struct iecm_queue *rx_q, struct
> > sk_buff *skb,
> > > +				   union virtchnl2_rx_desc *rx_desc,
> > > +				   u16 ptype)
> > > +{
> > > +	struct iecm_rx_ptype_decoded decoded =
> > > +					rx_q->vport->rx_ptype_lkup[ptype];
> > 
> > Declare, then assign to avoid wraps.
> > 
> 
> I'm just not seeing the benefit in doing that.  If 'net' tree is concerned with wrapping I would assume they would move to 100 cols with the rest of the kernel.

Everyone is concerned with wrapping.
But one thing is to have a function call wrapped by arguments:

	ret = some_long_function_name(argument1,
				      ARG2);

and completely different -- line breaks, when no alignment is
possible:

	some_really_long_variable =
		some_long_function_name();

At least I can tell for sure that declaration + assignment is way
more preferred over such line breaks for not altering readability
in any way.

> 
> > > +
> > > +	/* modifies the skb - consumes the enet header */

--- 8< ---

> > > +static bool iecm_rx_singleq_recycle_buf(struct iecm_queue *rxq,
> > > +					struct iecm_rx_buf *rx_buf)
> > > +{
> > > +	struct iecm_page_info *page_info =
> > > +			&rx_buf->page_info[rx_buf->page_indx];
> > 
> > Declare, then assign to avoid wraps.
> >
> 
> Will not fix.

The very same questions may come from the upstream maintainers.
The less such trivial places there will be, the better for everyone
I believe? Especially for the maintainers since they review tons of
code daily and aren't happy to see simple style issues again and
again.

>  
> > > +

--- 8< ---

> > > --
> > > 2.33.0
> > 
> > Thanks,
> > Al

Thanks,
Al
