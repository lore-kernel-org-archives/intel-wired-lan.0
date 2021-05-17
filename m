From: Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 17 May 2021 21:43:54 +0200
Subject: [Intel-wired-lan] [PATCH tip:irq/core v1] genirq: remove
 auto-set of the mask when setting the hint
In-Reply-To: <874kf1faac.ffs@nanos.tec.linutronix.de>
References: <20210501021832.743094-1-jesse.brandeburg@intel.com>
 <16d8ca67-30c6-bb4b-8946-79de8629156e@arm.com>
 <20210504092340.00006c61@intel.com>
 <CAFki+LmR-o+Fng21ggy48FUX7RhjjpjO87dn3Ld+L4BK2pSRZg@mail.gmail.com>
 <bf1d4892-0639-0bbf-443e-ba284a8ed457@arm.com>
 <87sg2lz0zz.ffs@nanos.tec.linutronix.de>
 <d1d5e797-49ee-4968-88c6-c07119343492@arm.com>
 <874kf1faac.ffs@nanos.tec.linutronix.de>
Message-ID: <871ra5f8n9.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, May 17 2021 at 21:08, Thomas Gleixner wrote:
> On Mon, May 17 2021 at 19:50, Robin Murphy wrote:
>> some of the callers in other subsystems appear to *expect* it to set
>> the underlying affinity as well, but whether any of those added within
>> the last 6 years represent a functional dependency rather than just a
>> performance concern I don't know.
>
> Sigh. Let me do yet another tree wide audit...

It's clearly only the perf muck which has a functional dependency.

None of the other usage sites has IRQF_NOBALANCING set which clearly
makes this a hint because user space can freely muck with the affinity.

Thanks,

        tglx



