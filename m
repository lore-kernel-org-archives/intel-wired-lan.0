From: Daniel Borkmann <daniel@iogearbox.net>
Date: Wed, 2 Jun 2021 10:09:28 +0200
Subject: [Intel-wired-lan] Regression 5.12.0-rc4 net: ice: significant
 throughput drop
In-Reply-To: <CAHn8xckNt3smeQPi3dgq5i_3vP7KwU45pnP5OCF8nOV_QEdyMA@mail.gmail.com>
References: <CAHn8xckNXci+X_Eb2WMv4uVYjO2331UWB2JLtXr_58z0Av8+8A@mail.gmail.com>
 <cc58c09e-bbb5-354a-2030-bf8ebb2adc86@iogearbox.net>
 <7f048c57-423b-68ba-eede-7e194c1fea4e@arm.com>
 <CAHn8xckNt3smeQPi3dgq5i_3vP7KwU45pnP5OCF8nOV_QEdyMA@mail.gmail.com>
Message-ID: <7c04eeea-22d3-c265-8e1e-b3f173f2179f@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 6/1/21 7:42 PM, Jussi Maki wrote:
> Hi Robin,
> 
> On Tue, Jun 1, 2021 at 2:39 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>>> The regression shows as a significant drop in throughput as measured
>>>> with "super_netperf" [0],
>>>> with measured bandwidth of ~95Gbps before and ~35Gbps after:
>>
>> I guess that must be the difference between using the flush queue
>> vs. strict invalidation. On closer inspection, it seems to me that
>> there's a subtle pre-existing bug in the AMD IOMMU driver, in that
>> amd_iommu_init_dma_ops() actually runs *after* amd_iommu_init_api()
>> has called bus_set_iommu(). Does the patch below work?
> 
> Thanks for the quick response & patch. I tried it out and indeed it
> does solve the issue:
> 
> # uname -a
> Linux zh-lab-node-3 5.13.0-rc3-amd-iommu+ #31 SMP Tue Jun 1 17:12:57
> UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
> root at zh-lab-node-3:~# ./super_netperf 32 -H 172.18.0.2
> 95341.2
> 
> root at zh-lab-node-3:~# uname -a
> Linux zh-lab-node-3 5.13.0-rc3-amd-iommu-unpatched #32 SMP Tue Jun 1
> 17:29:34 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
> root at zh-lab-node-3:~# ./super_netperf 32 -H 172.18.0.2
> 33989.5

Robin, probably goes without saying, but please make sure to include ...

Fixes: a250c23f15c2 ("iommu: remove DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE")

... to your fix in [0], maybe along with another Fixes tag pointing to the original
commit adding this issue. But certainly a250c23f15c2 would be good given the regression
was uncovered on that one first, so that Greg et al have a chance to pick this fix up
for stable kernels.

Thanks everyone!

   [0] https://lore.kernel.org/bpf/7f048c57-423b-68ba-eede-7e194c1fea4e at arm.com/
