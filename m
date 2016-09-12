From: John Fastabend <john.fastabend@gmail.com>
Date: Mon, 12 Sep 2016 11:11:52 -0700
Subject: [Intel-wired-lan] [net-next PATCH v2 2/2] e1000: bundle xdp
	xmit routines
In-Reply-To: <20160912141755.365c169e@redhat.com>
References: <20160909212915.4001.25504.stgit@john-Precision-Tower-5810>
 <20160909212938.4001.40540.stgit@john-Precision-Tower-5810>
 <20160912141755.365c169e@redhat.com>
Message-ID: <57D6EFE8.50707@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 16-09-12 05:17 AM, Jesper Dangaard Brouer wrote:
> On Fri, 09 Sep 2016 14:29:38 -0700
> John Fastabend <john.fastabend@gmail.com> wrote:
> 
>> e1000 supports a single TX queue so it is being shared with the stack
>> when XDP runs XDP_TX action. This requires taking the xmit lock to
>> ensure we don't corrupt the tx ring. To avoid taking and dropping the
>> lock per packet this patch adds a bundling implementation to submit
>> a bundle of packets to the xmit routine.
>>
>> I tested this patch running e1000 in a VM using KVM over a tap
>> device using pktgen to generate traffic along with 'ping -f -l 100'.
>>
>> Suggested-by: Jesper Dangaard Brouer <brouer@redhat.com>
> 
> Thank you for actually implementing this! :-)
> 

Yep no problem the effects are minimal on e1000 but should be
noticeable at 10/40/100gbps nics.

>> Signed-off-by: John Fastabend <john.r.fastabend@intel.com>
>> ---
> [...]


[...]

>> +static void e1000_xdp_xmit_bundle(struct e1000_rx_buffer_bundle *buffer_info,
>> +				  struct net_device *netdev,
>> +				  struct e1000_adapter *adapter)
>> +{
>> +	struct netdev_queue *txq = netdev_get_tx_queue(netdev, 0);
>> +	struct e1000_tx_ring *tx_ring = adapter->tx_ring;
>> +	struct e1000_hw *hw = &adapter->hw;
>> +	int i = 0;
>> +
>>  	/* e1000 only support a single txq at the moment so the queue is being
>>  	 * shared with stack. To support this requires locking to ensure the
>>  	 * stack and XDP are not running at the same time. Devices with
>>  	 * multiple queues should allocate a separate queue space.
>> +	 *
>> +	 * To amortize the locking cost e1000 bundles the xmits and sends as
>> +	 * many as possible until either running out of descriptors or failing.
>>  	 */
>>  	HARD_TX_LOCK(netdev, txq, smp_processor_id());
>>  
>> -	tx_ring = adapter->tx_ring;
>> -
>> -	if (E1000_DESC_UNUSED(tx_ring) < 2) {
>> -		HARD_TX_UNLOCK(netdev, txq);
>> -		return;
>> +	for (; i < E1000_XDP_XMIT_BUNDLE_MAX && buffer_info[i].buffer; i++) {
>                                                                        ^^^
>> +		e1000_xmit_raw_frame(buffer_info[i].buffer,
>> +				     buffer_info[i].length,
>> +				     adapter, tx_ring);
>> +		buffer_info[i].buffer->rxbuf.page = NULL;
>> +		buffer_info[i].buffer = NULL;
>> +		buffer_info[i].length = 0;
>> +		i++;
>                 ^^^
> Looks like "i" is incremented twice, is that correct?
> 
>>  	}

Yep this and a couple other issues are resolved in v3 which I'll send
out in a moment.

Also in v3 I kept the program in the adapter structure. Moving it into
the ring structure made the code a bit uglier IMO. I agree with the
logic but practically only one program can exist for e1000.

