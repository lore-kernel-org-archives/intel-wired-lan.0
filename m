From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Wed, 25 Aug 2021 09:57:59 +0200
Subject: [Intel-wired-lan] [PATCH v7 intel-next 0/9] XDP_TX improvements
 for ice
In-Reply-To: <20210819120004.34392-1-maciej.fijalkowski@intel.com>
References: <20210819120004.34392-1-maciej.fijalkowski@intel.com>
Message-ID: <CAJ8uoz0Hisa+f9S3DbeTzjPbmVTAfeQAc1KJ-AASUmnWtjkMhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Aug 19, 2021 at 2:15 PM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> I didn't realize that on v6 I didn't have CONFIG_NET_SWITCHDEV option
> set in the kernel config. I removed ice_eswitch_remap_ring but didn't
> adjust the q_vector's ring pointer to the new Rx/Tx union.
>
> Hope that it's the last time of embarrassment :)
>
> v6->v7:
> * fix compilation issues when CONFIG_NET_SWITCHDEV=y
>
> v5->v6:
> * rebase set on Tony's dev-queue
> * adjust switchdev code to ring split
> * compile with W=1 C=2 and fix outstanding kdoc issues
>
> v4->v5:
> * fix issues pointed by lkp; variables used for updating ring stats
>   could be un-inited
> * s/ice_ring/ice_rx_ring; it looks now symmetric given that we have
>   ice_tx_ring struct dedicated for Tx ring
> * go through the code and use ice_for_each_* macros; it was spotted by
>   Brett that there was a place around that code that this set is
>   touching that was not using the ice_for_each_txq. Turned out that there
>   were more such places
> * take care of coalesce related code; carry the info about type of ring
>   container in ice_ring_container
> * pull out getting rid of @ring_active onto separate patch, as suggested
>   by Brett
>
> v3->v4:
> * fix lkp issues;
>
> v2->v3:
> * improve XDP_TX in a proper way
> * split ice_ring
> * propagate XDP ring pointer to Rx ring
>
> v1->v2:
> * try to improve XDP_TX processing
>
> v6 : https://lore.kernel.org/bpf/20210818135916.25007-1-maciej.fijalkowski at intel.com/
> v5 : https://lore.kernel.org/bpf/20210818075256.GA16780 at ranger.igk.intel.com/
> v4 : https://lore.kernel.org/bpf/20210806095539.34423-1-maciej.fijalkowski at intel.com/
> v3 : https://lore.kernel.org/bpf/20210805230046.28715-1-maciej.fijalkowski at intel.com/
> v2 : https://lore.kernel.org/bpf/20210705164338.58313-1-maciej.fijalkowski at intel.com/
> v1 : https://lore.kernel.org/bpf/20210601113236.42651-1-maciej.fijalkowski at intel.com/
>
> Thanks!
> Maciej

Good work Maciej! This patch set really helps with performance and ease of use.

FWIW for patches 1, 2, 4 - 9:

Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>

I do not feel comfortable acking patch #3 since it is touching
something that is used by the whole driver. I think this patch should
be acked by the ice driver maintainers themselves, Jesse and Tony (I
believe).

/Magnus

> Maciej Fijalkowski (9):
>   ice: remove ring_active from ice_ring
>   ice: move ice_container_type onto ice_ring_container
>   ice: split ice_ring onto Tx/Rx separate structs
>   ice: unify xdp_rings accesses
>   ice: do not create xdp_frame on XDP_TX
>   ice: propagate xdp_ring onto rx_ring
>   ice: optimize XDP_TX workloads
>   ice: introduce XDP_TX fallback path
>   ice: make use of ice_for_each_* macros
>
>  drivers/net/ethernet/intel/ice/ice.h          |  41 +++-
>  drivers/net/ethernet/intel/ice/ice_arfs.c     |   2 +-
>  drivers/net/ethernet/intel/ice/ice_base.c     |  59 +++---
>  drivers/net/ethernet/intel/ice/ice_base.h     |   8 +-
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |   9 +-
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.h  |  10 +-
>  drivers/net/ethernet/intel/ice/ice_eswitch.c  |  35 ++--
>  drivers/net/ethernet/intel/ice/ice_eswitch.h  |   4 +-
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  |  95 +++++----
>  drivers/net/ethernet/intel/ice/ice_lib.c      |  92 +++++----
>  drivers/net/ethernet/intel/ice/ice_lib.h      |   6 +-
>  drivers/net/ethernet/intel/ice/ice_main.c     | 145 +++++++++-----
>  drivers/net/ethernet/intel/ice/ice_ptp.c      |   2 +-
>  drivers/net/ethernet/intel/ice/ice_ptp.h      |   4 +-
>  drivers/net/ethernet/intel/ice/ice_trace.h    |  28 +--
>  drivers/net/ethernet/intel/ice/ice_txrx.c     | 183 +++++++++++-------
>  drivers/net/ethernet/intel/ice/ice_txrx.h     | 126 +++++++-----
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  98 ++++++++--
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.h |  14 +-
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  |   2 +-
>  drivers/net/ethernet/intel/ice/ice_xsk.c      |  70 ++++---
>  drivers/net/ethernet/intel/ice/ice_xsk.h      |  20 +-
>  22 files changed, 629 insertions(+), 424 deletions(-)
>
> --
> 2.20.1
>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
