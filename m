From: Robin Murphy <robin.murphy@arm.com>
Date: Thu, 3 Jun 2021 14:09:46 +0100
Subject: [Intel-wired-lan] Regression 5.12.0-rc4 net: ice: significant
 throughput drop
In-Reply-To: <CAHn8xc=1g8bzV-uxaJAYpJ114rR7MLzth=4jyDG329ZwEG+kpg@mail.gmail.com>
References: <CAHn8xckNXci+X_Eb2WMv4uVYjO2331UWB2JLtXr_58z0Av8+8A@mail.gmail.com>
 <cc58c09e-bbb5-354a-2030-bf8ebb2adc86@iogearbox.net>
 <7f048c57-423b-68ba-eede-7e194c1fea4e@arm.com>
 <CAHn8xckNt3smeQPi3dgq5i_3vP7KwU45pnP5OCF8nOV_QEdyMA@mail.gmail.com>
 <7c04eeea-22d3-c265-8e1e-b3f173f2179f@iogearbox.net>
 <705f90c3-b933-8863-2124-3fea7fdbd81a@arm.com>
 <CAHn8xc=1g8bzV-uxaJAYpJ114rR7MLzth=4jyDG329ZwEG+kpg@mail.gmail.com>
Message-ID: <c434b9b4-5a8c-a7a9-4e01-b6d8bd40b918@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2021-06-03 13:32, Jussi Maki wrote:
> On Wed, Jun 2, 2021 at 2:49 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>>> Thanks for the quick response & patch. I tried it out and indeed it
>>>> does solve the issue:
>>
>> Cool, thanks Jussi. May I infer a Tested-by tag from that?
> 
> Of course!
> 
>> Given that the race looks to have been pretty theoretical until now, I'm
>> not convinced it's worth the bother of digging through the long history
>> of default domain and DMA ops movement to figure where it started, much
>> less attempt invasive backports. The flush queue change which made it
>> apparent only landed in 5.13-rc1, so as long as we can get this in as a
>> fix in the current cycle we should be golden - in the meantime, note
>> that booting with "iommu.strict=0" should also restore the expected
>> behaviour.
>>
>> FWIW I do still plan to resend the patch "properly" soon (in all honesty
>> it wasn't even compile-tested!)
> 
> BTW, even with the patch there's quite a bit of spin lock contention
> coming from ice_xmit_xdp_ring->dma_map_page_attrs->...->alloc_iova.
> CPU load drops from 85% to 20% (~80Mpps, 64b UDP) when iommu is
> disabled. Is this type of overhead to be expected?

Yes, IOVA allocation can still be a bottleneck - the percpu caching 
system mostly alleviates it, but certain workloads can still defeat 
that, and if you're spending significant time in alloc_iova() rather 
than alloc_iova_fast() then it sounds like yours is one of them.

If you're using small IOVA sizes which *should* be cached, then you 
might be running into a pathological case of thrashing the global depot. 
I've ranted before about the fixed MAX_GLOBAL_MAGS probably being too 
small for systems with more than 16 CPUs, which on a modern AMD system I 
imagine you may well have.

If on the other hand your workload is making larger mappings above the 
IOVA caching threshold, then please take a look at John's series for 
making that tuneable:

https://lore.kernel.org/linux-iommu/1622557781-211697-1-git-send-email-john.garry at huawei.com/

Cheers,
Robin.
