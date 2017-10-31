From: Matheus Almeida <hm.matheus@gmail.com>
Date: Tue, 31 Oct 2017 13:22:55 +0000
Subject: [Intel-wired-lan] Cable pull behaviour on Intel I350 card
Message-ID: <CACmWKmKsyKc13JoszThZREcCbJK46eRrAd8mJ0+4TL-dYg_e5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

I'm developing an appliance for the broadcast industry for real-time video
transmission.
We use Intel I350 network adapters (4 ports) and am seeking more
information about a behaviour that causes a transmission disruption (~20ms
to 80ms) when one of the ethernet cables is pulled.

Assuming that data port 0 and data port 1 are both transmitting data.
Disconnecting the ethernet cable from data port 1 seems to stop the
transmission of data port 0 for a short period of time. This is a big issue
for low-latency appliances like ours (I'll get into more in a second).

More information about our system:

   1. We use buildroot with Linux Kernel 4.9.29
   2. igb driver version 5.4.0-k
   3. 8 rx queues, 8 tx queues

The level of traffic flowing through the network seems to make the issue
more reproducible.

Is this behaviour expected ? If positive, is there a way around it ?

I ran ftrace to get a better picture of what happens during that period of
no transmission[1] and all I see [using the sched_switch option] is a
continuous execution of a kernel worker thread on that CPU.

I tried to make the following changes to our system with no improvements:

   1. Changed task priority to RT (this should preempt the kernel worker
   threads and give more ) for our transmitter task
   2. Changed the cpu_mask for the kernel worker threads so that they would
   execute on a spare CPU core
   3. Compiled the kernel with PREEMPT=1

I have also tried to get ftrace to generate call stacks to get an even
better understand of what's happening behind the scenes. Unfortunately this
seems to generate too much overhead and I haven't been able to get a clean
execution trace that highlights everything that happens during a cable pull.

Is there a better way to debug this issue ? I have total control of the
kernel that we build so I can build the igb driver differently if it allows
us to get to the bottom of this issue.

[1] Immediately after a cable pull

Thanks in advance,
Matheus
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20171031/7614fea7/attachment.html>
