From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 20 Sep 2018 12:49:03 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: reset next_to_clean and
 next_to_use when we reset the head and tail
In-Reply-To: <20180920104247.69280-1-sebastianx.basierski@intel.com>
References: <20180920104247.69280-1-sebastianx.basierski@intel.com>
Message-ID: <3002c47e062415ea888e72e6d1189425021272b7.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2018-09-20 at 12:42 +0200, Sebastian Basierski wrote:
> Only reset the next_to_clean and next_to_use values when we are resetting
> the head and tail hardware registers.  This way we can avoid having
> multiple functions doing the reset work and can more easily track the
> correlation between the registers and these values.
> 
> Signed-off-by: Sebastian Basierski <sebastianx.basierski@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 25 +++++++++----------
>  1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 27a8546c88b2..0e83f5e8973d 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -3482,10 +3482,16 @@ void ixgbe_configure_tx_ring(struct ixgbe_adapter
> *adapter,
>  	IXGBE_WRITE_REG(hw, IXGBE_TDBAH(reg_idx), (tdba >> 32));
>  	IXGBE_WRITE_REG(hw, IXGBE_TDLEN(reg_idx),
>  			ring->count * sizeof(union ixgbe_adv_tx_desc));
> +
> +	/* reset head and tail pointers */
>  	IXGBE_WRITE_REG(hw, IXGBE_TDH(reg_idx), 0);
>  	IXGBE_WRITE_REG(hw, IXGBE_TDT(reg_idx), 0);
>  	ring->tail = adapter->io_addr + IXGBE_TDT(reg_idx);
>  
> +	/* reset ntu and ntc to place SW in sync with hardwdare */

Mis-spelled 'hardware', I have fixed up the code comment in my tree

> +	ring->next_to_clean = 0;
> +	ring->next_to_use = 0;
> +
>  	/*
>  	 * set WTHRESH to encourage burst writeback, it should not be set
>  	 * higher than 1 when:
> @@ -4046,10 +4052,16 @@ void ixgbe_configure_rx_ring(struct ixgbe_adapter
> *adapter,
>  	/* Force flushing of IXGBE_RDLEN to prevent MDD */
>  	IXGBE_WRITE_FLUSH(hw);
>  
> +	/* reset head and tail pointers */
>  	IXGBE_WRITE_REG(hw, IXGBE_RDH(reg_idx), 0);
>  	IXGBE_WRITE_REG(hw, IXGBE_RDT(reg_idx), 0);
>  	ring->tail = adapter->io_addr + IXGBE_RDT(reg_idx);
>  
> +	/* reset ntu and ntc to place SW in sync with hardwdare */

Mis-spelled 'hardware', I have fixed up the code comment in my tree

> +	ring->next_to_clean = 0;
> +	ring->next_to_use = 0;
> +	ring->next_to_alloc = 0;
> +
>  	ixgbe_configure_srrctl(adapter, ring);
>  	ixgbe_configure_rscctl(adapter, ring);
>  
> @@ -5238,10 +5250,6 @@ static void ixgbe_clean_rx_ring(struct ixgbe_ring
> *rx_ring)
>  			rx_buffer = rx_ring->rx_buffer_info;
>  		}
>  	}
> -
> -	rx_ring->next_to_alloc = 0;
> -	rx_ring->next_to_clean = 0;
> -	rx_ring->next_to_use = 0;
>  }
>  
>  static int ixgbe_fwd_ring_up(struct ixgbe_adapter *adapter,
> @@ -5933,10 +5941,6 @@ static void ixgbe_clean_tx_ring(struct ixgbe_ring
> *tx_ring)
>  	/* reset BQL for queue */
>  	if (!ring_is_xdp(tx_ring))
>  		netdev_tx_reset_queue(txring_txq(tx_ring));
> -
> -	/* reset next_to_use and next_to_clean */
> -	tx_ring->next_to_use = 0;
> -	tx_ring->next_to_clean = 0;
>  }
>  
>  /**
> @@ -6369,8 +6373,6 @@ int ixgbe_setup_tx_resources(struct ixgbe_ring
> *tx_ring)
>  	if (!tx_ring->desc)
>  		goto err;
>  
> -	tx_ring->next_to_use = 0;
> -	tx_ring->next_to_clean = 0;
>  	return 0;
>  
>  err:
> @@ -6463,9 +6465,6 @@ int ixgbe_setup_rx_resources(struct ixgbe_adapter
> *adapter,
>  	if (!rx_ring->desc)
>  		goto err;
>  
> -	rx_ring->next_to_clean = 0;
> -	rx_ring->next_to_use = 0;
> -
>  	/* XDP RX-queue info */
>  	if (xdp_rxq_info_reg(&rx_ring->xdp_rxq, adapter->netdev,
>  			     rx_ring->queue_index) < 0)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180920/6c058a46/attachment.asc>
