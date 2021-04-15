From: Kurt Kanzenbach <kurt@linutronix.de>
Date: Thu, 15 Apr 2021 14:19:55 +0200
Subject: [Intel-wired-lan] [PATCH net] igb: Fix XDP with PTP enabled
In-Reply-To: <YHgiffS6A0sDzLGW@lore-desk>
References: <20210415092145.27322-1-kurt@linutronix.de>
 <YHgiffS6A0sDzLGW@lore-desk>
Message-ID: <871rbbhh90.fsf@kurt>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu Apr 15 2021, Lorenzo Bianconi wrote:
> [...]
>> @@ -8683,7 +8676,10 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
>>  	while (likely(total_packets < budget)) {
>>  		union e1000_adv_rx_desc *rx_desc;
>>  		struct igb_rx_buffer *rx_buffer;
>> +		ktime_t timestamp = 0;
>> +		int pkt_offset = 0;
>>  		unsigned int size;
>> +		void *pktbuf;
>>  
>>  		/* return some buffers to hardware, one at a time is too slow */
>>  		if (cleaned_count >= IGB_RX_BUFFER_WRITE) {
>> @@ -8703,15 +8699,22 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
>>  		dma_rmb();
>>  
>>  		rx_buffer = igb_get_rx_buffer(rx_ring, size, &rx_buf_pgcnt);
>> +		pktbuf = page_address(rx_buffer->page) + rx_buffer->page_offset;
>> +
>> +		/* pull rx packet timestamp if available */
>> +		if (igb_test_staterr(rx_desc, E1000_RXDADV_STAT_TSIP)) {
>> +			timestamp = igb_ptp_rx_pktstamp(rx_ring->q_vector,
>> +							pktbuf);
>> +			pkt_offset += IGB_TS_HDR_LEN;
>> +			size -= IGB_TS_HDR_LEN;
>> +		}
>>  
>>  		/* retrieve a buffer from the ring */
>>  		if (!skb) {
>> -			unsigned int offset = igb_rx_offset(rx_ring);
>> -			unsigned char *hard_start;
>> -
>> -			hard_start = page_address(rx_buffer->page) +
>> -				     rx_buffer->page_offset - offset;
>> -			xdp_prepare_buff(&xdp, hard_start, offset, size, true);
>> +			xdp.data = pktbuf + pkt_offset;
>> +			xdp.data_end = xdp.data + size;
>> +			xdp.data_meta = xdp.data;
>> +			xdp.data_hard_start = pktbuf - igb_rx_offset(rx_ring);
>
> in order to keep it aligned with other xdp drivers, I guess you can do something like:
>
> 			unsigned char *hard_start = pktbuf - igb_rx_offset(rx_ring);
> 			unsigned int offset = pkt_offset + igb_rx_offset(rx_ring);
>
> 			xdp_prepare_buff(&xdp, hard_start, offset, size, true);

This should work as well. I just kept it in sync with the igc driver,
because it doesn't use xdp_prepare_buff() either.

>
> Probably the compiler will optimize it.

Most likely.

Thanks,
Kurt
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210415/7934f0e0/attachment-0001.asc>
