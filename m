From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 31 Jul 2019 18:14:07 +0000
Subject: [Intel-wired-lan] [PATCH S25 10/12] ice: add validation in
 OP_CONFIG_VSI_QUEUES VF message
In-Reply-To: <20190725095401.24590-10-anthony.l.nguyen@intel.com>
References: <20190725095401.24590-1-anthony.l.nguyen@intel.com>
 <20190725095401.24590-10-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40EAEC@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, July 25, 2019 2:54 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S25 10/12] ice: add validation in
> OP_CONFIG_VSI_QUEUES VF message
> 
> From: Michal Swiatkowski <michal.swiatkowski@intel.com>
> 
> Check num_queue_pairs to avoid access to unallocated field of
> vsi->tx_rings/vsi->rx_rings. Without this validation we can set
> vsi->alloc_txq/vsi->alloc_rxq to value smaller than
> vsi->ICE_MAX_BASE_QS_PER_VF
> and send this command with num_queue_pairs greater than
> vsi->alloc_txq/vsi->alloc_rxq. This lead to access to unallocated memory.
> 
> In VF vsi alloc_txq and alloc_rxq should be the same. Get minimum because
> looks more readable.
> 
> Also add validation for ring_len param. It should be greater than 32 and be
> multiple of 32. Incorrect value leads to hang traffic on PF.
> 
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 31 ++++++++++++++-----
>  1 file changed, 24 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


