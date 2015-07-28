From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 28 Jul 2015 20:49:30 +0000
Subject: [Intel-wired-lan] [next PATCH S9 05/15] i40e/i40evf: fix tx
 hang	workaround code
In-Reply-To: <1437684884-222825-6-git-send-email-catherine.sullivan@intel.com>
References: <1437684884-222825-1-git-send-email-catherine.sullivan@intel.com>
 <1437684884-222825-6-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A016BE4C5@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Verified-by: Andrew Bowers <Andrewx.bowers@intel.com>

Present in git log, code changes present in tree.

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Thursday, July 23, 2015 1:55 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S9 05/15] i40e/i40evf: fix tx hang
> workaround code
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> The arm writeback (arm_wb) code is used for kicking the tx ring to make sure
> any pending work is completed even if interrupts are disabled. It was running
> when it didn't need to, and not clearing the ring->arm_wb state after it was
> set.  This caused tx hangs to still occur occasionally when there really was no
> hang.
> Fix this by resetting the variable right after it was used.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: I7bf75d552ba9c4bd203d40615213861a24bb5594
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 3 +--
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> index 738aca6..8a3d596 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> @@ -793,8 +793,6 @@ static bool i40e_clean_tx_irq(struct i40e_ring
> *tx_ring, int budget)
>  	    !test_bit(__I40E_DOWN, &tx_ring->vsi->state) &&
>  	    (I40E_DESC_UNUSED(tx_ring) != tx_ring->count))
>  		tx_ring->arm_wb = true;
> -	else
> -		tx_ring->arm_wb = false;
> 
>  	if (check_for_tx_hang(tx_ring) && i40e_check_tx_hang(tx_ring)) {
>  		/* schedule immediate reset if we believe we hung */ @@ -
> 1921,6 +1919,7 @@ int i40e_napi_poll(struct napi_struct *napi, int budget)
>  	i40e_for_each_ring(ring, q_vector->tx) {
>  		clean_complete &= i40e_clean_tx_irq(ring, vsi->work_limit);
>  		arm_wb |= ring->arm_wb;
> +		ring->arm_wb = false;
>  	}
> 
>  	/* We attempt to distribute budget to each Rx queue fairly, but don't
> diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
> b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
> index a584e21..6c353b2 100644
> --- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
> @@ -309,8 +309,6 @@ static bool i40e_clean_tx_irq(struct i40e_ring
> *tx_ring, int budget)
>  	    !test_bit(__I40E_DOWN, &tx_ring->vsi->state) &&
>  	    (I40E_DESC_UNUSED(tx_ring) != tx_ring->count))
>  		tx_ring->arm_wb = true;
> -	else
> -		tx_ring->arm_wb = false;
> 
>  	if (check_for_tx_hang(tx_ring) && i40e_check_tx_hang(tx_ring)) {
>  		/* schedule immediate reset if we believe we hung */ @@ -
> 1367,6 +1365,7 @@ int i40evf_napi_poll(struct napi_struct *napi, int budget)
>  	i40e_for_each_ring(ring, q_vector->tx) {
>  		clean_complete &= i40e_clean_tx_irq(ring, vsi->work_limit);
>  		arm_wb |= ring->arm_wb;
> +		ring->arm_wb = false;
>  	}
> 
>  	/* We attempt to distribute budget to each Rx queue fairly, but don't
> --
> 1.9.3
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
