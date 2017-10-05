From: Levi Pearson <levipearson@gmail.com>
Date: Thu, 5 Oct 2017 12:09:32 -0600
Subject: [Intel-wired-lan] [next-queue PATCH v4 3/4] net/sched:
 Introduce Credit Based Shaper (CBS) qdisc
In-Reply-To: <20171004063650.GA1895@nanopsycho>
References: <20171004002831.18371-1-vinicius.gomes@intel.com>
 <20171004002831.18371-4-vinicius.gomes@intel.com>
 <20171004063650.GA1895@nanopsycho>
Message-ID: <CAEYbN3RjUXGMyxo0t88-ASNVEVQdfXkMzBbMtMHAhqWScOO=Cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Oct 4, 2017 at 12:36 AM, Jiri Pirko <jiri@resnulli.us> wrote:

>>+static struct Qdisc_ops cbs_qdisc_ops __read_mostly = {
>>+      .next           =       NULL,
>>+      .id             =       "cbs",
>>+      .priv_size      =       sizeof(struct cbs_sched_data),
>>+      .enqueue        =       cbs_enqueue,
>>+      .dequeue        =       qdisc_dequeue_head,
>>+      .peek           =       qdisc_peek_dequeued,
>>+      .init           =       cbs_init,
>>+      .reset          =       qdisc_reset_queue,
>>+      .destroy        =       cbs_destroy,
>>+      .change         =       cbs_change,
>>+      .dump           =       cbs_dump,
>>+      .owner          =       THIS_MODULE,
>>+};
>
> I don't see a software implementation for this. Looks like you are
> trying abuse tc subsystem to bypass kernel. Could you please explain
> this? The golden rule is: implement in kernel, then offload.

It would be a shame if this were blocked due to a missing software
implementation. This module is analogous to (and designed to work
with) the mqprio module; it directly configures the 802.1Qav
(Forwarding and Queuing for Time-Sensitive Streams) functionality of
multi-queue NICs with that capability. I'm not sure what makes it seem
like an attempt to "bypass the kernel"; it's actually an attempt to
get an appropriate configuration path *into* the kernel, which has
been missing for some time.

While it would be valuable to have a CBS software-only implementation,
and Vinicius and colleagues have mentioned plans to implement one,
most users will have chosen Qav-compliant NICs and will prefer to use
the hardware capability. In fact they are often *already* using that
capability, but configure it via non-standardized interfaces in
out-of-tree or vendor-tree drivers. I believe it's valuable to have
the "knobs" fit in with the mqprio qdisc and the overall tc subsystem
rather than forcing users through various unrelated configuration
tools, but ultimately the hooks just need to be in the network
subsystem so the drivers can be told how the user wants to set the
registers.

It *might* be reasonable to add the functionality of this to mqprio
instead of a separate module, but this is only one of many possible
802.1Q shapers that could be selected and configured (with more being
defined by IEEE 802.1 working groups for different use cases), and it
seems cleaner to me to have their configuration be through separate
modules than crammed into an already-confusing one, especially since
mqprio has much broader applicability than CBS and it probably doesn't
make sense to burden all mqprio users with the configuration option
overhead.

This meets a specific need in industry (this is widely used in
automotive infotainment devices with broad hardware support across the
SoCs targeted at that industry) that is not well-served by a software
implementation of class-level shaping. As a maintainer of the OpenAvnu
project (sponsored by Avnu, an industry alliance formed around the TSN
standards), I will be integrating support for this as soon as it's
available to our traffic shaping management userspace tools, which
currently have to rely on out-of-tree drivers with custom interfaces
or the HTB shaper which can be configured close to CBS, but with
greatly increased overhead.


Levi
