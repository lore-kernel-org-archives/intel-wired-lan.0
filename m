From: Jesper Dangaard Brouer <jbrouer@redhat.com>
Date: Mon, 29 Nov 2021 15:39:04 +0100
Subject: [Intel-wired-lan] [PATCH net-next 2/2] igc: enable XDP metadata
 in driver
In-Reply-To: <20211126161649.151100-1-alexandr.lobakin@intel.com>
References: <163700856423.565980.10162564921347693758.stgit@firesoul>
 <163700859087.565980.3578855072170209153.stgit@firesoul>
 <20211126161649.151100-1-alexandr.lobakin@intel.com>
Message-ID: <6de05aea-9cf4-c938-eff2-9e3b138512a4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 26/11/2021 17.16, Alexander Lobakin wrote:
> From: Jesper Dangaard Brouer <brouer@redhat.com>
> Date: Mon, 15 Nov 2021 21:36:30 +0100
> 
>> Enabling the XDP bpf_prog access to data_meta area is a very small
>> change. Hint passing 'true' to xdp_prepare_buff().
>>
>> The SKB layers can also access data_meta area, which required more
>> driver changes to support. Reviewers, notice the igc driver have two
>> different functions that can create SKBs, depending on driver config.
>>
>> Hint for testers, ethtool priv-flags legacy-rx enables
>> the function igc_construct_skb()
>>
>>   ethtool --set-priv-flags DEV legacy-rx on
>>
>> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
>> ---
>>   drivers/net/ethernet/intel/igc/igc_main.c |   29 +++++++++++++++++++----------
>>   1 file changed, 19 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
>> index 76b0a7311369..b516f1b301b4 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_main.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
>> @@ -1718,24 +1718,26 @@ static void igc_add_rx_frag(struct igc_ring *rx_ring,
>>   
>>   static struct sk_buff *igc_build_skb(struct igc_ring *rx_ring,
>>   				     struct igc_rx_buffer *rx_buffer,
>> -				     union igc_adv_rx_desc *rx_desc,
>> -				     unsigned int size)
>> +				     struct xdp_buff *xdp)
>>   {
>> -	void *va = page_address(rx_buffer->page) + rx_buffer->page_offset;
>> +	unsigned int size = xdp->data_end - xdp->data;
>>   	unsigned int truesize = igc_get_rx_frame_truesize(rx_ring, size);
>> +	unsigned int metasize = xdp->data - xdp->data_meta;
>>   	struct sk_buff *skb;
>>   
>>   	/* prefetch first cache line of first page */
>> -	net_prefetch(va);
>> +	net_prefetch(xdp->data);
> 
> I'd prefer prefetching xdp->data_meta here. GRO layer accesses it.
> Maximum meta size for now is 32, so at least 96 bytes of the frame
> will stil be prefetched.

Prefetch works for "full" cachelines. Intel CPUs often prefect two 
cache-lines, when doing this, thus I guess we still get xdp->data.

I don't mind prefetching xdp->data_meta, but (1) I tried to keep the 
change minimal as current behavior was data area I kept that. (2) 
xdp->data starts on a cacheline and we know NIC hardware have touched 
that, it is not a full-cache-miss due to DDIO/DCA it is known to be in 
L3 cache (gain is around 2-3 ns in my machine for data prefetch).
Given this is only a 2.5 Gbit/s driver/HW I doubt this make any difference.

Tony is it worth resending a V2 of this patch?

>>   
>>   	/* build an skb around the page buffer */
>> -	skb = build_skb(va - IGC_SKB_PAD, truesize);
>> +	skb = build_skb(xdp->data_hard_start, truesize);
>>   	if (unlikely(!skb))
>>   		return NULL;
>>   
>>   	/* update pointers within the skb to store the data */
>> -	skb_reserve(skb, IGC_SKB_PAD);
>> +	skb_reserve(skb, xdp->data - xdp->data_hard_start);
>>   	__skb_put(skb, size);
>> +	if (metasize)
>> +		skb_metadata_set(skb, metasize);
>>   
>>   	igc_rx_buffer_flip(rx_buffer, truesize);
>>   	return skb;
>> @@ -1746,6 +1748,7 @@ static struct sk_buff *igc_construct_skb(struct igc_ring *rx_ring,
>>   					 struct xdp_buff *xdp,
>>   					 ktime_t timestamp)
>>   {
>> +	unsigned int metasize = xdp->data - xdp->data_meta;
>>   	unsigned int size = xdp->data_end - xdp->data;
>>   	unsigned int truesize = igc_get_rx_frame_truesize(rx_ring, size);
>>   	void *va = xdp->data;
>> @@ -1756,7 +1759,7 @@ static struct sk_buff *igc_construct_skb(struct igc_ring *rx_ring,
>>   	net_prefetch(va);
> 
> ...here as well.
> 

