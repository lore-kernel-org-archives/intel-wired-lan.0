From: Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 17 May 2021 21:47:12 +0200
Subject: [Intel-wired-lan] [PATCH tip:irq/core v1] genirq: remove
 auto-set of the mask when setting the hint
In-Reply-To: <CAFki+L=LDizBJmFUieMDg9J=U6mn6XxTPPkAaWiyppTouTzaqw@mail.gmail.com>
References: <20210501021832.743094-1-jesse.brandeburg@intel.com>
 <16d8ca67-30c6-bb4b-8946-79de8629156e@arm.com>
 <20210504092340.00006c61@intel.com>
 <CAFki+LmR-o+Fng21ggy48FUX7RhjjpjO87dn3Ld+L4BK2pSRZg@mail.gmail.com>
 <bf1d4892-0639-0bbf-443e-ba284a8ed457@arm.com>
 <CAFki+L=LDizBJmFUieMDg9J=U6mn6XxTPPkAaWiyppTouTzaqw@mail.gmail.com>
Message-ID: <87y2cddtxb.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Nitesh,

On Mon, May 17 2021 at 14:21, Nitesh Lal wrote:
> On Mon, May 17, 2021 at 1:26 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> We can use irq_set_affinity() to set the hint mask as well, however, maybe
> there is a specific reason behind separating those two in the
> first place (maybe not?).

Yes, because kernel side settings might overwrite the hint.

> But even in this case, we have to either modify the PMU drivers' IRQs
> affinity from the userspace or we will have to make changes in the existing
> request_irq code path.

Adjusting them from user space does not work for various reasons,
especially CPU hotplug.

> I am not sure about the latter because we already have the required controls
> to adjust the device IRQ mask (by using default_smp_affinity or by modifying
> them manually).

default_smp_affinity does not help at all and there is nothing a module
can modify manually.

I'll send out a patch series which cleans that up soon.

Thanks,

        tglx


