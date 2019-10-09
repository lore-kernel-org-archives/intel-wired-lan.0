From: Samudrala, Sridhar <sridhar.samudrala@intel.com>
Date: Wed, 9 Oct 2019 09:19:04 -0700
Subject: [Intel-wired-lan] [PATCH bpf-next 0/4] Enable direct receive on
 AF_XDP sockets
In-Reply-To: <4c316f09-0691-4a1b-f798-73299e978946@intel.com>
References: <1570515415-45593-1-git-send-email-sridhar.samudrala@intel.com>
 <4c316f09-0691-4a1b-f798-73299e978946@intel.com>
Message-ID: <411a0287-13fb-672b-740b-10a199e34836@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10/8/2019 1:05 AM, Bj?rn T?pel wrote:
> On 2019-10-08 08:16, Sridhar Samudrala wrote:
>> This is a rework of the following patch series
>> https://lore.kernel.org/netdev/1565840783-8269-1-git-send-email-sridhar.samudrala at intel.com/#r 
>>
>> that tried to enable direct receive by bypassing XDP program attached
>> to the device.
>>
>> Based on the community feedback and some suggestions from Bjorn, changed
>> the semantics of the implementation to enable direct receive on AF_XDP
>> sockets that are bound to a queue only when there is no normal XDP 
>> program
>> attached to the device.
>>
>> This is accomplished by introducing a special BPF prog pointer 
>> (DIRECT_XSK)
>> that is attached at the time of binding an AF_XDP socket to a queue of a
>> device. This is done only if there is no other XDP program attached to
>> the device. The normal XDP program has precedence and will replace the
>> DIRECT_XSK prog if it is attached later. The main reason to introduce a
>> special BPF prog pointer is to minimize the driver changes. The only 
>> change
>> is to use the bpf_get_prog_id() helper when QUERYING the prog id.
>>
>> Any attach of a normal XDP program will take precedence and the direct 
>> xsk
>> program will be removed. The direct XSK program will be attached
>> automatically when the normal XDP program is removed when there are any
>> AF_XDP direct sockets associated with that device.
>>
>> A static key is used to control this feature in order to avoid any 
>> overhead
>> for normal XDP datapath when there are no AF_XDP sockets in direct-xsk 
>> mode.
>>
>> Here is some performance data i collected on my Intel Ivybridge based
>> development system (Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz)
>> NIC: Intel 40Gb ethernet (i40e)
>>
>> xdpsock rxdrop 1 core (both app and queue's irq pinned to the same core)
>> ??? default : taskset -c 1 ./xdpsock -i enp66s0f0 -r -q 1
>> ??? direct-xsk :taskset -c 1 ./xdpsock -i enp66s0f0 -r -q 1
>> 6.1x improvement in drop rate
>>
>> xdpsock rxdrop 2 core (app and queue's irq pinned to different cores)
>> ??? default : taskset -c 3 ./xdpsock -i enp66s0f0 -r -q 1
>> ??? direct-xsk :taskset -c 3 ./xdpsock -i enp66s0f0 -r -d -q 1
>> 6x improvement in drop rate
>>
>> xdpsock l2fwd 1 core (both app and queue's irq pinned to the same core)
>> ??? default : taskset -c 1 ./xdpsock -i enp66s0f0 -l -q 1
>> ??? direct-xsk :taskset -c 1 ./xdpsock -i enp66s0f0 -l -d -q 1
>> 3.5x improvement in l2fwd rate
>>
>> xdpsock rxdrop 2 core (app and queue'sirq pinned to different cores)
>> ??? default : taskset -c 3 ./xdpsock -i enp66s0f0 -l -q 1
>> ??? direct-xsk :taskset -c 3 ./xdpsock -i enp66s0f0 -l -d -q 1
>> 4.5x improvement in l2fwd rate
>>
>> dpdk-pktgen is used to send 64byte UDP packets from a link partner and
>> ethtool ntuple flow rule is used to redirect packets to queue 1 on the
>> system under test.
>>
> 
> Thanks for working on this Sridhar! I like this approach! Except from
> the bpf_get_prog_id() changes, no driver changes are needed.
> 
> It's also a cleaner (IMO) approach than my previous attempts [1,2,3]
> 
> Would be interesting to see NFP support AF_XDP offloading with this
> option. (nudge, nudge).
> 
> A thought: From userland, a direct AF_XDP socket will not appear as an
> XDP program is attached to the device (id == 0). Maybe show in ss(8)
> (via xsk_diag.c) that the socket is direct?

Sure. will add this in the next revision.

> 
> [1] 
> https://lore.kernel.org/netdev/CAJ+HfNj63QcLY8=y1fF93PZd3XcfiGSrbbWdiGByjTzZQydSSg at mail.gmail.com/ 
> 
> [2] 
> https://lore.kernel.org/netdev/cd952f99-6bad-e0c8-5bcd-f0010218238c at intel.com/ 
> 
> [3] 
> https://lore.kernel.org/netdev/20181207114431.18038-1-bjorn.topel at gmail.com/ 
> 
