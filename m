From: Robin Murphy <robin.murphy@arm.com>
Date: Mon, 17 May 2021 19:50:35 +0100
Subject: [Intel-wired-lan] [PATCH tip:irq/core v1] genirq: remove
 auto-set of the mask when setting the hint
In-Reply-To: <87sg2lz0zz.ffs@nanos.tec.linutronix.de>
References: <20210501021832.743094-1-jesse.brandeburg@intel.com>
 <16d8ca67-30c6-bb4b-8946-79de8629156e@arm.com>
 <20210504092340.00006c61@intel.com>
 <CAFki+LmR-o+Fng21ggy48FUX7RhjjpjO87dn3Ld+L4BK2pSRZg@mail.gmail.com>
 <bf1d4892-0639-0bbf-443e-ba284a8ed457@arm.com>
 <87sg2lz0zz.ffs@nanos.tec.linutronix.de>
Message-ID: <d1d5e797-49ee-4968-88c6-c07119343492@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2021-05-17 19:08, Thomas Gleixner wrote:
> On Mon, May 17 2021 at 18:26, Robin Murphy wrote:
>> On 2021-05-17 17:57, Nitesh Lal wrote:
>> I'm not implying that there isn't a bug, or that this code ever made
>> sense in the first place, just that fixing it will unfortunately be a
>> bit more involved than a simple revert. This patch as-is *will* subtly
>> break at least the system PMU drivers currently using
> 
> s/using/abusing/
> 
>> irq_set_affinity_hint() - those I know require the IRQ affinity to
>> follow whichever CPU the PMU context is bound to, in order to meet perf
>> core's assumptions about mutual exclusion.
> 
> Which driver is that?

Right now, any driver which wants to control an IRQ's affinity and also 
build as a module, for one thing. I'm familiar with drivers/perf/ where 
a basic pattern has been widely copied; some of the callers in other 
subsystems appear to *expect* it to set the underlying affinity as well, 
but whether any of those added within the last 6 years represent a 
functional dependency rather than just a performance concern I don't know.

Robin.
