From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Sat, 30 Jan 2021 00:25:29 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 2/8] taprio: Add support
 for frame preemption offload
In-Reply-To: <87zh0rqpiq.fsf@vcostago-mobl2.amr.corp.intel.com>
References: <20210122224453.4161729-1-vinicius.gomes@intel.com>
 <20210122224453.4161729-3-vinicius.gomes@intel.com>
 <20210126000924.jjkjruzmh5lgrkry@skbuf>
 <87wnvvsayz.fsf@vcostago-mobl2.amr.corp.intel.com>
 <20210129232015.atl4336zqy4ev3bi@skbuf>
 <87zh0rqpiq.fsf@vcostago-mobl2.amr.corp.intel.com>
Message-ID: <20210130002529.maribb4n7wc2trfi@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Jan 29, 2021 at 03:42:05PM -0800, Vinicius Costa Gomes wrote:
> >> But as I said above, perhaps this should be handled in a per-driver
> >> way. I will remove this from taprio.
> >>
> >> I think removing this check/limitation from taprio should solve the
> >> second part of your question, right?
> >
> > Nope. Can you point me to either 802.1Q or 802.3 saying that at least
> > one priority should go to the express MAC?
> 
> After re-reading Anex Q, I know it's informative, and
> thinking/remembering things a bit better, it seems that the standard
> only defines preemption of express queues/priorities over preemptible
> traffic. The standard doesn't talk about preemptible pririoties
> preempting other preemptible priorities.
> 
> So, if there's no express queue, no preemption is going to happen, so it
> shouldn't be enabled, to avoid like an invalid/useless state.
> 
> So I am going to take back my previous email: this seems like it's
> better to be kept in a centralized place.

Sorry, what?
If you go to the Figure 99-5 Transmit Processing state diagram in IEEE
802.3 (which is what a hardware designer will actually implement), the
pMAC's transition from the PREEMPTABLE_TX state to TX_MCRC is gated by
the "preempt" variable.

Whose definition is:

Boolean that is TRUE when a preemptable packet is to be preempted.
The value of preempt is:
pAllow * (eTx + hold) * preemptableFragSize * MIN_REMAIN

(where * is logical AND, + is logical OR - editor's note).

The important part is (eTx + hold). It means that either the eMAC wants
to transmit, or a HOLD request has been emitted. Otherwise said, HOLD
requests should always trigger a preemption regardless of whether the
eMAC has packets to send or not.

I believe that Michael Teener's peristaltic shaper which is described in
Annex T "Cyclic queuing and forwarding" (right below what you linked me)
makes use of frame preemption triggered by HOLD requests, in order to
reduce the interference time as much as possible.
That's the use case I was actually thinking of when I asked. See slide
11 here:
https://www.ieee802.org/1/files/public/docs2012/new-avb-mjt-back-to-the-future-1112-v01.pdf
