From: Levi Pearson <levi.pearson@harman.com>
Date: Tue, 23 Jan 2018 18:43:22 -0700
Subject: [Intel-wired-lan] [RFC v2 net-next 00/10] Time based packet
 transmission
In-Reply-To: <20180117230621.26074-1-jesus.sanchez-palencia@intel.com>
References: <20180117230621.26074-1-jesus.sanchez-palencia@intel.com>
Message-ID: <CAEYbN3TNnp1SqwdgA+jF4FjFngTG-7u2ZaRa1G06bikGdH5XmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Jan 17, 2018 at 4:06 PM, Jesus Sanchez-Palencia
<jesus.sanchez-palencia@intel.com> wrote:
> This series is the v2 of the Time based packet transmission RFC, which was
> originally proposed by Richard Cochran: https://lwn.net/Articles/733962/ .

Great to see you carrying on with this!

> Our main questions at this stage are related to the qdisc:
>  - does the proposed design attend all use cases?
>  - should the qdisc really drop packets that expired after being queued even
>    for the SW best effort mode?

I don't think that being "expired" is necessarily cause for dropping.
The semantic of a launch time is "launch no earlier than this point"
after all, not a deadline. To keep the hardware working, we must only
enforce the invariant that we never queue a packet with an earlier
timestamp than one we previously enqueued that has not launched yet.
Just checking for expiration is going to rule out some potential uses
and also won't necessarily prevent enqueuing out-of-order packets.
Here is an example:

A group of applications enqueue packets to be sent at 1 second
intervals, and share a 5ms window in which they can send them. Due to
scheduling variation, they may finish executing in a different order
per interval, and occasionally some may not finish preparing their
packet before the window opens, although they always will present
their packet before the window closes.

If they all pick different times within the launch window, it is
possible that two of them might pick times very close to one another.
If they present their frames out-of-order to the qdisc, but close
enough to the launch time that the qdisc doesn't hold on to them (i.e.
in the [txtime - delta, txtime] range mentioned in tbs_dequeue), then
they will get enqueued out of order and the invariant will be
violated.  Reordering within some time window only works if all frames
for that window are scheduled well in advance of the first launch
time, and that's not great for applications that need to to calculate
right up to the time they need to send their data.

If they each schedule their packet for the beginning of the window, on
the other hand, everything will be fine for those that complete before
the window opens; there's no longer any order requirement that needs
to be maintained between those in the group, since they all use the
same timestamp. But those that finish after the window opens will be
"late" and have their frames dropped in the current scheme. There's no
technical reason to regard them as late until sending would exceed the
window bounds, but we also don't want to delay any of them once the
window opens.

To maintain the hardware ordering invariant, you need to keep track of
the most recent timestamp you have enqueued in the hardware. Anything
that hits tbs_enqueue with a timestamp earlier than that must be
either dropped or have its timestamp adjusted.

The one remaining question is how late can a timestamped frame be
before it should be dropped instead of enqueued, assuming it is to be
allowed at all? The qdisc could track the allowed window based on user
configuration. I believe the i210 hardware will launch any frame at
the head of queue with a launch time set at or before the present
time, but not so far before that it wraps and interprets the time as a
future time. The qdisc would need to be able query the driver about
how large that window is if it wants to pass in-the-past timestamps
through as-is, but it could also just update timestamps still within
the user-configured window to be set at the current time.

My understanding of reservations for industrial TSN use cases is that
applications will present their working period and their scheduling
accuracy to the central manager, which will take into account the
worst case timing bounds when creating the window that the application
will use on the network. It will then give back an assignment for a
start time offset from the period base time (UTC_time values that are
multiples of interval_time) at which the application's transmit window
starts, and it will remain open long enough to account for the
scheduling jitter in the application.

I think putting the window concept in the qdisc makes for a nice
mapping to how the TSN scheduling works as well as resolving some of
the tricky details around ensuring that you don't jam the hardware
with out-of-order timestamps or unnecessarily delay scheduling packets
to reorder them.


--Levi
