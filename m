From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 24 Jun 2015 15:13:27 -0700
Subject: [Intel-wired-lan] [net-next 06/10] fm10k: send traffic on
 default vid to vlan device if we have one
In-Reply-To: <1435097908.20240.30.camel@intel.com>
References: <1434757059-3384-1-git-send-email-jacob.e.keller@intel.com>	
 <1434757059-3384-6-git-send-email-jacob.e.keller@intel.com>	
 <5584E9FD.1000809@gmail.com> <1435097908.20240.30.camel@intel.com>
Message-ID: <558B2B87.40301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 06/23/2015 03:18 PM, Keller, Jacob E wrote:
> On Fri, 2015-06-19 at 21:20 -0700, Alexander Duyck wrote:
>> On 06/19/2015 04:37 PM, Jacob Keller wrote:
>>> This patch ensures that vlan traffic on the default vid will go to
>>> the
>>> corresponding vlan device if it exists. To do this, mask the
>>> rx_ring vid
>>> if we have an active vlan on that vid.
>>>
>>> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
>>> ---
>>>    drivers/net/ethernet/intel/fm10k/fm10k_netdev.c | 12 ++++++++++++
>>>    drivers/net/ethernet/intel/fm10k/fm10k_pci.c    |  4 ++++
>>>    2 files changed, 16 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
>>> b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
>>> index e1ceb3a2e2cd..c173c79373fe 100644
>>> --- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
>>> +++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
>>> @@ -758,6 +758,7 @@ static int fm10k_update_vid(struct net_device
>>> *netdev, u16 vid, bool set)
>>>    	struct fm10k_intfc *interface = netdev_priv(netdev);
>>>    	struct fm10k_hw *hw = &interface->hw;
>>>    	s32 err;
>>> +	int i;
>>>
>>>    	/* updates do not apply to VLAN 0 */
>>>    	if (!vid)
>>> @@ -775,6 +776,17 @@ static int fm10k_update_vid(struct net_device
>>> *netdev, u16 vid, bool set)
>>>    	if (!set)
>>>    		clear_bit(vid, interface->active_vlans);
>>>
>>> +	/* disable the default vid on ring if we have an active
>>> vlan */
>>> +	for (i = 0; i < interface->num_rx_queues; i++) {
>>> +		struct fm10k_ring *rx_ring = interface
>>> ->rx_ring[i];
>>> +		u16 rx_vid = rx_ring->vid & (VLAN_N_VID - 1);
>>> +
>>> +		if (test_bit(rx_vid, interface->active_vlans))
>>> +			rx_ring->vid |= FM10K_VLAN_CLEAR;
>>> +		else
>>> +			rx_ring->vid &= ~FM10K_VLAN_CLEAR;
>>> +	}
>>> +
>>>    	/* Do not remove default VID related entries from VLAN and
>>> MAC tables */
>>>    	if (!set && vid == hw->mac.default_vid)
>>>    		return 0;
>>> diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
>>> b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
>>> index 6d1364393a8b..989981ea3c64 100644
>>> --- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
>>> +++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
>>> @@ -694,6 +694,10 @@ static void fm10k_configure_rx_ring(struct
>>> fm10k_intfc *interface,
>>>    	/* assign default VLAN to queue */
>>>    	ring->vid = hw->mac.default_vid;
>>>
>>> +	/* if we have an active VLAN, disable default vid */
>>> +	if (test_bit(hw->mac.default_vid, interface
>>> ->active_vlans))
>>> +		ring->vid |= FM10K_VLAN_CLEAR;
>>> +
>>>    	/* Map interrupt */
>>>    	if (ring->q_vector) {
>>>    		rxint = ring->q_vector->v_idx + NON_Q_VECTORS(hw);
>>>
>> This doesn't quite work since the rx_ring->vid is doing a full 16b
>> comparison against a value that includes the QOS value.
>>
> To clarify, this should work as long as we fix the process_skb_fields?

Yeah, if you fix it then you should be all set as the change below would 
make it so that you could never match with the FM10K_VLAN_CLEAR bit set.

> I just realized that is a bug in the fm10k_process_skb_fields
> function.
>    You probably need to update it so that code does something more
> like
>
> if (rx_desc->w.vlan) {
> 	u16 vid = le16_to_cpu(rx_desc->w.vlan);
>
> 	if ((vid & VLAN_VID_MASK) != rx_ring->vid)
> 		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q),
> vid);
> 	else if (vid & VLAN_PRIO_MASK)
> 		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q),
> 				       vid & VLAN_PRIO_MASK);
> }	

