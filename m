From: Dmitry Popov <ixaphire@gmail.com>
Date: Wed, 29 Mar 2017 04:39:10 +0300
Subject: [Intel-wired-lan] [PATCH v7 2/2] ixgbe: add support for XDP_TX
 action
In-Reply-To: <20170324043145.10293.75036.stgit@john-Precision-Tower-5810>
References: <20170324042949.10293.43329.stgit@john-Precision-Tower-5810>
 <20170324043145.10293.75036.stgit@john-Precision-Tower-5810>
Message-ID: <20170329043910.8db257e04e3833fae5ace8cc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 23 Mar 2017 21:31:45 -0700
John Fastabend <john.fastabend@gmail.com> wrote:

> Add support for XDP_TX action.
> 
> A couple design choices were made here. First I use a new ring
> pointer structure xdp_ring[] in the adapter struct instead of
> pushing the newly allocated xdp TX rings into the tx_ring[]
> structure. This means we have to duplicate loops around rings
> in places we want to initialize both TX rings and XDP rings.
> But by making it explicit it is obvious when we are using XDP
> rings and when we are using TX rings. Further we don't have
> to do ring arithmatic which is error prone. As a proof point
> for doing this my first patches used only a single ring structure
> and introduced bugs in FCoE code and macvlan code paths.
> 
> Second I am aware this is not the most optimized version of
> this code possible. I want to get baseline support in using
> the most readable format possible and then once this series
> is included I will optimize the TX path in another series
> of patches.
> 
> Signed-off-by: John Fastabend <john.r.fastabend@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h         |   19 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |   25 ++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c     |   78 +++++-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |  279 +++++++++++++++++++---
>  4 files changed, 350 insertions(+), 51 deletions(-)

Hi there.

I've been testing&backporting these patches (good job btw) for
DDoS mitigation solutions and got one question/issue about XDP queues setup:

Briefly, what is being done:
N_cpus queues are allocated
>+	return adapter->xdp_prog ? nr_cpu_ids : 0;
and ixgbe_xmit_xdp_ring chooses one of them, based on the cpu it is running on
>+	struct ixgbe_ring *ring = adapter->xdp_ring[smp_processor_id()];

It's pretty good on ~default setups with one rx queue per each cpu and
uniformly spread irqs: queue#0 on cpu#0, queue#i on cpu#i etc. It is even
ok to reduce the number of queues (however then there's going to be some unused
xdp-only q_vectors/irqs). The real problem arises when one wants to move irqs to
different cpus: for instance, to handle packets only on cpus #8-15,24-27
(say, 2x8 NUMA server with HT and NIC bound to 2nd processor). XDP rings are
going to be shuffled really hard in this scenario: ixgbe_xmit_xdp_ring would
choose xdp_ring of some other q_vector, and irq of this q_vector would be 
handled on some other cpu (hence memory pages would walk across cpus etc).

And I'm curious, why not to hard-pair xdp rings with rx rings (placing each
pair in the same q_vector ofc)? It would save some irqs when n_queues < n_cpus
and make irq manipulation a lot easier. I couldn't get any real cons against
this pairing (except it might be a bit harder to implement), and couldn't find
any discussion about it. Did I miss something?


Also, regarding this patch, you might want to initialize q_vector->itr to
IXGBE_12K_ITR for xdp-only q_vectors.
Currently, 
	if (txr_count && !rxr_count) {
doesn't hit in ixgbe_alloc_q_vectors, and the 'else' branch
    /* rx or rx/tx vector */
    if (adapter->rx_itr_setting == 1)
        q_vector->itr = IXGBE_20K_ITR;
sets it to IXGBE_20K_ITR.
