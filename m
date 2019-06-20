From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Thu, 20 Jun 2019 13:07:20 -0400
Subject: [Intel-wired-lan] [PATCH net-next v4 1/7] igb: clear out tstamp
 after sending the packet
In-Reply-To: <A1A5CF42-A7D4-4DC4-9D57-ED0340B04A6F@intel.com>
References: <1560966016-28254-1-git-send-email-vedang.patel@intel.com>
 <1560966016-28254-2-git-send-email-vedang.patel@intel.com>
 <d6655497-5246-c24e-de35-fc6acdad0bf1@gmail.com>
 <A1A5CF42-A7D4-4DC4-9D57-ED0340B04A6F@intel.com>
Message-ID: <99e834ed-1c78-d35c-84dc-511d377284a1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 6/20/19 9:49 AM, Patel, Vedang wrote:
> 
> 
>> On Jun 20, 2019, at 3:47 AM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
>>
>>
>>
>> On 6/19/19 10:40 AM, Vedang Patel wrote:
>>> skb->tstamp is being used at multiple places. On the transmit side, it
>>> is used to determine the launchtime of the packet. It is also used to
>>> determine the software timestamp after the packet has been transmitted.
>>>
>>> So, clear out the tstamp value after it has been read so that we do not
>>> report false software timestamp on the receive side.
>>>
>>> Signed-off-by: Vedang Patel <vedang.patel@intel.com>
>>> ---
>>> drivers/net/ethernet/intel/igb/igb_main.c | 1 +
>>> 1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
>>> index fc925adbd9fa..f66dae72fe37 100644
>>> --- a/drivers/net/ethernet/intel/igb/igb_main.c
>>> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
>>> @@ -5688,6 +5688,7 @@ static void igb_tx_ctxtdesc(struct igb_ring *tx_ring,
>>> 	 */
>>> 	if (tx_ring->launchtime_enable) {
>>> 		ts = ns_to_timespec64(first->skb->tstamp);
>>> +		first->skb->tstamp = 0;
>>
>> Please provide more explanations.
>>
>> Why only this driver would need this ?
>>
> Currently, igb is the only driver which uses the skb->tstamp option on the transmit side (to set the hardware transmit timestamp). All the other drivers only use it on the receive side (to collect and send the hardware transmit timestamp to the userspace after packet has been sent).
> 
> So, any driver which supports the hardware txtime in the future will have to clear skb->tstamp to make sure that hardware tx transmit and tx timestamping can be done on the same packet.

The changelog is rather confusing :

"So, clear out the tstamp value after it has been read so that we do not
 report false software timestamp on the receive side."

I have hard time understanding why sending an skb through this driver
could cause a problem on receive side ?

I suggest to rephrase it to clear the confusion.

> 
> Thanks,
> Vedang
>>
>>> 		context_desc->seqnum_seed = cpu_to_le32(ts.tv_nsec / 32);
>>> 	} else {
>>> 		context_desc->seqnum_seed = 0;
>>>
> 
