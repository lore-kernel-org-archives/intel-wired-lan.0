From: Toke =?unknown-8bit?q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Tue, 01 Jun 2021 14:38:03 +0200
Subject: [Intel-wired-lan] [PATCH intel-next 2/2] ice: introduce XDP Tx
 fallback path
In-Reply-To: <20210601113236.42651-3-maciej.fijalkowski@intel.com>
References: <20210601113236.42651-1-maciej.fijalkowski@intel.com>
 <20210601113236.42651-3-maciej.fijalkowski@intel.com>
Message-ID: <87czt5dal0.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> Under rare circumstances there might be a situation where a requirement
> of having a XDP Tx queue per core could not be fulfilled and some of the
> Tx resources would have to be shared between cores. This yields a need
> for placing accesses to xdp_rings array onto critical section protected
> by spinlock.
>
> Design of handling such scenario is to at first find out how many queues
> are there that XDP could use. Any number that is not less than the half
> of a count of cores of platform is allowed. XDP queue count < cpu count
> is signalled via new VSI state ICE_VSI_XDP_FALLBACK which carries the
> information further down to Rx rings where new ICE_TX_XDP_LOCKED is set
> based on the mentioned VSI state. This ring flag indicates that locking
> variants for getting/putting xdp_ring need to be used in fast path.
>
> For XDP_REDIRECT the impact on standard case (one XDP ring per CPU) can
> be reduced a bit by providing a separate ndo_xdp_xmit and swap it at
> configuration time. However, due to the fact that net_device_ops struct
> is a const, it is not possible to replace a single ndo, so for the
> locking variant of ndo_xdp_xmit, whole net_device_ops needs to be
> replayed.
>
> It has an impact on performance (1-2 %) of a non-fallback path as
> branches are introduced.

I generally feel this is the right approach, although the performance
impact is a bit unfortunately, obviously. Maybe it could be avoided by
the use of static_branch? I.e., keep a global refcount of how many
netdevs are using the locked path and only activate the check in the
fast path while that refcount is >0?

-Toke

