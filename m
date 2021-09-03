From: Kuruvinakunnel, George <george.kuruvinakunnel@intel.com>
Date: Fri, 3 Sep 2021 06:50:43 +0000
Subject: [Intel-wired-lan] [PATCH v7 intel-next 8/9] ice: introduce
 XDP_TX fallback path
In-Reply-To: <20210819120004.34392-9-maciej.fijalkowski@intel.com>
References: <20210819120004.34392-1-maciej.fijalkowski@intel.com>
 <20210819120004.34392-9-maciej.fijalkowski@intel.com>
Message-ID: <PH0PR11MB51444F66A6FB34EA3D91B844E2CF9@PH0PR11MB5144.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Maciej
> Fijalkowski
> Sent: Thursday, August 19, 2021 5:30 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: joamaki at gmail.com; Lobakin, Alexandr <alexandr.lobakin@intel.com>;
> netdev at vger.kernel.org; toke at redhat.com; bjorn at kernel.org; kuba at kernel.org;
> bpf at vger.kernel.org; davem at davemloft.net; Karlsson, Magnus
> <magnus.karlsson@intel.com>
> Subject: [Intel-wired-lan] [PATCH v7 intel-next 8/9] ice: introduce XDP_TX fallback
> path
> 
> Under rare circumstances there might be a situation where a requirement of having
> XDP Tx queue per CPU could not be fulfilled and some of the Tx resources have
> to be shared between CPUs. This yields a need for placing accesses to xdp_ring
> inside a critical section protected by spinlock.
> These accesses happen to be in the hot path, so let's introduce the static branch
> that will be triggered from the control plane when driver could not provide Tx queue
> dedicated for XDP on each CPU.
> 
> Currently, the design that has been picked is to allow any number of XDP Tx
> queues that is at least half of a count of CPUs that platform has.
> For lower number driver will bail out with a response to user that there were not
> enough Tx resources that would allow configuring XDP. The sharing of rings is
> signalled via static branch enablement which in turn indicates that lock for xdp_ring
> accesses needs to be taken in hot path.
> 
> Approach based on static branch has no impact on performance of a non-fallback
> path. One thing that is needed to be mentioned is a fact that the static branch will
> act as a global driver switch, meaning that if one PF got out of Tx resources, then
> other PFs that ice driver is servicing will suffer. However, given the fact that HW
> that ice driver is handling has 1024 Tx queues per each PF, this is currently an
> unlikely scenario.
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |  3 ++
>  drivers/net/ethernet/intel/ice/ice_lib.c      |  4 +-
>  drivers/net/ethernet/intel/ice/ice_main.c     | 53 ++++++++++++++++---
>  drivers/net/ethernet/intel/ice/ice_txrx.c     | 16 +++++-
>  drivers/net/ethernet/intel/ice/ice_txrx.h     |  1 +
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  7 ++-
>  6 files changed, 75 insertions(+), 9 deletions(-)
> 

Tested-by: George Kuruvinakunnel <george.kuruvinakunnel@intel.com>
