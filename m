From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 21 May 2021 23:48:43 +0200
Subject: [Intel-wired-lan] [PATCH] genirq: Provide new interfaces for
 affinity hints
In-Reply-To: <CAFki+LkqBHnVYB5VBx_8Ch0u8RfXrJsRzxyuDfHhbR-dCeN3Lg@mail.gmail.com>
References: <20210504092340.00006c61@intel.com>
 <87pmxpdr32.ffs@nanos.tec.linutronix.de>
 <CAFki+Lkjn2VCBcLSAfQZ2PEkx-TR0Ts_jPnK9b-5ne3PUX37TQ@mail.gmail.com>
 <87im3gewlu.ffs@nanos.tec.linutronix.de>
 <CAFki+L=gp10W1ygv7zdsee=BUGpx9yPAckKr7pyo=tkFJPciEg@mail.gmail.com>
 <CAFki+L=eQoMq+mWhw_jVT-biyuDXpxbXY5nO+F6HvCtpbG9V2w@mail.gmail.com>
 <CAFki+LkB1sk3mOv4dd1D-SoPWHOs28ZwN-PqL_6xBk=Qkm40Lw@mail.gmail.com>
 <87zgwo9u79.ffs@nanos.tec.linutronix.de>
 <87wnrs9tvp.ffs@nanos.tec.linutronix.de>
 <CAFki+LkqBHnVYB5VBx_8Ch0u8RfXrJsRzxyuDfHhbR-dCeN3Lg@mail.gmail.com>
Message-ID: <87bl93ahc4.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, May 21 2021 at 12:13, Nitesh Lal wrote:
> On Fri, May 21, 2021 at 8:03 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>> Provide new interfaces:
>>
>>   irq_update_affinity_hint() - Only sets the affinity hint pointer
>>   irq_apply_affinity_hint()  - Set the pointer and apply the affinity to
>>                                the interrupt
>>
>
> Any reason why you ruled out the usage of irq_set_affinity_and_hint()?
> IMHO the latter makes it very clear what the function is meant to do.

You're right. I was trying to phase the existing hint setter out, but
that's probably pointless overengineering for no real value. Let me redo
that.

Thanks,

        tglx
