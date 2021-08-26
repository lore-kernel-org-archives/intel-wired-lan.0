From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 26 Aug 2021 09:41:19 -0700
Subject: [Intel-wired-lan] [PATCH v4] ixgbe: let the xdpdrv work with
 more than 64 cpus
In-Reply-To: <00890ff4-3264-337a-19cc-521a6434d1d0@gmail.com>
References: <20210826141623.8151-1-kerneljasonxing@gmail.com>
 <00890ff4-3264-337a-19cc-521a6434d1d0@gmail.com>
Message-ID: <860ead37-87f4-22fa-e4f3-5cadd0f2c85c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 8/26/2021 9:18 AM, Eric Dumazet wrote:

>> +static inline int ixgbe_determine_xdp_q_idx(int cpu)
>> +{
>> +	if (static_key_enabled(&ixgbe_xdp_locking_key))
>> +		return cpu % IXGBE_MAX_XDP_QS;
>> +	else
>> +		return cpu;
> 
> Even if num_online_cpus() is 8, the returned cpu here could be
> 
> 0, 32, 64, 96, 128, 161, 197, 224
> 
> Are we sure this will still be ok ?

I'm not sure about that one myself. Jason?

> 
>> +}
>> +
>>  static inline u8 ixgbe_max_rss_indices(struct ixgbe_adapter *adapter)
>>  {
>>  	switch (adapter->hw.mac.type) {
>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
>> index 0218f6c..884bf99 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
>> @@ -299,7 +299,10 @@ static void ixgbe_cache_ring_register(struct ixgbe_adapter *adapter)
>>  
>>  static int ixgbe_xdp_queues(struct ixgbe_adapter *adapter)
>>  {
>> -	return adapter->xdp_prog ? nr_cpu_ids : 0;
>> +	int queues;
>> +
>> +	queues = min_t(int, IXGBE_MAX_XDP_QS, num_online_cpus());
> 
> num_online_cpus() might change later...

I saw that too, but I wonder if it doesn't matter to the driver. If a
CPU goes offline or comes online after the driver loads, we will use
this logic to try to pick an available TX queue. But this is a
complicated thing that is easy to get wrong, is there a common example
of how to get it right?

A possible problem I guess is that if the "static_key_enabled" check
returned false in the past, we would need to update that if the number
of CPUs changes, do we need a notifier?

Also, now that I'm asking it, I dislike the global as it would apply to
all ixgbe ports and each PF would increment and decrement it
independently. Showing my ignorance here, but I haven't seen this
utility in the kernel before in detail. Not sure if this is "OK" from
multiple device (with the same driver / global namespace) perspective.

