From: Nitesh Lal <nilal@redhat.com>
Date: Tue, 4 May 2021 10:29:09 -0400
Subject: [Intel-wired-lan] [PATCH tip:irq/core v1] genirq: remove
 auto-set of the mask when setting the hint
In-Reply-To: <16d8ca67-30c6-bb4b-8946-79de8629156e@arm.com>
References: <20210501021832.743094-1-jesse.brandeburg@intel.com>
 <16d8ca67-30c6-bb4b-8946-79de8629156e@arm.com>
Message-ID: <CAFki+L=D8aS_jub0KHAkfsnvvJ_w8_mMYbaHeZ-GkQF1s_0WDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, May 4, 2021 at 8:15 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-05-01 03:18, Jesse Brandeburg wrote:
> > It was pointed out by Nitesh that the original work I did in 2014
> > to automatically set the interrupt affinity when requesting a
> > mask is no longer necessary. The kernel has moved on and no
> > longer has the original problem, BUT the original patch
> > introduced a subtle bug when booting a system with reserved or
> > excluded CPUs. Drivers calling this function with a mask value
> > that included a CPU that was currently or in the future
> > unavailable would generally not update the hint.
> >
> > I'm sure there are a million ways to solve this, but the simplest
> > one is to just remove a little code that tries to force the
> > affinity, as Nitesh has shown it fixes the bug and doesn't seem
> > to introduce immediate side effects.
>
> Unfortunately, I think there are quite a few other drivers now relying
> on this behaviour, since they are really using irq_set_affinity_hint()
> as a proxy for irq_set_affinity().

That's true.

> Partly since the latter isn't
> exported to modules, but also I have a vague memory of it being said
> that it's nice to update the user-visible hint to match when the
> affinity does have to be forced to something specific.

If you see the downside of it we are forcing the affinity to match the hint
mask without considering the default SMP affinity mask.

Also, we are repeating things here. First, we set certain mask for a device
IRQ via request_irq code path which does consider the default SMP mask but
then we are letting the driver over-write it.

If we want to set the IRQ mask in a certain way then it should be done at
the time of initial setup itself.

Do you know about a workload/use case that can show the benefit of
this behavior? As then we can try fixing it in the right way.

--
Thanks
Nitesh

