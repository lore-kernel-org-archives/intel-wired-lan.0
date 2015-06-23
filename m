From: Vick, Matthew <matthew.vick@intel.com>
Date: Tue, 23 Jun 2015 16:11:30 +0000
Subject: [Intel-wired-lan] [net-next 06/10] fm10k: send traffic on
 default vid to vlan device if we have one
In-Reply-To: <5584E9FD.1000809@gmail.com>
References: <1434757059-3384-1-git-send-email-jacob.e.keller@intel.com>
 <1434757059-3384-6-git-send-email-jacob.e.keller@intel.com>
 <5584E9FD.1000809@gmail.com>
Message-ID: <D1AED210.7D4C4%matthew.vick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 6/19/15, 9:20 PM, "Alexander Duyck" <alexander.duyck@gmail.com> wrote:

>On 06/19/2015 04:37 PM, Jacob Keller wrote:

[...]

>> diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
>>b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
>> index 6d1364393a8b..989981ea3c64 100644
>> --- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
>> +++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
>> @@ -694,6 +694,10 @@ static void fm10k_configure_rx_ring(struct
>>fm10k_intfc *interface,
>>   	/* assign default VLAN to queue */
>>   	ring->vid = hw->mac.default_vid;
>>
>> +	/* if we have an active VLAN, disable default vid */
>> +	if (test_bit(hw->mac.default_vid, interface->active_vlans))
>> +		ring->vid |= FM10K_VLAN_CLEAR;
>> +
>>   	/* Map interrupt */
>>   	if (ring->q_vector) {
>>   		rxint = ring->q_vector->v_idx + NON_Q_VECTORS(hw);
>>
>
>This doesn't quite work since the rx_ring->vid is doing a full 16b
>comparison against a value that includes the QOS value.
>
>I just realized that is a bug in the fm10k_process_skb_fields function.
>  You probably need to update it so that code does something more like
>
>if (rx_desc->w.vlan) {
>	u16 vid = le16_to_cpu(rx_desc->w.vlan);
>
>	if ((vid & VLAN_VID_MASK) != rx_ring->vid)
>		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vid);
>	else if (vid & VLAN_PRIO_MASK)
>		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q),
>				       vid & VLAN_PRIO_MASK);
>}

Agreed. Coincidentally, this bit us last week and we're working internally
to resolve it now. Your solution looks good to me.

