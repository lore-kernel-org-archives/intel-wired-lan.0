From: Robin Murphy <robin.murphy@arm.com>
Date: Mon, 17 May 2021 18:26:17 +0100
Subject: [Intel-wired-lan] [PATCH tip:irq/core v1] genirq: remove
 auto-set of the mask when setting the hint
In-Reply-To: <CAFki+LmR-o+Fng21ggy48FUX7RhjjpjO87dn3Ld+L4BK2pSRZg@mail.gmail.com>
References: <20210501021832.743094-1-jesse.brandeburg@intel.com>
 <16d8ca67-30c6-bb4b-8946-79de8629156e@arm.com>
 <20210504092340.00006c61@intel.com>
 <CAFki+LmR-o+Fng21ggy48FUX7RhjjpjO87dn3Ld+L4BK2pSRZg@mail.gmail.com>
Message-ID: <bf1d4892-0639-0bbf-443e-ba284a8ed457@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2021-05-17 17:57, Nitesh Lal wrote:
> On Tue, May 4, 2021 at 12:25 PM Jesse Brandeburg
> <jesse.brandeburg@intel.com> wrote:
>>
>> Robin Murphy wrote:
>>
>>> On 2021-05-01 03:18, Jesse Brandeburg wrote:
>>>> It was pointed out by Nitesh that the original work I did in 2014
>>>> to automatically set the interrupt affinity when requesting a
>>>> mask is no longer necessary. The kernel has moved on and no
>>>> longer has the original problem, BUT the original patch
>>>> introduced a subtle bug when booting a system with reserved or
>>>> excluded CPUs. Drivers calling this function with a mask value
>>>> that included a CPU that was currently or in the future
>>>> unavailable would generally not update the hint.
>>>>
>>>> I'm sure there are a million ways to solve this, but the simplest
>>>> one is to just remove a little code that tries to force the
>>>> affinity, as Nitesh has shown it fixes the bug and doesn't seem
>>>> to introduce immediate side effects.
>>>
>>> Unfortunately, I think there are quite a few other drivers now relying
>>> on this behaviour, since they are really using irq_set_affinity_hint()
>>> as a proxy for irq_set_affinity(). Partly since the latter isn't
>>> exported to modules, but also I have a vague memory of it being said
>>> that it's nice to update the user-visible hint to match when the
>>> affinity does have to be forced to something specific.
>>>
>>> Robin.
>>
>> Thanks for your feedback Robin, but there is definitely a bug here that
>> is being exposed by this code. The fact that people are using this
>> function means they're all exposed to this bug.
>>
>> Not sure if you saw, but this analysis from Nitesh explains what
>> happened chronologically to the kernel w.r.t this code, it's a useful
>> analysis! [1]
>>
>> I'd add in addition that irqbalance daemon *stopped* paying attention
>> to hints quite a while ago, so I'm not quite sure what purpose they
>> serve.
>>
>> [1]
>> https://lore.kernel.org/lkml/CAFki+Lm0W_brLu31epqD3gAV+WNKOJfVDfX2M8ZM__aj3nv9uA at mail.gmail.com/
>>
> 
> Wanted to follow up to see if there are any more objections or even
> suggestions to take this forward?

Oops, sorry, seems I got distracted before getting round to actually 
typing up my response :)

I'm not implying that there isn't a bug, or that this code ever made 
sense in the first place, just that fixing it will unfortunately be a 
bit more involved than a simple revert. This patch as-is *will* subtly 
break at least the system PMU drivers currently using 
irq_set_affinity_hint() - those I know require the IRQ affinity to 
follow whichever CPU the PMU context is bound to, in order to meet perf 
core's assumptions about mutual exclusion.

As far as the consistency argument goes, maybe that's just backwards and 
it should be irq_set_affinity() that also sets the hint, to indicate to 
userspace that the affinity has been forced by the kernel? Either way 
we'll need to do a little more diligence to figure out which callers 
actually care about more than just the hint, and sort them out first.

Robin.
