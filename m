From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Tue, 20 Apr 2021 16:33:33 +0000
Subject: [Intel-wired-lan] [PATCH net v2] igb: Fix XDP with PTP enabled
In-Reply-To: <20210419072332.7246-1-kurt@linutronix.de>
References: <20210419072332.7246-1-kurt@linutronix.de>
Message-ID: <c1eed5fe05a59f86ff868580e3ae89e251f498ec.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2021-04-19 at 09:23 +0200, Kurt Kanzenbach wrote:
> When using native XDP with the igb driver, the XDP frame data doesn't
> point to
> the beginning of the packet. It's off by 16 bytes. Everything works
> as expected
> with XDP skb mode.
> 
> Actually these 16 bytes are used to store the packet timestamps.
> Therefore, pull
> the timestamp before executing any XDP operations and adjust all
> other code
> accordingly. The igc driver does it like that as well.
> 
> Tested with Intel i210 card and AF_XDP sockets.
> 
> Fixes: 9cbc948b5a20 ("igb: add XDP support")
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---

<snip>

> @@ -8683,7 +8676,10 @@ static int igb_clean_rx_irq(struct
> igb_q_vector *q_vector, const int budget)
>  	while (likely(total_packets < budget)) {
>  		union e1000_adv_rx_desc *rx_desc;
>  		struct igb_rx_buffer *rx_buffer;
> +		ktime_t timestamp = 0;
> +		int pkt_offset = 0;
>  		unsigned int size;
> +		void *pktbuf;
>  
>  		/* return some buffers to hardware, one at a time is
> too slow */
>  		if (cleaned_count >= IGB_RX_BUFFER_WRITE) {
> @@ -8703,14 +8699,21 @@ static int igb_clean_rx_irq(struct
> igb_q_vector *q_vector, const int budget)
>  		dma_rmb();
>  
>  		rx_buffer = igb_get_rx_buffer(rx_ring, size,
> &rx_buf_pgcnt);
> +		pktbuf = page_address(rx_buffer->page) + rx_buffer-
> >page_offset;
> +
> +		/* pull rx packet timestamp if available */
> +		if (igb_test_staterr(rx_desc, E1000_RXDADV_STAT_TSIP))
> {
> +			timestamp = igb_ptp_rx_pktstamp(rx_ring-
> >q_vector,
> +							pktbuf);

The timestamp should be checked for failure and not adjust these values
if the timestamp was invalid.
 
> +			pkt_offset += IGB_TS_HDR_LEN;
> +			size -= IGB_TS_HDR_LEN;
> +		}

