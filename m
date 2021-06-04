From: Nitesh Lal <nilal@redhat.com>
Date: Fri, 4 Jun 2021 16:35:45 -0400
Subject: [Intel-wired-lan] [PATCH] genirq: Provide new interfaces for
 affinity hints
In-Reply-To: <87bl93ahc4.ffs@nanos.tec.linutronix.de>
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
 <87bl93ahc4.ffs@nanos.tec.linutronix.de>
Message-ID: <CAFki+LmW1d1f-mdFq8ovGERDRMkM7o=urmmQZi9cwXoR+Ydm=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, May 21, 2021 at 5:48 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Fri, May 21 2021 at 12:13, Nitesh Lal wrote:
> > On Fri, May 21, 2021 at 8:03 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >> Provide new interfaces:
> >>
> >>   irq_update_affinity_hint() - Only sets the affinity hint pointer
> >>   irq_apply_affinity_hint()  - Set the pointer and apply the affinity to
> >>                                the interrupt
> >>
> >
> > Any reason why you ruled out the usage of irq_set_affinity_and_hint()?
> > IMHO the latter makes it very clear what the function is meant to do.
>
> You're right. I was trying to phase the existing hint setter out, but
> that's probably pointless overengineering for no real value. Let me redo
> that.
>

Thomas, are you planning to send a v2 for this soon or did I somehow miss
it?

Since your other patch "genirq: Export affinity setter for modules" is
already in linux-next, I have started looking into the drivers where
we can use that.

On thinking about this whole chunk a little more, I do wonder about the
reason why we are still sticking with the hints.

The two reasons that I could come up with are:
- We are not entirely sure if irqbalance still consumes this or not
- For future use by some other userspace daemon  (?)

Does that sound right?

-- 
Thanks
Nitesh

