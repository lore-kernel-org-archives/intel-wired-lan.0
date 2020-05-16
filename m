From: Vladimir Oltean <olteanv@gmail.com>
Date: Sun, 17 May 2020 00:03:39 +0300
Subject: [Intel-wired-lan] [next-queue RFC 0/4] ethtool: Add support for
 frame preemption
In-Reply-To: <20200516.133739.285740119627243211.davem@davemloft.net>
References: <20200516012948.3173993-1-vinicius.gomes@intel.com>
 <20200516.133739.285740119627243211.davem@davemloft.net>
Message-ID: <CA+h21hoNW_++QHRob+NbWC2k7y7sFec3kotSjTL6s8eZGGT+2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi David,

On Sat, 16 May 2020 at 23:39, David Miller <davem@davemloft.net> wrote:
>
> From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Date: Fri, 15 May 2020 18:29:44 -0700
>
> > This series adds support for configuring frame preemption, as defined
> > by IEEE 802.1Q-2018 (previously IEEE 802.1Qbu) and IEEE 802.3br.
> >
> > Frame preemption allows a packet from a higher priority queue marked
> > as "express" to preempt a packet from lower priority queue marked as
> > "preemptible". The idea is that this can help reduce the latency for
> > higher priority traffic.
>
> Why do we need yet another name for something which is just basic
> traffic prioritization and why is this configured via ethtool instead
> of the "traffic classifier" which is where all of this stuff should
> be done?

It is not 'just another name for basic traffic prioritization'. With
basic traffic prioritization only, a high-priority packet still has to
wait in the egress queue of a switch until a (potentially large)
low-priority packet has finished transmission and has freed the
medium. Frame preemption changes that. Actually it requires hardware
support on both ends, because the way it is transmitted on the wire is
not compatible with regular Ethernet frames (it uses a special Start
Of Frame Delimiter to encode preemptible traffic).
I know we are talking about ridiculously low improvements in latency,
but the background is that Ethernet is making its way into the
industrial and process control fields, and for that type of
application you need to ensure minimally low and maximally consistent
end-to-end latencies. Frame preemption helps with the "minimally low"
part. The way it works is that typically there are 2 MACs per
interface (1 is "express" - equivalent to the legacy type, and the
other is "preemptible" - the new type) and this new IEEE 802.1Q clause
thing allows some arbitration/preemption event to happen between the
two MACs. When a preemption event happens, the preemptible MAC quickly
wraps up and aborts the frame it's currently transmitting (to come
back and continue later), making room for the express MAC to do its
thing because it's time-constrained. Then, after the express MAC
finishes, the preemptible MAC continues with the rest of the frame
fragments from where it was preempted.
As to why this doesn't go to tc but to ethtool: why would it go to tc?
You can't emulate such behavior in software. It's a hardware feature.
You only* (more or less) need to specify which traffic classes on a
port go to the preemptible MAC and which go to the express MAC. We
discussed about the possibility of extending tc-taprio to configure
frame preemption through it, but the consensus was that somebody might
want to use frame preemption as a standalone feature, without
scheduled traffic, and that inventing another qdisc for frame
preemption alone would be too much of a formalism. (I hope I didn't
omit anything important from the previous discussion on the topic)

Thanks,
-Vladimir
