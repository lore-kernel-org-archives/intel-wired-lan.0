From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 31 Oct 2017 09:05:16 -0700
Subject: [Intel-wired-lan] Cable pull behaviour on Intel I350 card
In-Reply-To: <CACmWKmKsyKc13JoszThZREcCbJK46eRrAd8mJ0+4TL-dYg_e5g@mail.gmail.com>
References: <CACmWKmKsyKc13JoszThZREcCbJK46eRrAd8mJ0+4TL-dYg_e5g@mail.gmail.com>
Message-ID: <CAKgT0UegUOPhD1h_d6YtrxPaPBdbBHF058exQXuS8AE1YSD-qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Oct 31, 2017 at 6:22 AM, Matheus Almeida <hm.matheus@gmail.com> wrote:
> Hi,
>
> I'm developing an appliance for the broadcast industry for real-time video
> transmission.
> We use Intel I350 network adapters (4 ports) and am seeking more information
> about a behaviour that causes a transmission disruption (~20ms to 80ms) when
> one of the ethernet cables is pulled.
>
> Assuming that data port 0 and data port 1 are both transmitting data.
> Disconnecting the ethernet cable from data port 1 seems to stop the
> transmission of data port 0 for a short period of time. This is a big issue
> for low-latency appliances like ours (I'll get into more in a second).
>
> More information about our system:
>
> We use buildroot with Linux Kernel 4.9.29
> igb driver version 5.4.0-k
> 8 rx queues, 8 tx queues
>
> The level of traffic flowing through the network seems to make the issue
> more reproducible.
>
> Is this behaviour expected ? If positive, is there a way around it ?

I wouldn't say this is expected, but then again, I don't know the
exact cause for what you may be seeing. To narrow it down we could use
some more information.

In your setup are you running anything like a team or bond on top of
the igb driver interfaces? Also how many CPUs are you running on the
system the device is installed in?

> I ran ftrace to get a better picture of what happens during that period of
> no transmission[1] and all I see [using the sched_switch option] is a
> continuous execution of a kernel worker thread on that CPU.
>
> I tried to make the following changes to our system with no improvements:

Would it be possible to provide a trace for that worker thread? I
would be interested in seeing if the worker thread happens to have
igb_watchdog_task in the path or not. My thought is that we are likely
spending time busy waiting in one of the PHY register functions due to
the link status changing so we are probably either re-reading the link
or resetting the port if there was Tx traffic pending. We would need
to sort out which of these events is taking place.

> Changed task priority to RT (this should preempt the kernel worker threads
> and give more ) for our transmitter task
> Changed the cpu_mask for the kernel worker threads so that they would
> execute on a spare CPU core
> Compiled the kernel with PREEMPT=1

One thing you might try just to eliminate hardware as being a possible
issue would be to use a second NIC and just use one port on each
device to verify we aren't looking at any sort of issue where we are
doing something like resetting one port and somehow introducing a
delay through that.

> I have also tried to get ftrace to generate call stacks to get an even
> better understand of what's happening behind the scenes. Unfortunately this
> seems to generate too much overhead and I haven't been able to get a clean
> execution trace that highlights everything that happens during a cable pull.
>
> Is there a better way to debug this issue ? I have total control of the
> kernel that we build so I can build the igb driver differently if it allows
> us to get to the bottom of this issue.

If nothing else you might look at using trace_printk to just manually
add printouts as needed through the driver. That is usually my default
when I really need to get in and check various points in the kernel.

Other than that I would say the main thing we need to look at is
finding the source of our stalls. You might look at testing the start
and exit of igb_watchdog_task and see if that is taking the 20-80usecs
you are seeing being consumed when you hit this event.

- Alex
