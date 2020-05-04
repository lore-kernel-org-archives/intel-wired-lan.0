From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 4 May 2020 14:14:34 -0700
Subject: [Intel-wired-lan] Does the 'igb` kernel module support setting
 2-Tuple filters (aka `--config-ntuple`) on a i210 NIC?
In-Reply-To: <CAGrNP8=qr3_ZPL7c4oWz0L6hzLSSHjh3iWa52VsUTmJjfUqxdw@mail.gmail.com>
References: <CAGrNP8nfqAZnEoOBsrxrsvszw7T5pdKHG4mt6fVcKB6iigV_BA@mail.gmail.com>
 <87zhaswn5t.fsf@intel.com>
 <CAGrNP8=qr3_ZPL7c4oWz0L6hzLSSHjh3iWa52VsUTmJjfUqxdw@mail.gmail.com>
Message-ID: <CAKgT0UfJ9gOhu=N1rCFa1u-3GhAoFjY=-N09-P=w1MYd0O05_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, May 4, 2020 at 6:58 AM Dan Williams <dwilliams@nextdroid.com> wrote:

> > We have a computer logging a high rate of ethernet packets ( 25k
>>> > packets/sec ~70 Mb/sec);   But we're having trouble convincing the
>>> hardware
>>> > to receive all of these packets, at a sustained rate -- specifically
>>> we're
>>> > dropping packets while processing through the kernel layers.    We're
>>> > currently attempting to optimize the network stack,  but we're having
>>> > trouble setting the driver parameters... which is what this message is
>>> all
>>> > about.
>>>
>>
>> That's weird. That packet rate is not *that* high, the Linux kernel
>> should be able to handle that fine.
>
>
>> Can you give more details of the workload you are running?
>>
>
> Okay, in more detail: we have two groups of incoming streams:  (for the
> minimum setup to cause a problem)
> - 4x Camera Streams  each transmits a 3.2mb image every .1 s, split into
> jumbo frames (mtu is set to the full 9000)
> - Constant stream of data from a Lidar at 18k packets / sec.  Each packet
> is 1206 bytes long.
> - Both streams continue steady-state, indefinitely (we have verified
> behavior out to 4 hours so far)
>

So you mentioned before that your rate was ~70mb/s or so. As far as the
streams is anything changing in terms of the sources or are the streams
coming from the same source throughout the run? I ask because if the
source/destination ports and IP addresses are not changing then the hash
will not change so the work on the queues should be constant as well.


> We receive all of these over ethernet, and routed to a single network port
> on a single NIC.   The driver is the 'igb' kernel module, as supplied from
> ubuntu.
> The OS is Ubuntu 16.04 LTS with a 4.15.0-88-lowlatency kernel.
>
> ----
> Biggest Problem:
>
> Over time decay of packet processing.
>
> We've been working on this for a couple of weeks; when the processes start
> we're logging the full data rate (~24kpps) but over time, something slows
> down, and our logging rate shrinks.
> (on the order of 20 packets / second / minute, consistently falling over
> hours. ... after the first hour, we've lost 500 pps, after the second hour,
> 1kpps... etc.)
>

It might be useful to provide "ethtool -S <iface>" output for the interface
at the start, then one hour in, and then two hours in. That would allow us
to check and see if there are any other indicators that are changing over
time such as flow control frames.


> Our user-land process simply isn't seeing the full count of packets -- we
> have debug code that reads it from the OS, and then immediately drops the
> buffer on the floor.  Generally, we see drops in netstat, but not in the
> driver. (i.e. from `ethtool -S | grep rx_*`)
> So, our tentative guess is that we want to tune some parameters, somewhere
> in the kernel or network driver to help out the kernel.    Ideas welcome,
> of course :)
>

The fact that you are seeing drops in the netstat would imply that your
application isn't able to keep up with the data rates being provided by the
network. Some of that can be addressed by trying to smooth out the
burstiness of the traffic by increasing the interrupt rate as I describe
below.


> ( We are *also* dropping from the ring buffer, when both the lidar stream
> and a camera stream are assigned to the same queue, but that looks like a
> releated but separate issue)
>

So in terms of the ring buffer there are essentially two knobs you have to
control some of that. The first is the size of the ring buffer, controlled
via "ethtool -G <iface> rx <ring size>", the default is 256, you may want
to try increasing it to 512 and see if that helps. The other item you could
look at adjusting is the interrupt moderation, that is controlled by
"ethtool -C <iface> rx-usecs <irq delay>". For your workload something like
an IRQ delay of 50usec might make sense. That should limit the interrupts
to about 20K per second which should mean that you only have one or two
frames in the ring per interrupt, assuming the queue doesn't get stuck in
NAPI polling mode.


> Things we've tried / checked:
> - irq alignment -- they're already reasonable set
> - cpu assignment (via `taskset`)
> - change processor task scheduling / priority (no effect)
>
> Ideas:
> - what is the default hash algorithm?  if we can't change it, maybe we can
> work around it?
>

It is a Toeplitz hash, and there is not a way to change that.


> - is there any other way to set the queue settings on this network card?
> Debug tool?  Rebuilding the kernel module with custom settings?
>

On the network card itself there isn't an option there. One option you
could look at would be receive packet steering, or receive flow steering.
You can find more information on those here:
https://www.kernel.org/doc/html/v5.1/networking/scaling.html



> - Our hardware also has an 82579 NIC as well -- would you guys recommend
> we use that NIC, instead?
>

The 82579 would likely have fewer options than the i210 you are currently
using. In addition it would support fewer queues.


> - Do other network cards / chipsets have better support under linux?
> Particularly when tuning input queues?
>

In the 1Gb space there usually isn't much out there for tuning individual
queues. Normally high queue counts aren't that common on 1Gb devices so it
doesn't make much sense to usually optimize for that.

In the 10Gb space the drivers tend to have many more options when it comes
to queue specific tuning, but I don't know if you would want to head in
that direction.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200504/6ba1d33b/attachment-0001.html>
