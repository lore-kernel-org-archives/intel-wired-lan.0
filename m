From: Patel, Vedang <vedang.patel@intel.com>
Date: Tue, 4 Jun 2019 19:53:17 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1 0/7] net/sched: Add txtime
 assist support for taprio
In-Reply-To: <4c4ec746-4282-ad3a-351c-1c7a355d093d@ti.com>
References: <1559065608-27888-1-git-send-email-vedang.patel@intel.com>
 <007b6a78-48e7-e667-d84b-dec745f84603@ti.com>
 <4c4ec746-4282-ad3a-351c-1c7a355d093d@ti.com>
Message-ID: <28C662B0-6B93-453B-B664-F3D8FFA8EFBB@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


> On Jun 3, 2019, at 6:54 AM, Murali Karicheri <m-karicheri2@ti.com> wrote:
> 
> On 06/03/2019 09:50 AM, Murali Karicheri wrote:
>> Hi Vedang,
>> On 05/28/2019 01:46 PM, Vedang Patel wrote:
>>> Currently, we are seeing packets being transmitted outside their timeslices. We
>>> can confirm that the packets are being dequeued at the right time. So, the
>>> delay is induced after the packet is dequeued, because taprio, without any
>>> offloading, has no control of when a packet is actually transmitted.
>>> 
>>> In order to solve this, we are making use of the txtime feature provided by ETF
>>> qdisc. Hardware offloading needs to be supported by the ETF qdisc in order to
>>> take advantage of this feature. The taprio qdisc will assign txtime (in
>>> skb->tstamp) for all the packets which do not have the txtime allocated via the
>>> SO_TXTIME socket option. For the packets which already have SO_TXTIME set,
>>> taprio will validate whether the packet will be transmitted in the correct
>>> interval.
>>> 
>>> In order to support this, the following parameters have been added:
>>> - offload (taprio): This is added in order to support different offloading
>>>    modes which will be added in the future.
>>> - txtime-delay (taprio): this is the time the packet takes to traverse through
>>>    the kernel to adapter card.
>> I am very new to this TC and QoS handling of Linux kernel and TSN. So sorry some of the  questions below are very basic in nature. I would soon would be working to add this support in our platform based on this.
>> So please answer.
>> Is txtime-delay from the instance qdisc de-queue the packet to the time
>> packets get onto the wire? I am wondering if this time is deterministic
>> or we have some way to ensure this can be tuned to meet a max value?
>> Also how would one calculate this value or have to measure it?
>>> - skip_sock_check (etf): etf qdisc currently drops any packet which does not
>>>    have the SO_TXTIME socket option set. This check can be skipped by specifying
>>>    this option.
>>> 
>>> Following is an example configuration:
>>> 
>>> $ tc qdisc replace dev $IFACE parent root handle 100 taprio \\
>>>        num_tc 3 \\
>>>        map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 \\
>>>        queues 1 at 0 1 at 0 1 at 0 \\
>>>        base-time $BASE_TIME \\
>>>        sched-entry S 01 300000 \\
>>>        sched-entry S 02 300000 \\
>>>        sched-entry S 04 400000 \\
>>>        offload 2 \\
>>>        txtime-delay 40000 \\
>>>        clockid CLOCK_TAI
>>> 
>> Could you tell me what is CLOCK_TAI?? I see below in the source code for
>> the definition in include/uapi/linux/time.h
>> /*
>>  * The driver implementing this got removed. The clock ID is kept as a
>>  * place holder. Do not reuse!
>>  */
>> #define CLOCK_SGI_CYCLE            10
>> #define CLOCK_TAI            11
>> So why do I see such defines being used in the example that is being
>> removed?
>> AFAIK, From the usage point of view, TSN requires the network being
>> synchronized through linux PTP. For synchronization phc2sys is used to
>> synchronize system time to the PHC. So why don't one use system time for
>> this?
>> So application will use clock_gettime() to know current time and
>> schedule the packet for transmission as well as user would use scripts
>> or such to check current system time and issue tc command above. So the
>> command should use CLOCK_REALTIME in that case. So all h/w and software
>> are aligned to the same time source. Or Have I understood it wrong? I am
>> assuming that for the offloaded case, h/w schedule Gate open, send
>> packet etc are synchronized to the PHC or use a translated time w.r.t the common time (network time. Assuming PHC tracks this).
>> Thanks in advance for clarifying this.
>>> $ tc qdisc replace dev $IFACE parent 100:1 etf \\
>>>        offload delta 200000 clockid CLOCK_TAI skip_sock_check
>>> 
>>> Here, the "offload" parameter is indicating that the TXTIME_OFFLOAD mode is
>>> enabled. Also, that all the traffic classes have been assigned the same queue.
> 
> Actually the tc class is mapped to the same queue in the previous
> command, not this one, right?
> 
Yes, you are right. It is done while setting up taprio. The way it?s written looks confusing. I will modify and clarify this in the next version of the series.

Thanks,
Vedang
> Murali
>>> This is to prevent the traffic classes in the lower priority queues from
>>> getting starved. Note that this configuration is specific to the i210 ethernet
>>> card. Other network cards where the hardware queues are given the same
>>> priority, might be able to utilize more than one queue.
>>> 
>>> Following are some of the other highlights of the series:
>>> - Fix a bug where hardware timestamping and SO_TXTIME options cannot be used
>>>    together. (Patch 1)
>>> - Introduce hardware offloading. This patch introduces offload parameter which
>>>    can be used to enable the txtime offload mode. It will also support enabling
>>>    full offload when the support is available in drivers. (Patch 3)
>>> - Make TxTime assist mode work with TCP packets. (Patch 6 & 7)
>>> 
>>> 
>>> The following changes are recommended to be done in order to get the best
>>> performance from taprio in this mode:
>>> # ip link set dev enp1s0 mtu 1514
>> May I know why MTU is changed to 1514 to include the Ethernet header?
>>> # ethtool -K eth0 gso off
>>> # ethtool -K eth0 tso off
>>> # ethtool --set-eee eth0 eee off
>> Could you please explain why these are needed?
>> Thanks
>> Murali
>>> 
>>> Thanks,
>>> Vedang Patel
>>> 
>>> Vedang Patel (6):
>>>    igb: clear out tstamp after sending the packet.
>>>    etf: Add skip_sock_check
>>>    taprio: calculate cycle_time when schedule is installed
>>>    taprio: Add support for txtime offload mode.
>>>    taprio: make clock reference conversions easier
>>>    taprio: Adjust timestamps for TCP packets.
>>> 
>>> Vinicius Costa Gomes (1):
>>>    taprio: Add the skeleton to enable hardware offloading
>>> 
>>>   drivers/net/ethernet/intel/igb/igb_main.c |   1 +
>>>   include/uapi/linux/pkt_sched.h            |   6 +
>>>   net/sched/sch_etf.c                       |  10 +
>>>   net/sched/sch_taprio.c                    | 548 ++++++++++++++++++++--
>>>   4 files changed, 532 insertions(+), 33 deletions(-)
>>> 
> 

