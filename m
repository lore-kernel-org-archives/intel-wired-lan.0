From: Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 17 May 2021 20:08:48 +0200
Subject: [Intel-wired-lan] [PATCH tip:irq/core v1] genirq: remove
 auto-set of the mask when setting the hint
In-Reply-To: <bf1d4892-0639-0bbf-443e-ba284a8ed457@arm.com>
References: <20210501021832.743094-1-jesse.brandeburg@intel.com>
 <16d8ca67-30c6-bb4b-8946-79de8629156e@arm.com>
 <20210504092340.00006c61@intel.com>
 <CAFki+LmR-o+Fng21ggy48FUX7RhjjpjO87dn3Ld+L4BK2pSRZg@mail.gmail.com>
 <bf1d4892-0639-0bbf-443e-ba284a8ed457@arm.com>
Message-ID: <87sg2lz0zz.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, May 17 2021 at 18:26, Robin Murphy wrote:
> On 2021-05-17 17:57, Nitesh Lal wrote:
> I'm not implying that there isn't a bug, or that this code ever made 
> sense in the first place, just that fixing it will unfortunately be a 
> bit more involved than a simple revert. This patch as-is *will* subtly 
> break at least the system PMU drivers currently using

s/using/abusing/

> irq_set_affinity_hint() - those I know require the IRQ affinity to 
> follow whichever CPU the PMU context is bound to, in order to meet perf 
> core's assumptions about mutual exclusion.

Which driver is that?

Thanks,

        tglx
