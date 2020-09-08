From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Tue, 8 Sep 2020 17:12:10 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next 4/4] ixgbe,
 xsk: use XSK_NAPI_WEIGHT as NAPI poll budget
In-Reply-To: <c5dac6d2-e2aa-05a4-2606-7db0687dd12b@intel.com>
References: <20200907150217.30888-1-bjorn.topel@gmail.com>
 <20200907150217.30888-5-bjorn.topel@gmail.com>
 <6bbf1793-d2be-b724-eec4-65546d4cbc9c@gmail.com>
 <c5dac6d2-e2aa-05a4-2606-7db0687dd12b@intel.com>
Message-ID: <b17dcc6e-cb48-9c90-f233-a178b23f9004@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 9/8/20 1:49 PM, Bj?rn T?pel wrote:
> On 2020-09-08 11:45, Eric Dumazet wrote:
>>
>>
>> On 9/7/20 5:02 PM, Bj?rn T?pel wrote:
>>> From: Bj?rn T?pel <bjorn.topel@intel.com>
>>>
>>> Start using XSK_NAPI_WEIGHT as NAPI poll budget for the AF_XDP Rx
>>> zero-copy path.
>>>
>>> Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
>>> ---
>>> ? drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 2 +-
>>> ? 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
>>> index 3771857cf887..f32c1ba0d237 100644
>>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
>>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
>>> @@ -239,7 +239,7 @@ int ixgbe_clean_rx_irq_zc(struct ixgbe_q_vector *q_vector,
>>> ????? bool failure = false;
>>> ????? struct sk_buff *skb;
>>> ? -??? while (likely(total_rx_packets < budget)) {
>>> +??? while (likely(total_rx_packets < XSK_NAPI_WEIGHT)) {
>>> ????????? union ixgbe_adv_rx_desc *rx_desc;
>>> ????????? struct ixgbe_rx_buffer *bi;
>>> ????????? unsigned int size
>>
>> This is a violation of NAPI API. IXGBE is already diverging a bit from best practices.
>>
> 
> Thanks for having a look, Eric! By diverging from best practices, do
> you mean that multiple queues share one NAPI context, and the budget
> is split over the queues (say, 4 queues, 64/4 per queue), or that Tx
> simply ignores the budget? Or both?

For instance, having ixgbe_poll() doing :

return min(work_done, budget - 1);

is quite interesting. It could hide bugs like :

I got a budget of 4, and processed 9999 packets because my maths have a bug,
but make sure to pretend we processed 3 packets...


> 
>> There are reasons we want to control the budget from callers,
>> if you want bigger budget just increase it instead of using your own ?
>>
>> I would rather use a generic patch.
>>
> 
> Hmm, so a configurable NAPI budget for, say, the AF_XDP enabled
> queues/NAPIs? Am I reading that correct? (Note that this is *only* for
> the AF_XDP enabled queues.)
> 
> I'll try to rework this to something more palatable.
> 
> 
> Thanks,
> Bj?rn
> 
>
