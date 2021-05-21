From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 21 May 2021 13:56:10 +0200
Subject: [Intel-wired-lan] [PATCH tip:irq/core v1] genirq: remove
 auto-set of the mask when setting the hint
In-Reply-To: <CAFki+LkB1sk3mOv4dd1D-SoPWHOs28ZwN-PqL_6xBk=Qkm40Lw@mail.gmail.com>
References: <20210504092340.00006c61@intel.com>
 <87pmxpdr32.ffs@nanos.tec.linutronix.de>
 <CAFki+Lkjn2VCBcLSAfQZ2PEkx-TR0Ts_jPnK9b-5ne3PUX37TQ@mail.gmail.com>
 <87im3gewlu.ffs@nanos.tec.linutronix.de>
 <CAFki+L=gp10W1ygv7zdsee=BUGpx9yPAckKr7pyo=tkFJPciEg@mail.gmail.com>
 <CAFki+L=eQoMq+mWhw_jVT-biyuDXpxbXY5nO+F6HvCtpbG9V2w@mail.gmail.com>
 <CAFki+LkB1sk3mOv4dd1D-SoPWHOs28ZwN-PqL_6xBk=Qkm40Lw@mail.gmail.com>
Message-ID: <87zgwo9u79.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Nitesh,

On Thu, May 20 2021 at 20:03, Nitesh Lal wrote:
> On Thu, May 20, 2021 at 5:57 PM Nitesh Lal <nilal@redhat.com> wrote:
>> I think here to ensure that we are not breaking any of the drivers we have
>> to first analyze all the existing drivers and understand how they are using
>> this API.
>> AFAIK there are three possible scenarios:
>>
>> - A driver use this API to spread the IRQs
>>   + For this case we should be safe considering the spreading is naturally
>>     done from the IRQ subsystem itself.
>
> Forgot to mention another thing in the above case is to determine whether
> it is true for all architectures or not as Thomas mentioned.

Yes.

>>
>> - A driver use this API to actually set the hint
>>   + These drivers should have no functional impact because of this revert

Correct.


>> - Driver use this API to force a certain affinity mask
>>   + In this case we have to replace the API with the irq_force_affinity()

irq_set_affinity() or irq_set_affinity_and_hint()

>> I can start looking into the individual drivers, however, testing them will
>> be a challenge.

The only way to do that is to have the core infrastructure added and
then send patches changing it in the way you think. The relevant
maintainers/developers should be able to tell you when your analysis
went south. :)

Been there, done that. It's just lots of work :)

Thanks,

        tglx
