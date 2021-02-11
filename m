From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Thu, 11 Feb 2021 02:09:09 +0100
Subject: [Intel-wired-lan] [PATCH net-next v3 9/9] igc: Enable TX via
 AF_XDP zero-copy
In-Reply-To: <20210209024243.23406-10-vedang.patel@intel.com>
References: <20210209024243.23406-1-vedang.patel@intel.com>
 <20210209024243.23406-10-vedang.patel@intel.com>
Message-ID: <20210211010909.GC44042@ranger.igk.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Feb 08, 2021 at 06:42:43PM -0800, Vedang Patel wrote:
> From: Andre Guedes <andre.guedes@intel.com>
> 
> Add support for transmitting packets via AF_XDP zero-copy mechanism.
> 
> The packet transmission itself is implemented by igc_xdp_xmit_zc() which
> is called from igc_clean_tx_irq() when the ring has AF_XDP zero-copy
> enabled. Likewise i40e and ice drivers, the transmission budget used is
> the number of descriptors available on the ring.
> 
> A new tx buffer type is introduced to 'enum igc_tx_buffer_type' to
> indicate the tx buffer uses memory from xsk pool so it can be properly
> cleaned after transmission or when the ring is cleaned.
> 
> The I225 controller has only 4 Tx hardware queues so the main difference
> between igc and other Intel drivers that support AF_XDP zero-copy is
> that there is no tx ring dedicated exclusively to XDP. Instead, tx
> rings are shared between the network stack and XDP, and netdev queue
> lock is used to ensure mutual exclusion. This is the same approach
> implemented to support XDP_TX and XDP_REDIRECT actions.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> Signed-off-by: Vedang Patel <vedang.patel@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h      |   3 +
>  drivers/net/ethernet/intel/igc/igc_base.h |   1 +
>  drivers/net/ethernet/intel/igc/igc_main.c | 115 +++++++++++++++++++++-
>  drivers/net/ethernet/intel/igc/igc_xdp.c  |  20 +++-
>  4 files changed, 131 insertions(+), 8 deletions(-)
> 

[...]

>  
> +static void igc_xdp_xmit_zc(struct igc_ring *ring)
> +{
> +	struct xsk_buff_pool *pool = ring->xsk_pool;
> +	struct netdev_queue *nq = txring_txq(ring);
> +	int cpu = smp_processor_id();
> +	struct xdp_desc xdp_desc;
> +	bool work_done;
> +	u16 budget;
> +
> +	if (!netif_carrier_ok(ring->netdev))
> +		return;
> +
> +	__netif_tx_lock(nq, cpu);
> +
> +	budget = igc_desc_unused(ring);
> +	work_done = false;
> +
> +	while (xsk_tx_peek_desc(pool, &xdp_desc) && budget--) {
> +		u32 cmd_type, olinfo_status;
> +		union igc_adv_tx_desc *desc;
> +		struct igc_tx_buffer *bi;
> +		dma_addr_t dma;
> +
> +		cmd_type = IGC_ADVTXD_DTYP_DATA | IGC_ADVTXD_DCMD_DEXT |
> +			   IGC_ADVTXD_DCMD_IFCS | IGC_TXD_DCMD |
> +			   xdp_desc.len;
> +		olinfo_status = xdp_desc.len << IGC_ADVTXD_PAYLEN_SHIFT;
> +
> +		dma = xsk_buff_raw_get_dma(pool, xdp_desc.addr);
> +		xsk_buff_raw_dma_sync_for_device(pool, dma, xdp_desc.len);
> +
> +		desc = IGC_TX_DESC(ring, ring->next_to_use);

Same suggestion as with ntc on Rx side

> +		desc->read.cmd_type_len = cpu_to_le32(cmd_type);
> +		desc->read.olinfo_status = cpu_to_le32(olinfo_status);
> +		desc->read.buffer_addr = cpu_to_le64(dma);
> +
> +		bi = &ring->tx_buffer_info[ring->next_to_use];
> +		bi->type = IGC_TX_BUFFER_TYPE_XSK;
> +		bi->protocol = 0;
> +		bi->bytecount = xdp_desc.len;
> +		bi->gso_segs = 1;
> +		bi->time_stamp = jiffies;
> +		bi->next_to_watch = desc;
> +
> +		netdev_tx_sent_queue(txring_txq(ring), xdp_desc.len);
> +
> +		ring->next_to_use++;
> +		if (ring->next_to_use == ring->count)
> +			ring->next_to_use = 0;
> +
> +		work_done = true;

Seems sub-optimal to set it on each iteration?

> +	}
> +
> +	if (work_done) {
> +		igc_flush_tx_descriptors(ring);
> +		xsk_tx_release(pool);
> +	}
> +
> +	__netif_tx_unlock(nq);
> +}
> +
