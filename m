From: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
Date: Fri, 26 Jan 2018 16:04:34 -0800
Subject: [Intel-wired-lan] [RFC v2 net-next 00/10] Time based packet
 transmission
In-Reply-To: <CAEYbN3TNnp1SqwdgA+jF4FjFngTG-7u2ZaRa1G06bikGdH5XmA@mail.gmail.com>
References: <20180117230621.26074-1-jesus.sanchez-palencia@intel.com>
 <CAEYbN3TNnp1SqwdgA+jF4FjFngTG-7u2ZaRa1G06bikGdH5XmA@mail.gmail.com>
Message-ID: <a7428d0f-44b0-8bb9-d5a8-802ac8ab2b4d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Levi,

On 01/23/2018 05:43 PM, Levi Pearson wrote:
> On Wed, Jan 17, 2018 at 4:06 PM, Jesus Sanchez-Palencia
> <jesus.sanchez-palencia@intel.com> wrote:
>> This series is the v2 of the Time based packet transmission RFC, which was
>> originally proposed by Richard Cochran: https://lwn.net/Articles/733962/ .
> 
> Great to see you carrying on with this!
> 
>> Our main questions at this stage are related to the qdisc:
>>  - does the proposed design attend all use cases?
>>  - should the qdisc really drop packets that expired after being queued even
>>    for the SW best effort mode?
> 
> I don't think that being "expired" is necessarily cause for dropping.
> The semantic of a launch time is "launch no earlier than this point"
> after all, not a deadline. To keep the hardware working, we must only
> enforce the invariant that we never queue a packet with an earlier
> timestamp than one we previously enqueued that has not launched yet.
> Just checking for expiration is going to rule out some potential uses
> and also won't necessarily prevent enqueuing out-of-order packets.


Let me just split this a bit to make sure we don?t mix things up.

Currently, as discussed during the RFC v1 thread, on tbs_enqueue() we drop
packets if they are expired or if they have an earlier timestamp than the last
dequeued packet.

On tbs_dequeue(), we drop packets if they have expired while sitting at our
timerqueue. That is done because our current semantic for txtime is ?no later
than this point?.  Are you suggesting that we change that to ?no earlier than
this point? instead? The delta parameter would then be defining how early is
acceptable for dequeuing a packet, but we?ll need another parameter that can
define how late it should be when we decide to drop it.



> Here is an example:
> 
> A group of applications enqueue packets to be sent at 1 second
> intervals, and share a 5ms window in which they can send them. Due to
> scheduling variation, they may finish executing in a different order
> per interval, and occasionally some may not finish preparing their
> packet before the window opens, although they always will present
> their packet before the window closes.
> 
> If they all pick different times within the launch window, it is
> possible that two of them might pick times very close to one another.
> If they present their frames out-of-order to the qdisc, but close
> enough to the launch time that the qdisc doesn't hold on to them (i.e.
> in the [txtime - delta, txtime] range mentioned in tbs_dequeue), then
> they will get enqueued out of order and the invariant will be
> violated.  Reordering within some time window only works if all frames
> for that window are scheduled well in advance of the first launch
> time, and that's not great for applications that need to to calculate
> right up to the time they need to send their data.


I like the example, but due to the data structure that we use internally,
tbs_enqueue() will always enqueue packets onto their correct position, i.e. the
rbtree will always be ?sorted?. If a dequeue() happens before the next enqueue,
then yes we may get to the situation you are describing, but that will always be
true regardless of the applications that are running, right? If that can?t be
fixed in userspace, then I?m afraid that either using a per-packet txtime is not
the right strategy for this system or tbs might not be the correct qdisc for it.

(...)


> 
> To maintain the hardware ordering invariant, you need to keep track of
> the most recent timestamp you have enqueued in the hardware. Anything
> that hits tbs_enqueue with a timestamp earlier than that must be
> either dropped or have its timestamp adjusted.


Yes, and we currently drop them there (that?s what the ktime_before(txtime, q->last)
check is doing). Adjusting timestamps is a can-of-worms, in my opinion, and I
don?t think we should go down that route.



> 
> The one remaining question is how late can a timestamped frame be
> before it should be dropped instead of enqueued, assuming it is to be
> allowed at all? The qdisc could track the allowed window based on user
> configuration. I believe the i210 hardware will launch any frame at
> the head of queue with a launch time set at or before the present
> time, but not so far before that it wraps and interprets the time as a
> future time. The qdisc would need to be able query the driver about
> how large that window is if it wants to pass in-the-past timestamps
> through as-is, but it could also just update timestamps still within
> the user-configured window to be set at the current time.


I believe I have tackled the question here already. For the rest, we don?t think
a qdisc should fetch any information from the driver. The information flow
should be kept as is, from qdisc to the driver, not the other way around.



> 
> My understanding of reservations for industrial TSN use cases is that
> applications will present their working period and their scheduling
> accuracy to the central manager, which will take into account the
> worst case timing bounds when creating the window that the application
> will use on the network. It will then give back an assignment for a
> start time offset from the period base time (UTC_time values that are
> multiples of interval_time) at which the application's transmit window
> starts, and it will remain open long enough to account for the
> scheduling jitter in the application.
> 
> I think putting the window concept in the qdisc makes for a nice
> mapping to how the TSN scheduling works as well as resolving some of
> the tricky details around ensuring that you don't jam the hardware
> with out-of-order timestamps or unnecessarily delay scheduling packets
> to reorder them.


I follow what you are saying, but I think we will either have those fixed at
userspace or through a separate mechanism. The tbs qdisc should be kept simple
and concise:

 * it provides a per-packet tx time;

 * it holds packets (in order) until at least their txtime minus a configurable
delta;

 * it drops packets if they are expired (or perhaps if they are after a
configurable threshold);

 * it avoids out-of-order timestamps and it allows you to turn a hw feature on
to increase accuracy for per-packet time based transmission.

Even though the concept of per-queue tx windows (with periods and offsets)
should be implementable on top of tbs, our opinion is that it might better fit
under yet another qdisc that should be designed specifically for that. We have
shared some ideas before, but that is definitely out-of-scope here.


Thanks for the feedback so far.

Regards,
Jesus
