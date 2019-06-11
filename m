From: Patel, Vedang <vedang.patel@intel.com>
Date: Tue, 11 Jun 2019 21:03:53 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1 5/7] taprio: Add support
 for txtime offload mode.
In-Reply-To: <89d1cea2-ae1c-bc1c-0327-29a3334cba49@ti.com>
References: <1559065608-27888-1-git-send-email-vedang.patel@intel.com>
 <1559065608-27888-6-git-send-email-vedang.patel@intel.com>
 <55c2daae-c69b-4847-f995-4df85c4ee8b8@ti.com>
 <E6AB74F1-C942-4167-97EF-329831D73F6C@intel.com>
 <7a8f56c5-69aa-52ed-3889-810466f80137@ti.com>
 <7F0484D6-80AA-454B-B179-9FAC20D633FD@intel.com>
 <89d1cea2-ae1c-bc1c-0327-29a3334cba49@ti.com>
Message-ID: <A8C0B7C0-BEA0-412E-9B3E-F3050E008D96@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> On Jun 10, 2019, at 7:27 AM, Murali Karicheri <m-karicheri2@ti.com> wrote:
> 
> Vedang,
> 
> On 06/07/2019 05:12 PM, Patel, Vedang wrote:
>> Hi Murali,
>>> On Jun 7, 2019, at 11:52 AM, Murali Karicheri <m-karicheri2@ti.com> wrote:
>>> 
>>> On 06/04/2019 04:06 PM, Patel, Vedang wrote:
>>>> Hi Murali,
>>>>> On Jun 3, 2019, at 7:15 AM, Murali Karicheri <m-karicheri2@ti.com> wrote:
>>>>> 
>>>>> Hi Vedang,
>>>>> 
>>>>> On 05/28/2019 01:46 PM, Vedang Patel wrote:
>>>>>> Currently, we are seeing non-critical packets being transmitted outside
>>>>>> of their timeslice. We can confirm that the packets are being dequeued
>>>>>> at the right time. So, the delay is induced in the hardware side.  The
>>>>>> most likely reason is the hardware queues are starving the lower
>>>>>> priority queues.
>>>>>> In order to improve the performance of taprio, we will be making use of the
>>>>>> txtime feature provided by the ETF qdisc. For all the packets which do not have
>>>>>> the SO_TXTIME option set, taprio will set the transmit timestamp (set in
>>>>>> skb->tstamp) in this mode. TAPrio Qdisc will ensure that the transmit time for
>>>>>> the packet is set to when the gate is open. If SO_TXTIME is set, the TAPrio
>>>>>> qdisc will validate whether the timestamp (in skb->tstamp) occurs when the gate
>>>>>> corresponding to skb's traffic class is open.
>>>>>> Following is the example configuration for enabling txtime offload:
>>>>>> tc qdisc replace dev eth0 parent root handle 100 taprio \\
>>>>>>       num_tc 3 \\
>>>>>>       map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 \\
>>>>>>       queues 1 at 0 1 at 0 1 at 0 \\
>>>>>>       base-time 1558653424279842568 \\
>>>>>>       sched-entry S 01 300000 \\
>>>>>>       sched-entry S 02 300000 \\
>>>>>>       sched-entry S 04 400000 \\
>>>>>>       offload 2 \\
>>>>>>       txtime-delay 40000 \\
>>>>>>       clockid CLOCK_TAI
>>>>>> tc qdisc replace dev $IFACE parent 100:1 etf skip_sock_check \\
>>>>>>       offload delta 200000 clockid CLOCK_TAI
>>>>>> Here, the "offload" parameter is indicating that the TXTIME_OFFLOAD mode is
>>>>>> enabled. Also, all the traffic classes are mapped to the same queue.  This is
>>>>>> only possible in taprio when txtime offload is enabled. Also note that the ETF
>>>>>> Qdisc is enabled with offload mode set.
>>>>>> In this mode, if the packet's traffic class is open and the complete packet can
>>>>>> be transmitted, taprio will try to transmit the packet immediately. This will
>>>>>> be done by setting skb->tstamp to current_time + the time delta indicated in
>>>>>> the txtime_delay parameter. This parameter indicates the time taken (in
>>>>>> software) for packet to reach the network adapter.
>>>>> 
>>>>> In TSN Time aware shaper, packets are sent when gate for a specific
>>>>> traffic class is open. So packets that are available in the queues are
>>>>> sent by the scheduler. So the ETF is not strictly required for this
>>>>> function.
>>>>> I understand if the application needs to send packets with
>>>>> some latency expectation should use ETF to schedule the packet in sync
>>>>> with the next gate open time. So txtime_delay is used to account for
>>>>> the delay for packets to travel from user space to nic.
>>>> This is not true. As explained in the other email, txtime-delay is the maximum time a packet might take after reaching taprio_enqueue() assuming the gate corresponding to that packet was already open.
>>>>> So it is ETF
>>>>> that need to inspect the skb->tstamp and allow or if time match or
>>>>> discard if late. Is this the case?
>>>>> 
>>>> The role of ETF is just to sort packets according to their transmit timestamp and send them to the hardware queues to transmit whenever their time comes. This is needed because the i210 hardware does not have any sort feature within its queue. If 2 packets arrive and the first packet has a transmit timestamp later than the second packet, the second packet won?t be transmitted on time.
>>>> Taprio in the txtime offload mode (btw, this will soon be renamed to txtime-assist) will set the transmit timestamp of each packet (in skb->tstamp) and then send it to ETF so that it can be sorted with the other packets and sent to hardware whenever the time comes. ETF will discard the packet if the transmit time is in the past or before the transmit time of the packet which is already been sent to the hardware.
>>>> Let me know if you have more questions about this.
>>> 
>>> It is bit confusing to have this mode in taprio. My assumption is
>>> that taprio implements TSN standard 802.1Qbv scheduler that is
>>> responsible for managing the Gate open/close and sending frames
>>> for specific traffic class during the Gate open. AFAIK, this
>>> scheduler doesn't inspect the packet's metadata such as time to
>>> send or such. So why is txtime offload mode is added to taprio?
>>> Could you please explain?
>>> 
>>> Murali
>>> 
>> Short answer: Taprio still implements a 802.1Qbv like schedule. But, it leverages the functionality from ETF to do so.
>> Long answer:
>> The software-only implementation of 802.1Qbv has quite a few low priority packets being transmitted outside their timeslice. This is because the higher priority queues in i210 are starving the lower priority queues. So, what the txtime-assist mode does is to assign an explicit tx timestamp and use the launchtime feature of the i210 adapter card to transmit the packets on time. It is still sending frames for a particular traffic class only when their gate is open. Also, it is not modifying any data in the packet which is transmitted. Just notifying the NIC when to transmit the packet. If there is a tx timestamp already assigned to a packet, it does not change it. Since we are assigning the tx timestamp, we have to route the packet through the ETF queue disc for sorting the packets according to their timestamps and sending it to the NIC.
>> We have to implement the above mechanism because, currently, we do not have the capability to offload the taprio schedule to the hardware.
> Ok, Thanks for the patience and explanation. Yes, it helps.
> 
> One last question. If your hardware i210 checks the time in a packet
> and finds it is  late, does it drop the packet? I understand that
> txtime-delay is for tuning this such that hardware see the packet on
> time and transmit. I also understand that packets get dropped
> at the ETF qdisc if late.
> 
> Murali

The i210 hardware does not drop packets if they are late. 

In i210 NIC, the launchtime field is only 25 bits long with 32 ns units. So, it will compare launchtime*32 to the SYSTIML register (it stores the nanosecond part of the PTP time). It will send the packet if the time is exactly same as above. It is the job of ETF to ensure that the packet is not sent too early by selecting the delta which is less than 0.5 sec.

For more information, you can look at Section 7.2.2.2.3 and Section 7.2.7.5.3 of the i210 data sheet[1]. 

Thanks,
Vedang

[1] - https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/i210-ethernet-controller-datasheet.pdf

