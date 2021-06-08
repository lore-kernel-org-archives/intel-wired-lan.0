From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Tue, 8 Jun 2021 14:12:59 +0200
Subject: [Intel-wired-lan] [PATCH intel-next 2/2] ice: introduce XDP Tx
 fallback path
In-Reply-To: <87czt5dal0.fsf@toke.dk>
References: <20210601113236.42651-1-maciej.fijalkowski@intel.com>
 <20210601113236.42651-3-maciej.fijalkowski@intel.com>
 <87czt5dal0.fsf@toke.dk>
Message-ID: <20210608121259.GA1971@ranger.igk.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Jun 01, 2021 at 02:38:03PM +0200, Toke H?iland-J?rgensen wrote:
> Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:
> 
> > Under rare circumstances there might be a situation where a requirement
> > of having a XDP Tx queue per core could not be fulfilled and some of the
> > Tx resources would have to be shared between cores. This yields a need
> > for placing accesses to xdp_rings array onto critical section protected
> > by spinlock.
> >
> > Design of handling such scenario is to at first find out how many queues
> > are there that XDP could use. Any number that is not less than the half
> > of a count of cores of platform is allowed. XDP queue count < cpu count
> > is signalled via new VSI state ICE_VSI_XDP_FALLBACK which carries the
> > information further down to Rx rings where new ICE_TX_XDP_LOCKED is set
> > based on the mentioned VSI state. This ring flag indicates that locking
> > variants for getting/putting xdp_ring need to be used in fast path.
> >
> > For XDP_REDIRECT the impact on standard case (one XDP ring per CPU) can
> > be reduced a bit by providing a separate ndo_xdp_xmit and swap it at
> > configuration time. However, due to the fact that net_device_ops struct
> > is a const, it is not possible to replace a single ndo, so for the
> > locking variant of ndo_xdp_xmit, whole net_device_ops needs to be
> > replayed.
> >
> > It has an impact on performance (1-2 %) of a non-fallback path as
> > branches are introduced.
> 
> I generally feel this is the right approach, although the performance
> impact is a bit unfortunately, obviously. Maybe it could be avoided by
> the use of static_branch? I.e., keep a global refcount of how many
> netdevs are using the locked path and only activate the check in the
> fast path while that refcount is >0?

This would be an ideal solution if we would be able to have it PF-scoped,
which AFAICT is not possible as static key is per module, right?

I checked that before the bank holiday here in Poland and indeed I was not
observing perf drops. Only thing that is questionable is the fact that a
single PF would affect all the others that ice driver is serving.

OTOH I see that Jesper acked that work.

Let me play with this a bit more as I'm in the middle of switching my HW
lab, but I wanted to break the silence over here. I didn't manage to check
that one fallback path will affect other PFs.

Thanks Toke for that great idea :) any other opinions are more than
welcome.

> 
> -Toke
> 
