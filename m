From: Robin Murphy <robin.murphy@arm.com>
Date: Wed, 2 Jun 2021 13:48:54 +0100
Subject: [Intel-wired-lan] Regression 5.12.0-rc4 net: ice: significant
 throughput drop
In-Reply-To: <7c04eeea-22d3-c265-8e1e-b3f173f2179f@iogearbox.net>
References: <CAHn8xckNXci+X_Eb2WMv4uVYjO2331UWB2JLtXr_58z0Av8+8A@mail.gmail.com>
 <cc58c09e-bbb5-354a-2030-bf8ebb2adc86@iogearbox.net>
 <7f048c57-423b-68ba-eede-7e194c1fea4e@arm.com>
 <CAHn8xckNt3smeQPi3dgq5i_3vP7KwU45pnP5OCF8nOV_QEdyMA@mail.gmail.com>
 <7c04eeea-22d3-c265-8e1e-b3f173f2179f@iogearbox.net>
Message-ID: <705f90c3-b933-8863-2124-3fea7fdbd81a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2021-06-02 09:09, Daniel Borkmann wrote:
> On 6/1/21 7:42 PM, Jussi Maki wrote:
>> Hi Robin,
>>
>> On Tue, Jun 1, 2021 at 2:39 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>>>> The regression shows as a significant drop in throughput as measured
>>>>> with "super_netperf" [0],
>>>>> with measured bandwidth of ~95Gbps before and ~35Gbps after:
>>>
>>> I guess that must be the difference between using the flush queue
>>> vs. strict invalidation. On closer inspection, it seems to me that
>>> there's a subtle pre-existing bug in the AMD IOMMU driver, in that
>>> amd_iommu_init_dma_ops() actually runs *after* amd_iommu_init_api()
>>> has called bus_set_iommu(). Does the patch below work?
>>
>> Thanks for the quick response & patch. I tried it out and indeed it
>> does solve the issue:

Cool, thanks Jussi. May I infer a Tested-by tag from that?

>> # uname -a
>> Linux zh-lab-node-3 5.13.0-rc3-amd-iommu+ #31 SMP Tue Jun 1 17:12:57
>> UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
>> root at zh-lab-node-3:~# ./super_netperf 32 -H 172.18.0.2
>> 95341.2
>>
>> root at zh-lab-node-3:~# uname -a
>> Linux zh-lab-node-3 5.13.0-rc3-amd-iommu-unpatched #32 SMP Tue Jun 1
>> 17:29:34 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
>> root at zh-lab-node-3:~# ./super_netperf 32 -H 172.18.0.2
>> 33989.5
> 
> Robin, probably goes without saying, but please make sure to include ...
> 
> Fixes: a250c23f15c2 ("iommu: remove DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE")
> 
> ... to your fix in [0], maybe along with another Fixes tag pointing to 
> the original
> commit adding this issue. But certainly a250c23f15c2 would be good given 
> the regression
> was uncovered on that one first, so that Greg et al have a chance to 
> pick this fix up
> for stable kernels.

Given that the race looks to have been pretty theoretical until now, I'm 
not convinced it's worth the bother of digging through the long history 
of default domain and DMA ops movement to figure where it started, much 
less attempt invasive backports. The flush queue change which made it 
apparent only landed in 5.13-rc1, so as long as we can get this in as a 
fix in the current cycle we should be golden - in the meantime, note 
that booting with "iommu.strict=0" should also restore the expected 
behaviour.

FWIW I do still plan to resend the patch "properly" soon (in all honesty 
it wasn't even compile-tested!)

Cheers,
Robin.
