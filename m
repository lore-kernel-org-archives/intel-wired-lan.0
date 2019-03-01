From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 1 Mar 2019 23:49:47 +0000
Subject: [Intel-wired-lan] [PATCH S15 05/14] ice: Audit hotpath
 structures with pahole
In-Reply-To: <20190219230414.25627-6-anirudh.venkataramanan@intel.com>
References: <20190219230414.25627-1-anirudh.venkataramanan@intel.com>
 <20190219230414.25627-6-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3675C1@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Tuesday, February 19, 2019 3:04 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S15 05/14] ice: Audit hotpath structures
> with pahole
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently the ice_q_vector structure and ice_ring_container structure are
> taking up more space than necessary due to cache alignment holes and
> unnecessary variables respectively. This is not helping the driver's
> performance. The following fixes were done to improve cahche alignment,
> reduce wasted space, and increase performance.
> 
> 1. Remove the ice_latency_range enum as it is unused.
> 2. Remove the latency_range variable in the ice_ring_container structure.
> 3. Change the size of the itr_idx in the ice_ring_container structure
>    from an int to an u16. This reduced the size of ice_ring_container
>    structure to 32 Bytes so it has no holes or padding.
> 4. Re-arrange the ice_q_vector structure using pahole to align
>    members as best as possible in regards to 64 Byte cache line size.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h      | 21 +++++++++++++--------
>  drivers/net/ethernet/intel/ice/ice_lib.c  |  2 --
> drivers/net/ethernet/intel/ice/ice_txrx.c |  2 +-
> drivers/net/ethernet/intel/ice/ice_txrx.h | 10 +---------
>  4 files changed, 15 insertions(+), 20 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


