From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@intel.com>
Date: Tue, 8 Sep 2020 14:21:54 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next 0/6] xsk: exit NAPI loop when
 AF_XDP Rx ring is full
In-Reply-To: <CAJ8uoz3WbS7E1OiC5p8x+o48vwkN43R9JxMwvRvgVk4n3SNiZg@mail.gmail.com>
References: <20200904135332.60259-1-bjorn.topel@gmail.com>
 <0257f769-0f43-a5b7-176d-7c5ff8eaac3a@intel.com>
 <11f663ec-5ea7-926c-370d-0b67d3052583@nvidia.com>
 <CAJ8uoz3WbS7E1OiC5p8x+o48vwkN43R9JxMwvRvgVk4n3SNiZg@mail.gmail.com>
Message-ID: <75146564-2774-47ac-cc75-40d74bea50d8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2020-09-08 13:37, Magnus Karlsson wrote:
> On Tue, Sep 8, 2020 at 12:33 PM Maxim Mikityanskiy <maximmi@nvidia.com> wrote:
>>
>> On 2020-09-04 16:59, Bj?rn T?pel wrote:
>>> On 2020-09-04 15:53, Bj?rn T?pel wrote:
>>>> This series addresses a problem that arises when AF_XDP zero-copy is
>>>> enabled, and the kernel softirq Rx processing and userland process
>>>> is running on the same core.
>>>>
>>> [...]
>>>>
>>>
>>> @Maxim I'm not well versed in Mellanox drivers. Would this be relevant
>>> to mlx5 as well?
>>
>> Thanks for letting me know about this series! So the basic idea is to
>> stop processing hardware completions if the RX ring gets full, because
>> the application didn't have chance to run? Yes, I think it's also
>> relevant to mlx5, the issue is not driver-specific, and a similar fix is
>> applicable. However, it may lead to completion queue overflows - some
>> analysis is needed to understand what happens then and how to handle it.
>>
>> Regarding the feature, I think it should be opt-in (disabled by
>> default), because old applications may not wakeup RX after they process
>> packets in the RX ring.
>

First of all; Max, thanks for some really good input as usual!


> How about need_wakeup enable/disable at bind time being that opt-in,
> instead of a new option? It is off by default, and when it is off, the
> driver busy-spins on the Rx ring until it can put an entry there. It
> will not yield to the application by returning something less than
> budget. Applications need not check the need_wakeup flag. If
> need_wakeup is enabled by the user, the contract is that user-space
> needs to check the need_wakeup flag and act on it. If it does not,
> then that is a programming error and it can be set for any unspecified
> reason. No reason to modify the application, if it checks need_wakeup.
> But if this patch behaves like that I have not checked.
>

It does not behave exactly like this. If need_wakeup is enabled, the 
napi look exists, but if not the napi is rearmed -- so we'll get a less 
efficient loop. I'll need address this.

I'm leaning towards a more explicit opt-in like Max suggested. As Max 
pointed out, AF_XDP/XDP_TX is actually a non-insane(!) way of using 
AF_XDP zero-copy, which will suffer from the early exit.


> Good points in the rest of the mail, that I think should be addressed.
>

Yeah, I agree. I will take a step back an rethink. I'll experiment with
the busy-polling suggested by Jakub, and also an opt-in early exit.

Thanks for all the suggestions folks!


Cheers,
Bj?rn


> /Magnus
> 
>> Is it required to change xdpsock accordingly?
>> Also, when need_wakeup is disabled, your driver implementation seems to
>> quit NAPI anyway, but it shouldn't happen, because no one will send a
>> wakeup.
>>
>> Waiting until the RX ring fills up, then passing control to the
>> application and waiting until the hardware completion queue fills up,
>> and so on increases latency - the busy polling approach sounds more
>> legit here.
>>
>> The behavior may be different depending on the driver implementation:
>>
>> 1. If you arm the completion queue and leave interrupts enabled on early
>> exit too, the application will soon be interrupted anyway and won't have
>> much time to process many packets, leading to app <-> NAPI ping-pong one
>> packet at a time, making NAPI inefficient.
>>
>> 2. If you don't arm the completion queue on early exit and wait for the
>> explicit wakeup from the application, it will easily overflow the
>> hardware completion queue, because we don't have a symmetric mechanism
>> to stop the application on imminent hardware queue overflow. It doesn't
>> feel correct and may be trickier to handle: if the application is too
>> slow, such drops should happen on driver/kernel level, not in hardware.
>>
>> Which behavior is used in your drivers? Or am I missing some more options?
>>
>> BTW, it should be better to pass control to the application before the
>> first dropped packet, not after it has been dropped.
>>
>> Some workloads different from pure AF_XDP, for example, 50/50 AF_XDP and
>> XDP_TX may suffer from such behavior, so it's another point to make a
>> knob on the application layer to enable/disable it.
>>
>>   From the driver API perspective, I would prefer to see a simpler API if
>> possible. The current API exposes things that the driver shouldn't know
>> (BPF map type), and requires XSK-specific handling. It would be better
>> if some specific error code returned from xdp_do_redirect was reserved
>> to mean "exit NAPI early if you support it". This way we wouldn't need
>> two new helpers, two xdp_do_redirect functions, and this approach would
>> be extensible to other non-XSK use cases without further changes in the
>> driver, and also the logic to opt-in the feature could be put inside the
>> kernel.
>>
>> Thanks,
>> Max
>>
>>>
>>> Cheers,
>>> Bj?rn
>>
