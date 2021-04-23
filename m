From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Fri, 23 Apr 2021 13:51:50 +0200
Subject: [Intel-wired-lan] [PATCH net v3] igb: Fix XDP with PTP enabled
In-Reply-To: <878s59qz1b.fsf@kurt>
References: <20210422052617.17267-1-kurt@linutronix.de>
 <20210422101129.GB44289@ranger.igk.intel.com> <878s59qz1b.fsf@kurt>
Message-ID: <20210423115150.GB64904@ranger.igk.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Apr 23, 2021 at 08:45:52AM +0200, Kurt Kanzenbach wrote:
> On Thu Apr 22 2021, Maciej Fijalkowski wrote:
> > On Thu, Apr 22, 2021 at 07:26:17AM +0200, Kurt Kanzenbach wrote:
> >> +		/* pull rx packet timestamp if available and valid */
> >> +		if (igb_test_staterr(rx_desc, E1000_RXDADV_STAT_TSIP)) {
> >> +			timestamp = igb_ptp_rx_pktstamp(rx_ring->q_vector,
> >> +							pktbuf);
> >> +
> >> +			if (timestamp) {
> >> +				pkt_offset += IGB_TS_HDR_LEN;
> >> +				size -= IGB_TS_HDR_LEN;
> >> +			}
> >> +		}
> >
> > Small nit: since this is a hot path, maybe we could omit the additional
> > branch that you're introducing above and make igb_ptp_rx_pktstamp() to
> > return either 0 for error cases and IGB_TS_HDR_LEN if timestamp was fine?
> > timestamp itself would be passed as an arg.
> >
> > So:
> > 		if (igb_test_staterr(rx_desc, E1000_RXDADV_STAT_TSIP)) {
> > 			ts_offset = igb_ptp_rx_pktstamp(rx_ring->q_vector,
> > 							pktbuf, &timestamp);
> > 			pkt_offset += ts_offset;
> > 			size -= ts_offset;
> > 		}
> >
> > Thoughts? I feel like if we see that desc has timestamp enabled then let's
> > optimize it for successful case.
> 
> Yes, this should work as well. Actually I didn't like the if statement
> either. Only one comment: It's not an offset but rather the timestamp
> header length. I'd call it 'ts_len'.

Right, sorry.

> 
> >
> >>  
> >>  		/* retrieve a buffer from the ring */
> >>  		if (!skb) {
> >> -			unsigned int offset = igb_rx_offset(rx_ring);
> >> -			unsigned char *hard_start;
> >> +			unsigned char *hard_start = pktbuf - igb_rx_offset(rx_ring);
> >> +			unsigned int offset = pkt_offset + igb_rx_offset(rx_ring);
> >
> > Probably we could do something similar in flavour of:
> > https://lore.kernel.org/bpf/20210118151318.12324-10-maciej.fijalkowski at intel.com/
> >
> > which broke XDP_REDIRECT and got fixed in:
> > https://lore.kernel.org/bpf/20210303153928.11764-2-maciej.fijalkowski at intel.com/
> >
> > You get the idea.
> 
> Yes, I do. However, I think such a change doesn't belong in this patch,
> which is a bugfix for XDP. It looks like an optimization. Should I split
> it into two patches and rather target net-next instead of net?

This was just a heads up from my side as it caught my eye. For sure it's
out of the scope of that patch, but would be good to have a follow up on
that.

> 
> Thanks for your review.
> 
> Thanks,
> Kurt


