From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 27 Oct 2020 15:43:56 +0100
Subject: [Intel-wired-lan] [PATCH v4 4/4] PCI: Limit
 pci_alloc_irq_vectors() to housekeeping CPUs
In-Reply-To: <20201027114739.GA11336@fuller.cnet>
References: <20201023085826.GP2611@hirez.programming.kicks-ass.net>
 <9ee77056-ef02-8696-5b96-46007e35ab00@redhat.com>
 <87ft6464jf.fsf@nanos.tec.linutronix.de>
 <20201026173012.GA377978@fuller.cnet>
 <875z6w4xt4.fsf@nanos.tec.linutronix.de>
 <86f8f667-bda6-59c4-91b7-6ba2ef55e3db@intel.com>
 <87v9ew3fzd.fsf@nanos.tec.linutronix.de>
 <85b5f53e-5be2-beea-269a-f70029bea298@intel.com>
 <87lffs3bd6.fsf@nanos.tec.linutronix.de>
 <959997ee-f393-bab0-45c0-4144c37b9185@redhat.com>
 <20201027114739.GA11336@fuller.cnet>
Message-ID: <87k0vb20gj.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Oct 27 2020 at 08:47, Marcelo Tosatti wrote:
> On Mon, Oct 26, 2020 at 06:22:29PM -0400, Nitesh Narayan Lal wrote:
> However, if per-CPU interrupts are not disabled, then the (for example)
> network device is free to include the CPU in its list of destinations.
> Which would require one to say, configure RPS (or whatever mechanism
> is distributing interrupts).

And why is that a problem? If that's possible then you can prevent
getting RX interrupts already today.

> Hum, it would feel safer (rather than trust the #1 rule to be valid
> in all cases) to ask the driver to disable the interrupt (after shutting
> down queue) for that particular CPU.
>
> BTW, Thomas, software is free to configure a particular MSI-X interrupt
> to point to any CPU:
>
> 10.11 MESSAGE SIGNALLED INTERRUPTS

I know how MSI works :)

> So taking the example where computation happens while isolated and later
> stored via block interface, aren't we restricting the usage scenarios
> by enforcing the "per-CPU queue has interrupt pointing to owner CPU"
> rule?

No. For block this is the ideal configuration (think locality) and it
prevents vector exhaustion. If you make these interrupts freely routable
then you bring back the vector exhaustion problem right away.

Now we already established that networking has different requirements,
so you have to come up with a different solution for it which allows to
work for all use cases.

Thanks,

        tglx

