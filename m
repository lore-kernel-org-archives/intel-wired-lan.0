From: William Tu <u9012063@gmail.com>
Date: Mon, 27 Mar 2017 11:38:52 -0700
Subject: [Intel-wired-lan] [PATCH v7 0/2] XDP support for ixgbe
In-Reply-To: <58D70379.3030802@gmail.com>
References: <20170324042949.10293.43329.stgit@john-Precision-Tower-5810>
 <CALDO+SYA4a37ePhzSPwbqqnCngU6uudeiCGvGoXMPU3MbX4W2g@mail.gmail.com>
 <58D70379.3030802@gmail.com>
Message-ID: <CALDO+SZDUycW-zmri1_7H1czTn+5rN3mt3a7qBE=VRqGw+CHNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sat, Mar 25, 2017 at 4:55 PM, John Fastabend
<john.fastabend@gmail.com> wrote:
> On 17-03-24 03:22 PM, William Tu wrote:
>> On Thu, Mar 23, 2017 at 9:30 PM, John Fastabend
>> <john.fastabend@gmail.com> wrote:
>>> This version fixes a couple issues with q_vector allocation and query on XDP
>>> program.
>>>
>>> ---
>>>
>>> John Fastabend (2):
>>>       ixgbe: add XDP support for pass and drop actions
>>>       ixgbe: add support for XDP_TX action
>>>
>>>
>>>  drivers/net/ethernet/intel/ixgbe/ixgbe.h         |   23 +
>>>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |   29 +
>>>  drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c     |   78 +++-
>>>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |  434 +++++++++++++++++++---
>>>  4 files changed, 490 insertions(+), 74 deletions(-)
>>>
>>> --
>>> Signature
>>
>> Thanks. I tested using samples/bpf/xdp1 and xdp2 using ping and dpdk
>> pktgen. Both work OK.
>>
>> When enabling xdp, dmesg shows:
>> [12270.610462] pps pps0: new PPS source ptp6
>> [12270.610465] ixgbe 0000:05:00.0: registered PHC device on enp5s0f0
>> [12271.619018] ixgbe 0000:05:00.0: removed PHC on enp5s0f0
>> [12271.943334] ixgbe 0000:05:00.0: Multiqueue Enabled: Rx Queue count
>> = 16, Tx Queue count = 16 XDP Queue count = 0
>> [12272.011324] pps pps0: new PPS source ptp6
>> [12272.011326] ixgbe 0000:05:00.0: registered PHC device on enp5s0f0
>> [12276.477066] ixgbe 0000:05:00.0 enp5s0f0: NIC Link is Up 10 Gbps,
>> Flow Control: None
>>
>> I'm not sure it's important or not.
>> Regards,
>> William
>>
>
> Well that is a bit odd. When you load the XDP program we should see a
> "XDP Queue count" equal to the cpu count from /proc/cpuinfo. But if this
> is from either after unloading a XDP program or from initial loading the
> module before an XDP program is loaded than zero is expected. The queues
> are only added after the XDP program is loaded.
>
> Thanks,
> John
>
in my case I have 16 cpus. But I saw XDP queues either 0 or 48.

[86079.450650] ixgbe 0000:05:00.1 enp5s0f1: NIC Link is Up 10 Gbps,
Flow Control: None
[86940.730799] ixgbe 0000:05:00.0: removed PHC on enp5s0f0
[86941.052806] ixgbe 0000:05:00.0: Multiqueue Enabled: Rx Queue count
= 16, Tx Queue count = 16 XDP Queue count = 48
[86941.216825] pps pps0: new PPS source ptp6
[86941.216827] ixgbe 0000:05:00.0: registered PHC device on enp5s0f0
[86945.371094] ixgbe 0000:05:00.0 enp5s0f0: NIC Link is Up 10 Gbps,
Flow Control: None
[86954.498885] ixgbe 0000:05:00.1: removed PHC on enp5s0f1
[86954.824992] ixgbe 0000:05:00.1: Multiqueue Enabled: Rx Queue count
= 16, Tx Queue count = 16 XDP Queue count = 0
[86954.893054] pps pps1: new PPS source ptp7
[86954.893055] ixgbe 0000:05:00.1: registered PHC device on enp5s0f1
[86959.094568] ixgbe 0000:05:00.1 enp5s0f1: NIC Link is Up 10 Gbps,
Flow Control: None
[86991.730721] ixgbe 0000:05:00.1: removed PHC on enp5s0f1
[86992.052007] ixgbe 0000:05:00.1: Multiqueue Enabled: Rx Queue count
= 16, Tx Queue count = 16 XDP Queue count = 48
[86992.216915] pps pps1: new PPS source ptp7
[86992.216916] ixgbe 0000:05:00.1: registered PHC device on enp5s0f1
[86992.338119] ixgbe 0000:05:00.1 enp5s0f1: initiating reset to clear
Tx work after link loss

Thanks,
William
