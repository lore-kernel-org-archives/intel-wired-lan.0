From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 5 Jan 2018 19:16:44 +0000
Subject: [Intel-wired-lan] [next PATCH S85-V1 05/14] i40e/i40evf: Clean
 up logic for adaptive ITR
In-Reply-To: <20171229134953.14355-1-alice.michael@intel.com>
References: <20171229134953.14355-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8D7206@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, December 29, 2017 5:50 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S85-V1 05/14] i40e/i40evf: Clean up
> logic for adaptive ITR
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> The logic for dynamic ITR update is confusing at best as there were odd paths
> chosen for how to find the rings associated with a given queue based on the
> vector index and other inconsistencies throughout the code.
> 
> This patch is an attempt to clean up the logic so that we can more easily
> understand what is going on. Specifically if there is a Rx or Tx ring that is
> enabled in dynamic mode on the q_vector it is allowed to override the other
> side of the interrupt moderation. While it isn't correct all this patch is doing is
> cleaning up the logic for now so that when we come through and fix it we can
> more easily identify that this is wrong.
> 
> The other big change made here is that we replace references to:
> 	vsi->rx_rings[q_vector->v_idx]->itr_setting
> with:
> 	q_vector->rx.ring->itr_setting
> 
> The general idea is we can avoid the long pointer chase since just accessing
> q_vector->rx.ring is a single pointer access versus having to chase down vsi-
> >rx_rings, and then finding the pointer in the array, and finally chasing down
> the itr_setting from there.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 55 +++++++------------------
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 59 +++++++--------------------
>  2 files changed, 28 insertions(+), 86 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


