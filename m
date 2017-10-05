From: Levi Pearson <levipearson@gmail.com>
Date: Thu, 5 Oct 2017 15:23:20 -0600
Subject: [Intel-wired-lan] [next-queue PATCH v4 3/4] net/sched:
 Introduce Credit Based Shaper (CBS) qdisc
In-Reply-To: <20171005.120508.2267452751875787466.davem@davemloft.net>
References: <CAEYbN3RjUXGMyxo0t88-ASNVEVQdfXkMzBbMtMHAhqWScOO=Cg@mail.gmail.com>
 <20171005.112909.2052593524154643514.davem@davemloft.net>
 <CY1PR0401MB1536A44D0AB459BB9618664A92700@CY1PR0401MB1536.namprd04.prod.outlook.com>
 <20171005.120508.2267452751875787466.davem@davemloft.net>
Message-ID: <CAEYbN3S+qyThOY4i0Odo6mQthbcTbCFGVXkDos3L_cTZcGdCxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

(apologies to davem for the repeat; I accidentally did a reply vs.
reply-all the first time)

On Thu, Oct 5, 2017 at 1:05 PM, David Miller <davem@davemloft.net> wrote:
> From: Rodney Cummings <rodney.cummings@ni.com>
> Date: Thu, 5 Oct 2017 18:41:48 +0000
>
>> The IEEE Std 802.1Q specs for credit-based shaper require precise transmit decisions
>> within a 125 microsecond window of time.
>>
>> Even with the Preempt RT patch or similar enhancements, that isn't very practical
>> as software-only. I doubt that software would conform to the standard's
>> requirements.
>>
>> This is analogous to memory, or CPU.
>
> I feel like this is looking for an excuse to not have to at least try to implement
> the software version of CBS.

I don't understand why you attribute this to excuse-making. Is the
objection due to the fact that the user interface is provided through
a qdisc module? In that case, is there a better configuration
interface for setting up traffic shaping registers that could be used
across all the NICs that provide the capability? There are quite a
number of them now, and the lack of kernel interfaces to the hardware
makes coordinating the userspace effort to support the protocols far
more difficult than it needs to be.

As a contrasting example, look at the DCB shaping functionality,
provided by the ETS shaper. It's specified in 802.1Q right next to the
CBS shaper. It has no software implementation in a qdisc module as far
as I can tell (although it should be less resource-intensive to
implement), yet there's a whole netlink protocol for configuring it. I
don't think it makes sense to tack on the dcb netlink interface to
every driver that implements Qav; most don't have the DCB shapers, and
the user-level control protocol for FQTSS is SRP instead of DCB's LLDP
extensions, so completely different userspace tools would be required
as well.

I just want a simple, standard interface for configuring some fairly
common and IEEE-standard hardware features related to AVB/TSN traffic
shaping. Do we need our own netlink protocol for TSN configuration? It
seems to be massive overkill for an interface to write a single
register, but I suppose it might also be used for configuring TSN
paramters in local switch devices, such as Qbv windows, which need
quite a bit more information. I would be happy to do some of the work,
but I'd like an idea of what kind of interface would be acceptable
before writing up an RFC implementation.


Levi
