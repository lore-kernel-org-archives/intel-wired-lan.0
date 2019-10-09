From: Samudrala, Sridhar <sridhar.samudrala@intel.com>
Date: Tue, 8 Oct 2019 23:29:59 -0700
Subject: [Intel-wired-lan] [PATCH bpf-next 0/4] Enable direct receive on
 AF_XDP sockets
In-Reply-To: <20191008174919.2160737a@cakuba.netronome.com>
References: <1570515415-45593-1-git-send-email-sridhar.samudrala@intel.com>
 <20191008174919.2160737a@cakuba.netronome.com>
Message-ID: <ce255470-6bf7-0ba4-c24f-0808e3331977@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 10/8/2019 5:49 PM, Jakub Kicinski wrote:
> On Mon,  7 Oct 2019 23:16:51 -0700, Sridhar Samudrala wrote:
>> This is a rework of the following patch series
>> https://lore.kernel.org/netdev/1565840783-8269-1-git-send-email-sridhar.samudrala at intel.com/#r
>> that tried to enable direct receive by bypassing XDP program attached
>> to the device.
>>
>> Based on the community feedback and some suggestions from Bjorn, changed
>> the semantics of the implementation to enable direct receive on AF_XDP
>> sockets that are bound to a queue only when there is no normal XDP program
>> attached to the device.
>>
>> This is accomplished by introducing a special BPF prog pointer (DIRECT_XSK)
>> that is attached at the time of binding an AF_XDP socket to a queue of a
>> device. This is done only if there is no other XDP program attached to
>> the device. The normal XDP program has precedence and will replace the
>> DIRECT_XSK prog if it is attached later. The main reason to introduce a
>> special BPF prog pointer is to minimize the driver changes. The only change
>> is to use the bpf_get_prog_id() helper when QUERYING the prog id.
>>
>> Any attach of a normal XDP program will take precedence and the direct xsk
>> program will be removed. The direct XSK program will be attached
>> automatically when the normal XDP program is removed when there are any
>> AF_XDP direct sockets associated with that device.
>>
>> A static key is used to control this feature in order to avoid any overhead
>> for normal XDP datapath when there are no AF_XDP sockets in direct-xsk mode.
> 
> Don't say that static branches have no overhead. That's dishonest.

I didn't mean to say no overhead, but the overhead is minimized using 
static_branch_unlikely()

> 
>> Here is some performance data i collected on my Intel Ivybridge based
>> development system (Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz)
>> NIC: Intel 40Gb ethernet (i40e)
>>
>> xdpsock rxdrop 1 core (both app and queue's irq pinned to the same core)
>>     default : taskset -c 1 ./xdpsock -i enp66s0f0 -r -q 1
>>     direct-xsk :taskset -c 1 ./xdpsock -i enp66s0f0 -r -q 1
>> 6.1x improvement in drop rate
>>
>> xdpsock rxdrop 2 core (app and queue's irq pinned to different cores)
>>     default : taskset -c 3 ./xdpsock -i enp66s0f0 -r -q 1
>>     direct-xsk :taskset -c 3 ./xdpsock -i enp66s0f0 -r -d -q 1
>> 6x improvement in drop rate
>>
>> xdpsock l2fwd 1 core (both app and queue's irq pinned to the same core)
>>     default : taskset -c 1 ./xdpsock -i enp66s0f0 -l -q 1
>>     direct-xsk :taskset -c 1 ./xdpsock -i enp66s0f0 -l -d -q 1
>> 3.5x improvement in l2fwd rate
>>
>> xdpsock rxdrop 2 core (app and queue'sirq pinned to different cores)
>>     default : taskset -c 3 ./xdpsock -i enp66s0f0 -l -q 1
>>     direct-xsk :taskset -c 3 ./xdpsock -i enp66s0f0 -l -d -q 1
>> 4.5x improvement in l2fwd rate
> 
> I asked you to add numbers for handling those use cases in the kernel
> directly.

Forgot to explicitly mention that I didn't see any regressions with 
xdp1, xdp2 or xdpsock in default mode with these patches. Performance 
remained the same.

> 
>> dpdk-pktgen is used to send 64byte UDP packets from a link partner and
>> ethtool ntuple flow rule is used to redirect packets to queue 1 on the
>> system under test.
> 
> Obviously still nack from me.
> 
