From: Patel, Vedang <vedang.patel@intel.com>
Date: Thu, 20 Jun 2019 20:32:26 +0000
Subject: [Intel-wired-lan] [PATCH net-next v4 1/7] igb: clear out tstamp
 after sending the packet
In-Reply-To: <99e834ed-1c78-d35c-84dc-511d377284a1@gmail.com>
References: <1560966016-28254-1-git-send-email-vedang.patel@intel.com>
 <1560966016-28254-2-git-send-email-vedang.patel@intel.com>
 <d6655497-5246-c24e-de35-fc6acdad0bf1@gmail.com>
 <A1A5CF42-A7D4-4DC4-9D57-ED0340B04A6F@intel.com>
 <99e834ed-1c78-d35c-84dc-511d377284a1@gmail.com>
Message-ID: <D1A9515C-D317-40F3-81A2-451F7228A853@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> On Jun 20, 2019, at 10:07 AM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
> 
> 
> 
> On 6/20/19 9:49 AM, Patel, Vedang wrote:
>> 
>> 
>>> On Jun 20, 2019, at 3:47 AM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
>>> 
>>> 
>>> 
>>> On 6/19/19 10:40 AM, Vedang Patel wrote:
>>>> skb->tstamp is being used at multiple places. On the transmit side, it
>>>> is used to determine the launchtime of the packet. It is also used to
>>>> determine the software timestamp after the packet has been transmitted.
>>>> 
>>>> So, clear out the tstamp value after it has been read so that we do not
>>>> report false software timestamp on the receive side.
>>>> 
>>>> Signed-off-by: Vedang Patel <vedang.patel@intel.com>
>>>> ---
>>>> drivers/net/ethernet/intel/igb/igb_main.c | 1 +
>>>> 1 file changed, 1 insertion(+)
>>>> 
>>>> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
>>>> index fc925adbd9fa..f66dae72fe37 100644
>>>> --- a/drivers/net/ethernet/intel/igb/igb_main.c
>>>> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
>>>> @@ -5688,6 +5688,7 @@ static void igb_tx_ctxtdesc(struct igb_ring *tx_ring,
>>>> 	 */
>>>> 	if (tx_ring->launchtime_enable) {
>>>> 		ts = ns_to_timespec64(first->skb->tstamp);
>>>> +		first->skb->tstamp = 0;
>>> 
>>> Please provide more explanations.
>>> 
>>> Why only this driver would need this ?
>>> 
>> Currently, igb is the only driver which uses the skb->tstamp option on the transmit side (to set the hardware transmit timestamp). All the other drivers only use it on the receive side (to collect and send the hardware transmit timestamp to the userspace after packet has been sent).
>> 
>> So, any driver which supports the hardware txtime in the future will have to clear skb->tstamp to make sure that hardware tx transmit and tx timestamping can be done on the same packet.
> 
> The changelog is rather confusing :
> 
> "So, clear out the tstamp value after it has been read so that we do not
> report false software timestamp on the receive side."
> 
> I have hard time understanding why sending an skb through this driver
> could cause a problem on receive side ?
> 
Ahh.. that?s clearly a false statement. Skb->tstamp is cleared so that it is not interpreted as a software timestamp when trying to send the Hardware TX timestamp to the userspace. I will rephrase the commit message in the next version.

Some more details:
The problem occurs when using the txtime-assist mode of taprio with packets which also request the hardware transmit timestamp (e.g. PTP packets). Whenever txtime-assist mode is set, taprio will assign a hardware transmit timestamp to all the packets (in skb->tstamp). PTP packets will also request the hardware transmit timestamp be sent to the userspace after packet is transmitted.

Whenever a new timestamp is detected by the driver (this work is done in igb_ptp_tx_work() which calls igb_ptp_tx_hwtstamps() in igb_ptp.c[1]), it will queue the timestamp in the ERR_QUEUE for the userspace to read. When the userspace is ready, it will issue a recvmsg() call to collect this timestamp. The problem is in this recvmsg() call. If the skb->tstamp is not cleared out, it will be interpreted as a software timestamp and the hardware tx timestamp will not be successfully sent to the userspace. Look at skb_is_swtx_tstamp() and the callee function __sock_recv_timestamp() in net/socket.c for more details. 

Thanks, 
Vedang

[1] - https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/intel/igb/igb_ptp.c?h=v5.2-rc5#n666

> I suggest to rephrase it to clear the confusion.
> 
>> 
>> Thanks,
>> Vedang
>>> 
>>>> 		context_desc->seqnum_seed = cpu_to_le32(ts.tv_nsec / 32);
>>>> 	} else {
>>>> 		context_desc->seqnum_seed = 0;
>>>> 
>> 

