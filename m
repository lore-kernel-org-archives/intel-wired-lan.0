From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 21 May 2021 17:15:53 +0200
Subject: [Intel-wired-lan] [PATCH tip:irq/core v1] genirq: remove
 auto-set of the mask when setting the hint
In-Reply-To: <CAFki+LnKycMFYTGTswX9vpMepNiCW6BL5TFMTuKZSniab5=4SA@mail.gmail.com>
References: <20210504092340.00006c61@intel.com>
 <87pmxpdr32.ffs@nanos.tec.linutronix.de>
 <CAFki+Lkjn2VCBcLSAfQZ2PEkx-TR0Ts_jPnK9b-5ne3PUX37TQ@mail.gmail.com>
 <87im3gewlu.ffs@nanos.tec.linutronix.de>
 <CAFki+L=gp10W1ygv7zdsee=BUGpx9yPAckKr7pyo=tkFJPciEg@mail.gmail.com>
 <CAFki+L=eQoMq+mWhw_jVT-biyuDXpxbXY5nO+F6HvCtpbG9V2w@mail.gmail.com>
 <CAFki+LkB1sk3mOv4dd1D-SoPWHOs28ZwN-PqL_6xBk=Qkm40Lw@mail.gmail.com>
 <87zgwo9u79.ffs@nanos.tec.linutronix.de>
 <CAFki+LnKycMFYTGTswX9vpMepNiCW6BL5TFMTuKZSniab5=4SA@mail.gmail.com>
Message-ID: <87pmxk9kye.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, May 21 2021 at 09:46, Nitesh Lal wrote:
> On Fri, May 21, 2021 at 7:56 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>> >> - Driver use this API to force a certain affinity mask
>> >>   + In this case we have to replace the API with the irq_force_affinity()
>>
>> irq_set_affinity() or irq_set_affinity_and_hint()
>
> Ah yes! my bad. _force_ doesn't check the mask against the online CPUs.
> Hmm, I didn't realize that you also added irq_set_affinity_and_hint()
> in your last patchset.

I did not. It just exposed irq_set_affinity().

See https://lore.kernel.org/r/87wnrs9tvp.ffs at nanos.tec.linutronix.de
for the new hint interface I came up with.

Thanks,

        tglx
