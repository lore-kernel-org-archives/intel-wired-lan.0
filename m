From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Wed, 28 Dec 2016 18:44:52 +0000
Subject: [Intel-wired-lan] [next PATCH S58 4/5] i40e/i40evf: don't open
 code pci_enable_msix_range
In-Reply-To: <1482861359-2352-4-git-send-email-bimmy.pujari@intel.com>
References: <1482861359-2352-1-git-send-email-bimmy.pujari@intel.com>
 <1482861359-2352-4-git-send-email-bimmy.pujari@intel.com>
Message-ID: <02874ECE860811409154E81DA85FBB5857D1677F@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

> -----Original Message-----
> From: Pujari, Bimmy
> Sent: Tuesday, December 27, 2016 9:56 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Keller, Jacob E <jacob.e.keller@intel.com>
> Subject: [next PATCH S58 4/5] i40e/i40evf: don't open code
> pci_enable_msix_range
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Make use of the available kernel facility and don't re-write
> pci_enable_msix_range function in the driver.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-Id: I3d2dd7fdb0ea7c3029f2ddafee3240ae21104e8b
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c     | 28 ++++++++++++----------
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 32 +++++++++++++------------
>  2 files changed, 33 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 227a06c..d87677d 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -7804,21 +7804,26 @@ static int i40e_alloc_rings(struct i40e_vsi *vsi)
>  /**
>   * i40e_reserve_msix_vectors - Reserve MSI-X vectors in the kernel
>   * @pf: board private structure
> - * @vectors: the number of MSI-X vectors to request
> + * @v_budget: the number of MSI-X vectors to request
>   *
>   * Returns the number of vectors reserved, or error
>   **/
> -static int i40e_reserve_msix_vectors(struct i40e_pf *pf, int vectors)
> +static int i40e_reserve_msix_vectors(struct i40e_pf *pf, int v_budget)
>  {
> -	vectors = pci_enable_msix_range(pf->pdev, pf->msix_entries,
> -					I40E_MIN_MSIX, vectors);
> -	if (vectors < 0) {
> +	int v_actual = 0;
> +
> +	v_actual = pci_enable_msix_range(pf->pdev,
> +					 pf->msix_entries,
> +					 I40E_MIN_MSIX,
> +					 v_budget);
> +	if (v_actual < 0)
>  		dev_info(&pf->pdev->dev,
> -			 "MSI-X vector reservation failed: %d\n", vectors);
> -		vectors = 0;
> -	}
> +			 "MSI-X vector reservation failed: %d\n", v_actual);
> +	dev_info(&pf->pdev->dev,
> +		 "%s: MSI-X vectors reserved: %d\n",
> +		 __func__, v_actual);
> 
> -	return vectors;
> +	return v_actual;
>  }
> 
>  /**
> @@ -7941,15 +7946,14 @@ static int i40e_init_msix(struct i40e_pf *pf)
>  	for (i = 0; i < v_budget; i++)
>  		pf->msix_entries[i].entry = i;
>  	v_actual = i40e_reserve_msix_vectors(pf, v_budget);
> -
>  	if (v_actual < I40E_MIN_MSIX) {
>  		pf->flags &= ~I40E_FLAG_MSIX_ENABLED;
>  		kfree(pf->msix_entries);
>  		pf->msix_entries = NULL;
> -		pci_disable_msix(pf->pdev);
>  		return -ENODEV;
> +	}
> 
> -	} else if (v_actual == I40E_MIN_MSIX) {
> +	if (v_actual == I40E_MIN_MSIX) {
>  		/* Adjust for minimal MSIX use */
>  		pf->num_vmdq_vsis = 0;
>  		pf->num_vmdq_qps = 0;
> diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
> b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
> index 9492b20..71e2c90 100644
> --- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
> +++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
> @@ -1122,34 +1122,36 @@ void i40evf_down(struct i40evf_adapter *adapter)
>  static int
>  i40evf_acquire_msix_vectors(struct i40evf_adapter *adapter, int vectors)
>  {
> -	int err, vector_threshold;
> +	int v_actual;
> 
>  	/* We'll want at least 3 (vector_threshold):
>  	 * 0) Other (Admin Queue and link, mostly)
>  	 * 1) TxQ[0] Cleanup
>  	 * 2) RxQ[0] Cleanup
> -	 */
> -	vector_threshold = MIN_MSIX_COUNT;
> -
> -	/* The more we get, the more we will assign to Tx/Rx Cleanup
> +	 *
> +	 * The more we get, the more we will assign to Tx/Rx Cleanup
>  	 * for the separate queues...where Rx Cleanup >= Tx Cleanup.
>  	 * Right now, we simply care about how many we'll get; we'll
>  	 * set them up later while requesting irq's.
>  	 */
> -	err = pci_enable_msix_range(adapter->pdev, adapter->msix_entries,
> -				    vector_threshold, vectors);
> -	if (err < 0) {
> -		dev_err(&adapter->pdev->dev, "Unable to allocate MSI-X
> interrupts\n");
> +	v_actual = pci_enable_msix_range(adapter->pdev, adapter-
> >msix_entries,
> +					 MIN_MSIX_COUNT, vectors);
> +	if (v_actual < 0) {
> +		dev_err(&adapter->pdev->dev, "Unable to allocate MSI-X
> interrupts: %d\n",
> +			v_actual);
>  		kfree(adapter->msix_entries);
>  		adapter->msix_entries = NULL;
> -		return err;
> +		return v_actual;
>  	}
> 
> -	/* Adjust for only the vectors we'll use, which is minimum
> -	 * of max_msix_q_vectors + NONQ_VECS, or the number of
> -	 * vectors we were allocated.
> -	 */
> -	adapter->num_msix_vectors = err;
> +	if (CLIENT_ENABLED(adapter)) {
> +		adapter->num_iwarp_msix = (v_actual - 1) / 2;
> +		adapter->num_msix_vectors = v_actual - adapter-
> >num_iwarp_msix;
> +		adapter->iwarp_base_vector = adapter->num_msix_vectors;
> +	} else {
> +		adapter->num_msix_vectors = v_actual;
> +	}
> +	adapter->num_msix_vectors = v_actual;

This still doesn't look right. I think the last line here needs to be dropped. Otherwise why have the else block at all, and why set num_msix_vectors separately in the first section? Ya, basically the code upstream doesn't have all of the CLIENT_ENABLED bits here. You need to drop the last line here I just marked, or you need to drop all the client enabled bits. Since the original code doesn't have the CLIENT_ENABLED portion, I suggest dropping that part for now and re-adding client support to this in a future patch.

>  	return 0;
>  }
> 
> --
> 2.4.11

