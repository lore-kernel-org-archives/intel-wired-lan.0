From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@intel.com>
Date: Tue, 28 Aug 2018 19:10:36 +0200
Subject: [Intel-wired-lan] [PATCH] i40e: report correct statistics when
 XDP is enabled
In-Reply-To: <a20ab03d-25e0-126a-d996-5c1750de0639@molgen.mpg.de>
References: <20180824112159.32298-1-bjorn.topel@intel.com>
 <20180824160016.245b08d8@redhat.com>
 <a20ab03d-25e0-126a-d996-5c1750de0639@molgen.mpg.de>
Message-ID: <dd4baf4e-f1bc-aecd-405a-cb49b58dfe37@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2018-08-28 19:00, Paul Menzel wrote:
> Dear Bj?rn,
> 
> 
> On 08/24/18 16:00, Jesper Dangaard Brouer wrote:
>> On Fri, 24 Aug 2018 13:21:59 +0200
>> Bj?rn T?pel <bjorn.topel@intel.com> wrote:
>>
>>> When XDP is enabled, the driver will report incorrect
>>> statistics. Received frames will reported as transmitted frames.
>>>
>>> This commits fixes the i40e implementation of ndo_get_stats64 (struct
> 
> Should you send a v2, then please use singular for *commit*:
> 
> This commit ?.
> 
>>> net_device_ops), so that iproute2 will report correct statistics
>>> (e.g. when running "ip -stats link show dev eth0") even when XDP is
>>> enabled.
> 
> In the future, I?d be great, if you could describe your fix in the
> commit message too. For example, why the if statement needs to move up.
>

Thanks for the review, Paul. I'll address your comments, if we'll end up
with V2.


Bj?rn

>>> Reported-by: Jesper Dangaard Brouer <brouer@redhat.com>
>>> Fixes: 74608d17fe29 ("i40e: add support for XDP_TX action")
>>
>> Stable candidate:
>>   $ git describe --contains 74608d17fe29
>>   v4.13-rc1~157^2~128^2~13
>>
>>> Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
>>
>> It works for me:
>>
>> Tested-by: Jesper Dangaard Brouer <brouer@redhat.com>
>>
>> I'm explicitly _not_ ACK'ing the patch, as I think the your code changes
>> below makes it harder to follow whether a TX or RX ring is getting
>> updated. But it is 100% up to the driver maintainers to say if this is
>> acceptable from a maintenance PoV.
>>
>>> ---
>>>   drivers/net/ethernet/intel/i40e/i40e_main.c | 24 +++++++++++----------
>>>   1 file changed, 13 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
>>> index e40c023cc7b6..7c122dd3faa1 100644
>>> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
>>> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
>>> @@ -425,9 +425,9 @@ static void i40e_get_netdev_stats_struct(struct net_device *netdev,
>>>   				  struct rtnl_link_stats64 *stats)
>>>   {
>>>   	struct i40e_netdev_priv *np = netdev_priv(netdev);
>>> -	struct i40e_ring *tx_ring, *rx_ring;
>>>   	struct i40e_vsi *vsi = np->vsi;
>>>   	struct rtnl_link_stats64 *vsi_stats = i40e_get_vsi_stats_struct(vsi);
>>> +	struct i40e_ring *ring;
>>>   	int i;
>>>   
>>>   	if (test_bit(__I40E_VSI_DOWN, vsi->state))
>>> @@ -441,24 +441,26 @@ static void i40e_get_netdev_stats_struct(struct net_device *netdev,
>>>   		u64 bytes, packets;
>>>   		unsigned int start;
>>>   
>>> -		tx_ring = READ_ONCE(vsi->tx_rings[i]);
>>> -		if (!tx_ring)
>>> +		ring = READ_ONCE(vsi->tx_rings[i]);
>>> +		if (!ring)
>>>   			continue;
>>> -		i40e_get_netdev_stats_struct_tx(tx_ring, stats);
>>> +		i40e_get_netdev_stats_struct_tx(ring, stats);
>>>   
>>> -		rx_ring = &tx_ring[1];
>>> +		if (i40e_enabled_xdp_vsi(vsi)) {
>>> +			ring++;
>>> +			i40e_get_netdev_stats_struct_tx(ring, stats);
>>> +		}
>>>   
>>> +		ring++;
>>>   		do {
>>> -			start = u64_stats_fetch_begin_irq(&rx_ring->syncp);
>>> -			packets = rx_ring->stats.packets;
>>> -			bytes   = rx_ring->stats.bytes;
>>> -		} while (u64_stats_fetch_retry_irq(&rx_ring->syncp, start));
>>> +			start   = u64_stats_fetch_begin_irq(&ring->syncp);
>>> +			packets = ring->stats.packets;
>>> +			bytes   = ring->stats.bytes;
>>> +		} while (u64_stats_fetch_retry_irq(&ring->syncp, start));
>>>   
>>>   		stats->rx_packets += packets;
>>>   		stats->rx_bytes   += bytes;
>>>   
>>> -		if (i40e_enabled_xdp_vsi(vsi))
>>> -			i40e_get_netdev_stats_struct_tx(&rx_ring[1], stats);
>>>   	}
>>>   	rcu_read_unlock();
>>>   
> 
> 
> Kind regards,
> 
> Paul
> 
