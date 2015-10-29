From: Allan, Bruce W <bruce.w.allan@intel.com>
Date: Thu, 29 Oct 2015 00:11:58 +0000
Subject: [Intel-wired-lan] [next-queue] fm10k: initialize xps at driver
 load
In-Reply-To: <1445894912-10174-1-git-send-email-jacob.e.keller@intel.com>
References: <1445894912-10174-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <804857E1F29AAC47BF68C404FC60A1847EC6D967@ORSMSX105.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Monday, October 26, 2015 2:29 PM
> To: Intel Wired LAN
> Subject: [Intel-wired-lan] [next-queue] fm10k: initialize xps at driver load
> 
> Similar to ixgbe and i40e, initialize XPS on driver load so that we can
> take advantage of this kernel feature.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k.h     |  3 +++
>  drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 18 ++++++++++++++++--
>  2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/fm10k/fm10k.h
> b/drivers/net/ethernet/intel/fm10k/fm10k.h
> index 2a16cd1b2a8b..c84be8189f4c 100644
> --- a/drivers/net/ethernet/intel/fm10k/fm10k.h
> +++ b/drivers/net/ethernet/intel/fm10k/fm10k.h
> @@ -23,6 +23,7 @@
> 
>  #include <linux/types.h>
>  #include <linux/etherdevice.h>
> +#include <linux/cpumask.h>
>  #include <linux/rtnetlink.h>
>  #include <linux/if_vlan.h>
>  #include <linux/pci.h>
> @@ -66,6 +67,7 @@ struct fm10k_l2_accel {
>  enum fm10k_ring_state_t {
>  	__FM10K_TX_DETECT_HANG,
>  	__FM10K_HANG_CHECK_ARMED,
> +	__FM10K_TX_XPS_INIT_DONE,
>  };
> 
>  #define check_for_tx_hang(ring) \
> @@ -209,6 +211,7 @@ struct fm10k_q_vector {
>  	struct fm10k_ring_container rx, tx;
> 
>  	struct napi_struct napi;
> +	cpumask_t affinity_mask;
>  	char name[IFNAMSIZ + 9];
> 
>  #ifdef CONFIG_DEBUG_FS
> diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
> b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
> index 15d8e10c2504..15e67a383d27 100644
> --- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
> +++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
> @@ -727,6 +727,13 @@ static void fm10k_configure_rx_ring(struct
> fm10k_intfc *interface,
> 
>  	fm10k_write_reg(hw, FM10K_RXINT(reg_idx), rxint);
> 
> +	/* Initialize XPS */
> +	if (!test_and_set_bit(__FM10K_TX_XPS_INIT_DONE, &ring->state)
> &&
> +	    ring->q_vector)
> +		netif_set_xps_queue(ring->netdev,
> +				    &ring->q_vector->affinity_mask,
> +				    ring->queue_index);
> +

The above hunk belongs in fm10k_configure_tx_ring() instead???

>  	/* enable queue */
>  	fm10k_write_reg(hw, FM10K_RXQCTL(reg_idx), rxqctl);
> 
> @@ -1478,8 +1485,10 @@ void fm10k_qv_free_irq(struct fm10k_intfc
> *interface)
>  		if (!q_vector->tx.count && !q_vector->rx.count)
>  			continue;
> 
> -		/* disable interrupts */
> +		/* clear the affinity_mask in the IRQ descriptor */
> +		irq_set_affinity_hint(entry->vector, NULL);
> 
> +		/* disable interrupts */
>  		writel(FM10K_ITR_MASK_SET, q_vector->itr);
> 
>  		free_irq(entry->vector, q_vector);
> @@ -1537,6 +1546,9 @@ int fm10k_qv_request_irq(struct fm10k_intfc
> *interface)
>  			goto err_out;
>  		}
> 
> +		/* assign the mask for this irq */
> +		irq_set_affinity_hint(entry->vector, &q_vector-
> >affinity_mask);
> +
>  		/* Enable q_vector */
>  		writel(FM10K_ITR_ENABLE, q_vector->itr);
> 
> @@ -1557,8 +1569,10 @@ int fm10k_qv_request_irq(struct fm10k_intfc
> *interface)
>  		if (!q_vector->tx.count && !q_vector->rx.count)
>  			continue;
> 
> -		/* disable interrupts */
> +		/* clear the affinity_mask in the IRQ descriptor */
> +		irq_set_affinity_hint(entry->vector, NULL);
> 
> +		/* disable interrupts */
>  		writel(FM10K_ITR_MASK_SET, q_vector->itr);
> 
>  		free_irq(entry->vector, q_vector);
> --
> 2.6.1.264.gbab76a9
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
